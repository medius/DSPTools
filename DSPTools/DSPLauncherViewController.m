//
//  DSPLauncherViewController.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/15/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPLauncherViewController.h"
#import "DSPSystemViewController.h"

@implementation DSPLauncherViewController

// Setters/getter
@synthesize launcherView;

- (TTLauncherView *)launcherView
{
    if (!launcherView)
    {
        launcherView = [[TTLauncherView alloc] init];
    }
    return launcherView;
}

- (void)setup
{

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setup];
    }
    return self;
}

- (void)dealloc
{
    [launcherView release];
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
    self.title = @"DSP Tools";
    self.launcherView.delegate = self;
    self.view = self.launcherView;
    self.view.backgroundColor = [UIColor blackColor];
    
    self.launcherView.columnCount = 4;
    
    NSString *imageName  = @"schematic.png";
    UIImage *thumbnail = [UIImage imageNamed:@"schematic.png"]; 
    [[TTURLCache sharedCache] storeImage:thumbnail forURL:imageName]; 
    
    TTLauncherItem *newSchematic = [[TTLauncherItem alloc] initWithTitle:@"New Schematic" image:nil URL:@"" canDelete:NO];
    self.launcherView.currentPageIndex = 0;
    TTLauncherItem *basicCircuit = [[TTLauncherItem alloc] initWithTitle:@"Basic Circuit" image:imageName URL:@"tt://url" canDelete:YES];
    TTLauncherItem *sahCircuit = [[TTLauncherItem alloc] initWithTitle:@"SH Circuit" image:imageName URL:@"tt://url" canDelete:YES];
    TTLauncherItem *deltaCircuit = [[TTLauncherItem alloc] initWithTitle:@"Delta Modulator Circuit" image:imageName URL:@"tt://url" canDelete:YES];
    TTLauncherItem *sigmaDeltaCircuit = [[TTLauncherItem alloc] initWithTitle:@"Sigma Delta Modulator Circuit" image:imageName URL:@"tt://url" canDelete:YES];
    
    NSArray *firstPage = [NSArray arrayWithObjects:newSchematic, basicCircuit, sahCircuit, deltaCircuit, sigmaDeltaCircuit, nil];
    self.launcherView.pages = [NSArray arrayWithObjects:firstPage, nil];
    
    [newSchematic release];
    [basicCircuit release];
    [sahCircuit release];
    [deltaCircuit release];
    [sigmaDeltaCircuit release];
    
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.navigationController setToolbarHidden:YES animated:NO];
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
    // return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

// Push the right controllers when an item is selected
- (void)launcherView:(TTLauncherView*)launcher didSelectItem:(TTLauncherItem*)item
{
    NSString *filePath;
    
    if (item.title == @"New Schematic")
    {
        filePath = [[NSBundle mainBundle] pathForResource:@"Untitled" ofType:@"dsp"];
    }
    if (item.title == @"Basic Circuit")
    {
        filePath = [[NSBundle mainBundle] pathForResource:@"Example1" ofType:@"dsp"];        
    }
    if (item.title == @"SH Circuit")
    {
        filePath = [[NSBundle mainBundle] pathForResource:@"SaH" ofType:@"dsp"];        
    }
    if (item.title == @"Delta Modulator Circuit")
    {
        filePath = [[NSBundle mainBundle] pathForResource:@"delta-modulator" ofType:@"dsp"];        
    }
    if (item.title == @"Sigma Delta Modulator Circuit")
    {
        filePath = [[NSBundle mainBundle] pathForResource:@"sigma-delta-modulator" ofType:@"dsp"];        
    }
    DSPSystemViewController *systemViewController = [[DSPSystemViewController alloc] init];
    systemViewController.circuitFilePath = filePath;
    [self.navigationController pushViewController:systemViewController animated:YES];
    [systemViewController release];
}
@end
