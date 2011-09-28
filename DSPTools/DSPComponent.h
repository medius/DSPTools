//
//  DSPComponent.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Three20/Three20.h"
#import "DSPComponentView.h"

@class DSPComponentModel;

@interface DSPComponent : NSObject <DSPComponentViewDelegate> {
    DSPComponentModel *_model;
    DSPComponentView  *_view;
    BOOL               _isWire;
    BOOL               _isScope;
}

@property (nonatomic, retain) DSPComponentModel *model;
@property (nonatomic, retain) DSPComponentView  *view;
@property (nonatomic, readonly) BOOL             isWire;
@property (nonatomic, readonly) BOOL             isScope;

@end
