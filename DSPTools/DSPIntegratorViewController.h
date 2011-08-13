//
//  DSPIntegratorViewController.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSPComponentViewController.h"
#import "DSPIntegratorView.h"

@interface DSPIntegratorViewController : DSPComponentViewController {
    DSPIntegratorView *integratorView;
}

@property (nonatomic, retain) DSPIntegratorView *integratorView;

@end
