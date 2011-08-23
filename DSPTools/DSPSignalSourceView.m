//
//  DSPSignalSourceView.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/22/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPSignalSourceView.h"
#import "DSPHelper.h"

static const NSUInteger kDefaultWidth = 2;
static const NSUInteger kDefaultHeight = 2;

@implementation DSPSignalSourceView

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
    CGPoint center = CGPointMake(self.gridScale, self.gridScale);
    [DSPHelper drawCircleAtPoint:center withRadius:self.gridScale/2 withLineWidth:self.lineWidth withLineColor:self.lineColor withFillColor:self.fillColor];
    
    // Draw the pins
    CGPoint startPoint, endPoint;
    
    // Draw the output pin
    startPoint.x = self.gridScale; startPoint.y = 0;
    endPoint.x = self.gridScale; endPoint.y = self.gridScale/2;
    [DSPHelper drawLineFromPoint:startPoint toPoint:endPoint withLineWidth:self.lineWidth withLineColor:self.lineColor];
    
    // Draw a sinewave
    CGRect waveRect = CGRectMake(self.gridScale*3/4, self.gridScale*3/4, self.gridScale/2, self.gridScale/2);
   // CGRect waveRect = CGRectMake(self.gridScale/2, self.gridScale/2, self.gridScale, self.gridScale);

    [DSPHelper drawSineWaves:1 inRect:waveRect withLineWidth:self.lineWidth withLineColor:self.lineColor];

}

/* Class methods */

+ (CGRect)defaultFrameForPrimaryAnchor:(DSPGridPoint)anchor forGridScale:(CGFloat)gridScale
{
    DSPGridRect gridFrame;
    gridFrame.origin.x = anchor.x - kDefaultWidth/2;
    gridFrame.origin.y = anchor.y;
    gridFrame.size.width = kDefaultWidth;
    gridFrame.size.height = kDefaultHeight;
    
    CGRect realFrame = [DSPHelper getRealRectFromGridRect:gridFrame forGridScale:gridScale];
    return realFrame;
}

+ (DSPGridPoint)defaultSecondaryAnchorForPrimaryAnchor:(DSPGridPoint)anchor
{
    DSPGridPoint secondaryAnchor;
    secondaryAnchor.x = anchor.x;
    secondaryAnchor.y = anchor.y + kDefaultHeight;
    return secondaryAnchor;
}

+ (CGRect)frameForAnchor1:(DSPGridPoint)anchor1 andAnchor2:(DSPGridPoint)anchor2 forGridScale:(CGFloat)gridScale;
{
    DSPGridRect gridFrame;
    gridFrame.origin.x = anchor1.x - kDefaultWidth/2;
    gridFrame.origin.y = anchor1.y;
    gridFrame.size.width = kDefaultWidth;
    gridFrame.size.height = anchor2.y - anchor1.y;
    
    CGRect realFrame = [DSPHelper getRealRectFromGridRect:gridFrame forGridScale:gridScale];
    return realFrame;
}

@end
