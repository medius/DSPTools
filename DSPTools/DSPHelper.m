//
//  DSPHelper.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/17/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPHelper.h"
#import "Three20/Three20.h"

#import "DSPHeader.h"
#import "DSPGlobalSettings.h"
#import "DSPComponentView.h"

@implementation DSPHelper

// Get the real point from grid point
+ (CGPoint)getRealPointFromGridPoint:(DSPGridPoint)gridPoint forGridScale:(CGFloat)gridScale;
{
    CGPoint realPoint;    
    realPoint.x = gridPoint.x * gridScale;
    realPoint.y = gridPoint.y * gridScale;
    return realPoint;
}

// Get the real size from grid size
+ (CGSize)getRealSizeFromGridSize:(DSPGridSize)gridSize forGridScale:(CGFloat)gridScale;
{
    CGSize realSize;
    realSize.width = gridSize.width * gridScale;
    realSize.height = gridSize.height * gridScale;
    return realSize;
}

// Get the real rect from grid rect
+ (CGRect)getRealRectFromGridRect:(DSPGridRect)gridRect forGridScale:(CGFloat)gridScale;
{
    CGRect realRect;
    realRect.origin = [self getRealPointFromGridPoint:gridRect.origin forGridScale:gridScale];
    realRect.size = [self getRealSizeFromGridSize:gridRect.size forGridScale:gridScale];
    return realRect;
}

// Get the grid point from a real point
+ (DSPGridPoint)getGridPointFromRealPoint:(CGPoint)realPoint forGridScale:(CGFloat)gridScale;
{
    DSPGridPoint gridPoint;
    gridPoint.x = roundf(realPoint.x/gridScale);
    gridPoint.y = roundf(realPoint.y/gridScale);
    return gridPoint;
}

+ (void)drawFilledCircleAtPoint:(CGPoint)point withColor:(UIColor *)color withRadius:(CGFloat)radius inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
	CGContextBeginPath(context);
    CGContextSetStrokeColorWithColor(context, [color CGColor]);
	CGContextAddArc(context, point.x, point.y, radius, 0, 2*M_PI, YES);
	CGContextStrokePath(context);
	UIGraphicsPopContext();
}

// Draw a box for a given rectangle on a grid
+ (void)drawBoxForGridRect:(DSPGridRect)gridRect 
             withLineWidth:(CGFloat)lineWidth 
             withLineColor:(UIColor *)lineColor
             withFillColor:(UIColor *)fillColor
              forGridScale:(CGFloat)gridScale;
{
    CGRect realRect = [self getRealRectFromGridRect:gridRect forGridScale:gridScale];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    // Set the line width, line color, and fill color
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, [lineColor CGColor]);
    CGContextSetFillColorWithColor(context, [fillColor CGColor]);
    
    // Draw the box
    CGContextAddRect(context, CGRectMake(realRect.origin.x, realRect.origin.y, realRect.size.width, realRect.size.height));
    CGContextDrawPath(context, kCGPathFillStroke);
    
    UIGraphicsPopContext();
}

// Draw a line on the grid from one point to the other 
+ (void)drawGridLineFromPoint:(DSPGridPoint)startPoint 
                      toPoint:(DSPGridPoint)endPoint 
                withLineWidth:(CGFloat)lineWidth 
                withLineColor:(UIColor *)lineColor
                 forGridScale:(CGFloat)gridScale
{
    CGPoint realStartPoint = [self getRealPointFromGridPoint:startPoint forGridScale:gridScale];
    CGPoint realEndPoint = [self getRealPointFromGridPoint:endPoint forGridScale:gridScale];
    
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

// Draw a box for a given rectangle
+ (void)drawRoundedBoxForRect:(CGRect)rect 
                   withRadius:(CGFloat)radius
                withLineWidth:(CGFloat)lineWidth 
         withLineColor:(UIColor *)lineColor
         withFillColor:(UIColor *)fillColor
{    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    // Set the line width, line color, and fill color
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, [lineColor CGColor]);
    CGContextSetFillColorWithColor(context, [fillColor CGColor]);
    
    // Draw the box
    TTRoundedRectangleShape *roundedRectangle = [TTRoundedRectangleShape shapeWithRadius:radius];
    [roundedRectangle addToPath:rect];
    //CGContextAddRect(context, CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height));
    CGContextDrawPath(context, kCGPathFillStroke);
    
    UIGraphicsPopContext();
}

