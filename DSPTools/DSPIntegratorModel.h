//
//  DSPIntegratorModel.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSPComponentModel.h"

@interface DSPIntegratorModel : DSPComponentModel {
    double _initialValue;
    double _saturationValue;
    double _samplePeriod;

@private
    double _currentValue;
    double _previousSimulationTime;
    double _timeSinceLastSample;
    double _timeAtLastSample;
}

@property (nonatomic) double initialValue;
@property (nonatomic) double saturationValue;
@property (nonatomic) double samplePeriod;

@end
