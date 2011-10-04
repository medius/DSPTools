//
//  DSPSystemViewController.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/16/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPSystemViewController.h"

#import "DSPCircuitFileIO.h"
#import "DSPCircuit.h"
#import "DSPCircuitUIManager.h"
#import "DSPCircuitAnalyzer.h"
#import "DSPSimulator.h"
#import "DSPGridView.h"

#import "DSPWaveformViewController.h"
#import "DSPComponentListTableViewController.h"

// Temporary
#import "DSPHeader.h"
#import "DSPHelper.h"
#import "DSPGlobalSettings.h"

#import "DSPComponents.h"
#import "DSPNode.h"

static const CGFloat kGridScale = 15;
static const CGFloat kComponentListHeight = 120;
static const CGFloat kToolBarItemWidth    = 40;

@interface DSPSystemViewController()
@property (readonly) DSPCircuitFileIO    *fileIO;
@property (readonly) DSPCircuit          *circuit;
@property (readonly) DSPCircuitUIManager *circuitUIManager;
@property (readonly) DSPSimulator        *simulator;
@property (readonly) TTView              *systemView;
@property (readonly) DSPGridView         *gridView;

- (NSArray *)createToolBarItems;
@end

@implementation DSPSystemViewController


#pragma mark - Accessors

@synthesize circuitFilePath  = _circuitFilePath;
@synthesize systemView       = _systemView;
@synthesize gridView         = _gridView;

- (DSPCircuitFileIO *)fileIO
{
    if (!_fileIO) {
        _fileIO = [[DSPCircuitFileIO alloc] init];
        _fileIO.delegate = self.circuit;
    }
    return _fileIO;
}

- (DSPCircuit *)circuit
{
    if (!_circuit) {
        _circuit = [[DSPCircuit alloc] init];
    }
    return _circuit;
}

- (DSPCircuitUIManager *)circuitUIManager
{
    if (!_circuitUIManager) {
        _circuitUIManager = [[DSPCircuitUIManager alloc] init];
    }
    return _circuitUIManager;
}

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

- (id)init
{
    self = [super init];
    if (self) {
        // Initialize the systemView
        CGRect systemViewFrame = TTApplicationFrame();
        _systemView = [[TTView alloc] initWithFrame:systemViewFrame];
        
        // Initialize the gridView
        CGRect gridViewFrame = TTApplicationFrame();
        _gridView = [[DSPGridView alloc] initWithFrame:gridViewFrame];
        _gridView.gridScale = kGridScale;
        
        [self setup];
    }
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_systemView);
    TT_RELEASE_SAFELY(_gridView);
    TT_RELEASE_SAFELY(_circuit);
    TT_RELEASE_SAFELY(_circuitUIManager)
    TT_RELEASE_SAFELY(_simulator);
    TT_RELEASE_SAFELY(_fileIO);
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
    // Read the circuit from the file
    [self.fileIO readCircuitFile:self.circuitFilePath];
    
    self.view = self.systemView;
    [self.view addSubview:self.gridView];
    self.gridView.delegate = self.circuitUIManager;
    self.circuitUIManager.delegate = self.circuit;
    
    // Configure the navigation controller when in system view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController setToolbarHidden:NO animated:NO];
    self.navigationController.toolbar.barStyle = UIBarStyleBlackOpaque;
    
    // Populate the grid with the components
    for (DSPComponent *component in self.circuit.components) {
        component.view.frame = 
        [DSPHelper getFrameForObject:component.view 
                         withAnchor1:component.view.anchor1 
                         withAnchor2:component.view.anchor2 
                        forGridScale:self.gridView.gridScale];
        component.view.gridScale = self.gridView.gridScale;
        component.view.isDraggable = YES;
        [self.gridView addSubview:component.view];
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

#pragma mark - Toolbar buttons and their actions

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
    UIBarButtonItem *chartButton = [[UIBarButtonItem alloc] initWithImage:chartButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(waveformButtonPressed)];
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
    
    NSMutableArray *removedComponents = [[NSMutableArray alloc] init];
    for (DSPComponent *component in self.circuit.components) {
        if (component.view.isSelected) {
            [component.view removeFromSuperview];
            [removedComponents addObject:component];
        }
    }
    [self.circuit.components removeObjectsInArray:removedComponents];
    [removedComponents release];
}

- (void)waveformButtonPressed
{
    DSPCircuitAnalyzer *circuitAnalyzer = [[DSPCircuitAnalyzer alloc] init];
    circuitAnalyzer.components = self.circuit.components;
    [circuitAnalyzer analyze];
    self.circuit.nodes = circuitAnalyzer.nodes;
    self.circuit.errors = circuitAnalyzer.errors;
    [circuitAnalyzer release];
    
    self.simulator.components = self.circuit.components;
    self.simulator.nodes = self.circuit.nodes;
    [self.simulator simulate];
    
    DSPWaveformViewController *waveform = [[DSPWaveformViewController alloc] init];
    waveform.graphView.frame = self.view.bounds;
    waveform.delegate = self;
    waveform.dataSource = self.circuit;
    waveform.plotList = [self.circuit scopeNames];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:waveform];
    [self presentModalViewController:navigationController animated:YES];
    [waveform release];
    
}

#pragma mark - ComponentList Protocol methods

- (void)componentListCancelButtonPressed
{
    [self.modalViewController dismissModalViewControllerAnimated:YES];
}

- (void)componentSelected:(NSString *)componentClassName viewClass:(NSString *)viewClassName;
{
    NSLog(@"%@", componentClassName);

    [self.modalViewController dismissModalViewControllerAnimated:YES];
    DSPComponentView *componentView = [self.circuitUIManager addComponentWithClassName:componentClassName viewClass:viewClassName forGridScale:self.gridView.gridScale];
    [self.gridView addSubview:componentView];
    [self.gridView updateUI];
}

#pragma mark - Waveform Delegate Protocol methods

- (void)waveformDoneButtonPressed
{
    [self.modalViewController dismissModalViewControllerAnimated:YES];
}

@end
