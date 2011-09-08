//
//  DSPNode.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/29/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPNode.h"

@implementation DSPNode

// Setters/getters
@synthesize fanInComponent      = _fanInComponent;
@synthesize fanOutComponents    = _fanOutComponents;
@synthesize signalType          = _signalType;
@synthesize currentValue        = _currentValue;
@synthesize currentValueIsValid = _currentValueIsValid;
@synthesize previousValue       = _previousValue;
@synthesize usePreviousValue    = _usePreviousValue;
@synthesize location            = _location;
@synthesize wires               = _wires;

- (NSMutableArray *)fanOutComponents
{
    if (!_fanOutComponents)
    {
        _fanOutComponents = [[NSMutableArray alloc] init];
    }
    return _fanOutComponents;
}

- (NSMutableArray *)wires
{
    if (!_wires) 
    {
        _wires = [[NSMutableArray alloc] init];
    }
    return _wires;
}

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.currentValue = 0;
        self.currentValueIsValid = NO;
        self.previousValue = 0;
    }
    return self;
}

- (void)dealloc
{
    [_fanInComponent release];
    [_fanOutComponents release];
    [_wires release];
    [super dealloc];
}

- (void)updateValue:(DSPSignalValue)newValue
{
    if (self.currentValueIsValid) {
        // TODO: Error this should not happen
    } else
    {
        // Move the current value to previous value
        self.previousValue = self.currentValue;
        self.currentValue = newValue;
        self.currentValueIsValid = YES;
    }
}

- (void)reset
{
    self.previousValue = 0;
    self.currentValue = 0;
    self.currentValueIsValid = NO;
}

@end
