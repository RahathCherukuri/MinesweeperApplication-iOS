//
//  MinesweeperAppTests.m
//  MinesweeperAppTests
//
//  Created by Rahath Cherukuri on 3/16/14.
//  Copyright (c) 2014 Rahath Cherukuri. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Minesweeper.h"
#import "SecondViewController.h"
#import "FirstViewController.h"

@interface MinesweeperAppTests : XCTestCase

@end

@implementation MinesweeperAppTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNoOfMines
{
    Minesweeper * minesweeper = [[Minesweeper alloc]init];
    //Test for same value of rows and columns
    int noOfMines = [minesweeper noOfMineswithrows:7 andcolumns:7];
    NSNumber * noOfMiness = [NSNumber numberWithInt:noOfMines];
    NSNumber * value = [NSNumber numberWithInt:9];
    XCTAssertEqualObjects(value, noOfMiness, @"Working for 7*7");
    
    //Test for different values of rows and columns
    noOfMines = [minesweeper noOfMineswithrows:8 andcolumns:5];
    noOfMiness = [NSNumber numberWithInt:noOfMines];
    value = [NSNumber numberWithInt:8];
    XCTAssertEqualObjects(value, noOfMiness, @"Working for 8*5");
    
}

//Testing initial color for SecondView Controller.
-(void)testInitialColorForSecondVC
{
    SecondViewController * SVC = [[SecondViewController alloc]init];
    [[NSUserDefaults standardUserDefaults] setFloat:0.0 forKey:@"rSlider"];
    [[NSUserDefaults standardUserDefaults] setFloat:0.0 forKey:@"bSlider"];
    [[NSUserDefaults standardUserDefaults] setFloat:0.0 forKey:@"gSlider"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [SVC viewDidLoad];
    float rValue=[[NSUserDefaults standardUserDefaults] floatForKey:@"rSlider"];
    float bValue=[[NSUserDefaults standardUserDefaults] floatForKey:@"bSlider"];
    float gValue=[[NSUserDefaults standardUserDefaults] floatForKey:@"gSlider"];
    
    NSLog(@" RedValue:%f, BlueValue: %f, GreenValue: %f", rValue, bValue, gValue);
    NSNumber * rValueNum = [NSNumber numberWithFloat:rValue];
    NSNumber * value = [NSNumber numberWithFloat:0.3];
    XCTAssertEqualObjects(value, rValueNum, @"Correct Value for Red");
    
    NSNumber * bValueNum = [NSNumber numberWithFloat:bValue];
    value = [NSNumber numberWithFloat:0.5];
    XCTAssertEqualObjects(value, bValueNum, @"Correct Value for Blue");
    
    NSNumber * gValueNum = [NSNumber numberWithFloat:gValue];
    value = [NSNumber numberWithFloat:0.4];
    XCTAssertEqualObjects(value, gValueNum, @"Correct Value for Green");
}

//Testing the Minesweeper object not to be nil.
-(void)testMineesweeperObjFirstVC
{
    FirstViewController *FVC = [[FirstViewController alloc]init];
    Minesweeper * minesweeper = [FVC minesweeper];
    XCTAssertNotNil(minesweeper, @"minesweeper object is not nil");
}

@end
