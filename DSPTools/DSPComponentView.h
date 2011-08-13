//
//  DSPComponentView.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

// This class handles all the common view functions a DSPComponent.

#import <UIKit/UIKit.h>
#import "DSPHeader.h"

@interface DSPComponentView : UIView {
    // Define the bounding box of the component
    // Note: The origin of this rectangle is only relevant in the superview 
    // to decide the frame of this view.
    DSPGridPoint origin;
    DSPGridSize size;
    
    UIColor *lineColor;
    CGFloat lineWidth;
}

@property DSPGridPoint origin;
@property (readonly) DSPGridSize size;

@property (nonatomic, retain) UIColor *lineColor;
@property CGFloat lineWidth;

// Draw a box for a given rectangle on a grid
+ (void)drawBoxForGridRect:(DSPGridRect)gridRect 
             withLineWidth:(CGFloat)lineWidth 
             withLineColor:(UIColor *)lineColor;


// Draw a line on the grid from one point to the other 
+ (void)drawLineFromPoint:(DSPGridPoint)startPoint 
                  toPoint:(DSPGridPoint)endPoint 
            withLineWidth:(CGFloat)lineWidth 
            withLineColor:(UIColor *)lineColor;
@end
