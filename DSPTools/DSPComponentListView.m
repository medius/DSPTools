//
//  DSPComponentListView.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/17/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPComponentListView.h"
#import "Three20UI/Three20UI+Additions.h"
#import "DSPHelper.h"

#import "DSPIntegratorView.h"
#import "DSPSummationView.h"

static const CGFloat kDefaultWidth = 1500;

@implementation DSPComponentListView

- (void)setup
{
    self.contentMode = UIViewContentModeRedraw;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth|
                            UIViewAutoresizingFlexibleTopMargin|
                            UIViewAutoresizingFlexibleBottomMargin;
    self.showsVerticalScrollIndicator = NO;    
    self.contentSize = CGSizeMake(kDefaultWidth, self.height);
    
    CGFloat gridScale = 12;

    DSPIntegratorView *dspIV = [[DSPIntegratorView alloc] init];    
    
    DSPGridPoint componentLocation;
    componentLocation.x = 1;
    componentLocation.y = 0;
    dspIV.origin = componentLocation;
    
    DSPGridRect componentFrame; 
    componentFrame.origin = dspIV.origin;
    componentFrame.size = dspIV.size;
    dspIV.frame = [DSPHelper getRealRectFromGridRect:componentFrame forGridScale:gridScale];
    dspIV.gridScale = gridScale;
    dspIV.draggable = NO;
    dspIV.lineColor = [UIColor blackColor];
    dspIV.fillColor = [UIColor clearColor];
    
    [self addSubview:dspIV];
    
    DSPSummationView *dspSV = [[DSPSummationView alloc] init];
    
    componentLocation.x = dspIV.frame.size.width;
    [dspIV release];

    componentLocation.y = 0;
    dspSV.origin = componentLocation;
    
    componentFrame.origin = dspSV.origin;
    componentFrame.size = dspSV.size;
    dspSV.frame = [DSPHelper getRealRectFromGridRect:componentFrame forGridScale:gridScale];
    dspSV.gridScale = gridScale;
    dspSV.draggable = NO;
    dspSV.lineColor = [UIColor blackColor];
    dspSV.fillColor = [UIColor clearColor];
    
    [self addSubview:dspSV];
    [dspSV release];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
