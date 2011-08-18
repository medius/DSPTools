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
#import "DSPHelper.h"

static const CGFloat kRectangleRadius = 5;

@implementation DSPComponentView

// Setters/getters
@synthesize origin              = _origin;
@synthesize size                = _size;
@synthesize lineWidth           = _lineWidth;
@synthesize lineColor           = _lineColor;
@synthesize fillColor           = _fillColor;
@synthesize draggable           = _draggable;
@synthesize inViewTouchLocation = _inViewTouchLocation;
@synthesize rectangleRadius     = _rectangleRadius;

//// Override the frame setting to add an extra margin
//- (void)setFrame:(CGRect)newFrame
//{
//    CGRect frame = CGRectMake(newFrame.origin.x - self.frameMargin, newFrame.origin.y - self.frameMargin, newFrame.size.width + self.frameMargin*2, newFrame.size.height + self.frameMargin*2);
//    [super setFrame:frame];
//}

- (CGFloat)gridScale
{
    return _gridScale;
}

- (void)setGridScale:(CGFloat)gridScale
{
    _gridScale = gridScale;
}

- (void)setupShape
{
    // Override this in subclasses to setup shape properties
}

- (void)setup
{
    [self setupShape];
    self.contentMode = UIViewContentModeRedraw;    
    self.backgroundColor = [UIColor clearColor];
    self.lineColor = [UIColor blueColor];
    self.fillColor = [UIColor whiteColor];
    self.lineWidth = 2.0;
    self.rectangleRadius = kRectangleRadius;
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [_lineColor release];
    [super dealloc];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.draggable) return;
    UITouch *aTouch = [touches anyObject];
    self.inViewTouchLocation = [aTouch locationInView:self];
    self.lineWidth = 4.0;
    self.backgroundColor = [UIColor yellowColor];
    [self updateUI];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.draggable) return;
    
    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self.superview];
    
    // Get the effective location so that the frame origin in not set to
    // the touch location. 
    CGPoint effectiveLocation;
    effectiveLocation.x = location.x - self.inViewTouchLocation.x;
    effectiveLocation.y = location.y - self.inViewTouchLocation.y;
    
    // Keep the view confined to the screen
    if (effectiveLocation.x < self.superview.bounds.origin.x) 
    {
        effectiveLocation.x = self.superview.bounds.origin.x;
    }
    
    if (effectiveLocation.y < self.superview.bounds.origin.y) 
    {
        effectiveLocation.y = self.superview.bounds.origin.y;
    }
    
    if (effectiveLocation.x + self.frame.size.width > self.superview.bounds.origin.x + self.superview.bounds.size.width) 
    {
        effectiveLocation.x = self.superview.bounds.origin.x + self.superview.bounds.size.width - self.frame.size.width;
    }
    
    if (effectiveLocation.y + self.frame.size.height > self.superview.bounds.origin.y + self.superview.bounds.size.height) 
    {
        effectiveLocation.y = self.superview.bounds.origin.y + self.superview.bounds.size.height - self.frame.size.width;
    }
    
    // Align the new location to the grid
    DSPGridPoint newGridOrigin = [DSPHelper getGridPointFromRealPoint:effectiveLocation forGridScale:self.gridScale];    
    CGPoint newRealOrigin = [DSPHelper getRealPointFromGridPoint:newGridOrigin forGridScale:self.gridScale];
    
    // Change the frame according to the new origin
    // Use block animations if it is supported (iOS 4.0 and later)
    if ([UIView respondsToSelector:@selector(animateWithDuration:animations:)]) 
    {
        [UIView animateWithDuration:0.0 animations:^{
            self.frame = CGRectMake(newRealOrigin.x, newRealOrigin.y, 
                                    self.frame.size.width, self.frame.size.height);
        }];
    }
    // If block animations are not supported, use the old way of animations
    else
    {
        [UIView beginAnimations:@"Dragging A ComponentView" context:nil];
        self.frame = CGRectMake(newRealOrigin.x, newRealOrigin.y, 
                                self.frame.size.width, self.frame.size.height);
        [UIView commitAnimations];
    }
    
    // Save the updated location
    self.origin = newGridOrigin;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.draggable) return;
    self.lineWidth = 2.0;
    self.backgroundColor = [UIColor clearColor];
    [self updateUI];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.draggable) return;
    self.lineWidth = 2.0;
    self.backgroundColor = [UIColor clearColor];
    [self updateUI];
}

@end
