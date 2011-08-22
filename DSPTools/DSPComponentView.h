//
//  DSPComponentView.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

// This class handles all the common view functions a DSPComponent.

#import <UIKit/UIKit.h>
#import "Three20/Three20.h"
#import "DSPHeader.h"

@interface DSPComponentView : TTView {
    DSPGridSize     _size;
    
    DSPGridPoint    _anchor1;
    DSPGridPoint    _anchor2;
    
    CGFloat         _gridScale;
    CGFloat         _lineWidth;
    UIColor*        _lineColor;
    UIColor*        _fillColor;
    BOOL            _draggable;
    BOOL            _selected;
    
@private
    CGPoint         _inViewTouchLocation;
    CGFloat         _rectangleRadius;
}

@property (readonly) DSPGridSize        size;

@property DSPGridPoint                  anchor1;
@property DSPGridPoint                  anchor2;

@property CGFloat gridScale;
@property CGFloat lineWidth;
@property (nonatomic, retain) UIColor*  lineColor;
@property (nonatomic, retain) UIColor*  fillColor;
@property BOOL                          draggable;
@property BOOL                          selected;

@property CGPoint                       inViewTouchLocation;
@property CGFloat                       rectangleRadius;

@end
