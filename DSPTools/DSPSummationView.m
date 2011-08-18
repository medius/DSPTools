//
//  DSPSummationView.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/17/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPSummationView.h"
#import "DSPHelper.h"

@implementation DSPSummationView

- (void)setupShape
{
    DSPGridSize defaultSize;
    defaultSize.width = 4;
    defaultSize.height = 4;
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

@end
