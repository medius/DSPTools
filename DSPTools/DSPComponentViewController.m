//
//  DSPComponentViewController.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPComponentViewController.h"
#import "DSPPin.h"

@implementation DSPComponentViewController

// Setters/getters
@synthesize componentModel = _componentModel;
@synthesize componentView  = _componentView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // This part is necessary as loadView is not called on this controller when it is created.
        // The componentView needs to be able to pass the information about anchor setting to the
        // controller so that the pins in the model can be set.
        self.componentView.delegate = self;
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
- (void)loadView
{

}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    

}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.componentModel = nil;
    self.componentView = nil;
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    // Return YES for supported orientations
//    // return (interfaceOrientation == UIInterfaceOrientationPortrait);
//    return YES;
//}

// Set the pin locations based on anchor 1
- (void)anchor1Set:(DSPComponentView *)requestor toValue:(DSPGridPoint)newValue
{
    // Subclasses need to implement this
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"You must override %@ in a subclass" userInfo:nil]; 
}

// Set the pin locations based on anchor 2
- (void)anchor2Set:(DSPComponentView *)requestor toValue:(DSPGridPoint)newValue
{
    // Subclasses need to implement this
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"You must override %@ in a subclass" userInfo:nil]; 
}

//// Message from the view about the changed position.
//- (void)viewPositionChanged:(DSPComponentView *)requestor byShiftValue:(DSPGridPoint)shiftValue
//{
//    // Move the input pins as necessary
//    for (DSPPin* pin in self.component.inputPins) {
//        DSPGridPoint newLocation;
//        newLocation.x = pin.location.x + shiftValue.x;
//        newLocation.y = pin.location.y + shiftValue.y;
//        pin.location = newLocation;
//    }
//    
//    // Move the output pins as necessary
//    for (DSPPin* pin in self.component.outputPins) {
//        DSPGridPoint newLocation;
//        newLocation.x = pin.location.x + shiftValue.x;
//        newLocation.y = pin.location.y + shiftValue.y;
//        pin.location = newLocation;
//    }
//}


@end
