//
//  DSPSimulator.h
//  DSPTools
//
//  Created by Puru Choudhary on 9/2/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSPWaveformViewController.h"

@interface DSPSimulator : NSObject {
    NSArray *_components;
    NSArray *_nodes;
    
@private
    NSMutableArray* _xAxisBuffer;
    NSMutableArray* _yAxisBuffer1;
    NSMutableArray* _yAxisBuffer2;
}

@property (nonatomic, retain) NSArray *components;
@property (nonatomic, retain) NSArray *nodes;

- (void)simulate;
//- (NSNumber *)numberForWaveformIndex:(NSUInteger)waveformIndex axis:(DSPWaveformAxis)waveformAxis recordIndex:(NSUInteger)index;

@end
