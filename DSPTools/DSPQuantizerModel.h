//
//  DSPQuantizerModel.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSPComponentModel.h"

@interface DSPQuantizerModel : DSPComponentModel {
    double _quantizationInterval;
    double _samplePeriod;
    
@private
    double _timeSinceLastSample;
    double _timeAtLastSample;
}

@property (nonatomic) double quantizationInterval;
@property (nonatomic) double samplePeriod;

@end
