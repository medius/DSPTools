//
//  DSPCircuitFileIO.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/29/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPCircuitFileIO.h"
#import "DSPComponents.h"

@implementation DSPCircuitFileIO


+ (NSDictionary *)circuitInFile:(NSString *)filePath
{
    // Circuit data
    NSMutableDictionary *circuit = [NSMutableDictionary dictionary];
    NSMutableArray *components = [[NSMutableArray alloc] init];
    DSPComponentView *componentView;
    
    // Get the lines in the file
    NSArray *lines;
    lines = [[[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] 
              stringByStandardizingPath] 
             componentsSeparatedByString:@"\n"];
    
    NSEnumerator *nse = [lines objectEnumerator];
    
    NSString *line;
    while((line = [nse nextObject])) {
        NSArray *fields = [line componentsSeparatedByString:@" "];
        
        // Ignore if there are fewer than five elements
        if ([fields count]<5) {
            continue;
        }
        
        NSLog(@"%@", line);
        
        // Find the type of component and initialize the related view object
        NSString *identifier = [fields objectAtIndex:0];
        
        // Signal source
        if ([identifier isEqualToString:SIGNAL_SOURCE]) 
        {
            componentView = [[DSPSignalSourceView alloc] init];
        }
        // Integrator
        else if ([identifier isEqualToString:INTEGRATOR]) 
        {
            componentView = [[DSPIntegratorView alloc] init];
        }
        // Wire
        else if ([identifier isEqualToString:WIRE]) 
        {
            componentView = [[DSPWireView alloc] init];
        }
        else
        {
            componentView = nil;
        }
        
        // TODO: Careful, a bad circuit description will crash this
        
        // Get the first anchor of the component
        DSPGridPoint anchor1;
        anchor1.x = [[fields objectAtIndex:1] integerValue];
        anchor1.y = [[fields objectAtIndex:2] integerValue];
        if (componentView)
        {
            componentView.anchor1 = anchor1;
        }
        
        // Get the second anchor of the component
        DSPGridPoint anchor2;
        anchor2.x = [[fields objectAtIndex:3] integerValue];
        anchor2.y = [[fields objectAtIndex:4] integerValue];
        if (componentView)
        {
            componentView.anchor2 = anchor2;
        }
        
        //NSLog(@"%g %g %g %g", )
        // Add the object to the component list
        if (componentView) {
            [components addObject:componentView];
            [componentView release];
        }      
        componentView = nil;
    }
    
    [circuit setObject:components forKey:@"components"];
    [components release];
    return circuit;
}

@end
