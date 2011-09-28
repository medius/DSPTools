//
//  DSPWaveformViewController.m
//  DSPTools
//
//  Created by Puru Choudhary on 9/8/11.
//  Copyright 2011 Puru Choudhary. All rights reserved.
//

#import "DSPWaveformViewController.h"
#import "DSPHeader.h"
#import "DSPWaveformDataSourceProtocol.h"

@interface DSPWaveformViewController()
@property (nonatomic, retain) CPTXYGraph *graph;
@property (readonly) NSArray             *colorList;
@end

@implementation DSPWaveformViewController

#pragma mark - Accessors
@synthesize plotList   = _plotList;
@synthesize graphView  = _graphView;
@synthesize graph      = _graph;
@synthesize dataSource = _dataSource;
@synthesize delegate   = _delegate;

- (CPTGraphHostingView *)graphView
{
    if (!_graphView) {
        _graphView = [[CPTGraphHostingView alloc] init];
    }
    return _graphView;
}

- (CPTXYGraph *)graph
{
    if (!_graph) {
        _graph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
    }
    return _graph;
}

- (NSArray *)colorList
{
    if (!_colorList) {
        _colorList = [NSArray arrayWithObjects:[CPTColor redColor], [CPTColor greenColor], [CPTColor yellowColor], nil];
    }
    return _colorList;
}

#pragma mark - Initialization and deallocation

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
    TT_RELEASE_SAFELY(_graphView);
    TT_RELEASE_SAFELY(_graph);
    TT_RELEASE_SAFELY(_colorList);
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
    self.view = self.graphView;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Screen setup
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
    
    // Cancel button
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.delegate action:@selector(waveformDoneButtonPressed)];
    self.navigationItem.rightBarButtonItem = doneButton;
    [doneButton release];
    
    self.title = @"Waveform";
    
    // Graph
    self.graph.frame = self.view.bounds;
    self.graphView.hostedGraph = self.graph;
    CPTTheme *theme = [CPTTheme themeNamed:@"Dark Gradients"];
    [self.graph applyTheme:theme];
    self.graph.paddingLeft = 20.0;
    self.graph.paddingTop = 20.0;
    self.graph.paddingRight = 20.0;
    self.graph.paddingBottom = 20.0;
    
    // Plotspace
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)self.graph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-0.5) length:CPTDecimalFromFloat(6)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-1.5) length:CPTDecimalFromFloat(3)];
    
    // AxisSet
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)self.graph.axisSet;
    
    // Linestyle
    CPTMutableLineStyle *lineStyle = [CPTLineStyle lineStyle];
    lineStyle.lineColor = [CPTColor blackColor];
    lineStyle.lineWidth = 2.0f;
    
    // X Axis
    axisSet.xAxis.majorIntervalLength = [[NSDecimalNumber decimalNumberWithString:@"5"] decimalValue];
    axisSet.xAxis.minorTicksPerInterval = 4;
    axisSet.xAxis.majorTickLineStyle = lineStyle;
    axisSet.xAxis.minorTickLineStyle = lineStyle;
    axisSet.xAxis.axisLineStyle = lineStyle;
    axisSet.xAxis.minorTickLength = 5.0f;
    axisSet.xAxis.majorTickLength = 7.0f;
    axisSet.xAxis.labelOffset = 3.0f;
 
    // Y Axis
    axisSet.yAxis.majorIntervalLength = [[NSDecimalNumber decimalNumberWithString:@"1"] decimalValue];
    axisSet.yAxis.minorTicksPerInterval = 4;
    axisSet.yAxis.majorTickLineStyle = lineStyle;
    axisSet.yAxis.minorTickLineStyle = lineStyle;
    axisSet.yAxis.axisLineStyle = lineStyle;
    axisSet.yAxis.minorTickLength = 5.0f;
    axisSet.yAxis.majorTickLength = 7.0f;
    axisSet.yAxis.labelOffset = 3.0f;
    
    NSUInteger colorIndex = 0;
    
    // Setup all the plots
    for (NSString *plotName in self.plotList) {
        if ([plotName isKindOfClass:[NSString class]]) {
            CPTScatterPlot *plot = [[CPTScatterPlot alloc] init];
            plot.identifier = plotName;
            CPTMutableLineStyle *plotLineStyle = [[plot.dataLineStyle mutableCopy] autorelease];
            plotLineStyle.lineWidth = 1.0f;
            plotLineStyle.lineColor = [self.colorList objectAtIndex:colorIndex];

            plot.dataLineStyle = plotLineStyle;
            plot.dataSource = self;
            [self.graph addPlot:plot];
            TT_RELEASE_SAFELY(plot);
            
            // Get the next color
            colorIndex++;
            if (colorIndex >= [self.colorList count]) {
                colorIndex = 0;
            }
        }
    }
    
//    // X Squared Plot
//    CPTScatterPlot *xSquaredPlot = [[CPTScatterPlot alloc] init];
//    xSquaredPlot.identifier = @"Signal Source";
//    CPTMutableLineStyle *xSquaredPlotLineStyle = [[xSquaredPlot.dataLineStyle mutableCopy] autorelease];
//    xSquaredPlotLineStyle.lineWidth = 1.0f;
//    xSquaredPlotLineStyle.lineColor = [CPTColor redColor];
//    xSquaredPlot.dataLineStyle = xSquaredPlotLineStyle;
//    xSquaredPlot.dataSource = self;
//    [self.graph addPlot:xSquaredPlot];
//    TT_RELEASE_SAFELY(xSquaredPlot);
//    
//    CPTPlotSymbol *greenCirclePlotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
//    greenCirclePlotSymbol.fill = [CPTFill fillWithColor:[CPTColor greenColor]];
//    greenCirclePlotSymbol.size = CGSizeMake(2.0, 2.0);
//    xSquaredPlot.plotSymbol = greenCirclePlotSymbol;
//    
//    // X Inverse Plot
//    CPTScatterPlot *xInversePlot = [[CPTScatterPlot alloc] init];
//    xInversePlot.identifier = @"Integrator";
//    CPTMutableLineStyle *xInversePlotLineStyle = [[xInversePlot.dataLineStyle mutableCopy] autorelease];
//    xInversePlotLineStyle.lineWidth = 1.0f;
//    xInversePlotLineStyle.lineColor = [CPTColor greenColor];
//    xInversePlot.dataLineStyle = xInversePlotLineStyle;
//    xInversePlot.dataSource = self;
//    [self.graph addPlot:xInversePlot];
//    TT_RELEASE_SAFELY(xInversePlot)
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

#pragma mark - Plot Data Source Methods

- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return 100;
}

- (NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    if (fieldEnum == CPTScatterPlotFieldX) {
        return [self.dataSource numberForWaveformIndex:0 axis:DSPWaveformAxisX recordIndex:index];
    }
    else {
        NSUInteger waveformIndex = [self.plotList indexOfObject:plot.identifier];
        if (waveformIndex != NSNotFound) {
            return [self.dataSource numberForWaveformIndex:waveformIndex axis:DSPWaveformAxisY recordIndex:index];
        }
        else {
            return 0;
        }
    }
}

@end
