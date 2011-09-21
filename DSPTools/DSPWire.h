//
//  DSPWire.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/31/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSPComponent.h"

@interface DSPWire : DSPComponent {
    BOOL _isReverse;        // When YES, anchor1 is output and anchor2 is input
}

@property (nonatomic) BOOL isReverse;

@end
