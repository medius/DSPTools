//
//  DSPCircuitAnalyzer.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/30/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DSPCircuitAnalyzer : NSObject {
    NSArray        *_components;
    NSMutableArray *_nodes;
    NSMutableArray *_errors;
}

@property (nonatomic, retain) NSArray          *components;
@property (nonatomic, readonly) NSMutableArray *nodes;
@property (nonatomic, readonly) NSMutableArray *errors;

// Analyzes the circuit
- (void)analyze;

@end
