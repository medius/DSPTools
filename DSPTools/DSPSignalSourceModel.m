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
