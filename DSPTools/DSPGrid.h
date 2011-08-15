//
//  DSPGrid.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/12/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSPHeader.h"

@interface DSPGrid : NSObject {
    
}

// Get the real point from grid point
+ (CGPoint)getRealPointFromGridPoint:(DSPGridPoint)gridPoint;

// Get the real size from grid size
+ (CGSize)getRealSizeFromGridSize:(DSPGridSize)gridSize;

// Get the real rect from grid rect
+ (CGRect)getRealRectFromGridRect:(DSPGridRect)gridRect;

// Get the grid point from a real point
+ (DSPGridPoint)getGridPointFromRealPoint:(CGPoint)realPoint;

@end
