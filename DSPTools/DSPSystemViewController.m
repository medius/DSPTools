//
//  DSPSystemViewController.m
//  DSPTools
//
//  Created by Puru Choudhary on 8/16/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPSystemViewController.h"
#import "DSPGridViewController.h"

@implementation DSPSystemViewController

// Setters/getters
@synthesize systemView;
@synthesize gridView;

- (DSPSystemView *)systemView
{
    if (!systemView)
    {
        systemView = [[DSPSystemView alloc] init];
    }
    return systemView;
}

- (DSPGridView *)gridView
{
    if (!gridView)
    {
        gridView = [[DSPGridView alloc] init];
    }
    return gridView;
}

#define TOOLBAR_ITEM_WIDTH 40

// Create toolbar items 
- (NSArray *)createToolBarItems
{
    NSMutableArray *toolBarItems = [NSMutableArray array];
    
    // Create add component button
    UIImage *addButtonImage = [UIImage imageNamed:@"plus_24.png"];
    UIBarButtonItem *addComponentButton = [[UIBarButtonItem alloc] initWithImage:addButtonImage style:UIBarButtonItemStylePlain target:nil action:nil];
    addComponentButton.width = TOOLBAR_ITEM_WIDTH;
    [toolBarItems addObject:addComponentButton];
    [addComponentButton release];
    
    // Create delete component button
    UIImage *deleteButtonImage = [UIImage imageNamed:@"stop_24.png"];
    UIBarButtonItem *deleteComponentButton = [[UIBarButtonItem alloc] initWithImage:deleteButtonImage style:UIBarButtonItemStylePlain target:nil action:nil];
    deleteComponentButton.width = TOOLBAR_ITEM_WIDTH;
    [toolBarItems addObject:deleteComponentButton];
    [deleteComponentButton release];
    
    // Create component setting button
    UIImage *settingsButtonsImage = [UIImage imageNamed:@"gear_24.png"];
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithImage:settingsButtonsImage style:UIBarButtonItemStylePlain target:nil action:nil];
    settingsButton.width = TOOLBAR_ITEM_WIDTH;
    [toolBarItems addObject:settingsButton];
    [settingsButton release];
    
    // Create pencil button
    UIImage *pencilButtonsImage = [UIImage imageNamed:@"pencil_24.png"];
    UIBarButtonItem *pencilButton = [[UIBarButtonItem alloc] initWithImage:pencilButtonsImage style:UIBarButtonItemStylePlain target:nil action:nil];
    pencilButton.width = TOOLBAR_ITEM_WIDTH;
    [toolBarItems addObject:pencilButton];
    [pencilButton release];
    
    // Create chart button
    UIImage *chartButtonsImage = [UIImage imageNamed:@"chart_line_24.png"];
    UIBarButtonItem *chartButton = [[UIBarButtonItem alloc] initWithImage:chartButtonsImage style:UIBarButtonItemStylePlain target:nil action:nil];
    chartButton.width = TOOLBAR_ITEM_WIDTH;
    [toolBarItems addObject:chartButton];
    [chartButton release];
    
    return toolBarItems;
}

- (void)setup
{
    self.systemView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.gridView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    
    [self setToolbarItems:[self createToolBarItems]];
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
    [systemView release];
    [gridView release];
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
    self.view = self.systemView;
    
    // Configure the navigation controller when in system view.
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.toolbarHidden = NO;
    self.navigationController.toolbar.barStyle = UIBarStyleBlackOpaque;
    
    // Get the navigation and tool bar sizes to calculate grid view frame.
    CGRect navigationBarFrame = self.navigationController.navigationBar.frame;
    CGRect toolbarFrame = self.navigationController.toolbar.frame;
    CGRect gridViewFrame = CGRectMake(0, 0, navigationBarFrame.size.width, toolbarFrame.origin.y - navigationBarFrame.origin.y - navigationBarFrame.size.height);

    self.gridView.frame = gridViewFrame;
    [self.view addSubview:self.gridView];
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

@end
