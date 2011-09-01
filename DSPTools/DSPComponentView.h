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

@class DSPComponentView;

@protocol DSPComponentViewDelegate
- (void)anchor1Set:(DSPComponentView *)requestor toValue:(DSPGridPoint)newValue;
- (void)anchor2Set:(DSPComponentView *)requestor toValue:(DSPGridPoint)newValue;
@end

@interface DSPComponentView : TTView {
    DSPGridPoint    _anchor1;
    DSPGridPoint    _anchor2;
    
    CGFloat         _gridScale;
    CGFloat         _lineWidth;
    UIColor*        _lineColor;
    UIColor*        _fillColor;
    BOOL            _draggable;
    BOOL            _selected;
   
    DSPGridSize     _size;
    
    id <DSPComponentViewDelegate> _delegate;

@private
    CGPoint         _inViewTouchLocation;
    CGFloat         _rectangleRadius;
}



@property (nonatomic) DSPGridPoint      anchor1;
@property (nonatomic) DSPGridPoint      anchor2;

@property CGFloat                       gridScale;
@property CGFloat                       lineWidth;
@property (nonatomic, retain) UIColor*  lineColor;
@property (nonatomic, retain) UIColor*  fillColor;
@property BOOL                          draggable;  // isDraggable
@property BOOL                          selected;   // isSelected

@property (readonly) DSPGridSize        size;
@property (assign) id <DSPComponentViewDelegate> delegate;

@property CGFloat                       rectangleRadius;

@end
