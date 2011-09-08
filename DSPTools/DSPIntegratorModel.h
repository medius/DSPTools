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
    
@private
    double _currentValue;
    double _previousSimulationTime;
}

@property (nonatomic) double initialValue;
@property (nonatomic) double saturationValue;

@end
