//
//  DSPCircuit.m
//  DSPTools
//
//  Created by Puru Choudhary on 9/19/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPCircuit.h"
#import "Three20/Three20.h"
#import "DSPComponents.h"

@implementation DSPCircuit

#pragma mark - Accessors

@synthesize components = _components;
@synthesize nodes      = _nodes;
@synthesize errors     = _errors;

- (NSMutableArray *)components
{
    if (!_components) {
        _components = [[NSMutableArray alloc] init];
    }
    return _components;
}

- (NSMutableArray *)nodes
{
    if (!_nodes) {
        _nodes = [[NSMutableArray alloc] init];
    }
    return _nodes;
}

- (NSMutableArray *)errors
{
    if (!_errors) {
        _errors = [[NSMutableArray alloc] init];
    }
    return _errors;
}

#pragma mark - Setup and dealloc

- (void)dealloc
{
    TT_RELEASE_SAFELY(_components);
    TT_RELEASE_SAFELY(_nodes);
    TT_RELEASE_SAFELY(_errors);
    [super dealloc];
}

#pragma mark - Circuit Modification Protocol

- (void)addComponentWithClassName:(NSString *)className withAnchor1:(DSPGridPoint)anchor1 withAnchor2:(DSPGridPoint)anchor2
{
    DSPComponent *newComponent = [[NSClassFromString(className) alloc] init];
    if (newComponent) {
        newComponent.view.delegate = newComponent;
        newComponent.view.anchor1 = anchor1;
        newComponent.view.anchor2 = anchor2;
        
        [self.components addObject:newComponent];
        [newComponent release];
    }
    else {
        // TODO: Log errors in errors dictionary to help user resolve it later
        TTDERROR(@"Could not create component for class %@", className);
    }
}

- (void)removeComponent:(DSPComponentViewController *)component
{
    
}

@end
