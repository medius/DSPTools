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
    BOOL        _isVertical;
}

@property (readonly) NSUInteger wireLength;
@property (readonly) BOOL       isVertical;

// Provide the frame for given anchors
+ (CGRect)frameForAnchor1:(DSPGridPoint)anchor1 andAnchor2:(DSPGridPoint)anchor2 forGridScale:(CGFloat)gridScale;

@end
