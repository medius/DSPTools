//
//  DSPGlobalSettings.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/12/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DSPGlobalSettings : NSObject {
    CGFloat gridScale;
}

@property CGFloat gridScale;

// Shared Global Setting
+ (DSPGlobalSettings *)sharedGlobalSettings;

@end
