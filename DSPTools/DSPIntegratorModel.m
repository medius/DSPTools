//
//  DSPIntegratorModel.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPIntegratorModel.h"
#import "DSPPin.h"

@implementation DSPIntegratorModel

- (NSArray *)inputPins
{
    if (!_inputPins) 
    {
        // Setup the input pin
        DSPPin *pin = [[DSPPin alloc] init];
        
        DSPSignalType signalType;
        signalType.valueType = DSPAnalogValue;
        signalType.domainType = DSPTimeDomain;
        pin.signalType = signalType;
        
        _inputPins = [[NSArray alloc] initWithObjects:pin, nil];
        [pin release];
    }
    return _inputPins;
}

- (NSArray *)outputPins
{
    if (!_outputPins) 
    {
        // Setup the output pin
        DSPPin *pin = [[DSPPin alloc] init];
        
        DSPSignalType signalType;
        signalType.valueType = DSPAnalogValue;
        signalType.domainType = DSPTimeDomain;
        pin.signalType = signalType;
        
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
    }
    return self;
}

@end
