//
//  DSPIntegratorView.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPIntegratorView.h"
#import "DSPGrid.h"

@implementation DSPIntegratorView

- (void)setupShape
{
    DSPGridSize defaultSize;
    defaultSize.width = 5;
    defaultSize.height = 4;
    size = defaultSize;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Draw the inner box
    DSPGridRect box;
    box.origin.x = 1;
    box.origin.y = 0;
    box.size.width = self.size.width - 2;
    box.size.height = self.size.height;
    
    [DSPComponentView drawBoxForGridRect:box withLineWidth:self.lineWidth withLineColor:self.lineColor];
    
    DSPGridPoint startPoint, endPoint;

    // Draw the input pin
    startPoint.x = 0; startPoint.y = 2;
    endPoint.x = 1; endPoint.y = 2;
    [DSPComponentView drawLineFromPoint:startPoint toPoint:endPoint withLineWidth:lineWidth withLineColor:lineColor];

    // Draw the output pin
    startPoint.x = 4; startPoint.y = 2;
    endPoint.x = 5; endPoint.y = 2;
    [DSPComponentView drawLineFromPoint:startPoint toPoint:endPoint withLineWidth:lineWidth withLineColor:lineColor];
    
    [self setNeedsDisplay];
}

- (void)prepareDealloc
{
    
}

@end
