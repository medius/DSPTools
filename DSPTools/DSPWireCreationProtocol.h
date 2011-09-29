//
//  DSPWireCreationProtocol.h
//  DSPTools
//
//  Created by Puru Choudhary on 9/20/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSPHeader.h"

@class DSPComponentView;

@protocol DSPWireCreationProtocol <NSObject>
- (DSPComponentView *)createWireforAnchor1:(DSPGridPoint)anchor1 
                                andAnchor2:(DSPGridPoint)anchor2 
                              forGridScale:(CGFloat)gridScale;
@end
