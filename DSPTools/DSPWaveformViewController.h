//
//  DSPWaveformViewController.h
//  DSPTools
//
//  Created by Puru Choudhary on 9/8/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSPHeader.h"
#import "Three20/Three20.h"
#import "CorePlot-CocoaTouch.h"

@protocol DSPWaveformViewDelegate
- (NSNumber *)numberForWaveformIndex:(NSUInteger)waveformIndex axis:(DSPWaveformAxis)waveformAxis recordIndex:(NSUInteger)index;
@end

@interface DSPWaveformViewController : TTViewController <CPTPlotDataSource> {
    CPTGraphHostingView          *_graphView;
    id <DSPWaveformViewDelegate>  _delegate;
    
@private
    CPTXYGraph                   *_graph;
}

@property (nonatomic, retain) CPTGraphHostingView *graphView;
@property (assign) id <DSPWaveformViewDelegate>    delegate;

@end
