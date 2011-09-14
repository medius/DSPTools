//
//  DSPPin.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/29/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPPin.h"
#import "Three20/Three20.h"

@implementation DSPPin

@synthesize signalValue   = _signalValue;
@synthesize signalType    = _signalType;
@synthesize connectedNode = _connectedNode;
@synthesize location      = _location;
@synthesize isOutput      = _isOutput;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_connectedNode);
    [super dealloc];
}

// Update the pin based on new value
- (void)updateValue:(DSPSignalValue)newValue
{
    self.signalValue = newValue;
}

- (void)reset
{
    self.signalValue = 0;
}

@end
