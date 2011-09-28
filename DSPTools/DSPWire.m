//
//  DSPWire.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/31/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPWire.h"
#import "DSPWireModel.h"
#import "DSPWireView.h"
#import "DSPPin.h"

@implementation DSPWire

#pragma mark - Accessors

@synthesize isReverse = _isReverse;

- (DSPComponentModel *)model
{
    if (!_model) {
        _model = [[DSPWireModel alloc] init];
    }
    return _model;
}

- (DSPComponentView *)view
{
    if (!_view) {
        _view = [[DSPWireView alloc] init];
    }
    return _view;
}

#pragma mark - Setup and dealloc

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        _isWire = YES;
        _name = @"Wire";
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark - Pin location update methods

// Set the pin locations based on anchor 1
- (void)anchor1Set:(DSPComponentView *)requestor toValue:(DSPGridPoint)newValue
{
    DSPPin *pin;
    if (self.isReverse) 
    {
        pin = [[self.model outputPins] lastObject];
    } 
    else
    {
        pin =[[self.model inputPins] lastObject];
    }
     
    pin.location = newValue;
}

// Set the pin locations based on anchor 2
- (void)anchor2Set:(DSPComponentView *)requestor toValue:(DSPGridPoint)newValue
{
    DSPPin *pin;
    if (self.isReverse) {
        pin = [[self.model inputPins] lastObject];
    } 
    else {
        pin =[[self.model outputPins] lastObject];
    }
    
    pin.location = newValue;
}

@end
