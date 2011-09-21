//
//  DSPSystemViewController.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/16/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Three20/Three20.h"

#import "DSPComponentListProtocol.h"

@protocol DSPWireCreation;
@protocol DSPWaveformDelegateProtocol;

@class DSPCircuitFileIO;
@class DSPCircuit;
@class DSPCircuitUIManager;
@class DSPSimulator;
@class DSPGridView;

@interface DSPSystemViewController : TTViewController <DSPComponentListProtocol, DSPWireCreation, DSPWaveformDelegateProtocol> {
    NSString               *_circuitFilePath;
    
@private
    DSPCircuitFileIO       *_fileIO;
    DSPCircuit             *_circuit;
    DSPCircuitUIManager    *_circuitUIManager;
    DSPSimulator           *_simulator;
    
    TTView                 *_systemView;
    DSPGridView            *_gridView;

}

@property (copy) NSString *circuitFilePath;

@end
