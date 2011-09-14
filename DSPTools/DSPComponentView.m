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
@property (nonatomic) CGPoint inViewTouchLocation;
@property (nonatomic) CGPoint anchor1RelativeToOrigin;

- (void)updateUI;
- (DSPComponentView *)copyComponentView;
@end

@implementation DSPComponentView

#pragma mark - Accessors

@synthesize anchor1             = _anchor1;
@synthesize anchor2             = _anchor2;
@synthesize gridScale           = _gridScale;
@synthesize lineWidth           = _lineWidth;
@synthesize lineColor           = _lineColor;
@synthesize fillColor           = _fillColor;
@synthesize isDraggable         = _isDraggable;
@synthesize isListMember        = _isListMember;

@synthesize size                = _size;
@synthesize delegate            = _delegate;
@synthesize inViewTouchLocation = _inViewTouchLocation;
@synthesize anchor1RelativeToOrigin = _anchor1RelativeToOrigin;
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

- (BOOL)isSelected
{
    return _isSelected;
}

- (void)setIsSelected:(BOOL)newIsSelected
{
    if (newIsSelected != _isSelected) {
        _isSelected = newIsSelected;
        if (_isSelected) {
            self.backgroundColor = [UIColor highlightedBackgroundColor];
            [self updateUI];
        }
        else {
            self.backgroundColor = [UIColor clearColor];
            [self updateUI];
        }
    }
}

- (BOOL)isVertical
{
    if (_anchor1.x == _anchor2.x) {
        _isVertical = YES;
    }
    else {
        _isVertical = NO;
    }
    return _isVertical;
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
    TT_RELEASE_SAFELY(_lineColor);
    [super dealloc];
}

#pragma mark - Touch management

// Control scaling with pinch gesture
- (void)tap:(UITapGestureRecognizer *)gesture 
{
	if (self.isSelected) {
        self.isSelected = NO;
    }
    else {
        self.isSelected = YES;
    }
}

// Extend UIView with this?
- (void)animateToFrame:(CGRect)newFrame
{
    // Use block animations if it is supported (iOS 4.0 and later)
    if ([UIView respondsToSelector:@selector(animateWithDuration:animations:)]) {
        [UIView animateWithDuration:0.0 animations:^{
            self.frame = newFrame;
        }];
    }
    // If block animations are not supported, use the old way of animations
    else {
        [UIView beginAnimations:@"Dragging A ComponentView" context:nil];
        self.frame = newFrame;
        [UIView commitAnimations];
    }
}

