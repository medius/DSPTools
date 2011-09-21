//
//  DSPGlobalSettings.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/12/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPGlobalSettings.h"
#import "Three20Core/Three20Core.h"

@implementation DSPGlobalSettings


static DSPGlobalSettings *sharedGlobalSettings = nil;

#pragma mark - Accessors

// Get the shared instance and create it if necessary.
+ (DSPGlobalSettings*)sharedGlobalSettings {
    if (sharedGlobalSettings == nil) {
        sharedGlobalSettings = [[super allocWithZone:NULL] init];
    }
    
    return sharedGlobalSettings;
}

// Components info
- (NSArray *)componentsInfo
{
    if (!_componentsInfo) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"DSPComponents-Info" ofType:@"plist"];
        if (!path) {
            TTDERROR(@"Could not find file DSPComponents-Info.plist");
        }
        NSDictionary *fileContents = [[[NSDictionary alloc] initWithContentsOfFile:path] retain];
        _componentsInfo = [fileContents objectForKey:@"components"];
    }
    return _componentsInfo;
}

#pragma mark - Setup and dealloc
- (void)setupDefaults
{
}

// We can still have a regular init method, that will get called the first time the Singleton is used.
- (id)init
{
    self = [super init];
    
    if (self) {
        // Work your initialising magic here as you normally would
        [self setupDefaults];
    }
    
    return self;
}

// Your dealloc method will never be called, as the singleton survives for the duration of your app.
// However, I like to include it so I know what memory I'm using (and incase, one day, I convert away from Singleton).
-(void)dealloc
{
    // I'm never called!
    [super dealloc];
}

// We don't want to allocate a new instance, so return the current one.
+ (id)allocWithZone:(NSZone*)zone {
    return [[self sharedGlobalSettings] retain];
}

#pragma mark - Copy
// Equally, we don't want to generate multiple copies of the singleton.
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

#pragma mark - Memory Management
// Once again - do nothing, as we don't have a retain counter for this object.
- (id)retain {
    return self;
}

// Replace the retain counter so we can never release this object.
- (NSUInteger)retainCount {
    return NSUIntegerMax;
}

// This function is empty, as we don't want to let the user release this object.
- (oneway void)release {
    
}

//Do nothing, other than return the shared instance - as this is expected from autorelease.
- (id)autorelease {
    return self;
}

@end
