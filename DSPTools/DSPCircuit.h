//
//  DSPCircuit.h
//  DSPTools
//
//  Created by Puru Choudhary on 9/19/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSPCircuitModificationProtocol.h"

@interface DSPCircuit : NSObject <DSPCircuitModificationProtocol> {
    NSMutableArray *_components;
    NSMutableArray *_nodes;
    NSMutableArray *_errors;
}

@property (nonatomic, retain) NSMutableArray *components;
@property (nonatomic, retain) NSMutableArray *nodes;
@property (nonatomic, retain) NSMutableArray *errors;

@end
