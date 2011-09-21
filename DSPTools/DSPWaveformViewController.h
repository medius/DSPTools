//
//  DSPWaveformViewController.h
//  DSPTools
//
//  Created by Puru Choudhary on 9/8/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Three20/Three20.h"
#import "CorePlot-CocoaTouch.h"

@protocol DSPWaveformDelegateProtocol;

@interface DSPWaveformViewController : TTViewController <CPTPlotDataSource> {
    CPTGraphHostingView              *_graphView;
    id <DSPWaveformDelegateProtocol>  _delegate;
    
@private
    CPTXYGraph                       *_graph;
}

@property (nonatomic, retain) CPTGraphHostingView   *graphView;
@property (assign) id <DSPWaveformDelegateProtocol>  delegate;

@end
