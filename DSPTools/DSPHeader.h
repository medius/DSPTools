//
//  DSPHeader.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>

// Grid Point
struct DSPGridPoint {
    NSUInteger x;
    NSUInteger y;
};
typedef struct DSPGridPoint DSPGridPoint;

// Grid Size
struct DSPGridSize {
    NSUInteger width;
    NSUInteger height;
};
typedef struct DSPGridSize DSPGridSize;

// Grid Rectangle
struct DSPGridRect {
    DSPGridPoint origin;
    DSPGridSize size;
};
typedef struct DSPGridRect DSPGridRect;