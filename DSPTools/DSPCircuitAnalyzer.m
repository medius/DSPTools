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

+ (void)connectNode:(DSPNode *)node toComponent:(DSPComponentViewController *)component withPin:(DSPPin *)pin;
{
    if (component.isWire) 
    {
        [node.wires addObject:component];
    }
    else 
    {
        if (!pin.isOutput) {
            // Components with input pins are fanouts of a given node
            [node.fanOutComponents addObject:component];
        }
        else
        {
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

+ (void)createNodesForComponent:(DSPComponentViewController *)component inNodes:(NSMutableArray *)nodes
{
    // Create nodes for pins
    for (DSPPin *pin in component.componentModel.pins) 
    {
        BOOL nodeForThisPinExists = NO;
        for (int i=0; i<[nodes count]; i++) {
            DSPNode *existingNode = (DSPNode *)[nodes objectAtIndex:i];
            
            // A node is found that matches the pin location
            if (existingNode.location.x == pin.location.x && existingNode.location.y == pin.location.y) {
                // Connect the existing node to the component and its pin
                [DSPCircuitAnalyzer connectNode:existingNode toComponent:component withPin:pin];
                
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
            [DSPCircuitAnalyzer connectNode:newNode toComponent:component withPin:pin];

            // Add the new node to the nodes array
            [nodes addObject:newNode];
            [newNode release];
        }
    }
}

+ (void)transferComponentstoNode:(DSPNode *)targetNode fromNode:(DSPNode *)sourceNode withNodesList:(NSMutableArray *)nodes
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
    [nodes removeObject:sourceNode];
}

+ (NSDictionary *)simulatonModelForCircuit:(NSDictionary *)circuit
{
    // First Pass:
    // Loop through each component and create a node for each pin of every 
    // component, including wires. For components with pins sharing a common
    // position, create a single node.
    
    NSMutableDictionary *simulationModel = [NSMutableDictionary dictionary];
    NSMutableArray *nodes = [[NSMutableArray alloc] init];
    NSMutableArray *components = [[circuit objectForKey:@"components"] mutableCopy];
    
    // Errors are noted in components with mismatching value types, mismatching domains,
    // unconnected components, etc.
    NSMutableArray *errors = [[NSMutableArray alloc] init];

    for (DSPComponentViewController *component in components) {
        // Create nodes for pins
        [DSPCircuitAnalyzer createNodesForComponent:component inNodes:nodes];
    }
        
    // Second pass:
    // Merge the nodes that connect to wires to adjacent nodes and remove all wires.
    NSMutableArray *wiresToRemove = [[NSMutableArray alloc] init];
    
    for (DSPComponentViewController *component in components) {
        if (component.isWire) {
            // Mark the wire for removal from the components list
            [wiresToRemove addObject:component];
            
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
                NSLog(@"ERROR: CircuitAnalyzer - nodeA does not contain the wire.");
            }
            
            if (![nodeB.wires containsObject:component]) {
                // TODO: Error in circuit analysis
                // Assert something here
                NSLog(@"ERROR: CircuitAnalyzer - nodeB does not contain the wire.");
            }
            
            // Remove the wire from nodeA and nodeB
            [nodeA.wires removeObject:component];
            [nodeB.wires removeObject:component];
            
            // If both the nodes are fanin, it is an error condition
            // This can also happen if two sources, or outputs are shorted. So this can be a circuit(user) problem.
            if (nodeA.fanInComponent && nodeB.fanInComponent) {
                // TODO: Error 
                // Assert something here
                NSLog(@"Error: CircuitAnalyzer - Both the nodes are fan in type.");
            }
            
            // If nodeB has a fanin
            if (nodeB.fanInComponent) {
                [DSPCircuitAnalyzer transferComponentstoNode:nodeB fromNode:nodeA withNodesList:nodes];
            }
            // If nodeA has a fanin or neither have a fanin
            else {
                [DSPCircuitAnalyzer transferComponentstoNode:nodeA fromNode:nodeB withNodesList:nodes];
            }
            
            // Release both the nodes. The node that was removed from the nodes list will be removed permanently.
            [nodeA release];
            [nodeB release];
        }
    }

    // Remove the wires from the component list
    [components removeObjectsInArray:wiresToRemove];
    
    
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
    
    // Add the data to the simulation model
    [simulationModel setValue:nodes forKey:@"nodes"];
    [simulationModel setValue:components forKey:@"components"];
    [simulationModel setValue:errors forKey:@"errors"];
    
    // Cleanup 
    [nodes release];
    [components release];
    [errors release];
    
    return simulationModel;
}

// Second pass: 
// Detect the true direction of the signal flow in all the wires.

//    // Create a queue of nodeIDs
//    NSMutableArray *nodeQueue = [[NSMutableArray alloc] init];
//    
//    for (NSUInteger i=0; i<[nodes count]; i++) {
//        [nodeQueue addObject:[NSValue value:&i withObjCType:@encode(NSUInteger)]];
//    }
//    
//    while ([nodeQueue count]>0) {
//        
//        NSUInteger currentNodeID;
//        id nodeID = [nodeQueue objectAtIndex:0];
//        [nodeID getValue:&currentNodeID];
//        
//        DSPNode *node = [nodes objectAtIndex:currentNodeID];
//        [nodeQueue removeObject:nodeID];
//
//        // If a node has a fanin component and also has wires
//        // TODO: If a node has a fanout and no fanin, but has wires, should the wires be fanin or fanout?
//        if (node.fanInComponent && node.wires) {
//            for (int i=0; i<[node.wires count]; i++) {
//                DSPWireViewController *wire = [node.wires objectAtIndex:i];
//                
//                // If the output pin is connected to the current node, swap the pins of the wire
//                DSPPin *inputPin = [[wire.componentModel inputPins] lastObject];
//                DSPPin *outputPin = [[wire.componentModel outputPins] lastObject];
//                if (outputPin.nodeID == currentNodeID) {
//                    inputPin.isOutput = YES;
//                    outputPin.isOutput = NO;
//                }
//                
//                // Assign this wire as a fanout of the current node
//                [node.fanOutComponents addObject:wire];
//
//            }
//        }
//        // If a node does not have a fanin, add it to the back of the queue.
//        else
//        {
//            [nodeQueue addObject:nodeID];
//        }
//    }
//    
//    [nodeQueue release];

@end