- (void)snapToGrid
{
    CGPoint realNewAnchor1 = CGPointMake(self.frame.origin.x+self.anchor1RelativeToOrigin.x, self.frame.origin.y+self.anchor1RelativeToOrigin.y);
    
    // Align the new anchor1 to the grid
    DSPGridPoint newAnchor1 = [DSPHelper getGridPointFromRealPoint:realNewAnchor1 forGridScale:self.gridScale];    
    
    DSPGridPoint shift;
    shift.x = newAnchor1.x - self.anchor1.x;
    shift.y = newAnchor1.y - self.anchor1.y;
    
    DSPGridPoint newAnchor2;
    newAnchor2.x = self.anchor2.x + shift.x;
    newAnchor2.y = self.anchor2.y + shift.y;
    
    CGRect frame = [DSPHelper getFrameForObject:self withAnchor1:newAnchor1 withAnchor2:newAnchor2 forGridScale:self.gridScale];
    [self animateToFrame:frame];
    
    // Save the updated location
    self.anchor1 = newAnchor1;
    self.anchor2 = newAnchor2;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // If addDelegate is assigned, it is probably a componentlist member
    // TODO: This is a really bad coding. ComponentView should not know anything about componentlist, etc.
    if (self.isListMember) {
        Class classOfSelf = [self class];
        DSPComponentView *viewCopy = [[classOfSelf alloc] init];
        
        [self.superview.superview addSubview:self];
        [self.superview addSubview:viewCopy];
        [viewCopy release];
        self.isDraggable = YES;
    }
    
    if (!self.isDraggable) return;
    //if (!self.selected) return;
    
    UITouch *aTouch = [touches anyObject];
    self.inViewTouchLocation = [aTouch locationInView:self];
    
    // TODO: This way of doing might give a lot of problems as it relies heavily on the initial position of the component
    // When a component is moving from a componentbar to the grid, this might not be there.
    CGPoint realNewAnchor1 = [DSPHelper getRealPointFromGridPoint:self.anchor1 forGridScale:self.gridScale];
    self.anchor1RelativeToOrigin = CGPointMake(realNewAnchor1.x-self.frame.origin.x, realNewAnchor1.y-self.frame.origin.y);
    
    [self updateUI];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
    if (!self.isDraggable) return;
    //if (!self.selected) return;

    UITouch *aTouch = [touches anyObject];
    CGPoint location = [aTouch locationInView:self.superview];
    
    // Get the effective location so that the frame origin in not set to
    // the touch location. 
    CGPoint effectiveLocation;
    effectiveLocation.x = location.x - self.inViewTouchLocation.x;
    effectiveLocation.y = location.y - self.inViewTouchLocation.y;
    
    // Keep the view confined to the screen
    if (effectiveLocation.x < self.superview.bounds.origin.x) {
        effectiveLocation.x = self.superview.bounds.origin.x;
    }
    
    if (effectiveLocation.y < self.superview.bounds.origin.y) {
        effectiveLocation.y = self.superview.bounds.origin.y;
    }
    
    if (effectiveLocation.x + self.frame.size.width > self.superview.bounds.origin.x + self.superview.bounds.size.width) {
        effectiveLocation.x = self.superview.bounds.origin.x + self.superview.bounds.size.width - self.frame.size.width;
    }
    
    if (effectiveLocation.y + self.frame.size.height > self.superview.bounds.origin.y + self.superview.bounds.size.height) {
        effectiveLocation.y = self.superview.bounds.origin.y + self.superview.bounds.size.height - self.frame.size.width;
    }

    CGRect frame = CGRectMake(effectiveLocation.x, effectiveLocation.y, self.frame.size.width, self.frame.size.height);
    [self animateToFrame:frame];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.isDraggable) return;
    [self snapToGrid];
    [self updateUI];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.isDraggable) return;
    [self snapToGrid];
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

#pragma mark -
#pragma mark NSCopying methods

-(id)copyWithZone:(NSZone *)zone
{
    DSPComponentView *viewCopy = [[DSPComponentView allocWithZone:zone] init];
    
    viewCopy->_anchor1 = self->_anchor1;
    viewCopy->_anchor2 = self->_anchor2;
    viewCopy->_gridScale = self->_gridScale;
    viewCopy->_lineWidth = self->_lineWidth;
    viewCopy->_lineColor = [self->_lineColor copy];
    viewCopy->_fillColor = [self->_fillColor copy];
    viewCopy->_isDraggable = self->_isDraggable;
    viewCopy->_isSelected = self->_isSelected;
    viewCopy->_isVertical = self->_isVertical;
    viewCopy->_isListMember = self->_isListMember;
    viewCopy->_size = self->_size;
    
    viewCopy->_inViewTouchLocation = self->_inViewTouchLocation;
    viewCopy->_anchor1RelativeToOrigin = self->_anchor1RelativeToOrigin;
    viewCopy->_rectangleRadius = self->_rectangleRadius;
    
    return viewCopy;
}

- (DSPComponentView *)copyComponentView
{
    DSPComponentView *viewCopy = [[DSPComponentView alloc] init];
 	
    viewCopy->_anchor1 = self->_anchor1;
    viewCopy->_anchor2 = self->_anchor2;
    viewCopy->_gridScale = self->_gridScale;
    viewCopy->_lineWidth = self->_lineWidth;
    viewCopy->_lineColor = [self->_lineColor copy];
    viewCopy->_fillColor = [self->_fillColor copy];
    viewCopy->_isDraggable = self->_isDraggable;
    viewCopy->_isSelected = self->_isSelected;
    viewCopy->_isVertical = self->_isVertical;
    viewCopy->_isListMember = self->_isListMember;
    viewCopy->_size = self->_size;
    
    viewCopy->_inViewTouchLocation = self->_inViewTouchLocation;
    viewCopy->_anchor1RelativeToOrigin = self->_anchor1RelativeToOrigin;
    viewCopy->_rectangleRadius = self->_rectangleRadius;
    
    return viewCopy;
}

@end
