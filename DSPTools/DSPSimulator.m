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

@interface DSPSimulator () 
@property (nonatomic, retain) NSMutableArray* xAxisBuffer;
@property (nonatomic, retain) NSMutableArray* yAxisBuffer1;
@property (nonatomic, retain) NSMutableArray* yAxisBuffer2;
@end

@implementation DSPSimulator

#pragma mark - Accessors

@synthesize components = _components;
@synthesize nodes      = _nodes;

- (NSArray *)components
{
    if (!_components) {
        _components = [[NSArray alloc] init];
    }
    return _components;
}

- (NSArray *)nodes
{
    if (!_nodes) {
        _nodes = [[NSArray alloc] init];
    }
    return _nodes;
}

@synthesize xAxisBuffer = _xAxisBuffer;
@synthesize yAxisBuffer1 = _yAxisBuffer1;
@synthesize yAxisBuffer2 = _yAxisBuffer2;

- (NSMutableArray *)xAxisBuffer
{
    if (!_xAxisBuffer) {
        _xAxisBuffer = [[NSMutableArray alloc] init];
    }
    return _xAxisBuffer;
}

- (NSMutableArray *)yAxisBuffer1
{
    if (!_yAxisBuffer1) {
        _yAxisBuffer1 = [[NSMutableArray alloc] init];
    }
    return _yAxisBuffer1;
}

- (NSMutableArray *)yAxisBuffer2
{
    if (!_yAxisBuffer2) {
        _yAxisBuffer2 = [[NSMutableArray alloc] init];
    }
    return _yAxisBuffer2;
}

#pragma mark - Setup and dealloc

- (void)dealloc
{
    TT_RELEASE_SAFELY(_components);
    TT_RELEASE_SAFELY(_nodes);
    
    TT_RELEASE_SAFELY(_xAxisBuffer);
    TT_RELEASE_SAFELY(_yAxisBuffer1);
    TT_RELEASE_SAFELY(_yAxisBuffer2);
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
    for (double simulationTime = 0; simulationTime<5 ; simulationTime = simulationTime + 0.05) {
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
        
        NSNumber *xValue = [NSNumber numberWithDouble:simulationTime];
        [self.xAxisBuffer addObject:xValue];

        DSPNode *sourceOutput = [self.nodes objectAtIndex:0];
        NSNumber *yValue1 = [NSNumber numberWithDouble:(double)sourceOutput.currentValue];
        [self.yAxisBuffer1 addObject:yValue1];
        
        DSPNode *integratorOutput = [self.nodes lastObject];
        NSNumber *yValue2 = [NSNumber numberWithDouble:(double)integratorOutput.currentValue];
        [self.yAxisBuffer2 addObject:yValue2];
        
    }
    
    [simulationComponents release];

}

#pragma mark - Waveform Data Source Methods

// This might not be suitable here. It should respond to probes rather than waveform.
- (NSNumber *)numberForWaveformIndex:(NSUInteger)waveformIndex axis:(DSPWaveformAxis)waveformAxis recordIndex:(NSUInteger)index
{
    if (waveformAxis == DSPWaveformAxisX) {
        return [self.xAxisBuffer objectAtIndex:index];
    }
    else {
        if (waveformIndex == 0) {
            return [self.yAxisBuffer1 objectAtIndex:index];
        }
        else {
            return [self.yAxisBuffer2 objectAtIndex:index];
        }
    }
}

@end
