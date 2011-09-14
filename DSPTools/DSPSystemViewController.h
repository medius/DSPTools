//
//  DSPSystemViewController.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/16/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Three20UI/Three20UI.h"
#import "DSPGridView.h"

@class DSPGridView;
@class DSPComponentListView;

@interface DSPSystemViewController : TTViewController <DSPWireCreation> {
@private
    TTView*                 _systemView;
    DSPGridView*            _gridView;
    DSPComponentListView*   _componentListView;
    NSMutableDictionary*    _circuit;   // I am not sure if this needed as instance variable. What about simulaton model?
}

@property (readonly) TTView*                systemView;
@property (readonly) DSPGridView*           gridView;
@property (readonly) DSPComponentListView*  componentListView;
@property (readonly) NSMutableDictionary*   circuit;

// Initialize with a circuit file
- (id)initWithCircuitFile:(NSString *)filePath;

@end
