//
//  DSPComponent.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPComponent.h"


@implementation DSPComponent

// Setters/getters
@synthesize inputPins  = _inputPins;
@synthesize outputPins = _outputPins;
@synthesize hasMemory  = _hasMemory;
@synthesize isWire     = _isWire;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        _isWire = NO;
        _hasMemory = NO;
    }
    return self;
}

- (void)dealloc
{
    [_inputPins release];
    [_outputPins release];
    [super dealloc];
}

@end
