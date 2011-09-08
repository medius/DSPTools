//
//  DSPIntegratorModel.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPIntegratorModel.h"
#import "DSPPin.h"

@interface DSPIntegratorModel() 
@property (nonatomic) double currentValue;
@property (nonatomic) double previousSimulationTime;
@end

@implementation DSPIntegratorModel

@synthesize initialValue           = _initialValue;
@synthesize saturationValue        = _saturationValue;
@synthesize currentValue           = _currentValue;
@synthesize previousSimulationTime = _previousSimulationTime;

- (NSArray *)pins
{
    if (!_pins) 
    {
        // Setup the input pin
        DSPPin *inputPin = [[DSPPin alloc] init];
        
        DSPSignalType signalType;
        signalType.valueType = DSPAnalogValue;
        signalType.domainType = DSPTimeDomain;
        inputPin.signalType = signalType;
        inputPin.isOutput = NO;
                
        // Setup the output pin
        DSPPin *outputPin = [[DSPPin alloc] init];
        
        signalType.valueType = DSPAnalogValue;
        signalType.domainType = DSPTimeDomain;
        outputPin.signalType = signalType;
        outputPin.isOutput = YES;
        
        _pins = [[NSArray alloc] initWithObjects:inputPin, outputPin, nil];
        [inputPin release]; [outputPin release];
    }
    return _pins;
}

- (void)reset
{
    [super reset];
    self.currentValue = self.initialValue;
    self.previousSimulationTime = 0;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.saturationValue = 1.0;
    }
    return self;
}

- (double)inputValue
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
    double deltaTime = simulationTime - self.previousSimulationTime;
    
    // Perform the integral function
    self.currentValue = self.currentValue + [self inputValue] * deltaTime;
    
    self.previousSimulationTime = simulationTime;
    [self updateOutput:self.currentValue];
}



@end
