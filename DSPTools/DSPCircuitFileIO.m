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
    NSString *fileContent;
    fileContent = [[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] 
              stringByStandardizingPath];
    
    NSDictionary *parsedFile = [self.parser objectWithString:fileContent error:nil];
    
    if (parsedFile) {
        NSArray *components = [parsedFile objectForKey:@"components"];
        
        for (NSDictionary* component in components) {
            NSString *componentID = [component objectForKey:@"id"];

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
                if ([(NSString *)[componentInfo objectForKey:@"id"] isEqual:componentID]) {
                    NSString *componentClassName = (NSString *)[componentInfo objectForKey:@"className"];
                    [self.delegate addComponentWithName:componentClassName withAnchor1:anchor1 withAnchor2:anchor2];
                    break;
                }
            }
        }
    }
}


//- (NSMutableDictionary *)circuitInFile:(NSString *)filePath
//{
//    // Circuit data
//    NSMutableDictionary *circuit = [NSMutableDictionary dictionary];
//    NSMutableArray *components = [[NSMutableArray alloc] init];
//    DSPComponentViewController *componentViewController;
//    
//    // Get the lines in the file
//    NSArray *lines;
//    lines = [[[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] 
//              stringByStandardizingPath] 
//             componentsSeparatedByString:@"\n"];
//    
//    NSEnumerator *nse = [lines objectEnumerator];
//    
//    NSString *line;
//    while((line = [nse nextObject])) {
//        NSArray *fields = [line componentsSeparatedByString:@" "];
//        
//        // Ignore if there are fewer than five elements
//        if ([fields count]<5) {
//            continue;
//        }
//        
//        NSLog(@"%@", line);
//        
//        /* Find the type of component and initialize the related view object */
//        NSString *identifier = [fields objectAtIndex:0];
//        
//        // Signal source
//        if ([identifier isEqualToString:SIGNAL_SOURCE]) {
//            componentViewController = [[DSPSignalSourceViewController alloc] init];
//        }
//        // Integrator
//        else if ([identifier isEqualToString:INTEGRATOR]) {
//            componentViewController = [[DSPIntegratorViewController alloc] init];
//        }
//        // Wire
//        else if ([identifier isEqualToString:WIRE]) {
//            componentViewController = [[DSPWireViewController alloc] init];
//        }
//        else {
//            componentViewController = nil;
//        }
//        
//        // TODO: Careful, a bad circuit description will crash this
//        
//        // Get the first anchor of the component
//        DSPGridPoint anchor1;
//        anchor1.x = [[fields objectAtIndex:1] integerValue];
//        anchor1.y = [[fields objectAtIndex:2] integerValue];
//        if (componentViewController) {
//            componentViewController.componentView.anchor1 = anchor1;
//        }
//        
//        // Get the second anchor of the component
//        DSPGridPoint anchor2;
//        anchor2.x = [[fields objectAtIndex:3] integerValue];
//        anchor2.y = [[fields objectAtIndex:4] integerValue];
//        if (componentViewController) {
//            componentViewController.componentView.anchor2 = anchor2;
//        }
//        
//        // Add the object to the component list
//        if (componentViewController) {
//            [components addObject:componentViewController];
//            [componentViewController release];
//        }      
//        componentViewController = nil;
//    }
//    
//    [circuit setObject:components forKey:@"components"];
//    [components release];
//    return circuit;
//}
@end
