//
//  DSPCircuitAnalyzer.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/30/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DSPCircuitAnalyzer : NSObject {
    
}

// Returns a set of nodes and list of components with pins updated with node information
+ (NSDictionary *)simulatonModelForCircuit:(NSDictionary *)circuit;

@end
