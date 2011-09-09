//
//  DSPSystemViewController.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/16/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPSystemViewController.h"
#import "DSPGridView.h"
#import "DSPComponentListView.h"
#import "Three20UI/Three20UI+Additions.h"

#import "DSPCircuitFileIO.h"
#import "DSPCircuitAnalyzer.h"
#import "DSPSimulator.h"

// Temporary
#import "DSPHeader.h"
#import "DSPHelper.h"
#import "DSPGlobalSettings.h"

#import "DSPComponents.h"
#import "DSPNode.h"

#import "CorePlot-CocoaTouch.h"

static const CGFloat kComponentListHeight = 80;
static const CGFloat kToolBarItemWidth    = 40;

@interface DSPSystemViewController()
- (NSArray *)createToolBarItems;
@end

@implementation DSPSystemViewController


// Setters/getters
@synthesize systemView          = _systemView;
@synthesize gridView            = _gridView;
@synthesize componentListView   = _componentListView;
@synthesize circuit             = _circuit;

- (void)setup
{
    self.systemView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self setToolbarItems:[self createToolBarItems]];
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil filePath:(NSString *)filePath
- (id)initWithCircuitFile:(NSString *)filePath
{
    self = [super init];
    if (self) {
        // TODO: Change this to use self.*
        
        // Get the circuit from the file
        _circuit = [[DSPCircuitFileIO circuitInFile:filePath] retain];
        
        // Initialize the systemView
        CGRect systemViewFrame = TTApplicationFrame();
        _systemView = [[TTView alloc] initWithFrame:systemViewFrame];
        
        // Initialize the gridView
        CGRect gridViewFrame = TTApplicationFrame();
        _gridView = [[DSPGridView alloc] initWithFrame:gridViewFrame];
        
        // Initialize the componentListView
        CGRect componentListFrame = CGRectMake(0, _systemView.bottom - kComponentListHeight, _systemView.width, kComponentListHeight);
        _componentListView = [[DSPComponentListView alloc] initWithFrame:componentListFrame];
        
        [self setup];
    }
    return self;
}

