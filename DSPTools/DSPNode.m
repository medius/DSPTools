//
//  DSPNode.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/29/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPNode.h"

@implementation DSPNode

//@property (nonatomic, retain) DSPComponentViewController* _fanInComponent;
//@property (nonatomic, retain) NSArray*                    _fanOutComponents;
//@property (nonatomic) DSPSignalType                       _signalType;
//@property (nonatomic) DSPSignalValue                      _currentValue;
//@property (nonatomic) DSPSignalValue                      _previousValue;
//@property (nonatomic) BOOL                                _currentValueIsValid;
//
//@property (nonatomic) DSPGridPoint                        _location;
//@property (nonatomic, retain) NSArray*                    _wires;

// Setters/getters
@synthesize fanInComponent      = _fanInComponent;
@synthesize fanOutComponents    = _fanOutComponents;
@synthesize signalType          = _signalType;
@synthesize currentValue        = _currentValue;
@synthesize previousValue       = _previousValue;
@synthesize currentValueIsValid = _currentValueIsValid;
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

- (void)dealloc
{
    [_fanInComponent release];
    [_fanOutComponents release];
    [_wires release];
    [super dealloc];
}

@end
