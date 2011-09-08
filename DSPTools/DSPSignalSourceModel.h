//
//  DSPSignalSourceModel.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/31/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSPComponentModel.h"

@interface DSPSignalSourceModel : DSPComponentModel {
    double _maxAmplitude;
    double _frequency;
    double _phaseShift;
    double _amplitudeBias;
}

@property (nonatomic) double maxAmplitude;
@property (nonatomic) double frequency;
@property (nonatomic) double phaseShift;
@property (nonatomic) double amplitudeBias;

@end
