//
//  DSPSummationModel.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPSummationModel.h"
#import "DSPPin.h"

@interface DSPSummationModel () 

@end

@implementation DSPSummationModel

#pragma mark - Accessors

- (NSArray *)pins
{
    if (!_pins) 
    {
        // Setup the input pin1
        DSPPin *inputPin1 = [[DSPPin alloc] init];
        
        DSPSignalType signalType;
        signalType.valueType = DSPAnalogValue;
        signalType.domainType = DSPTimeDomain;
        inputPin1.signalType = signalType;
        inputPin1.isOutput = NO;
                
        // Setup the input pin2
        DSPPin *inputPin2 = [[DSPPin alloc] init];
        
        signalType.valueType = DSPAnalogValue;
        signalType.domainType = DSPTimeDomain;
        inputPin2.signalType = signalType;
        inputPin2.isOutput = NO;
        
        // Setup the output pin
        DSPPin *outputPin = [[DSPPin alloc] init];
        
        signalType.valueType = DSPAnalogValue;
        signalType.domainType = DSPTimeDomain;
        outputPin.signalType = signalType;
        outputPin.isOutput = YES;
        
        _pins = [[NSArray alloc] initWithObjects:inputPin1, inputPin2, outputPin, nil];
        [inputPin1 release]; [inputPin2 release]; [outputPin release];
    }
    return _pins;
}

#pragma mark - Setup and dealloc
- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization

    }
    return self;
}

#pragma mark - Evaluation methods

- (void)reset
{
    [super reset];
}

- (double)inputValue1
{
    DSPPin *inputPin = [[self inputPins] objectAtIndex:0];
    return (double)inputPin.signalValue;
}

- (double)inputValue2
{
    DSPPin *inputPin = [[self inputPins] lastObject];
    return (double)inputPin.signalValue;
}

// Update the value of pins at the output
- (void)updateOutput:(double)outputValue
{
    DSPPin *pin = [[self outputPins] lastObject];
    pin.signalValue = outputValue;
}

- (void)evaluteAtTime:(double)simulationTime
{
    double outputValue = [self inputValue1] - [self inputValue2];
    [self updateOutput:outputValue];
}


@end
