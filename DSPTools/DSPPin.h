//
//  DSPPin.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/29/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSPHeader.h"
#import "DSPNode.h"

@interface DSPPin : NSObject {
    DSPSignalValue  _signalValue;
    DSPSignalType   _signalType;
    DSPNode*        _connectedNode; // Node this pin is connected to. TODO: Get rid of this reference. 
                                    // It's really bad. Has circular reference between node, component and pins.
    DSPGridPoint    _location;
    BOOL            _isOutput;
}

@property (nonatomic) DSPSignalValue   signalValue;
@property (nonatomic) DSPSignalType    signalType;
@property (nonatomic, retain) DSPNode* connectedNode;
@property (nonatomic) DSPGridPoint     location;
@property (nonatomic) BOOL             isOutput;

// Update the pin based on new value
- (void)updateValue:(DSPSignalValue)newValue;

// Reset the signal values
- (void)reset;

@end
