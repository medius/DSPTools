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
#import "DSPComponentModels.h"

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

- (NSMutableArray *)scopes
{    
    if (!_scopes) {
        _scopes = [[NSMutableArray alloc] init];
    }
    
    [_scopes removeAllObjects];
    
    for (DSPComponent *component in self.components) {
        if (component.isScope) {
            [_scopes addObject:component];
        }
    }
    
    return _scopes;
}

#pragma mark - Setup and dealloc

- (void)dealloc
{
    TT_RELEASE_SAFELY(_components);
    TT_RELEASE_SAFELY(_nodes);
    TT_RELEASE_SAFELY(_errors);
    TT_RELEASE_SAFELY(_scopes);
    [super dealloc];
}

#pragma mark - Circuit Modification Protocol

- (DSPComponent *)addComponentWithClassName:(NSString *)className withSymbol:(NSString *)symbolName withAnchor1:(DSPGridPoint)anchor1 withAnchor2:(DSPGridPoint)anchor2
{
    DSPComponent *newComponent = [[NSClassFromString(className) alloc] init];
    if (newComponent) {
        newComponent.symbol = symbolName;
        newComponent.view.delegate = newComponent;
        newComponent.view.anchor1 = anchor1;
        newComponent.view.anchor2 = anchor2;
        
        [self.components addObject:newComponent];
        [newComponent release];
        return [self.components lastObject];
    }
    else {
        // TODO: Log errors in errors dictionary to help user resolve it later
        TTDERROR(@"Could not create component for class %@", className);
        return nil;
    }
}

- (DSPComponent *)addComponentWithClassName:(NSString *)className withAnchor1:(DSPGridPoint)anchor1
{
    return nil;
}

- (void)removeComponent:(DSPComponent *)component
{
    [self.components removeObject:component];
}

#pragma mark - Public methods
- (NSArray *)scopeNames
{
    NSMutableArray *names = [NSMutableArray array];
    for (int i=0; i<[self.scopes count]; i++) {
        DSPScope *scope = [self.scopes objectAtIndex:i];
        NSString *name = [scope.name stringByAppendingFormat:@" %d", i];
        [names addObject:name];
    }
    return names;
}


#pragma mark - Waveform Data Source Methods

- (NSNumber *)numberForWaveformIndex:(NSUInteger)waveformIndex axis:(DSPWaveformAxis)waveformAxis recordIndex:(NSUInteger)index
{
    DSPScope *scope = [self.scopes lastObject];
    DSPScopeModel *scopeModel = (DSPScopeModel *)scope.model;
    
    if (waveformAxis == DSPWaveformAxisX) {
        return [scopeModel.simulationTimeBuffer objectAtIndex:index];
    }
    else {
        scope = [self.scopes objectAtIndex:waveformIndex];
        scopeModel = (DSPScopeModel *)scope.model;
        if (scopeModel) {
            return [scopeModel.valueBuffer objectAtIndex:index];
        }
        else {
            return 0;
        }
        
    }
}

@end
