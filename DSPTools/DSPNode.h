//
//  DSPNode.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/29/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSPHeader.h"

@class DSPComponent;

@interface DSPNode : NSObject {
    DSPComponent               *_fanInComponent;            // Only one fan in to a node is allowed
    NSMutableArray             *_fanOutComponents;
    DSPSignalType               _signalType;
    DSPSignalValue              _currentValue;              // Value at current time step
    BOOL                        _currentValueIsValid;
    DSPSignalValue              _previousValue;             // Value at previous time step
    BOOL                        _usePreviousValue;          // Use the previous value of this node 
                                                            // (output of a memory component)
    
    // These are used only during circuit analysis
    // TODO: Remove this from here and use a local structure in circuit analyzer if needed
    // If a node does not have an inherent location, it does not belong here.
    // Maybe rename this object to a net?
    DSPGridPoint                _location;
    NSMutableArray             *_wires;
}

@property (nonatomic, retain) DSPComponent   *fanInComponent;
@property (nonatomic, retain) NSMutableArray *fanOutComponents;
@property (nonatomic) DSPSignalType           signalType;
@property (nonatomic) DSPSignalValue          currentValue;
@property (nonatomic) BOOL                    currentValueIsValid;
@property (nonatomic) DSPSignalValue          previousValue;
@property (nonatomic) BOOL                    usePreviousValue;

@property (nonatomic) DSPGridPoint            location;
@property (nonatomic, retain) NSMutableArray *wires;

// Update the node based on new value
- (void)updateValue:(DSPSignalValue)newValue;

// Reset the signal values
- (void)reset;

@end
