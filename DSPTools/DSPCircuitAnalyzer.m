//
//  DSPCircuitAnalyzer.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/30/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPCircuitAnalyzer.h"
#import "DSPComponentViewController.h"
#import "DSPPin.h"
#import "DSPNode.h"

@implementation DSPCircuitAnalyzer

#pragma mark - Accessors

@synthesize components = _components;
@synthesize nodes      = _nodes;
@synthesize errors     = _errors;

- (NSArray *)components
{
    if (!_components) {
        _components = [[NSMutableArray alloc] init];
    }
    return _components;
}

- (NSMutableArray *)nodes
{
    if (!_nodes) {
        _nodes = [[NSMutableArray alloc] init];
    }
    return _nodes;
}

- (NSMutableArray *)errors
{
    if (!_errors) {
        _errors = [[NSMutableArray alloc] init];
    }
    return _errors;
}

#pragma mark - Setup and dealloc
- (void)dealloc
{
    TT_RELEASE_SAFELY(_components);
    TT_RELEASE_SAFELY(_nodes);
    TT_RELEASE_SAFELY(_errors);
    [super dealloc];
}

#pragma mark - Circuit Analysis Core Methods

- (void)connectNode:(DSPNode *)node toComponent:(DSPComponentViewController *)component withPin:(DSPPin *)pin;
{
    if (component.isWire) {
        [node.wires addObject:component];
    }
    else {
        if (!pin.isOutput) {
            // Components with input pins are fanouts of a given node
            [node.fanOutComponents addObject:component];
        }
        else {
            // Component with an output pin is a fanin of a given node
            node.fanInComponent = component;
            
            // Use the previous value if this component has a memory
            if (component.componentModel.hasMemory) {
                node.usePreviousValue = YES;
            }
        }
        
    }
    
    // Assign the node to the pin
    pin.connectedNode = node;

}

- (void)createNodesForComponent:(DSPComponentViewController *)component
{
    // Create nodes for pins
    for (DSPPin *pin in component.componentModel.pins) 
    {
        BOOL nodeForThisPinExists = NO;
        for (int i=0; i<[self.nodes count]; i++) {
            DSPNode *existingNode = (DSPNode *)[self.nodes objectAtIndex:i];
            
            // A node is found that matches the pin location
            if (existingNode.location.x == pin.location.x && existingNode.location.y == pin.location.y) {
                // Connect the existing node to the component and its pin
                [self connectNode:existingNode toComponent:component withPin:pin];
                
                nodeForThisPinExists = YES;
                
                // Check if the value type matches
                if (existingNode.signalType.valueType != pin.signalType.valueType) {
                    // TODO: Mismatch of value type. Register an error
                    // TODO: Improve this to check if a node supports both modes, then allow the stricter version
                    // e.g if a node allows both values, then the pin with analog value is allowed.
                    // Think about this in greater detail
                }
                
                // Check if the domain type matches
                if (existingNode.signalType.domainType != pin.signalType.domainType) {
                    // TODO: Mismatch of domain type. Register an error
                    // TODO: Improve this to check if a node supports both modes, then allow the stricter version
                    // Think about this in greater detail
                }
                
                // Since a node is found for this pin, no need of checking further
                break;
            }
        }
        
        // If a node does not exist for this pin, create one.
        if (!nodeForThisPinExists) {
            DSPNode *newNode = [[DSPNode alloc] init];
            newNode.location = pin.location;
            newNode.signalType = pin.signalType;
            
            // Connect the new node to the component and its pin
            [self connectNode:newNode toComponent:component withPin:pin];

            // Add the new node to the nodes array
            [self.nodes addObject:newNode];
            [newNode release];
        }
    }
}

