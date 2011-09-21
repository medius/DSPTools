//
//  DSPComponentViewController.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

// This will handle the properties of components like scale, frequency, etc.
// when editing for a give circuit.
// Is this the right place for it. Handling setting is not handling the component view,
// it's handling setting view.

#import <UIKit/UIKit.h>
#import "Three20/Three20.h"
#import "DSPComponentModel.h"
#import "DSPComponentView.h"

@interface DSPComponentViewController : TTViewController <DSPComponentViewDelegate> {
    DSPComponentModel *_componentModel;
    DSPComponentView  *_componentView;
    BOOL               _isWire;
}

@property (nonatomic, retain) DSPComponentModel *componentModel;
@property (nonatomic, retain) DSPComponentView  *componentView;
@property (nonatomic, readonly) BOOL             isWire;

@end
