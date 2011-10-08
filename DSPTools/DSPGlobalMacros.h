//
//  DSPGlobalMacros.h
//  DSPTools
//
//  Created by Puru Choudhary on 9/8/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#define UIColorFromRGB(rgbValue) [UIColor \
                                 colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                                 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                                 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]