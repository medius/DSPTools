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
}

@property (nonatomic, retain) NSArray *components;
@property (nonatomic, retain) NSArray *nodes;

- (void)simulate;

@end
