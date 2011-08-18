//
//  DSPSystemViewController.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/16/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Three20UI/Three20UI.h"

@class DSPGridView;
@class DSPComponentListView;

@interface DSPSystemViewController : TTViewController {
@private
    TTView*                 _systemView;
    DSPGridView*            _gridView;
    DSPComponentListView*   _componentListView;
}

@property (readonly) TTView*                systemView;
@property (readonly) DSPGridView*           gridView;
@property (readonly) DSPComponentListView*  componentListView;

@end
