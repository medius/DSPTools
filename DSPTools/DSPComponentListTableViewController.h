//
//  DSPComponentListTableViewController.h
//  DSPTools
//
//  Created by Puru Choudhary on 9/15/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DSPComponentListProtocol;

@interface DSPComponentListTableViewController : UITableViewController {
    id <DSPComponentListProtocol> _delegate;
    
@private
    NSArray *_componentList;
}

@property (nonatomic, assign) id <DSPComponentListProtocol> delegate;
@property (nonatomic, retain) NSArray *componentList;

@end
