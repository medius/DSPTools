//
//  DSPSampleAndHold.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/31/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPSampleAndHold.h"
#import "DSPSampleAndHoldModel.h"
#import "DSPSampleAndHoldView.h"
#import "DSPPin.h"

@implementation DSPSampleAndHold

#pragma mark - Accessors

- (DSPComponentModel *)model
{
    if (!_model) {
        _model = [[DSPSampleAndHoldModel alloc] init];
    }
    return _model;
}

- (DSPComponentView *)view
{
    if (!_view) {
        _view = [[DSPSampleAndHoldView alloc] init];
    }
    return _view;
}

#pragma mark - Setup and dealloc

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        _name = @"SampleAndHold";
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
    DSPPin *inputPin = [[self.model inputPins] lastObject];
    inputPin.location = newValue;
    
    DSPPin *outputPin = [[self.model outputPins] lastObject];
    DSPGridPoint newLocation;
    newLocation.x = newValue.x + 4;  // Change these constants to use values from the view later;
    newLocation.y = newValue.y;
    
    outputPin.location = newLocation;
}

// Set the pin locations based on anchor 2
- (void)anchor2Set:(DSPComponentView *)requestor toValue:(DSPGridPoint)newValue
{
     // This does nothing for now
}

@end
