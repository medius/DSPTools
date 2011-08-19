//
//  DSPIntegratorView.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPIntegratorView.h"
#import "DSPHelper.h"

@implementation DSPIntegratorView

- (void)setupShape
{
    DSPGridSize defaultSize;
    defaultSize.width = 4;
    defaultSize.height = 6;
    _size = defaultSize;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawContent:(CGRect)rect
{   
    CGFloat margin = self.gridScale/2;
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




@end
