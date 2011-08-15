//
//  DSPComponentMacros.h
//  DSPTools
//
//  Created by Puru Choudhary on 8/15/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

// Initialize the view and set the frame from the DSPComponentView parameters
#define LOADVIEW_STEPS_01 \
    DSPGridRect componentFrame; \
    componentFrame.origin = self.componentView.origin; \
    componentFrame.size = self.componentView.size; \
    self.view.frame = [DSPGrid getRealRectFromGridRect:componentFrame];
