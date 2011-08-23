//
//  DSPSummationView.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/17/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPSummationView.h"
#import "DSPHelper.h"

static const NSUInteger kDefaultWidth = 4;
static const NSUInteger kDefaultHeight = 4;

@implementation DSPSummationView

- (void)setupShape
{
    DSPGridSize defaultSize;
    defaultSize.width = kDefaultWidth;
    defaultSize.height = kDefaultWidth;
    _size = defaultSize;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawContent:(CGRect)rect
{   
    // Draw the circle
    CGPoint center = CGPointMake(2*self.gridScale, 2*self.gridScale);
    [DSPHelper drawCircleAtPoint:center withRadius:self.gridScale withLineWidth:self.lineWidth withLineColor:self.lineColor withFillColor:self.fillColor];

    // Draw the pins
    CGPoint startPoint, endPoint;
    
    // Draw the input pin 1
    startPoint.x = 0; startPoint.y = 2*self.gridScale;
    endPoint.x = self.gridScale; endPoint.y = 2*self.gridScale;
    [DSPHelper drawLineFromPoint:startPoint toPoint:endPoint withLineWidth:self.lineWidth withLineColor:self.lineColor];
    
    // Draw the input pin 2
    startPoint.x = 2*self.gridScale; startPoint.y = 4*self.gridScale;
    endPoint.x = 2*self.gridScale; endPoint.y = 3*self.gridScale;
    [DSPHelper drawLineFromPoint:startPoint toPoint:endPoint withLineWidth:self.lineWidth withLineColor:self.lineColor];
    
    // Draw the output pin
    startPoint.x = 3*self.gridScale; startPoint.y = 2*self.gridScale;
    endPoint.x = 4*self.gridScale; endPoint.y = 2*self.gridScale;
    [DSPHelper drawLineFromPoint:startPoint toPoint:endPoint withLineWidth:self.lineWidth withLineColor:self.lineColor];
}

/* Class methods */

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
