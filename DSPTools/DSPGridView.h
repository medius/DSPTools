//
//  DSPGridView.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

// *** This should be a singleton class?

#import <UIKit/UIKit.h>
#import "Three20/Three20.h"
#import "DSPHeader.h"

@protocol DSPWireCreation <NSObject>
- (void)createWireforAnchor1:(DSPGridPoint)anchor1 andAnchor2:(DSPGridPoint)anchor2;
@end

@interface DSPGridView : TTView {
    CGFloat     _gridScale;
    UIColor*    _gridPointColor;
    BOOL        _wireDrawingInProgress;
    
    id <DSPWireCreation> _delegate;
    
@private
    NSMutableArray* _wirePoints;
}

@property (nonatomic) CGFloat          gridScale;
@property (nonatomic, retain) UIColor* gridPointColor;
@property BOOL                         wireDrawingInProgress;
@property (assign) id <DSPWireCreation>         delegate;

@property (nonatomic, retain )NSMutableArray* wirePoints;
@end
