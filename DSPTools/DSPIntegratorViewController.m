//
//  DSPIntegratorViewController.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/31/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPIntegratorViewController.h"
#import "DSPIntegratorModel.h"
#import "DSPIntegratorView.h"
#import "DSPPin.h"

@implementation DSPIntegratorViewController

- (DSPComponentModel *)componentModel
{
    if (!_componentModel) {
        _componentModel = [[DSPIntegratorModel alloc] init];
    }
    return _componentModel;
}

- (DSPComponentView *)componentView
{
    if (!_componentView) {
        _componentView = [[DSPIntegratorView alloc] init];
    }
    return _componentView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
//- (void)loadView
//{
//
//}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// Set the pin locations based on anchor 1
- (void)anchor1Set:(DSPComponentView *)requestor toValue:(DSPGridPoint)newValue
{
    DSPPin *inputPin = [self.componentModel.inputPins lastObject];
    inputPin.location = newValue;
    
    DSPPin *outputPin = [self.componentModel.outputPins lastObject];
    DSPGridPoint newLocation;
    newLocation.x = newValue.x + 4;  // Change these constants to use values from the view later;
    newLocation.y = newValue.y;
    
    outputPin.location = newLocation;
}

// Set the pin locations based on anchor 2
- (void)anchor2Set:(DSPComponentView *)requestor toValue:(DSPGridPoint)newValue
{
     // This does nothing for now
}

@end
