//
//  DSPGrid.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/12/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPGrid.h"
#import "DSPGlobalSettings.h"

@implementation DSPGrid


// Get the real point from grid point
+ (CGPoint)getRealPointFromGridPoint:(DSPGridPoint)gridPoint
{
    CGPoint realPoint;
    
    // Get the gridScale
    CGFloat gridScale = [DSPGlobalSettings sharedGlobalSettings].gridScale;
    
    realPoint.x = gridPoint.x * gridScale;
    realPoint.y = gridPoint.y * gridScale;
    return realPoint;
}

// Get the real size from grid size
+ (CGSize)getRealSizeFromGridSize:(DSPGridSize)gridSize
{
    CGSize realSize;
    
    // Get the gridScale
    CGFloat gridScale = [DSPGlobalSettings sharedGlobalSettings].gridScale;
    
    realSize.width = gridSize.width * gridScale;
    realSize.height = gridSize.height * gridScale;
    return realSize;
}

// Get the real rect from grid rect
+ (CGRect)getRealRectFromGridRect:(DSPGridRect)gridRect
{
    CGRect realRect;
    
    realRect.origin = [self getRealPointFromGridPoint:gridRect.origin];
    realRect.size = [self getRealSizeFromGridSize:gridRect.size];
    return realRect;
}

// Get the grid point from a real point
+ (DSPGridPoint)getGridPointFromRealPoint:(CGPoint)realPoint
{
    DSPGridPoint gridPoint;
    
    // Get the gridScale
    CGFloat gridScale = [DSPGlobalSettings sharedGlobalSettings].gridScale;
    
    gridPoint.x = roundf(realPoint.x/gridScale);
    gridPoint.y = roundf(realPoint.y/gridScale);
    
    return gridPoint;
}

@end