// Draw a line from one point to the other 
+ (void)drawLineFromPoint:(CGPoint)startPoint 
                  toPoint:(CGPoint)endPoint 
            withLineWidth:(CGFloat)lineWidth 
            withLineColor:(UIColor *)lineColor
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    // Set the line width and line color
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, [lineColor CGColor]);
    
    // Draw the line
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextStrokePath(context);
    
    UIGraphicsPopContext();
}

// Draw a circle at a point with given radius
+ (void)drawCircleAtPoint:(CGPoint)point 
               withRadius:(CGFloat)radius 
            withLineWidth:(CGFloat)lineWidth 
            withLineColor:(UIColor *)lineColor
            withFillColor:(UIColor *)fillColor
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    // Set the line width and line color
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, [lineColor CGColor]);
    CGContextSetFillColorWithColor(context,[fillColor CGColor]);

    // Draw the circle
    CGContextAddArc(context, point.x, point.y, radius, 0, 2*M_PI, YES);
    CGContextFillPath(context);
    CGContextAddArc(context, point.x, point.y, radius, 0, 2*M_PI, YES);
    CGContextStrokePath(context);

    UIGraphicsPopContext();
}

// Draw sinewaves
+ (void)drawSineWaves:(NSUInteger)numberOfWaves 
               inRect:(CGRect)rect
        withLineWidth:(CGFloat)lineWidth
        withLineColor:(UIColor *)lineColor
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    CGMutablePathRef path = CGPathCreateMutable();
    float x = rect.size.width/numberOfWaves;
    float y = rect.size.height;
    float yc = rect.size.height/2;
    float w = rect.origin.x; 
    float yOffset = rect.origin.y;
    
    while (w<(rect.origin.x+rect.size.width)) {
        CGPathMoveToPoint(path, nil, w,yOffset+y/2);
        CGPathAddQuadCurveToPoint(path, nil, w+x/4, yOffset-yc,w+ x/2, yOffset+y/2);
        CGPathMoveToPoint(path, nil, w+x/2,yOffset+y/2);
        CGPathAddQuadCurveToPoint(path, nil, w+3*x/4, yOffset+y+yc, w+x, yOffset+y/2);
        CGContextAddPath(context, path);
        
        CGContextSetLineWidth(context, lineWidth);
        CGContextSetStrokeColorWithColor(context, [lineColor CGColor]);
        
        CGContextDrawPath(context, kCGPathStroke);
        w+=x;
    }

    UIGraphicsPopContext();
    CGPathRelease(path);

}

// Get the frame for a given object based on its anchors
+ (CGRect)getFrameForObject:(id)object 
                withAnchor1:(DSPGridPoint)anchor1
                withAnchor2:(DSPGridPoint)anchor2
               forGridScale:(CGFloat)gridScale
{
    CGRect frame;
    
    for (NSDictionary *componentInfo in [DSPGlobalSettings sharedGlobalSettings].componentsInfo ) {
        NSString *viewClassName = (NSString *)[componentInfo objectForKey:@"viewClassName"];
        
        if (viewClassName) {
            Class componentViewClass = NSClassFromString(viewClassName);
            
            if ([object isKindOfClass:componentViewClass]) {
                frame = [componentViewClass frameForAnchor1:anchor1 andAnchor2:anchor2 forGridScale:gridScale];
                break;
            }
        }

    }
    return frame;
}


@end

//    if ([object isKindOfClass:[DSPIntegratorView class]])
//    {
//        frame = [DSPIntegratorView frameForAnchor1:anchor1 andAnchor2:anchor2 forGridScale:gridScale];
//    }
//    else if ([object isKindOfClass:[DSPSummationView class]])
//    {
//        frame = [DSPSummationView frameForAnchor1:anchor1 andAnchor2:anchor2 forGridScale:gridScale];
//    }
//    else if ([object isKindOfClass:[DSPWireView class]])
//    {
//        frame = [DSPWireView frameForAnchor1:anchor1 andAnchor2:anchor2 forGridScale:gridScale];
//    }    
//    else if ([object isKindOfClass:[DSPSignalSourceView class]])
//    {
//        frame = [DSPSignalSourceView frameForAnchor1:anchor1 andAnchor2:anchor2 forGridScale:gridScale];
//    }