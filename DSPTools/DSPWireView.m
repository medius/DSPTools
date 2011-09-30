//
//  DSPWireView.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/19/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPWireView.h"
#import "DSPHeader.h"
#import "DSPHelper.h"

static const CGFloat kDefaultWireLineWidth = 1.0;

@implementation DSPWireView

#pragma mark - Accessors
- (NSUInteger)wireLength
{
    if (_anchor1.x == _anchor2.x) {
        _wireLength = abs(_anchor1.y - _anchor2.y);
    }
    else if (_anchor1.y == _anchor2.y) {
        _wireLength = abs(_anchor1.x - _anchor2.x);
    }
    return _wireLength;
}

#pragma mark - Setup and dealloc

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.lineWidth = kDefaultWireLineWidth;
    }
    return self;
}

#pragma mark - Draw methods

- (void)drawContent:(CGRect)rect
{   
    CGFloat margin = marginForGridScale(self.gridScale);

    // Draw the wire
    CGPoint startPoint, endPoint;
    
    if (self.isVertical) {
        startPoint.x = margin; startPoint.y = 0;
        endPoint.x = margin; endPoint.y = self.wireLength*self.gridScale;
    } 
    else {
        startPoint.x = 0; startPoint.y = margin;
        endPoint.x = self.wireLength*self.gridScale; endPoint.y = margin;
    }
    [DSPHelper drawLineFromPoint:startPoint toPoint:endPoint withLineWidth:self.lineWidth withLineColor:self.lineColor];
}

#pragma mark - View information methods

+ (CGRect)frameForAnchor1:(DSPGridPoint)anchor1 andAnchor2:(DSPGridPoint)anchor2 forGridScale:(CGFloat)gridScale
{
    CGFloat margin = marginForGridScale(gridScale);
    CGPoint realAnchor1 = [DSPHelper getRealPointFromGridPoint:anchor1 forGridScale:gridScale];
    CGPoint realAnchor2 = [DSPHelper getRealPointFromGridPoint:anchor2 forGridScale:gridScale];
    
    CGRect frame;

    // Return empty frame if both the anchors are the same
    if ([NSValue value:&anchor1 withObjCType:@encode(DSPGridPoint)] == [NSValue value:&anchor2 withObjCType:@encode(DSPGridPoint)]) return frame;
    
    // Build frame for a horizontal wire
    if (anchor1.y == anchor2.y) 
    {
        // Based on the x direction of the wire, generate a frame that is left to right
        if (anchor1.x < anchor2.x) {
            frame = CGRectMake(realAnchor1.x, realAnchor1.y-margin, abs(realAnchor1.x-realAnchor2.x), 2*margin);
        }
        else {
            frame = CGRectMake(realAnchor2.x, realAnchor2.y-margin, abs(realAnchor1.x-realAnchor2.x), 2*margin);   
        }
        
    } 
    // Build frame for a vertical wire
    else if (anchor1.x == anchor2.x) {
        // Based on the y direction of the wire, generate a frame that is top to bottom
        if (anchor1.y < anchor2.y) {
            frame = CGRectMake(realAnchor1.x-margin, realAnchor1.y, 2*margin, abs(realAnchor1.y-realAnchor2.y));
        }
        else {
            frame = CGRectMake(realAnchor2.x-margin, realAnchor2.y, 2*margin, abs(realAnchor1.y-realAnchor2.y));
        }
    }
    return frame;
}

@end
