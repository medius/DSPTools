//
//  DSPCircuitModificationProtocol.h
//  DSPTools
//
//  Created by Puru Choudhary on 9/19/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSPHeader.h"

@class DSPComponent;

@protocol DSPCircuitModificationProtocol <NSObject>

// Add a component with anchor1 and anchor2
- (DSPComponent *)addComponentWithClassName:(NSString *)className withSymbol:(NSString *)symbolName withAnchor1:(DSPGridPoint)anchor1 withAnchor2:(DSPGridPoint)anchor2;

// Remove a component
- (void)removeComponent:(DSPComponent *)component;

@optional
// Add a component with anchor1
- (DSPComponent *)addComponentWithClassName:(NSString *)className withAnchor1:(DSPGridPoint)anchor1;
@end
