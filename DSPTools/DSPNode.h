//
//  DSPNode.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/29/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSPHeader.h"

@class DSPComponentViewController;

@interface DSPNode : NSObject {
    DSPComponentViewController* _fanInComponent;            // Only one fan in to a node is allowed
    NSMutableArray*             _fanOutComponents;
    DSPSignalType               _signalType;
    DSPSignalValue              _currentValue;
    DSPSignalValue              _previousValue;
    BOOL                        _currentValueIsValid;
    
    // These are used only during circuit analysis
    DSPGridPoint                _location;
    NSMutableArray*             _wires;
}

@property (nonatomic, retain) DSPComponentViewController* fanInComponent;
@property (nonatomic, retain) NSMutableArray*             fanOutComponents;
@property (nonatomic) DSPSignalType                       signalType;
@property (nonatomic) DSPSignalValue                      currentValue;
@property (nonatomic) DSPSignalValue                      previousValue;
@property (nonatomic) BOOL                                currentValueIsValid;

@property (nonatomic) DSPGridPoint                        location;
@property (nonatomic, retain) NSMutableArray*             wires;

@end
