//
//  DSPComponentModel.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

// This is basic model of a DSPComponent. All the specific components are derived from it
// Any of the simulation model functions are implemented here

#import <Foundation/Foundation.h>


@interface DSPComponentModel : NSObject {
    NSArray*    _pins;
    BOOL        _hasMemory;         // Whether the component remembers its last output value
    BOOL        _isASource;
}

@property (nonatomic, retain) NSArray* pins;
@property (readonly) BOOL              hasMemory;
@property (readonly) BOOL              isASource;

// Returns all the input pins
- (NSArray *)inputPins;

// Returns all the output pins
- (NSArray *)outputPins;

// Evaluate the output at a given simulation time
- (void)evaluteAtTime:(double)simulationTime;

// Reset the model values
- (void)reset;

@end
