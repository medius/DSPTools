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
}

@property (nonatomic, readonly) NSMutableArray *simulationTimeBuffer;
@property (nonatomic, readonly) NSMutableArray *valueBuffer;

@end
