//
//  DSPCircuitFileIO.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/29/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DSPCircuitModificationProtocol;
@class SBJsonParser;
@class SBJsonWriter;

@interface DSPCircuitFileIO : NSObject {
    id <DSPCircuitModificationProtocol> _delegate;
    
@private
    SBJsonParser *_parser;
    SBJsonWriter *_writer;
}

@property (assign) id <DSPCircuitModificationProtocol> delegate;

// Parses a circuit file and returns a dictionary with circuit components
// and options
- (void)readCircuitFile:(NSString *)filePath;

@end
