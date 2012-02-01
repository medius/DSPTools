//
//  DSPScopeModel.h
//  DSPTools
//
//  Created by Puru Choudhary on 9/21/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSPComponentModel.h"

@interface DSPScopeModel : DSPComponentModel {
    NSMutableArray *_simulationTimeBuffer;
    NSMutableArray *_valueBuffer;
    NSUInteger      _bufferMaxSize;
    BOOL            _bufferFull;
}

@property (readonly) NSMutableArray *simulationTimeBuffer;
@property (readonly) NSMutableArray *valueBuffer;
@property (nonatomic) NSUInteger     bufferMaxSize;
@property (nonatomic, readonly) BOOL bufferFull;

@end
