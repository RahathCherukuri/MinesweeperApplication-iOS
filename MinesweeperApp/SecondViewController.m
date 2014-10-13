//
//  SecondViewController.m
//  MinesweeperApp
//
//  Created by Rahath Cherukuri on 3/16/14.
//  Copyright (c) 2014 Rahath Cherukuri. All rights reserved.
//
//

#import "SecondViewController.h"



@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize rowStepperValue;
@synthesize colStepperValue;
@synthesize rowValue;
@synthesize colValue;
@synthesize rSliderValue;
@synthesize gSliderValue;
@synthesize bSliderValue;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    rSliderValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"rSlider"];
    gSliderValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"gSlider"];
    bSliderValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"bSlider"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    if(rSliderValue==0.0 && gSliderValue==0.0 && bSliderValue==0.0)
    {
        rSliderValue=0.3;
        gSliderValue=0.4;
        bSliderValue=0.5;
        [[NSUserDefaults standardUserDefaults] setFloat:self.rSliderValue forKey:@"rSlider"];
        [[NSUserDefaults standardUserDefaults] setFloat:self.gSliderValue forKey:@"gSlider"];
        [[NSUserDefaults standardUserDefaults] setFloat:self.bSliderValue forKey:@"bSlider"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    self.colorShower.backgroundColor = [UIColor colorWithRed:self.rSliderValue green:self.gSliderValue blue:self.bSliderValue alpha:1];
    self.stepper1.value= [[NSUserDefaults standardUserDefaults] integerForKey:@"rStepper"];
    self.rowValue.text= [NSString stringWithFormat:@"%i",(int)self.stepper1.value];
    self.stepper2.value= [[NSUserDefaults standardUserDefaults] integerForKey:@"cStepper"];
    self.colValue.text= [NSString stringWithFormat:@"%i",(int)self.stepper2.value];
    float i= [[NSUserDefaults standardUserDefaults] floatForKey:@"rSlider"];
    self.rValue.value= i;
    float j= [[NSUserDefaults standardUserDefaults] floatForKey:@"gSlider"];
    self.gValue.value= j;
    float k= [[NSUserDefaults standardUserDefaults] floatForKey:@"bSlider"];
    self.bValue.value= k;
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
 /*   NSInteger rvlue= [[NSUserDefaults standardUserDefaults] integerForKey:@"rStepper"];
    self.rowStepperValue= rvlue;
    //NSLog(@"%i",btime);
    self.rowValue.text= [NSString stringWithFormat:@"%i",rvlue];*/
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//Function call is made if we change the values in row stepper
-(IBAction)rowValueChanged:(UIStepper*)sender
{
    
    self.rowStepperValue= [sender value];
    self.rowValue.text= [NSString stringWithFormat:@"%i",self.rowStepperValue];
    [[NSUserDefaults standardUserDefaults] setInteger:self.rowStepperValue forKey:@"rStepper"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
//Function call is made if we change the values in col stepper
-(IBAction)colValueChanged:(UIStepper*)sender
{
    self.colStepperValue= [sender value];
    self.colValue.text= [NSString stringWithFormat:@"%i",self.colStepperValue];
    [[NSUserDefaults standardUserDefaults] setInteger:self.colStepperValue forKey:@"cStepper"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

//Function call is made if we change the values in red slider
-(IBAction)rValueChanged:(UISlider*)sender
{
    self.rSliderValue= [sender value];
    NSLog(@"Red: %f",self.rSliderValue);
    self.colorShower.backgroundColor = [UIColor colorWithRed:self.rSliderValue green:self.gSliderValue blue:self.bSliderValue alpha:1];
    [[NSUserDefaults standardUserDefaults] setFloat:self.rSliderValue forKey:@"rSlider"];
    [[NSUserDefaults standardUserDefaults] setFloat:self.gSliderValue forKey:@"gSlider"];
    [[NSUserDefaults standardUserDefaults] setFloat:self.bSliderValue forKey:@"bSlider"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
//Function call is made if we change the values in green slider
-(IBAction)gValueChanged:(UISlider*)sender
{
    self.gSliderValue= [sender value];
    NSLog(@"Green: %f",self.gSliderValue);
    self.colorShower.backgroundColor = [UIColor colorWithRed:self.rSliderValue green:self.gSliderValue blue:self.bSliderValue alpha:1];
    [[NSUserDefaults standardUserDefaults] setFloat:self.rSliderValue forKey:@"rSlider"];
    [[NSUserDefaults standardUserDefaults] setFloat:self.gSliderValue forKey:@"gSlider"];
    [[NSUserDefaults standardUserDefaults] setFloat:self.bSliderValue forKey:@"bSlider"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
//Function call is made if we change the values in blue slider
-(IBAction)bValueChanged:(UISlider*)sender
{
    self.bSliderValue= [sender value];
    NSLog(@"Blue: %f",self.bSliderValue);
    self.colorShower.backgroundColor = [UIColor colorWithRed:self.rSliderValue green:self.gSliderValue blue:self.bSliderValue alpha:1];
    [[NSUserDefaults standardUserDefaults] setFloat:self.rSliderValue forKey:@"rSlider"];
    [[NSUserDefaults standardUserDefaults] setFloat:self.gSliderValue forKey:@"gSlider"];
    [[NSUserDefaults standardUserDefaults] setFloat:self.bSliderValue forKey:@"bSlider"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end
