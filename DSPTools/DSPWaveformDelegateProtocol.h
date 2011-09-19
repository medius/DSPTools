//
//  DSPWaveformDelegateProtocol.h
//  DSPTools
//
//  Created by Puru Choudhary on 9/9/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSPHeader.h"

@protocol DSPWaveformDelegateProtocol <NSObject>
- (NSNumber *)numberForWaveformIndex:(NSUInteger)waveformIndex axis:(DSPWaveformAxis)waveformAxis recordIndex:(NSUInteger)index;
- (void)waveformDoneButtonPressed;
@end
