//
//  DSPGlobalSettings.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/12/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSPHeader.h"

@interface DSPGlobalSettings : NSObject {
    NSArray *_componentsInfo;
}

@property (nonatomic, readonly) NSArray *componentsInfo;

// Shared Global Setting
+ (DSPGlobalSettings *)sharedGlobalSettings;

@end
