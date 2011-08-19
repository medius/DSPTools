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

@synthesize gridPointColor        = _gridPointColor;
@synthesize wirePoints            = _wirePoints;

- (UIColor *)gridPointColor
{
    if (!_gridPointColor)
    {
        _gridPointColor = [[UIColor alloc] init];
    }
    return _gridPointColor;
}

- (NSMutableArray *)wirePoints
{
    if (!_wirePoints) 
    {
        _wirePoints = [[NSMutableArray array] retain];
    }
    return _wirePoints;
}

- (BOOL)wireDrawingInProgress
{
    return _wireDrawingInProgress;
}

-(void)setWireDrawingInProgress:(BOOL)wireDrawingInProgress
{
    _wireDrawingInProgress = wireDrawingInProgress;
    
    // If wire drawing is in progress, disable dragging of components
    for (DSPComponentView *componentView in self.subviews)
    {
        if (_wireDrawingInProgress)
            componentView.draggable = NO;
        else
            componentView.draggable = YES;
    }
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

- (void)dealloc
{
    [_gridPointColor release];
    [_wirePoints release];
    [super dealloc];
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
    
    // Draw the wire
    BOOL firstPoint = YES;
    DSPGridPoint currentGridPoint, lastGridPoint;
    CGPoint lastPoint;
    if (self.wirePoints) {
        for (id point in self.wirePoints)
        {
            [point getValue:&currentGridPoint];
            
            if (!firstPoint) {
                // Draw line from lastPoint to currentPoint
                currentPoint = [DSPHelper getRealPointFromGridPoint:currentGridPoint forGridScale:gridScale];
                lastPoint = [DSPHelper getRealPointFromGridPoint:lastGridPoint forGridScale:gridScale];
                [DSPHelper drawLineFromPoint:lastPoint toPoint:currentPoint withLineWidth:2.0 withLineColor:[UIColor redColor]];
            }
            lastGridPoint = currentGridPoint;
            firstPoint = NO;
        }
    }

}

- (NSArray *)createWireComponents:(NSArray *)wirePoints
{
    DSPGridPoint wireStartPoint, wireLastPoint, currentGridPoint;
    BOOL isFirstPointOfArray = YES;
    
    NSMutableArray *wires = [NSMutableArray array];
    for (id point in wirePoints)
    {
        // Get the DSPGridPoint value of the current point
        [point getValue:&currentGridPoint];
        
        if (isFirstPointOfArray) {
            wireStartPoint = currentGridPoint;
            wireLastPoint = wireStartPoint;
            isFirstPointOfArray = NO;
        }
        else 
        {
            // If the current point is not along the same line as the wire start and last points,
            // create a wire component between first and last points
            // Also, assign the first and last point for the new wire segment
            if (!((wireStartPoint.x == wireLastPoint.x && wireStartPoint.x == currentGridPoint.x) ||
                  (wireStartPoint.y == wireLastPoint.y && wireStartPoint.y == currentGridPoint.y)))
            {
                // Create wire with wireStartPoint and wireLastPoint
                // TODO: Write wire creating code here
                
                // Assign for latest segment
                wireStartPoint = wireLastPoint;
            }
            // Move the last point to the current point
            wireLastPoint = currentGridPoint;

        }
    }
    
    return wires;
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.wireDrawingInProgress) return;
    
        
    
    UITouch *aTouch = [touches anyObject];
    CGPoint currentTouch = [aTouch locationInView:self];
    
    // Get the gridScale
    CGFloat gridScale = [DSPGlobalSettings sharedGlobalSettings].gridScale;
    
    DSPGridPoint gridPoint = [DSPHelper getGridPointFromRealPoint:currentTouch forGridScale:gridScale];
    [self.wirePoints addObject:[NSValue value: &gridPoint withObjCType:@encode(DSPGridPoint)]];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.wireDrawingInProgress) return;
    
    UITouch *aTouch = [touches anyObject];
    CGPoint currentTouch = [aTouch locationInView:self];
    
    // Get the gridScale
    CGFloat gridScale = [DSPGlobalSettings sharedGlobalSettings].gridScale;
    
    DSPGridPoint gridPoint = [DSPHelper getGridPointFromRealPoint:currentTouch forGridScale:gridScale];
    DSPGridPoint lastPoint;
    [[_wirePoints lastObject] getValue:&lastPoint];
    
    // Convert diagonal movements to horizontal movements
    if (lastPoint.x != gridPoint.x && lastPoint.y != gridPoint.y) gridPoint.y = lastPoint.y;
    
    [self.wirePoints addObject:[NSValue value: &gridPoint withObjCType:@encode(DSPGridPoint)]];
    
    [self updateUI];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
    NSArray *wires = [self createWireComponents:self.wirePoints];
    [self.wirePoints removeAllObjects];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.wirePoints removeAllObjects];
}

@end
