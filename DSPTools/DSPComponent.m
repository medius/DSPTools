//
//  DSPComponentController.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPComponent.h"
#import "DSPComponentModel.h"
#import "DSPPin.h"

@implementation DSPComponent

#pragma mark - Accessors
@synthesize model  = _model;
@synthesize view   = _view;
@synthesize isWire = _isWire;

#pragma mark - Setup and dealloc

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization

        _isWire = NO;
    }
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_model);
    TT_RELEASE_SAFELY(_view);
    [super dealloc];
}

#pragma mark - Pin location update methods

// Set the pin locations based on anchor 1
- (void)anchor1Set:(DSPComponentView *)requestor toValue:(DSPGridPoint)newValue
{
    // Subclasses need to implement this
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"You must override %@ in a subclass" userInfo:nil]; 
}

// Set the pin locations based on anchor 2
- (void)anchor2Set:(DSPComponentView *)requestor toValue:(DSPGridPoint)newValue
{
    // Subclasses need to implement this
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"You must override %@ in a subclass" userInfo:nil]; 
}

@end
