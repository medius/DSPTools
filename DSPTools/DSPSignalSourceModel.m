//
//  DSPSignalSourceModel.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/31/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPSignalSourceModel.h"
#import "DSPPin.h"

@implementation DSPSignalSourceModel

@synthesize maxAmplitude  = _maxAmplitude;
@synthesize frequency     = _frequency;
@synthesize phaseShift    = _phaseShift;
@synthesize amplitudeBias = _amplitudeBias;

// Set the output pins
- (NSArray *)pins
{
    if (!_pins) 
    {
        // Setup the output pin
        DSPPin *pin = [[DSPPin alloc] init];
        
        DSPSignalType signalType;
        signalType.valueType    = DSPAnalogValue;
        signalType.domainType   = DSPTimeDomain;
        pin.signalType          = signalType;
        pin.isOutput            = YES;
        
        _pins = [[NSArray alloc] initWithObjects:pin, nil];
        [pin release];
    }
    return _pins;
}

- (void)resetValues
{

}

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        _isASource = YES;
        self.frequency = 1.0;
        self.maxAmplitude = 1.0;
    }
    return self;
}

// Update the value of pins at the output
- (void)updateOutput:(double)outputValue
{
    DSPPin *pin = [[self outputPins] lastObject];
    pin.signalValue = outputValue;
}

// Evaluate the output for a given simulation time
- (void)evaluteAtTime:(double)simulationTime
{
    double angle = 2*M_PI*self.frequency*simulationTime + self.phaseShift;
    double outputValue = self.maxAmplitude*sin(angle) + self.amplitudeBias;
    
    [self updateOutput:outputValue];
}


@end
