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
#import "DSPHelper.h"
#import "DSPComponentView.h"

static const CGFloat kGridPointRadius = 0.5;

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
    self.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.contentMode = UIViewContentModeRedraw;
    self.backgroundColor = [UIColor whiteColor];
    self.gridPointColor = [UIColor grayColor];
    
    // Create the ability to scale the gridView
    UIPinchGestureRecognizer *pinchgr = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
	[self addGestureRecognizer:pinchgr];
	[pinchgr release];
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

// Update the subviews based on their properties.
- (void)updateSubViews
{
    // Get the gridScale
    CGFloat gridScale = [DSPGlobalSettings sharedGlobalSettings].gridScale;
    
    for (DSPComponentView *componentView in self.subviews)
    {
        componentView.gridScale = gridScale;
        DSPGridPoint origin = componentView.origin;
        DSPGridSize size = componentView.size;
        
        CGPoint realOrigin = [DSPHelper getRealPointFromGridPoint:origin forGridScale:gridScale];
        CGSize realSize = [DSPHelper getRealSizeFromGridSize:size forGridScale:gridScale];
        
        // Use block animations if it is supported (iOS 4.0 and later)
        if ([UIView respondsToSelector:@selector(animateWithDuration:animations:)]) 
        {
            [UIView animateWithDuration:0.0 animations:^{
                componentView.frame = CGRectMake(realOrigin.x, realOrigin.y, 
                                                 realSize.width, realSize.height);
            }];
        }
        // If block animations are not supported, use the old way of animations
        else
        {
            [UIView beginAnimations:@"Scaling A ComponentView" context:nil];
            componentView.frame = CGRectMake(realOrigin.x, realOrigin.y, 
                                             realSize.width, realSize.height);
            [UIView commitAnimations];
        }
        
    }
    
}

- (void)updateUI
{
    [self setNeedsDisplay];
    [self updateSubViews];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawContent:(CGRect)rect
{
    // Get the gridScale
    CGFloat gridScale = [DSPGlobalSettings sharedGlobalSettings].gridScale;
    
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
            [DSPHelper drawCircleAtPoint:currentPoint withRadius:kGridPointRadius withLineWidth:0.5 withLineColor:self.gridPointColor withFillColor:self.gridPointColor];
        }
    }
    
}

// Control scaling with pinch gesture
- (void)pinch:(UIPinchGestureRecognizer *)gesture 
{
	if (gesture.state == UIGestureRecognizerStateChanged ||
		gesture.state == UIGestureRecognizerStateEnded) 
    {
        // Get the gridScale
        CGFloat gridScale = [DSPGlobalSettings sharedGlobalSettings].gridScale;
        
		gridScale *= gesture.scale;
		gesture.scale = 1;
        [DSPGlobalSettings sharedGlobalSettings].gridScale = gridScale;
        [self updateUI];
	}
}


- (void)dealloc
{
    [gridPointColor release];
    [super dealloc];
}


@end
