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
#import "DSPWaveformViewController.h"
#import "DSPComponentListTableViewController.h"

// Temporary
#import "DSPHeader.h"
#import "DSPHelper.h"
#import "DSPGlobalSettings.h"

#import "DSPComponents.h"
#import "DSPNode.h"

static const CGFloat kGridScale = 20;
static const CGFloat kComponentListHeight = 120;
static const CGFloat kToolBarItemWidth    = 40;

@interface DSPSystemViewController()
- (NSArray *)createToolBarItems;
@end

@implementation DSPSystemViewController


#pragma mark - Accessors
@synthesize systemView   = _systemView;
@synthesize gridView     = _gridView;
@synthesize circuit      = _circuit;
@synthesize simulator    = _simulator;

- (DSPSimulator *)simulator
{
    if (!_simulator) {
        _simulator = [[DSPSimulator alloc] init];
    }
    return _simulator;
}

#pragma mark - Setup and dealloc

- (void)setup
{
    self.systemView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self setToolbarItems:[self createToolBarItems]];
}

- (id)initWithCircuitFile:(NSString *)filePath
{
    self = [super init];
    if (self) {
        // Get the circuit from the file
        _circuit = [[DSPCircuitFileIO circuitInFile:filePath] retain];
        
        // Initialize the systemView
        CGRect systemViewFrame = TTApplicationFrame();
        _systemView = [[TTView alloc] initWithFrame:systemViewFrame];
        
        // Initialize the gridView
        CGRect gridViewFrame = TTApplicationFrame();
        _gridView = [[DSPGridView alloc] initWithFrame:gridViewFrame];
        _gridView.gridScale = kGridScale;
        _gridView.delegate = self;
        
        [self setup];
    }
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_systemView);
    TT_RELEASE_SAFELY(_gridView);
    TT_RELEASE_SAFELY(_circuit);
    TT_RELEASE_SAFELY(_simulator);
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
    
    // Configure the navigation controller when in system view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController setToolbarHidden:NO animated:NO];
    self.navigationController.toolbar.barStyle = UIBarStyleBlackOpaque;
    
    
    NSArray *components = [self.circuit objectForKey:@"components"];
    
    // Populate the grid with the components
    for (DSPComponentViewController *componentViewController in components) {
        componentViewController.componentView.frame = 
        [DSPHelper getFrameForObject:componentViewController.componentView 
                         withAnchor1:componentViewController.componentView.anchor1 
                         withAnchor2:componentViewController.componentView.anchor2 
                        forGridScale:self.gridView.gridScale];
        componentViewController.componentView.gridScale = self.gridView.gridScale;
        componentViewController.componentView.isDraggable = YES;
        [self.gridView addSubview:componentViewController.componentView];
    };
    
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
    UIBarButtonItem *addComponentButton = [[UIBarButtonItem alloc] initWithImage:addButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(addComponent)];
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

// Add component
- (void)addComponent
{
    DSPComponentListTableViewController *componentListTVC = [[DSPComponentListTableViewController alloc] init];
    componentListTVC.delegate = self;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:componentListTVC];
    [self presentModalViewController:navigationController animated:YES];
    [componentListTVC release];
    [navigationController release];
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
        
    [self.simulator runSimulationForComponents:components andNodes:nodes];

    
    DSPWaveformViewController *waveform = [[DSPWaveformViewController alloc] init];
    waveform.graphView.frame = self.view.bounds;
    waveform.delegate = self;
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:waveform];
    [self presentModalViewController:navigationController animated:YES];
    [waveform release];
    [navigationController release];
    [simulationModel release];

}

#pragma mark - Wire Creation Protocol

- (void)createWireforAnchor1:(DSPGridPoint)anchor1 andAnchor2:(DSPGridPoint)anchor2
{
    DSPWireViewController *newWire = [[DSPWireViewController alloc] init];
    newWire.componentView.frame = 
    [DSPHelper getFrameForObject:newWire.componentView 
                     withAnchor1:anchor1 
                     withAnchor2:anchor2 
                    forGridScale:self.gridView.gridScale];
    newWire.componentView.anchor1 = anchor1;
    newWire.componentView.anchor2 = anchor2;
    newWire.componentView.gridScale = self.gridView.gridScale;
    newWire.componentView.isDraggable = YES;

    
    [self.gridView addSubview:newWire.componentView];
    NSMutableArray *components = [self.circuit objectForKey:@"components"];
    [components addObject:newWire];
    [newWire release];
    [self.gridView setNeedsDisplay];
}

#pragma mark - ComponentList Protocol methods

- (void)componentListCancelButtonPressed
{
    [self.modalViewController dismissModalViewControllerAnimated:YES];
}

- (void)componentSelected:(NSString *)componentName
{
    NSLog(@"%@", componentName);
    [self.modalViewController dismissModalViewControllerAnimated:YES];
}

#pragma mark - Waveform Data Source Methods

- (NSNumber *)numberForWaveformIndex:(NSUInteger)waveformIndex axis:(DSPWaveformAxis)waveformAxis recordIndex:(NSUInteger)index
{
    return [self.simulator numberForWaveformIndex:waveformIndex axis:waveformAxis recordIndex:index];
}

- (void)waveformDoneButtonPressed
{
    [self.modalViewController dismissModalViewControllerAnimated:YES];
}

@end
