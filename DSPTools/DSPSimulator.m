//
//  DSPSimulator.m
//  DSPTools
//
//  Created by Puru Choudhary on 9/2/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPSimulator.h"
#import "DSPComponent.h"
#import "DSPComponentModel.h"
#import "DSPPin.h"
#import "DSPNode.h"

@implementation DSPSimulator

#pragma mark - Accessors

@synthesize components = _components;
@synthesize nodes      = _nodes;

#pragma mark - Setup and dealloc

- (void)dealloc
{
    TT_RELEASE_SAFELY(_components);
    TT_RELEASE_SAFELY(_nodes);
    [super dealloc];
}

#pragma mark - Simulation

- (void)evaluateComponent:(DSPComponent *)component atTime:(double)time
{
    // Evaluate the component
    [component.model evaluteAtTime:time];
    
    // Update the node connected to the output pins
    for (DSPPin *pin in [component.model outputPins]) {
        DSPNode *currentNode = pin.connectedNode;
        [currentNode updateValue:pin.signalValue];
    }
}

// Updates the signal values of input pins of the component 
// Returns yes, if all the inputs are ready.
// Returns NO, if any input is not ready
- (BOOL)inputsReadyForComponent:(DSPComponent *)component
{
    // Inputs are ready if all of them are connected to a node with usePreviousValue set or the currentValue is valid
    // If a component is a source, its inputs are ready since it does not have any inputs
    BOOL inputsReady = YES;
    for (DSPPin *pin in [component.model inputPins]) {
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

- (void)simulate
{
    // Components and nodes should be set
    if (!self.components) {
        return;
    }
    
    if (!self.nodes) {
        return;
    }
    
    // Even though the circuit analyzer will try to arrange the components in the best order
    // possible, assume a random order of components and nodes.
    
    // Run a dummy simulation to arrange the components in the right order
    NSMutableArray *temporaryComponents = [self.components mutableCopy];
    NSMutableArray *simulationComponents = [[NSMutableArray alloc] init];
    
    double time = 0;
    
    while ([temporaryComponents count]) {
        DSPComponent *component = [[temporaryComponents objectAtIndex:0] retain];
        
        // Do not simulate wires
        if (component.isWire) {
            [temporaryComponents removeObject:component];
            continue;
        }
        
        BOOL inputsReady = [self inputsReadyForComponent:component];
        
        // Evaluate the output if the inputs are ready
        if (inputsReady) {
            [self evaluateComponent:component atTime:time];
            
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
    for (DSPNode *node in self.nodes) {
        if (!node.currentValueIsValid) {
            TTDERROR(@"ERROR: Simulator - A node is not updated.");
        }
        [node reset];
    }
    
    // Reset the components
    for (DSPComponent *component in simulationComponents) {
        [component.model reset];
    }
    
    // Iterate through each time step
    for (double simulationTime = 0; simulationTime<5 ; simulationTime = simulationTime + 0.01) {
        // Invalidate all the current values of the nodes
        for (DSPNode *node in self.nodes) {
            node.currentValueIsValid = NO;
        }
        
        // Evaluate each component
        for (DSPComponent *component in simulationComponents) {
            BOOL inputsReady = [self inputsReadyForComponent:component];
            
            if (inputsReady) {
                [self evaluateComponent:component atTime:simulationTime];
            } else {
                // TODO: This condition should not occur as all the inputs should be ready
                NSLog(@"ERROR: Simulator - Inputs not ready!");
            }
        }
        
    }
    
    [simulationComponents release];

}



@end