- (void)transferComponentstoNode:(DSPNode *)targetNode fromNode:(DSPNode *)sourceNode
{
    // Move all the fanout components
    [targetNode.fanOutComponents addObjectsFromArray:sourceNode.fanOutComponents];
    
    // For each input pin of each fanout of sourceNode that is connected to sourceNode, assign its connectedNode to targetNode
    for (DSPComponentViewController *fanOut in sourceNode.fanOutComponents) {
        for (DSPPin *pin in [fanOut.componentModel inputPins]) {
            if ([pin.connectedNode isEqual:sourceNode]) {
                pin.connectedNode = targetNode;
            }
        }
    }
    
    // Move all the wires
    [targetNode.wires addObjectsFromArray:sourceNode.wires];
    
    // For each pin of wires of sourceNode that are connected to sourceNode, assign to targetNode
    for (DSPComponentViewController *wire in sourceNode.wires) {
        for (DSPPin *pin in wire.componentModel.pins) {
            if ([pin.connectedNode isEqual:sourceNode]) {
                pin.connectedNode = targetNode;
            }
        }
    }
    
    // Remove sourceNode from the list of nodes
    [self.nodes removeObject:sourceNode];
}

- (void)analyze
{
    // Components property must be set before calling this method
    if (!self.components) {
        return;
    }
    
    // First Pass:
    // Loop through each component and create a node for each pin of every 
    // component, including wires. For components with pins sharing a common
    // position, create a single node.
    
    for (DSPComponentViewController *component in self.components) {
        // Debug
        NSLog(@"%d %d %d %d\n", component.componentView.anchor1.x, component.componentView.anchor1.y, component.componentView.anchor2.x, component.componentView.anchor2.y);
        
        // Create nodes for pins
        [self createNodesForComponent:component];
    }
        
    // Second pass:
    // Merge the nodes that connect to wires to adjacent nodes
    
    for (DSPComponentViewController *component in self.components) {
        if (component.isWire) {            
            // Get the two nodes connected to the wire
            DSPPin *pinA = [[component.componentModel inputPins] lastObject];
            DSPPin *pinB = [[component.componentModel outputPins] lastObject];
            
            // One of these nodes will be released in this iteration from nodes list and the 
            // references will no longer be valid. Hence we need to retain them till we are done.
            DSPNode *nodeA = [pinA.connectedNode retain];
            DSPNode *nodeB = [pinB.connectedNode retain];
            
            // These are not user errors, but programming errors from the first pass
            if (![nodeA.wires containsObject:component]) {
                // TODO: Error in circuit analysis
                // Assert something here
                TTDERROR(@"CircuitAnalyzer - nodeA does not contain the wire.");
            }
            
            if (![nodeB.wires containsObject:component]) {
                // TODO: Error in circuit analysis
                // Assert something here
                TTDERROR(@"CircuitAnalyzer - nodeB does not contain the wire.");
            }
            
            // Remove the wire from nodeA and nodeB
            [nodeA.wires removeObject:component];
            [nodeB.wires removeObject:component];
            
            // If both the nodes are fanin, it is an error condition
            // This can also happen if two sources, or outputs are shorted. So this can be a circuit(user) problem.
            if (nodeA.fanInComponent && nodeB.fanInComponent) {
                // TODO: Error 
                // Assert something here
                TTDERROR(@"CircuitAnalyzer - Both the nodes are fanin type.");
            }
            
            // If nodeB has a fanin
            if (nodeB.fanInComponent) {
                [self transferComponentstoNode:nodeB fromNode:nodeA];
            }
            // If nodeA has a fanin or neither have a fanin
            else {
                [self transferComponentstoNode:nodeA fromNode:nodeB];
            }
            
            // Release both the nodes. The node that was removed from the nodes list will be removed permanently.
            [nodeA release];
            [nodeB release];
        }
    }
    
    // Sanity check
    // Perform sanity checks here. Make sure there is at least one source,
    // sources are not shorted, etc. Examine the nodes and see if the fanin and fanouts
    // are compatible in terms of signal type, etc.
    
    // Optimization for simulator
    // Rearrange the component list for simulation
    // Sources should be at the top of the list.
    // Then the components that have all their inputs as memory components or sources, etc.
    // Sinks go last.
    // There is a definite order for each circuit, but 
    // can the entire component order be determined statically?
    
}

@end
