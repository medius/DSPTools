//
//  DSPComponentListView.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/17/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Three20/Three20.h"

@interface DSPComponentListView : UIScrollView {
    CGFloat _gridScale;
}

@property (nonatomic) CGFloat gridScale;

- (id)initWithFrame:(CGRect)frame andGridScale:(CGFloat)initGridScale;

@end
