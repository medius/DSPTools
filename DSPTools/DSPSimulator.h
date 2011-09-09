//
//  DSPSimulator.h
//  DSPTools
//
//  Created by Puru Choudhary on 9/2/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSPWaveformViewController.h"

@protocol DSPWaveformViewDelegate;

@interface DSPSimulator : NSObject <DSPWaveformViewDelegate> {
    
}

+ (void)runSimulationForComponents:(NSArray *)components andNodes:(NSArray *)nodes;

@end
