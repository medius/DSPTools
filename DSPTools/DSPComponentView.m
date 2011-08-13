//
//  DSPComponentView.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPComponentView.h"
#import "DSPHeader.h"
#import "DSPGlobalSettings.h"
#import "DSPGrid.h"

@implementation DSPComponentView

// Setters/getters
@synthesize origin, size;
@synthesize lineColor, lineWidth;

- (void)setupShape
{
    // Override this in subclasses to setup shape properties
}

- (void)setup
{
    [self setupShape];
    self.backgroundColor = [UIColor clearColor];
    self.lineColor = [UIColor blueColor];
    self.lineWidth = 1.0;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)prepareDealloc
{
    // Release objects here in subclasses 
}

- (void)dealloc
{
    [self prepareDealloc];
    [super dealloc];
}

// Draw a box for a given rectangle on a grid
+ (void)drawBoxForGridRect:(DSPGridRect)gridRect 
             withLineWidth:(CGFloat)lineWidth 
             withLineColor:(UIColor *)lineColor
{
    CGRect realRect = [DSPGrid getRealRectFromGridRect:gridRect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    // Set the line width, line color, and fill color
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, [lineColor CGColor]);
    CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);

    // Draw the box
    CGContextAddRect(context, CGRectMake(realRect.origin.x, realRect.origin.y, realRect.size.width, realRect.size.height));
    CGContextDrawPath(context, kCGPathFillStroke);

    UIGraphicsPopContext();
}

// Draw a line on the grid from one point to the other 
+ (void)drawLineFromPoint:(DSPGridPoint)startPoint 
                  toPoint:(DSPGridPoint)endPoint 
            withLineWidth:(CGFloat)lineWidth 
            withLineColor:(UIColor *)lineColor
{
    CGPoint realStartPoint = [DSPGrid getRealPointFromGridPoint:startPoint];
    CGPoint realEndPoint = [DSPGrid getRealPointFromGridPoint:endPoint];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);

    // Set the line width and line color
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, [lineColor CGColor]);
    
    // Draw the line
    CGContextMoveToPoint(context, realStartPoint.x, realStartPoint.y);
    CGContextAddLineToPoint(context, realEndPoint.x, realEndPoint.y);
    CGContextStrokePath(context);
    
    UIGraphicsPopContext();
}

@end
