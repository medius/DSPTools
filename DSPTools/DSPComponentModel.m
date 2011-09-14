//
//  DSPComponentModel.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPComponentModel.h"
#import "DSPPin.h"
#import "Three20/Three20.h"

@implementation DSPComponentModel

// Setters/getters
@synthesize pins      = _pins;
@synthesize hasMemory = _hasMemory;
@synthesize isASource = _isASource;

// Reset the model values
- (void)reset
{
    // Reset all the pins
    for (DSPPin *pin in self.pins) {
        [pin reset];
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        _hasMemory = NO;
        _isASource = NO;
        [self reset];
    }
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_pins);
    [super dealloc];
}

// Evaluate the output at a given simulation time
- (void)evaluteAtTime:(double)simulationTime
{
    // Subclasses must override this
}

// Return all the input pins
- (NSArray *)inputPins
{
    NSMutableArray *inputPins = [NSMutableArray array];
    for (DSPPin *pin in self.pins) {
        if (!pin.isOutput) {
            [inputPins addObject:pin];
        }
    }
    return inputPins;
}

// Return all the output pins
- (NSArray *)outputPins
{
    NSMutableArray *outputPins = [NSMutableArray array];
    for (DSPPin *pin in self.pins) {
        if (pin.isOutput) {
            [outputPins addObject:pin];
        }
    }
    return outputPins;
}

@end
