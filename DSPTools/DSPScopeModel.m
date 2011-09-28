//
//  DSPScopeModel.m
//  DSPTools
//
//  Created by Puru Choudhary on 9/21/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPScopeModel.h"
#import "Three20/Three20.h"
#import "DSPPin.h"

@implementation DSPScopeModel

#pragma mark - Accessors

- (NSMutableArray *)simulationTimeBuffer
{
    if (!_simulationTimeBuffer) {
        _simulationTimeBuffer = [[NSMutableArray alloc] init];
    }
    return _simulationTimeBuffer;
}

- (NSMutableArray *)valueBuffer
{
    if (!_valueBuffer) {
        _valueBuffer = [[NSMutableArray alloc] init];
    }
    return _valueBuffer;
    
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

- (void)dealloc
{
    TT_RELEASE_SAFELY(_simulationTimeBuffer);
    TT_RELEASE_SAFELY(_valueBuffer);
    [super dealloc];
}

// Set the input pins
- (NSArray *)pins
{
    if (!_pins) {
        // Setup the output pin
        DSPPin *pin = [[DSPPin alloc] init];
        
        DSPSignalType signalType;
        signalType.valueType    = DSPAnalogValue;
        signalType.domainType   = DSPTimeDomain;
        pin.signalType          = signalType;
        pin.isOutput            = NO;
        
        _pins = [[NSArray alloc] initWithObjects:pin, nil];
        [pin release];
    }
    return _pins;
}

- (void) reset
{
    // Empty the buffers
}

- (double)inputValue
{
    DSPPin *inputPin = [[self inputPins] lastObject];
    return (double)inputPin.signalValue;
}

// Evaluate the output for a given simulation time
- (void)evaluteAtTime:(double)simulationTime
{
    NSNumber *time = [NSNumber numberWithDouble:simulationTime];
    [self.simulationTimeBuffer addObject:time];
    
    NSNumber *value = [NSNumber numberWithDouble:[self inputValue]];
    [self.valueBuffer addObject:value];
}

@end
