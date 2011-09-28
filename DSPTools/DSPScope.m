//
//  DSPScope.m
//  DSPTools
//
//  Created by Puru Choudhary on 9/21/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPScope.h"
#import "DSPScopeModel.h"
#import "DSPScopeView.h"
#import "DSPPin.h"

@implementation DSPScope

#pragma mark - Accessors

- (DSPComponentModel *)model
{
    if (!_model) {
        _model = [[DSPScopeModel alloc] init];
    }
    return _model;
}

- (DSPComponentView *)view
{
    if (!_view) {
        _view = [[DSPScopeView alloc] init];
    }
    return _view;
}

#pragma mark - Setup and dealloc

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        _isScope = YES;
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
}

// Set the pin locations based on anchor 2
- (void)anchor2Set:(DSPComponentView *)requestor toValue:(DSPGridPoint)newValue
{
    // This does nothing for now
}

@end
