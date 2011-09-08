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

// This stores one end of the wire (anchor2). 
- (NSArray *)pins
{
    if (!_pins) 
    {
        // Setup the pins
        DSPPin *pin1 = [[DSPPin alloc] init];
        pin1.isOutput = NO;
        
        DSPPin *pin2 = [[DSPPin alloc] init];
        pin2.isOutput = YES;
        
        _pins = [[NSArray alloc] initWithObjects:pin1, pin2, nil];
        [pin1 release]; [pin2 release];
    }
    return _pins;
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
