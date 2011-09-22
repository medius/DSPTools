//
//  DSPScopeModel.m
//  DSPTools
//
//  Created by Puru Choudhary on 9/21/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPScopeModel.h"
#import "DSPPin.h"

@implementation DSPScopeModel

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

// Evaluate the output for a given simulation time
- (void)evaluteAtTime:(double)simulationTime
{
    // TODO: Update the buffer with the new input pin value
}

@end
