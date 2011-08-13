//
//  DSPGridViewController.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSPGridView.h"

@interface DSPGridViewController : UIViewController {
@private
    DSPGridView *mainGridView;
}

@property (readonly) DSPGridView *mainGridView;

@end
