//
//  DSPWireModel.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/31/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPWireModel.h"
#import "DSPPin.h"

@implementation DSPWireModel

// This stores one end of the wire (anchor1). It is used for circuit analysis, but not in simulation.
- (NSArray *)inputPins
{
    if (!_inputPins) 
    {
        // Setup the input pin
        DSPPin *pin = [[DSPPin alloc] init];
        
        _inputPins = [[NSArray alloc] initWithObjects:pin, nil];
        [pin release];
    }
    return _inputPins;
}

// This stores one end of the wire (anchor2). It is used for circuit analysis, but not in simulation.
- (NSArray *)outputPins
{
    if (!_outputPins) 
    {
        // Setup the input pin
        DSPPin *pin = [[DSPPin alloc] init];
        
        _outputPins = [[NSArray alloc] initWithObjects:pin, nil];
        [pin release];
    }
    return _outputPins;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        _isWire = YES;
    }
    return self;
}

@end
