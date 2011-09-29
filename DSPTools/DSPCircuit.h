//
//  DSPCircuit.h
//  DSPTools
//
//  Created by Puru Choudhary on 9/19/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSPCircuitModificationProtocol.h"
#import "DSPWaveformDataSourceProtocol.h"

@interface DSPCircuit : NSObject <DSPCircuitModificationProtocol, DSPWaveformDataSourceProtocol> {
    NSMutableArray *_components;
    NSMutableArray *_nodes;
    NSMutableArray *_errors;
    NSMutableArray *_scopes;
}

@property (nonatomic, retain) NSMutableArray *components;
@property (nonatomic, retain) NSMutableArray *nodes;
@property (nonatomic, retain) NSMutableArray *errors;
@property (nonatomic, readonly) NSMutableArray *scopes;

// Return a list of names of all the scopes
- (NSArray *)scopeNames;

@end
