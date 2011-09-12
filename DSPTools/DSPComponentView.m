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

#define highlightedBackgroundColor blueColor

static const CGFloat kRectangleRadius = 5;
static const CGFloat kDefaultLineWidth = 3.0;
//static const CGFloat kHighlightedLineWidth = 3.0;

@interface DSPComponentView() 
@property CGPoint     inViewTouchLocation;

- (void)updateUI;
@end

@implementation DSPComponentView

#pragma mark - Accessors

@synthesize anchor1             = _anchor1;
@synthesize anchor2             = _anchor2;
@synthesize gridScale           = _gridScale;
@synthesize lineWidth           = _lineWidth;
@synthesize lineColor           = _lineColor;
@synthesize fillColor           = _fillColor;
@synthesize draggable           = _draggable;

@synthesize size                = _size;
@synthesize delegate            = _delegate;
@synthesize inViewTouchLocation = _inViewTouchLocation;
@synthesize rectangleRadius     = _rectangleRadius;


- (void)setAnchor1:(DSPGridPoint)newAnchor1
{
    _anchor1 = newAnchor1;
    [self.delegate anchor1Set:self toValue:newAnchor1];
}

- (void)setAnchor2:(DSPGridPoint)newAnchor2
{
    _anchor2 = newAnchor2;
    [self.delegate anchor2Set:self toValue:newAnchor2];
}

- (BOOL)selected
{
    return _selected;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    if (_selected) 
    {
        self.backgroundColor = [UIColor highlightedBackgroundColor];
        [self updateUI];
    }
    else
    {
        self.backgroundColor = [UIColor clearColor];
        [self updateUI];
    }
}

#pragma mark - Setup and dealloc

- (void)componentViewSetup
{
    // Override this in subclasses to setup shape properties
}

- (void)setup
{
    self.contentMode = UIViewContentModeRedraw;    
    self.backgroundColor = [UIColor clearColor];
    self.lineColor = [UIColor blackColor];
    self.fillColor = [UIColor whiteColor];
    self.lineWidth = kDefaultLineWidth;
    self.rectangleRadius = kRectangleRadius;
    
    // Create the ability to select the component
    UITapGestureRecognizer *tapgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
	[self addGestureRecognizer:tapgr];
	[tapgr release];
    
    [self componentViewSetup];
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

- (void)dealloc
{
    [_lineColor release];
    [super dealloc];
}

// Control scaling with pinch gesture
- (void)tap:(UITapGestureRecognizer *)gesture 
{
	if (self.selected) 
    {
        self.selected = NO;
    }
    else
    {
        self.selected = YES;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.draggable) return;
    if (!self.selected) return;
    
    UITouch *aTouch = [touches anyObject];
    self.inViewTouchLocation = [aTouch locationInView:self];
    self.backgroundColor = [UIColor highlightedBackgroundColor];

    [self updateUI];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    if (!self.draggable) return;
    if (!self.selected) return;

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
    
    // Make the effectiveLocation relative to anchor1
    // TODO: This does not work for blocks whose anchors are at top and bottom. 
    // effectiveLocation.y = effectiveLocation.y + self.size.height/2*self.gridScale;
    
    // Align the new anchor1 to the grid
    DSPGridPoint newAnchor1 = [DSPHelper getGridPointFromRealPoint:effectiveLocation forGridScale:self.gridScale];    
    //CGPoint newRealOrigin = [DSPHelper getRealPointFromGridPoint:newGridOrigin forGridScale:self.gridScale];
    
    DSPGridPoint shift;
    shift.x = newAnchor1.x - self.anchor1.x;
    shift.y = newAnchor1.y - self.anchor1.y;
    
    DSPGridPoint newAnchor2;
    newAnchor2.x = self.anchor2.x + shift.x;
    newAnchor2.y = self.anchor2.y + shift.y;
    
    CGRect frame = [DSPHelper getFrameForObject:self withAnchor1:newAnchor1 withAnchor2:newAnchor2 forGridScale:self.gridScale];
        
    // Change the frame according to the new origin
    // Use block animations if it is supported (iOS 4.0 and later)
    if ([UIView respondsToSelector:@selector(animateWithDuration:animations:)]) 
    {
        [UIView animateWithDuration:0.0 animations:^{
            self.frame = frame;
        }];
    }
    // If block animations are not supported, use the old way of animations
    else
    {
        [UIView beginAnimations:@"Dragging A ComponentView" context:nil];
        self.frame = frame;
        [UIView commitAnimations];
    }
    
    // Save the updated location
    self.anchor1 = newAnchor1;
    self.anchor2 = newAnchor2;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.draggable) return;
    [self updateUI];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.draggable) return;
    [self updateUI];
}


// Subclasses need to implement this
+ (CGRect)defaultFrameForPrimaryAnchor:(DSPGridPoint)anchor forGridScale:(CGFloat)gridScale
{
    // Subclasses need to implement this
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"You must override %@ in a subclass" userInfo:nil];
}

+ (DSPGridPoint)defaultSecondaryAnchorForPrimaryAnchor:(DSPGridPoint)anchor
{
    // Subclasses need to implement this
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"You must override %@ in a subclass" userInfo:nil];   
}

+ (CGRect)frameForAnchor1:(DSPGridPoint)anchor1 andAnchor2:(DSPGridPoint)anchor2 forGridScale:(CGFloat)gridScale;
{
    // Subclasses need to implement this
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"You must override %@ in a subclass" userInfo:nil];
}

@end
