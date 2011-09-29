//
//  DSPComponentListProtocol.h
//  DSPTools
//
//  Created by Puru Choudhary on 9/20/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DSPComponentListProtocol <NSObject>
- (void)componentListCancelButtonPressed;
- (void)componentSelected:(NSString *)componentClassName viewClass:(NSString *)viewClassName;
@end
