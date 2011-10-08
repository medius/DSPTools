//
//  DSPCircuitUIManager.m
//  DSPTools
//
//  Created by Puru Choudhary on 9/20/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPCircuitUIManager.h"
#import "DSPHeader.h"
#import "DSPComponents.h"
#import "DSPHelper.h"
#import "DSPCircuitModificationProtocol.h"
#import "DSPComponentView.h"

@implementation DSPCircuitUIManager

#pragma mark - Accessors
@synthesize delegate = _delegate;

#pragma mark - Public methods
- (DSPComponentView *)addComponentWithClassName:(NSString *)componentClassName viewClass:(NSString *)viewClassName symbol:(NSString *)symbolName forGridScale:(CGFloat)gridScale
{
    DSPGridPoint anchor1;
    anchor1.x = 10;
    anchor1.y = 10;
    
    Class viewClass = NSClassFromString(viewClassName);
    DSPGridPoint anchor2 = [viewClass defaultSecondaryAnchorForPrimaryAnchor:anchor1];
    
    DSPComponent *newComponent = [self.delegate addComponentWithClassName:componentClassName withSymbol:symbolName withAnchor1:anchor1 withAnchor2:anchor2];
    
//    newComponent.view.frame = 
//    [DSPHelper getFrameForObject:newComponent.view 
//                     withAnchor1:anchor1 
//                     withAnchor2:anchor2 
//                    forGridScale:gridScale];
    newComponent.view.anchor1 = anchor1;
    newComponent.view.anchor2 = anchor2;
//    newComponent.view.gridScale = gridScale;
    newComponent.view.isDraggable = YES;
    
    return newComponent.view;
}

- (void)deleteComponents
{

}

#pragma mark - Wire Creation Protocol

- (DSPComponentView *)createWireforAnchor1:(DSPGridPoint)anchor1 andAnchor2:(DSPGridPoint)anchor2 forGridScale:(CGFloat)gridScale
{
    // TODO: This should come from component info list
    DSPWire *newWire = (DSPWire*)[self.delegate addComponentWithClassName:@"DSPWire" withSymbol:@"w" withAnchor1:anchor1 withAnchor2:anchor2];
    
//    newWire.view.frame = 
//    [DSPHelper getFrameForObject:newWire.view 
//                     withAnchor1:anchor1 
//                     withAnchor2:anchor2 
//                    forGridScale:gridScale];
    newWire.view.anchor1 = anchor1;
    newWire.view.anchor2 = anchor2;
//    newWire.view.gridScale = gridScale;
    newWire.view.isDraggable = YES;
    
    return newWire.view;
}

@end
