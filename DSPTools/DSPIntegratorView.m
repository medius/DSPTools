//
//  DSPIntegratorView.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPIntegratorView.h"
#import "DSPHelper.h"
#import "DSPHeader.h"

static const NSUInteger kDefaultWidth = 4;
static const NSUInteger kDefaultHeight = 6;

@implementation DSPIntegratorView

- (void)componentViewSetup
{
    DSPGridSize defaultSize;
    defaultSize.width = kDefaultWidth;
    defaultSize.height = kDefaultHeight;
    _size = defaultSize;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawContent:(CGRect)rect
{   
    CGFloat margin = marginForGridScale(self.gridScale);
    
    // Draw the box
    CGRect box = CGRectMake(margin, margin, (self.size.width-1)*self.gridScale, (self.size.height-1)*self.gridScale);
    [DSPHelper drawRoundedBoxForRect:box withRadius:self.rectangleRadius withLineWidth:self.lineWidth withLineColor:self.lineColor withFillColor:self.fillColor];
    
    // Draw the pins
    CGPoint startPoint, endPoint;

    // Draw the input pin
    startPoint.x = 0; startPoint.y = self.size.height/2*self.gridScale;
    endPoint.x = margin; endPoint.y = self.size.height/2*self.gridScale;
    [DSPHelper drawLineFromPoint:startPoint toPoint:endPoint withLineWidth:self.lineWidth withLineColor:self.lineColor];

    // Draw the output pin
    startPoint.x = self.size.width*self.gridScale - margin; startPoint.y = self.size.height/2*self.gridScale;
    endPoint.x = self.size.width*self.gridScale; endPoint.y = self.size.height/2*self.gridScale;
    [DSPHelper drawLineFromPoint:startPoint toPoint:endPoint withLineWidth:self.lineWidth withLineColor:self.lineColor];

}

#pragma mark - View information methods

+ (CGRect)defaultFrameForPrimaryAnchor:(DSPGridPoint)anchor forGridScale:(CGFloat)gridScale
{
    DSPGridRect gridFrame;
    gridFrame.origin.x = anchor.x;
    gridFrame.origin.y = anchor.y - kDefaultHeight/2;
    gridFrame.size.width = kDefaultWidth;
    gridFrame.size.height = kDefaultHeight;
    
    CGRect realFrame = [DSPHelper getRealRectFromGridRect:gridFrame forGridScale:gridScale];
    return realFrame;
}

+ (DSPGridPoint)defaultSecondaryAnchorForPrimaryAnchor:(DSPGridPoint)anchor
{
    DSPGridPoint secondaryAnchor;
    secondaryAnchor.x = anchor.x + kDefaultWidth;
    secondaryAnchor.y = anchor.y;
    return secondaryAnchor;
}

+ (CGRect)frameForAnchor1:(DSPGridPoint)anchor1 andAnchor2:(DSPGridPoint)anchor2 forGridScale:(CGFloat)gridScale;
{
    DSPGridRect gridFrame;
    gridFrame.origin.x = anchor1.x;
    gridFrame.origin.y = anchor1.y - kDefaultHeight/2;
    gridFrame.size.width = anchor2.x - anchor1.x;
    gridFrame.size.height = kDefaultHeight;
    
    CGRect realFrame = [DSPHelper getRealRectFromGridRect:gridFrame forGridScale:gridScale];
    return realFrame;
}

@end