- (void)dealloc
{
    [_systemView release];
    [_gridView release];
    [_componentListView release];
    [_circuit release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)closeSchematic
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    self.view = self.systemView;
    [self.view addSubview:self.gridView];
    //[self.view addSubview:self.componentListView];
    
    // Configure the navigation controller when in system view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController setToolbarHidden:NO animated:NO];
    self.navigationController.toolbar.barStyle = UIBarStyleBlackOpaque;
    
    
    // Get the gridScale
    CGFloat gridScale = [DSPGlobalSettings sharedGlobalSettings].gridScale;
//    DSPGridPoint componentLocation;

//    // Integrator block
//    DSPIntegratorView *dspIV = [[DSPIntegratorView alloc] init];
//    componentLocation.x = 5;
//    componentLocation.y = 7;
//    dspIV.frame = [DSPIntegratorView defaultFrameForPrimaryAnchor:componentLocation forGridScale:gridScale];
//    dspIV.anchor1 = componentLocation;
//    dspIV.anchor2 = [DSPIntegratorView defaultSecondaryAnchorForPrimaryAnchor:componentLocation];
//    dspIV.gridScale = gridScale;
//    dspIV.draggable = YES;
//    [self.gridView addSubview:dspIV];
//    [dspIV release];
//    
//    // Summation block
//    DSPSummationView *dspSV = [[DSPSummationView alloc] init];
//    componentLocation.x = 10;
//    componentLocation.y = 7;
//    dspSV.frame = [DSPSummationView defaultFrameForPrimaryAnchor:componentLocation forGridScale:gridScale];
//    dspSV.anchor1 = componentLocation;
//    dspSV.anchor2 = [DSPSummationView defaultSecondaryAnchorForPrimaryAnchor:componentLocation];
//    dspSV.gridScale = gridScale;
//    dspSV.draggable = YES;
//    [self.gridView addSubview:dspSV];
//    [dspSV release];
//    
//    // Signal source 
//    DSPSummationView *dspSS = [[DSPSignalSourceView alloc] init];
//    componentLocation.x = 2;
//    componentLocation.y = 7;
//    dspSS.frame = [DSPSignalSourceView defaultFrameForPrimaryAnchor:componentLocation forGridScale:gridScale];
//    dspSS.anchor1 = componentLocation;
//    dspSS.anchor2 = [DSPSignalSourceView defaultSecondaryAnchorForPrimaryAnchor:componentLocation];
//    dspSS.gridScale = gridScale;
//    dspSS.draggable = YES;
//    [self.gridView addSubview:dspSS];
//    [dspSS release];
    
    NSArray *components = [self.circuit objectForKey:@"components"];
    
    // Populate the grid with the components
    for (DSPComponentViewController *componentViewController in components) {
        componentViewController.componentView.frame = 
        [DSPHelper getFrameForObject:componentViewController.componentView 
                         withAnchor1:componentViewController.componentView.anchor1 
                         withAnchor2:componentViewController.componentView.anchor2 
                        forGridScale:gridScale];
        componentViewController.componentView.gridScale = gridScale;
        componentViewController.componentView.draggable = YES;
        [self.gridView addSubview:componentViewController.componentView];
    };
    
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.componentListView.backgroundColor = [UIColor brownColor];
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

// Create toolbar items 
- (NSArray *)createToolBarItems
{
    NSMutableArray *toolBarItems = [NSMutableArray array];
    
    // Create back button
    UIImage *backButtonsImage = [UIImage imageNamed:@"arrow_left_24.png"];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:backButtonsImage style:UIBarButtonItemStylePlain target:self action:@selector(closeSchematic)];
    backButton.width = kToolBarItemWidth;
    [toolBarItems addObject:backButton];
    [backButton release];
    
    // Create add component button
    UIImage *addButtonImage = [UIImage imageNamed:@"plus_24.png"];
    UIBarButtonItem *addComponentButton = [[UIBarButtonItem alloc] initWithImage:addButtonImage style:UIBarButtonItemStylePlain target:nil action:nil];
    //    UIBarButtonItem *addComponentButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    addComponentButton.width = kToolBarItemWidth;
    [toolBarItems addObject:addComponentButton];
    [addComponentButton release];
    
    // Create delete component button
    UIImage *deleteButtonImage = [UIImage imageNamed:@"delete_24.png"];
    UIBarButtonItem *deleteComponentButton = [[UIBarButtonItem alloc] initWithImage:deleteButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(crossPressed)];
    //    UIBarButtonItem *deleteComponentButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:nil action:nil];
    deleteComponentButton.width = kToolBarItemWidth;
    [toolBarItems addObject:deleteComponentButton];
    [deleteComponentButton release];
    
    // Create component setting button
    UIImage *settingsButtonImage = [UIImage imageNamed:@"gear_24.png"];
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithImage:settingsButtonImage style:UIBarButtonItemStylePlain target:nil action:nil];
    settingsButton.width = kToolBarItemWidth;
    [toolBarItems addObject:settingsButton];
    [settingsButton release];
    
    // Create pencil button
    UIImage *pencilButtonImage = [UIImage imageNamed:@"pencil_24.png"];
    UIBarButtonItem *pencilButton = [[UIBarButtonItem alloc] initWithImage:pencilButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(drawWire)];
    pencilButton.width = kToolBarItemWidth;
    [toolBarItems addObject:pencilButton];
    [pencilButton release];
    
    // Create chart button
    UIImage *chartButtonImage = [UIImage imageNamed:@"chart_line_24.png"];
    UIBarButtonItem *chartButton = [[UIBarButtonItem alloc] initWithImage:chartButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(analyzeCircuit)];
    chartButton.width = kToolBarItemWidth;
    [toolBarItems addObject:chartButton];
    [chartButton release];
    
    return toolBarItems;
}

// Wire drawing mode
- (void)drawWire
{
    self.gridView.wireDrawingInProgress = YES;
}

- (void)crossPressed
{
    if (self.gridView.wireDrawingInProgress) self.gridView.wireDrawingInProgress = NO;
}

- (void)analyzeCircuit
{
    NSDictionary *simulationModel = [[DSPCircuitAnalyzer simulatonModelForCircuit:self.circuit] retain];
    
    NSArray *components = [simulationModel objectForKey:@"components"];
    NSArray *nodes = [simulationModel objectForKey:@"nodes"];
    
    for (DSPNode* node in nodes) {
        DSPGridPoint location = node.location;
        NSLog(@"Node x:%d y:%d", location.x, location.y);
    }
    
    [DSPSimulator runSimulationForComponents:components andNodes:nodes];
    [simulationModel release];
}

@end
