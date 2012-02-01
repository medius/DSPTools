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

@protocol DSPWaveformDataSourceProtocol;

@protocol DSPWaveformDelegateProtocol <NSObject>
- (void)waveformDoneButtonPressed;
@end

@interface DSPWaveformViewController : TTViewController <CPTPlotDataSource> {
    NSArray                           *_plotList;
    CPTGraphHostingView               *_graphView;
    id <DSPWaveformDataSourceProtocol> _dataSource;
    id <DSPWaveformDelegateProtocol>   _delegate;
    
@private
    CPTXYGraph                         *_graph;
    NSArray                            *_colorList;
    NSTimer                            *_reloadTimer;
}

@property (nonatomic, retain) NSArray                 *plotList;
@property (nonatomic, retain) CPTGraphHostingView     *graphView;
@property (assign) id <DSPWaveformDataSourceProtocol>  dataSource;
@property (assign) id <DSPWaveformDelegateProtocol>    delegate;

@end
