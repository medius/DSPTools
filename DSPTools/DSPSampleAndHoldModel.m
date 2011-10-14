//
//  DSPSampleAndHoldModel.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPSampleAndHoldModel.h"
#import "DSPPin.h"

@interface DSPSampleAndHoldModel () 
@property (nonatomic) double timeSinceLastSample;
@property (nonatomic) double timeAtLastSample;
@end

@implementation DSPSampleAndHoldModel

#pragma mark - Accessors
@synthesize samplePeriod = _samplePeriod;
@synthesize timeSinceLastSample = _timeSinceLastSample;
@synthesize timeAtLastSample = _timeAtLastSample;

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

#pragma mark - Setup and dealloc
- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        _hasMemory = YES;
        _samplePeriod = 0.05;
    }
    return self;
}

#pragma mark - Evaluation methods

- (void)reset
{
    [super reset];
    self.timeAtLastSample = 0;
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
    self.timeSinceLastSample = simulationTime - self.timeAtLastSample;
    
    if (self.timeSinceLastSample >= self.samplePeriod) {
        self.timeSinceLastSample = 0;
        self.timeAtLastSample = simulationTime;
    }
    
    if (self.timeSinceLastSample == 0) {
        [self updateOutput:[self inputValue]];
    }
}



@end
