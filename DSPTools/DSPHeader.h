//
//  DSPHeader.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import <Foundation/Foundation.h>

/* UI related */
#define marginForGridScale(gridScale) gridScale/2

// Grid Point
typedef struct {
    NSUInteger x;
    NSUInteger y;
} DSPGridPoint;

// Grid Size
typedef struct {
    NSUInteger width;
    NSUInteger height;
} DSPGridSize;

// Grid Rectangle
typedef struct {
    DSPGridPoint origin;
    DSPGridSize size;
} DSPGridRect;

/* Model related */
// Value type
typedef enum {
    DSPAllValues = 0,
    DSPAnalogValue,
    DSPDigitalValue
} DSPValueType;

// Domain type
typedef enum {
    DSPAllDomains = 0,
    DSPTimeDomain,
    DSPFrequencyDomain
} DSPDomainType;

// Signal type
typedef struct {
    DSPValueType valueType;
    DSPDomainType domainType;
} DSPSignalType;

// Signal value
typedef double DSPSignalValue;

// Waveform axis
typedef enum {
    DSPWaveformAxisX = 0,
    DSPWaveformAxisY
} DSPWaveformAxis;
