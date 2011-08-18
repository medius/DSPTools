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

@interface DSPGridView : TTView {
    UIColor *gridPointColor;
}

@property (nonatomic, retain) UIColor *gridPointColor;

@end
