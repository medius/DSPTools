//
//  DSPCircuitFileIO.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/29/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DSPCircuitFileIO : NSObject {
    
}

// Parses a circuit file and returns a dictionary with circuit components
// and options
+ (NSDictionary *)circuitInFile:(NSString *)filePath;

@end
