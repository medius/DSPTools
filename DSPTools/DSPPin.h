//
//  DSPPin.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/29/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSPHeader.h"

@interface DSPPin : NSObject {
    DSPSignalType   _signalType;
    id              _node;          // Node this pin is connected to
    DSPGridPoint    _location;
}

@property DSPSignalType signalType;
@property (retain) id   node;
@property DSPGridPoint  location;

@end
