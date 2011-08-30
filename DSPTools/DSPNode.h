//
//  DSPNode.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/29/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSPHeader.h"

@interface DSPNode : NSObject {
    NSArray*        _fanInComponents;
    NSArray*        _fanOutComponents;
    DSPSignalType   _signalType;
    DSPSignalValue  _currentValue;
    DSPSignalValue  _previousValue;
    BOOL            _currentValueIsValid;
}

@end
