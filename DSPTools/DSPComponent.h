//
//  DSPComponent.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

// This is basic model of a DSPComponent. All the specific components are derived from it
// Any of the simulation model functions are implemented here

#import <Foundation/Foundation.h>


@interface DSPComponent : NSObject {
    NSArray*    _inputPins;
    NSArray*    _outputPins;
    BOOL        _hasMemory;         // Whether the component remembers its last output value
    BOOL        _isWire;
}

@property (nonatomic, retain) NSArray* inputPins;
@property (nonatomic, retain) NSArray* outputPins;
@property (readonly) BOOL              hasMemory;
@property (readonly) BOOL              isWire;

@end
