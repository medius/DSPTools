//
//  DSPSignalSource.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/31/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPSignalSource.h"
#import "DSPSignalSourceModel.h"
#import "DSPSignalSourceView.h"
#import "DSPPin.h"

@implementation DSPSignalSource

#pragma mark - Accessors

- (DSPComponentModel *)model
{
    if (!_model) {
        _model = [[DSPSignalSourceModel alloc] init];
    }
    return _model;
}

- (DSPComponentView *)view
{
    if (!_view) {
        _view = [[DSPSignalSourceView alloc] init];
    }
    return _view;
}

#pragma mark - Setup and dealloc

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
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
    DSPPin *outputPin = [[self.model outputPins] lastObject];    
    outputPin.location = newValue;
}

// Set the pin locations based on anchor 2
- (void)anchor2Set:(DSPComponentView *)requestor toValue:(DSPGridPoint)newValue
{
    // This does nothing for now
}

@end
