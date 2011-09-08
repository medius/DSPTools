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
struct DSPGridPoint {
    NSUInteger x;
    NSUInteger y;
};
typedef struct DSPGridPoint DSPGridPoint;

// Grid Size
struct DSPGridSize {
    NSUInteger width;
    NSUInteger height;
};
typedef struct DSPGridSize DSPGridSize;

// Grid Rectangle
struct DSPGridRect {
    DSPGridPoint origin;
    DSPGridSize size;
};
typedef struct DSPGridRect DSPGridRect;

/* Model related */
// Value type
enum DSPValueType {
    DSPAllValues = 0,
    DSPAnalogValue,
    DSPDigitalValue
    };
typedef enum DSPValueType DSPValueType;

// Domain type
enum DSPDomainType {
    DSPAllDomains = 0,
    DSPTimeDomain,
    DSPFrequencyDomain
    };
typedef enum DSPDomainType DSPDomainType;

// Signal type
struct DSPSignalType {
    DSPValueType valueType;
    DSPDomainType domainType;
};
typedef struct DSPSignalType DSPSignalType;

// Signal value
typedef double DSPSignalValue;

// NodeID type
typedef NSUInteger NodeID;
