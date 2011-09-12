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

#import "DSPComponents.h"

static const CGFloat kDefaultWidth = 1000;

@implementation DSPComponentListView

#pragma mark - Accessors
@synthesize gridScale = _gridScale;

- (void)setGridScale:(CGFloat)newGridScale
{
    if (newGridScale != _gridScale) {
        _gridScale = newGridScale;
        // TODO: Update the gridscale of all the components
    }
}

#pragma mark - Setup and dealloc

- (void)setup
{
    self.contentMode = UIViewContentModeRedraw;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth|
                            UIViewAutoresizingFlexibleTopMargin|
                            UIViewAutoresizingFlexibleBottomMargin;
    self.showsVerticalScrollIndicator = NO;    
    self.contentSize = CGSizeMake(kDefaultWidth, self.height);
    
    DSPGridPoint anchor1, anchor2;

    // Integrator
    DSPIntegratorView *dspIV = [[DSPIntegratorView alloc] init];        
    anchor1.x = 1;
    anchor1.y = 3;
    anchor2 = [DSPIntegratorView defaultSecondaryAnchorForPrimaryAnchor:anchor1];
    dspIV.frame = [DSPIntegratorView defaultFrameForPrimaryAnchor:anchor1 forGridScale:_gridScale];
    dspIV.anchor1 = anchor1;
    dspIV.anchor2 = anchor2;
    dspIV.gridScale = _gridScale;
    dspIV.draggable = NO;
    dspIV.lineColor = [UIColor blackColor];
    dspIV.fillColor = [UIColor clearColor];
    [self addSubview:dspIV];
    [dspIV release];

    // Signal Source
    DSPSignalSourceView *dspSSV = [[DSPSignalSourceView alloc] init];
    anchor1.x = 7;
    anchor1.y = 2;
    anchor2 = [DSPSignalSourceView defaultSecondaryAnchorForPrimaryAnchor:anchor1];
    dspSSV.frame = [DSPSignalSourceView defaultFrameForPrimaryAnchor:anchor1 forGridScale:self.gridScale];
    dspSSV.anchor1 = anchor1;
    dspSSV.anchor2 = anchor2;
    dspSSV.gridScale = _gridScale;
    dspSSV.draggable = NO;
    dspSSV.lineColor = [UIColor blackColor];
    dspSSV.fillColor = [UIColor clearColor];
    [self addSubview:dspSSV];
    [dspSSV release];
}

- (id)initWithFrame:(CGRect)frame andGridScale:(CGFloat)initGridScale;
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _gridScale = initGridScale;
        [self setup];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end
