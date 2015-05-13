//
//  FirstViewController.m
//  MinesweeperApp
//
//  Created by Rahath Cherukuri on 3/16/14.
//  Copyright (c) 2014 Rahath Cherukuri. All rights reserved.
//
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property (strong,nonatomic) Minesweeper *minesweeper;
@end

@implementation FirstViewController

@synthesize minesweeper=_minesweeper;


- (Minesweeper *)minesweeper
{
    if (!_minesweeper)
        _minesweeper = [[Minesweeper alloc] init];
    return _minesweeper;
}


- (void)viewDidLoad
{
    [super viewDidLoad];   // don't forget!
    [self.minesweeper initializeMatrix];

    //added the code here for the rgb values to get from NSUSER defaults
    //rSliderValue=[[NSUserDefaults standardUserDefaults] floatForKey:@"rSlider"];
    //bSliderValue=[[NSUserDefaults standardUserDefaults] floatForKey:@"bSlider"];
    //gSliderValue=[[NSUserDefaults standardUserDefaults] floatForKey:@"gSlider"];

    UIView *tapView = self.view;  // this is our minesweeper object
    // create gesture recognizer, with associated gesture handler
    UITapGestureRecognizer *tapDoubleGR = [[UITapGestureRecognizer alloc]
                                           initWithTarget:tapView action:@selector(tapDoubleHandler:)];
    tapDoubleGR.numberOfTapsRequired = 2;         // set appropriate GR attributes
    [tapView addGestureRecognizer:tapDoubleGR];   // add GR to view
    UITapGestureRecognizer *tapSingleGR = [[UITapGestureRecognizer alloc]
                                           initWithTarget:tapView action:@selector(tapSingleHandler:)];
    tapSingleGR.numberOfTapsRequired = 1;         // set appropriate GR attributes
    [tapSingleGR requireGestureRecognizerToFail: tapDoubleGR];  // prevent single tap recognition on double-tap
    [tapView addGestureRecognizer:tapSingleGR];   // add GR to view
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
