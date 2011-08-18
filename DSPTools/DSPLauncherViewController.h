//
//  DSPLauncherViewController.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/15/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Three20UI/Three20UI.h"

@interface DSPLauncherViewController : TTViewController <TTLauncherViewDelegate> {
@private
    TTLauncherView *launcherView;
}

@property (readonly) TTLauncherView *launcherView;

@end
