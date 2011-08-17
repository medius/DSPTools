//
//  DSPSystemViewController.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/16/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSPGridView.h"

@interface DSPSystemViewController : UIViewController {
@private
    UIView *systemView;
    DSPGridView *gridView;
}

@property (readonly) UIView *systemView;
@property (readonly) DSPGridView *gridView;

@end
