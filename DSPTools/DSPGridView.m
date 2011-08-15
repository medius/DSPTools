//
//  DSPGridView.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPGridView.h"
#import "DSPHeader.h"
#import "DSPGlobalSettings.h"

@implementation DSPGridView

@synthesize gridPointColor;

- (UIColor *)gridPointColor
{
    if (!gridPointColor)
    {
        gridPointColor = [[UIColor alloc] init];
    }
    return gridPointColor;
}

- (void)setup
{
    self.backgroundColor = [UIColor whiteColor];
    self.gridPointColor = [UIColor grayColor];
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

- (void)awakeFromNib
{
    [self setup];
}

- (void)updateUI
{
    [self setNeedsDisplay];
}

#define GRID_POINT_RADIUS 0.5     // Radius of a grid point

- (void)drawGridPointAt:(CGPoint)point inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
	CGContextBeginPath(context);
    CGContextSetStrokeColorWithColor(context, [self.gridPointColor CGColor]);
	CGContextAddArc(context, point.x, point.y, GRID_POINT_RADIUS, 0, 2*M_PI, YES);
	CGContextStrokePath(context);
	UIGraphicsPopContext();
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Get the gridScale
    CGFloat gridScale = [DSPGlobalSettings sharedGlobalSettings].gridScale;
    
    // Get the current context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Start point of the grid
    CGPoint startPoint;
    startPoint.x = self.bounds.origin.x;
    startPoint.y = self.bounds.origin.y;
    
    // End point of the grid 
    // Note: This may not be the actual end point, but establishes the limits on the screen
    // for the grid points
    CGPoint endPoint;
    endPoint.x = self.bounds.origin.x + self.bounds.size.width;
    endPoint.y = self.bounds.origin.y + self.bounds.size.height;
    
    // Draw the main grid
    CGPoint currentPoint;
    for (currentPoint.x = startPoint.x; currentPoint.x <= endPoint.x; currentPoint.x += gridScale) {
        for (currentPoint.y = startPoint.y; currentPoint.y <= endPoint.y; currentPoint.y += gridScale) {
            [self drawGridPointAt:currentPoint inContext:context];
        }
    }
    
}


- (void)dealloc
{
    [gridPointColor release];
    [super dealloc];
}


@end
