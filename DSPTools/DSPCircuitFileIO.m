//
//  DSPCircuitFileIO.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/29/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPCircuitFileIO.h"
#import "Three20/Three20.h"
#import "SBJson.h"

#import "DSPGlobalSettings.h"
#import "DSPCircuitModificationProtocol.h"

// Temporary?
#import "DSPComponents.h"
#import "DSPComponentViews.h"

@interface DSPCircuitFileIO () 
@property (nonatomic, retain) SBJsonParser *parser;
@property (nonatomic, retain) SBJsonWriter *writer;
@end

@implementation DSPCircuitFileIO

#pragma mark - Accessors
@synthesize delegate = _delegate;
@synthesize parser   = _parser;
@synthesize writer   = _writer;

- (SBJsonParser *)parser
{
    if (!_parser) {
        _parser = [[SBJsonParser alloc] init];
    }
    return _parser; 
}

- (SBJsonWriter *)writer
{
    if (!_writer) {
        _writer = [[SBJsonWriter alloc] init];
        _writer.humanReadable = YES;
    }
    return _writer;
}

#pragma mark - Setup and dealloc
- (void)dealloc
{
    TT_RELEASE_SAFELY(_parser);
    TT_RELEASE_SAFELY(_writer);
    [super dealloc];
}

- (void)readCircuitFile:(NSString *)filePath
{    
//    NSString *fileContent;
//    fileContent = [[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] 
//              stringByStandardizingPath];
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    NSError *error;
    NSDictionary *parsedData;
    if (fileData) {
         parsedData = [self.parser objectWithData:fileData];
    }
    
    //NSLog(@"File Content:\n%@", fileContent);
    
    if (error) {
//        NSLog(@"Domain: %@", [error domain]);
//        NSLog(@"Desc: %@", [error localizedDescription]);
//        NSLog(@"Reason: %@",[error localizedFailureReason]);
//        NSLog(@"Recovery options: %@", [error localizedRecoveryOptions]);
//        NSLog(@"Recovery suggestion: %@", [error localizedRecoverySuggestion]);
    }

    
    if (parsedData) {
        NSArray *components = [parsedData objectForKey:@"components"];
        
        for (NSDictionary* component in components) {
            NSString *componentID = [component objectForKey:@"sym"];

            // Get the first anchor of the component
            DSPGridPoint anchor1;
            anchor1.x = [[component objectForKey:@"a1x"] integerValue];
            anchor1.y = [[component objectForKey:@"a1y"] integerValue];
            
            // Get the second anchor of the component
            DSPGridPoint anchor2;
            anchor2.x = [[component objectForKey:@"a2x"] integerValue];
            anchor2.y = [[component objectForKey:@"a2y"] integerValue];
            
            // Match with available component IDs
            for (NSDictionary *componentInfo in [DSPGlobalSettings sharedGlobalSettings].componentsInfo ) {
                if ([(NSString *)[componentInfo objectForKey:@"symbol"] isEqual:componentID]) {
                    NSString *componentClassName = (NSString *)[componentInfo objectForKey:@"className"];
                    [self.delegate addComponentWithClassName:componentClassName withSymbol:componentID withAnchor1:anchor1 withAnchor2:anchor2];
                    break;
                }
            }
        }
    }
}

- (void)writeCircuitFile:(NSArray *)components
{
    NSMutableArray *writeComponents = [[NSMutableArray alloc] init];
    for (DSPComponent *component in components) {
        NSMutableDictionary *newComponent = [[NSMutableDictionary alloc] init];
        [newComponent setObject:component.symbol forKey:@"sym"];
        [newComponent setObject:[NSString stringWithFormat:@"%d",component.view.anchor1.x] forKey:@"a1x"];
        [newComponent setObject:[NSString stringWithFormat:@"%d",component.view.anchor1.y] forKey:@"a1y"];
        [newComponent setObject:[NSString stringWithFormat:@"%d",component.view.anchor2.x] forKey:@"a2x"];
        [newComponent setObject:[NSString stringWithFormat:@"%d",component.view.anchor2.y] forKey:@"a2y"];
        [writeComponents addObject:newComponent];
        [newComponent release];
    }
    
    NSMutableDictionary *circuitData = [[NSMutableDictionary alloc] init];
    [circuitData setObject:writeComponents forKey:@"components"];
    [writeComponents release];
    
    NSString *fileContents = [self.writer stringWithObject:circuitData];
    NSLog(@"%@",fileContents);
}

@end
