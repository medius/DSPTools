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
    DSPSignalType   _signalType;
    DSPNode*        _node;          // Node this pin is connected to
    DSPGridPoint    _location;
}

@property (nonatomic) DSPSignalType    signalType;
@property (nonatomic, retain) DSPNode* node;
@property (nonatomic) DSPGridPoint     location;

@end
