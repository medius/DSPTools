//
//  DSPWireView.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/19/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSPComponentView.h"

@interface DSPWireView : DSPComponentView {
    NSUInteger  _wireLength;
}

@property (readonly) NSUInteger wireLength;

@end
