//
//  DSPCircuitModificationProtocol.h
//  DSPTools
//
//  Created by Puru Choudhary on 9/19/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSPHeader.h"

@class DSPComponentViewController;

@protocol DSPCircuitModificationProtocol <NSObject>

// Add a component with anchor1
- (void)addComponentWithName:(NSString *)name withAnchor1:(DSPGridPoint)anchor1;

// Add a component with anchor1 and anchor2
- (void)addComponentWithName:(NSString *)name withAnchor1:(DSPGridPoint)anchor1 withAnchor2:(DSPGridPoint)anchor2;

// Remove a component
- (void)removeComponent:(DSPComponentViewController *)component;

@end
