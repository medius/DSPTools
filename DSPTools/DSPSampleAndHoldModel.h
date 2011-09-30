//
//  DSPSampleAndHoldModel.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSPComponentModel.h"

@interface DSPSampleAndHoldModel : DSPComponentModel {
    double _samplePeriod;
    
@private
    double _timeSinceLastSample;
    double _timeAtLastSample;
}

@property (nonatomic) double samplePeriod;

@end
