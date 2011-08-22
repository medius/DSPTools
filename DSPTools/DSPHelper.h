//
//  DSPHelper.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/17/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSPHeader.h"

@interface DSPHelper : NSObject {
    
}

// Get the real point from grid point
+ (CGPoint)getRealPointFromGridPoint:(DSPGridPoint)gridPoint forGridScale:(CGFloat)gridScale;;

// Get the real size from grid size
+ (CGSize)getRealSizeFromGridSize:(DSPGridSize)gridSize forGridScale:(CGFloat)gridScale;;

// Get the real rect from grid rect
+ (CGRect)getRealRectFromGridRect:(DSPGridRect)gridRect forGridScale:(CGFloat)gridScale;;

// Get the grid point from a real point
+ (DSPGridPoint)getGridPointFromRealPoint:(CGPoint)realPoint forGridScale:(CGFloat)gridScale;;

// Draw a circle at a given point
+ (void)drawFilledCircleAtPoint:(CGPoint)point withColor:(UIColor *)color withRadius:(CGFloat)radius inContext:(CGContextRef)context;

// Draw a box for a given rectangle on a grid
+ (void)drawBoxForGridRect:(DSPGridRect)gridRect 
             withLineWidth:(CGFloat)lineWidth 
             withLineColor:(UIColor *)lineColor
             withFillColor:(UIColor *)fillColor
              forGridScale:(CGFloat)gridScale;


// Draw a line on the grid from one point to the other 
+ (void)drawGridLineFromPoint:(DSPGridPoint)startPoint 
                      toPoint:(DSPGridPoint)endPoint 
                withLineWidth:(CGFloat)lineWidth 
                withLineColor:(UIColor *)lineColor
                 forGridScale:(CGFloat)gridScale;

// Draw a box for a given rectangle
+ (void)drawRoundedBoxForRect:(CGRect)rect
                   withRadius:(CGFloat)radius
                withLineWidth:(CGFloat)lineWidth 
                withLineColor:(UIColor *)lineColor
                withFillColor:(UIColor *)fillColor;

// Draw a line from one point to the other 
+ (void)drawLineFromPoint:(CGPoint)startPoint 
                  toPoint:(CGPoint)endPoint 
            withLineWidth:(CGFloat)lineWidth 
            withLineColor:(UIColor *)lineColor;

// Draw a circle at a point with given radius
+ (void)drawCircleAtPoint:(CGPoint)point 
               withRadius:(CGFloat)radius 
            withLineWidth:(CGFloat)lineWidth 
            withLineColor:(UIColor *)lineColor
            withFillColor:(UIColor *)fillColor;

// Get the frame for a given object based on its anchors
+ (CGRect)getFrameForObject:(id)object 
                withAnchor1:(DSPGridPoint)anchor1
                withAnchor2:(DSPGridPoint)anchor2
               forGridScale:(CGFloat)gridScale;


@end
