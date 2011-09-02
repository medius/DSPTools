//
//  DSPCircuitAnalyzer.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/30/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPCircuitAnalyzer.h"
#import "DSPComponents.h"
#import "DSPPin.h"
#import "DSPNode.h"

@implementation DSPCircuitAnalyzer

+ (void)createNodesForComponent:(DSPComponentViewController *)component inNodes:(NSMutableArray *)nodes isInput:(BOOL)isInput
{
    NSArray *pins;
    if (isInput) 
    {
        pins = component.componentModel.inputPins;
    }
    else
    {
        pins = component.componentModel.outputPins;
    }
    
    
    // Create nodes for input pins
    for (DSPPin *pin in pins) 
    {
        BOOL nodeForThisPinExists = NO;
        for (int i=0; i<[nodes count]; i++) {
            DSPNode *existingNode = (DSPNode *)[nodes objectAtIndex:i];
            
            // A node is found that matches the pin location
            if (existingNode.location.x == pin.location.x && existingNode.location.y == pin.location.y) {
                if ([component isKindOfClass:[DSPWireViewController class]]) 
                {
                    [existingNode.wires addObject:component];
                }
                else 
                {
                    if (isInput) {
                        // Components with input pins are fanouts of a given node
                        [existingNode.fanOutComponents addObject:component];
                    }
                    else
                    {
                        // Component with an output pin is a fanin of a given node
                        existingNode.fanInComponent = component;
                    }
                    
                }
                                
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
            
            // TODO: This code is repeated from above. Make the code common through a function or macro
            if ([component isKindOfClass:[DSPWireViewController class]]) 
            {
                [newNode.wires addObject:component];
            }
            else 
            {
                if (isInput) {
                    // Components with input pins are fanouts of a given node
                    [newNode.fanOutComponents addObject:component];
                }
                else
                {
                    // Component with an output pin is a fanin of a given node
                    newNode.fanInComponent = component;
                }
                
            }
            // ^ TODO: Above code is repeated.
            
            // Add the new node to the nodes array
            [nodes addObject:newNode];
            
            // Assign the new node to the pin
            pin.node = newNode;
            
            [newNode release];
        }
    }
}

+ (NSDictionary *)simulatonModelForCircuit:(NSDictionary *)circuit
{
    // First Pass:
    // Loop through each component and create a node for each pin of every 
    // component, including wires. For components with pins sharing a common
    // position, create a single node.
    
    NSDictionary *simulationModel = [NSMutableDictionary dictionary];
    NSMutableArray *nodes = [[NSMutableArray alloc] init];
    NSArray *components = [[circuit objectForKey:@"components"] retain];
    
    // Errors are noted in components with mismatching value types, mismatching domains,
    // unconnected components, etc.
    NSMutableArray *errors = [[NSMutableArray alloc] init];

    for (DSPComponentViewController *component in components) {
        // Create nodes for input pins
        [DSPCircuitAnalyzer createNodesForComponent:component inNodes:nodes isInput:YES];
        
        // Create nodes for output pins
        [DSPCircuitAnalyzer createNodesForComponent:component inNodes:nodes isInput:NO];
    }
    
    // Note: Circuit can be simulated with only first pass. 
    
    // Second pass
    // Merge the nodes that connect to wires to adjacent nodes and remove all wires.
    // TODO: Iterate over wires and merge their nodes. Only one pass is required and is 
    // guaranteed to finish.
    
    
    // Sanity check
    // Perform sanity checks here. Make sure there is at least one source,
    // sources are not shorted, etc.
    
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

@end
