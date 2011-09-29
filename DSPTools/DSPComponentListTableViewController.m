//
//  DSPComponentListTableViewController.m
//  DSPTools
//
//  Created by Puru Choudhary on 9/15/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPComponentListTableViewController.h"
#import "Three20/Three20.h"
#import "DSPGlobalSettings.h"
#import "DSPComponentListProtocol.h"

@interface DSPComponentListTableViewController ()
@property (nonatomic, readonly) NSArray *componentList;
@end

@implementation DSPComponentListTableViewController

#pragma mark - Accessors
@synthesize delegate = _delegate;

- (NSArray *)componentList
{
    if (!_componentList) {
        _componentList = [[DSPGlobalSettings sharedGlobalSettings].componentsInfo retain];
    }
    return _componentList;
}

#pragma mark - Setup and dealloc

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization        
    }
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_componentList);
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.toolbarHidden = YES; 
    
    // Cancel button
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self.delegate action:@selector(componentListCancelButtonPressed)];
    self.navigationItem.rightBarButtonItem = cancelButton;
    [cancelButton release];
    
    self.title = @"Add Component";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    // return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.componentList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    NSDictionary *component = [self.componentList objectAtIndex:indexPath.row];
    cell.textLabel.text = [component objectForKey:@"name"];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *selectedComponent = [self.componentList objectAtIndex:indexPath.row];
    NSString *componentClassName = [selectedComponent objectForKey:@"className"];
    NSString *viewClassName = [selectedComponent objectForKey:@"viewClassName"];
    [self.delegate componentSelected:componentClassName viewClass:viewClassName];
}



@end
