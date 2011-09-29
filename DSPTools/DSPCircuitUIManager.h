//
//  DSPCircuitUIManager.h
//  DSPTools
//
//  Created by Puru Choudhary on 9/20/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "DSPComponentListProtocol.h"
#import "DSPWireCreationProtocol.h"

@protocol DSPCircuitModificationProtocol;

@interface DSPCircuitUIManager : NSObject <DSPWireCreationProtocol> {
    id <DSPCircuitModificationProtocol> _delegate;
}

@property (assign) id <DSPCircuitModificationProtocol> delegate;

- (DSPComponentView *)addComponentWithClassName:(NSString *)componentClassName 
                        viewClass:(NSString *)viewClassName 
                     forGridScale:(CGFloat)gridScale;
- (void)deleteComponents;

@end
