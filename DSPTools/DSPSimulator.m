//
//  DSPSimulator.m
//  DSPTools
//
//  Created by Puru Choudhary on 9/2/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPSimulator.h"
#import "DSPComponentViewController.h"
#import "DSPPin.h"
#import "DSPNode.h"

@implementation DSPSimulator

+ (void)evaluateComponent:(DSPComponentViewController *)component atTime:(double)time
{
    // Evaluate the component
    [component.componentModel evaluteAtTime:time];
    
    // Update the node connected to the output pins
    for (DSPPin *pin in [component.componentModel outputPins]) {
        DSPNode *currentNode = pin.connectedNode;
        [currentNode updateValue:pin.signalValue];
    }
}

// Updates the signal values of input pins of the component 
// Returns yes, if all the inputs are ready.
// Returns NO, if any input is not ready
+ (BOOL)inputsReadyForComponent:(DSPComponentViewController *)component
{
    // Inputs are ready if all of them are connected to a node with usePreviousValue set or the currentValue is valid
    // If a component is a source, its inputs are ready since it does not have any inputs
    BOOL inputsReady = YES;
    for (DSPPin *pin in [component.componentModel inputPins]) {
        DSPNode *node = pin.connectedNode;
        
        // Update the pins of the components
        if (node.usePreviousValue) {
            [pin updateValue:node.previousValue];
        } 
        else if (node.currentValueIsValid) {
            [pin updateValue:node.currentValue];
        }
        else {
            inputsReady = NO;
        }
    }
    
    return inputsReady;
}

+ (void)runSimulationForComponents:(NSArray *)components andNodes:(NSArray *)nodes
{
    // Even though the circuit analyzer will try to arrange the components in the best order
    // possible, assume a random order of components and nodes.
    
    // Run a dummy simulation to arrange the components in the right order
    NSMutableArray *temporaryComponents = [components mutableCopy];
    NSMutableArray *simulationComponents = [[NSMutableArray alloc] init];
    
    double time = 0;
    
    while ([temporaryComponents count]) {
        DSPComponentViewController *component = [[temporaryComponents objectAtIndex:0] retain];
        
        BOOL inputsReady = [DSPSimulator inputsReadyForComponent:component];
        
        // Evaluate the output if the inputs are ready
        if (inputsReady) {
            [DSPSimulator evaluateComponent:component atTime:time];
            
            // Add the component to the simulation component list
            [simulationComponents addObject:component];
            [temporaryComponents removeObject:component];
        }
        else {
            // Move the object to the back of the queue if it cannot be evaluated at the moment
            [temporaryComponents removeObject:component];
            [temporaryComponents addObject:component];
        }
        
        [component release];
    }
    
    [temporaryComponents release];
    
    // Verify that all the nodes are updated and then reset the nodes
    for (DSPNode *node in nodes) {
        if (!node.currentValueIsValid) {
            NSLog(@"ERROR: Simulator - A node is not updated.");
        }
        [node reset];
    }
    
    // Reset the components
    for (DSPComponentViewController *component in simulationComponents) {
        [component.componentModel reset];
    }
    
    // Iterate through each time step
    for (double simulationTime; simulationTime<5 ; simulationTime = simulationTime + 0.1) {
        // Invalidate all the current values of the nodes
        for (DSPNode *node in nodes) {
            node.currentValueIsValid = NO;
        }
        
        // Evaluate each component
        for (DSPComponentViewController *component in simulationComponents) {
            BOOL inputsReady = [DSPSimulator inputsReadyForComponent:component];
            
            if (inputsReady) {
                [DSPSimulator evaluateComponent:component atTime:simulationTime];
            } else {
                // TODO: This condition should not occur as all the inputs should be ready
                NSLog(@"ERROR: Simulator - Inputs not ready!");
            }
        }
    }
    
    [simulationComponents release];

}

@end
