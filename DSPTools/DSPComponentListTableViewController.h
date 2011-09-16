//
//  DSPComponentListTableViewController.h
//  DSPTools
//
//  Created by Puru Choudhary on 9/15/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Three20/Three20.h"

@protocol DSPComponentListProtocol <NSObject>
- (void)componentListCancelButtonPressed;
- (void)componentSelected:(NSString *)componentName;
@end

@interface DSPComponentListTableViewController : UITableViewController {
    id <DSPComponentListProtocol> _delegate;
    
@private
    NSArray *_componentList;
}

@property (nonatomic, assign) id <DSPComponentListProtocol> delegate;
@property (nonatomic, retain) NSArray *componentList;

@end
