//
//  Minesweeper.h
//  MinesweeperApplication
//
//  Created by Rahath Cherukuri on 3/16/14.
//  Copyright (c) 2014 Rahath Cherukuri. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Minesweeper : UIView

@property (nonatomic, assign) int row;
@property (nonatomic, assign) int col;
@property (nonatomic, assign) CGFloat dw;
@property (nonatomic, assign) CGFloat dh;
@property (nonatomic,assign) IBOutlet UILabel *seconds;
@property (nonatomic,assign) IBOutlet UILabel *BestTime;
@property (nonatomic,assign) IBOutlet UILabel * MineDisplayer;
-(void) initializeMatrix;
-(void) checkSurroundings: (int) r andArg: (int)c;

@end

/*Number used for what
 mine= -2
 numbers= 1-8
 covered= -10(initial)
 uncovered= 9(no mines surrounding and clicked)
 flag=11
 */