//
//  DSPQuantizerModel.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPQuantizerModel.h"
#import "DSPPin.h"

@interface DSPQuantizerModel () 
@property (nonatomic) double timeSinceLastSample;
@property (nonatomic) double timeAtLastSample;
@end

@implementation DSPQuantizerModel

#pragma mark - Accessors
@synthesize quantizationInterval = _quantizationInterval;
@synthesize samplePeriod         = _samplePeriod;
@synthesize timeSinceLastSample  = _timeSinceLastSample;
@synthesize timeAtLastSample     = _timeAtLastSample;

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
        _samplePeriod = 0.1;
        _quantizationInterval = 0.1;
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
//    self.timeSinceLastSample = simulationTime - self.timeAtLastSample;
//    
//    if (self.timeSinceLastSample >= self.samplePeriod) {
//        self.timeSinceLastSample = 0;
//        self.timeAtLastSample = simulationTime;
//    }
//    
//    if (self.timeSinceLastSample == 0) {
//     
//    }
    
    if ([self inputValue] >= 0) {
        [self updateOutput:self.quantizationInterval];
    }
    else {
        [self updateOutput:-1*self.quantizationInterval];
    }
    
//    double outputValue = self.quantizationInterval * round([self inputValue]/self.quantizationInterval);
//    [self updateOutput:outputValue];
    
}



@end
