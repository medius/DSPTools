//
//  DSPGridViewController.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/11/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPGridViewController.h"
#import "DSPGlobalSettings.h"
#import "DSPHeader.h"
#import "DSPGrid.h"

#import "DSPIntegratorViewController.h"

@implementation DSPGridViewController

// Setters/getters
@synthesize mainGridView;

- (DSPGridView *)mainGridView {
	if (!mainGridView) {
		mainGridView = [[DSPGridView alloc] init];
	}
	return mainGridView;
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
    [mainGridView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Update the UI
- (void)updateUI
{
    [self.view setNeedsDisplay];
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    self.view = self.mainGridView;
    
    // Initialize a sample Integrator
    DSPIntegratorViewController *dspIVC = [[DSPIntegratorViewController alloc] init];
    
    DSPGridSize componentSize;
    componentSize = dspIVC.componentView.size;
    
    DSPGridPoint componentLocation;
    componentLocation.x = 5;
    componentLocation.y = 7;
    dspIVC.componentView.origin = componentLocation;
    
    [self.view addSubview:dspIVC.view];
    [dspIVC release];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self updateUI];
}


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

@end
