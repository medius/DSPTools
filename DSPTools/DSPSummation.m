//
//  DSPSummation.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/31/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPSummation.h"
#import "DSPSummationModel.h"
#import "DSPSummationView.h"
#import "DSPPin.h"

@implementation DSPSummation

#pragma mark - Accessors

- (DSPComponentModel *)model
{
    if (!_model) {
        _model = [[DSPSummationModel alloc] init];
    }
    return _model;
}

- (DSPComponentView *)view
{
    if (!_view) {
        _view = [[DSPSummationView alloc] init];
    }
    return _view;
}

#pragma mark - Setup and dealloc

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        _name = @"Summation";
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
    DSPPin *inputPin1 = [[self.model inputPins] objectAtIndex:0];
    inputPin1.location = newValue;

    DSPPin *inputPin2 = [[self.model inputPins] lastObject];
    DSPGridPoint newLocation;
    newLocation.x = newValue.x + 2;  // Change these constants to use values from the view later;
    newLocation.y = newValue.y + 2;
    inputPin2.location = newLocation;
    
    DSPPin *outputPin = [[self.model outputPins] lastObject];
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
