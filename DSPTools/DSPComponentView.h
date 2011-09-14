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

//@protocol DSPComponentAddProtocol <NSObject>
//- (void)addComponent:(DSPComponentView *)componentView;
//@end

@interface DSPComponentView : TTView <NSCopying, NSMutableCopying> {
    DSPGridPoint    _anchor1;
    DSPGridPoint    _anchor2;
    
    CGFloat         _gridScale;
    CGFloat         _lineWidth;
    UIColor*        _lineColor;
    UIColor*        _fillColor;
    BOOL            _isDraggable;
    BOOL            _isSelected;
    BOOL            _isVertical;
    BOOL            _isListMember;
    DSPGridSize     _size;
    
    id <DSPComponentViewDelegate> _delegate;

@private
    CGPoint         _inViewTouchLocation;
    CGPoint         _anchor1RelativeToOrigin;
    CGFloat         _rectangleRadius;
}



@property (nonatomic) DSPGridPoint      anchor1;
@property (nonatomic) DSPGridPoint      anchor2;

@property CGFloat                       gridScale;
@property CGFloat                       lineWidth;
@property (nonatomic, retain) UIColor*  lineColor;
@property (nonatomic, retain) UIColor*  fillColor;
@property BOOL                          isDraggable;
@property BOOL                          isSelected;
@property (readonly) BOOL               isVertical;
@property BOOL                          isListMember;

@property (readonly) DSPGridSize        size;
@property (assign) id <DSPComponentViewDelegate> delegate;

@property CGFloat                       rectangleRadius;


// Provide the default frame for the primary anchor
+ (CGRect)defaultFrameForPrimaryAnchor:(DSPGridPoint)anchor forGridScale:(CGFloat)gridScale;

// Proivde the default secondary anchor for the primary anchor
+ (DSPGridPoint)defaultSecondaryAnchorForPrimaryAnchor:(DSPGridPoint)anchor;

// Provide the frame for given anchors
+ (CGRect)frameForAnchor1:(DSPGridPoint)anchor1 andAnchor2:(DSPGridPoint)anchor2 forGridScale:(CGFloat)gridScale;

@end
