//
//  SecondViewController.h
//  MinesweeperApp
//
//  Created by Rahath Cherukuri on 3/16/14.
//  Copyright (c) 2014 Rahath Cherukuri. All rights reserved.
//
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController
{
    
}
@property (nonatomic,assign) int rowStepperValue;
@property (nonatomic,assign) int colStepperValue;
@property (nonatomic,assign) float rSliderValue;
@property (nonatomic,assign) float gSliderValue;
@property (nonatomic,assign) float bSliderValue;

//For both the steppers: row and col
@property (weak,nonatomic) IBOutlet UIStepper *stepper1;
@property (weak,nonatomic) IBOutlet UIStepper *stepper2;
//To display in a label
@property (weak,nonatomic) IBOutlet UILabel *rowValue;
@property (weak,nonatomic) IBOutlet UILabel *colValue;
//to get the values of RGB
@property (nonatomic,retain) IBOutlet UISlider *rValue;
@property (nonatomic,retain) IBOutlet UISlider *gValue;
@property (nonatomic,retain) IBOutlet UISlider *bValue;
//to display Mixture of cols
@property (nonatomic,retain) IBOutlet UILabel *colorShower;


-(IBAction)rowValueChanged:(id)sender;
-(IBAction)colValueChanged:(id)sender;
-(IBAction)rValueChanged:(id)sender;
-(IBAction)gValueChanged:(id)sender;
-(IBAction)bValueChanged:(id)sender;
@end
