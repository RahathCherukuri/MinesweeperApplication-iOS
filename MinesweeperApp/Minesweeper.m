
//
//  Minesweeper.m
//  MinesweeperApplication
//
//  Created by Rahath Cherukuri on 3/16/14.
//  Copyright (c) 2014 Rahath Cherukuri. All rights reserved.
//
//

#import <math.h>
#import "Minesweeper.h"
#import "SecondViewController.h"

@interface Minesweeper()
{
    BOOL firstTime;
    int clickedRow;
    int clickedCol;
}
@end

@implementation Minesweeper

@synthesize row= _row;
@synthesize col=_col;
@synthesize dw=_dw;
@synthesize dh=_dh;



//matrix which chnges the values with clicks
int Matrix[16][16];
//matrix1 remains same till the last it gets only set when we click on new game
int Matrix1[16][16];
//matrix values are changed when we click on correct location of mine(look at single click handler)
int dupMatrix[16][16];
//gets set to true when it enters doubletap hanler or singletap handler
BOOL doubleTap;
//not used
BOOL singleTap;
//gets set only when game is lost
bool lostGame= false;
//used to put the grid down
int downValue = 80;
//keeps a track  number of mines still present if it is 0 then he is won(look at single click handler)
int won=0;
//timer has to be set only once
bool timertype=false;

int highscore=10000;

//timer variables
int timercount;
NSTimer * timer;

int noofrows;
int noofcols;
//counts the no of mines at that point
int dmine=0;


//Initialized in the draw rect method
-(void) initializeMatrix
{
    timercount=0;
    firstTime= TRUE;
    lostGame= false;
    int count=0;
    clickedCol=-10;
    clickedRow=-10;
    noofrows=(int)[[NSUserDefaults standardUserDefaults] integerForKey:@"rStepper"];
    noofcols= (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"cStepper"];
    if(noofrows==0 && noofcols==0)//Initially when the application is started in a different machine
    {
        noofrows=10;
        noofcols=7;
        [[NSUserDefaults standardUserDefaults] setInteger:noofrows forKey:@"rStepper"];
        [[NSUserDefaults standardUserDefaults] setInteger:noofcols forKey:@"cStepper"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    //caliculates the percentage of mines
    //int noofmines= (noofrows*noofcols)/5;
    int noofmines = [self noOfMineswithrows:noofrows andcolumns:noofcols];
    for(int i=0;i <noofcols;i++)
    {
        for(int j=0;j<noofrows;j++)
        {
            Matrix[i][j]=-10;
        }
    }
    
    while(count<noofmines)
    {
        int randx= arc4random_uniform(noofcols);//gets random values less than 16
        int randy= arc4random_uniform(noofrows);
        Matrix[randx][randy]= -2;
        count++;
    }
    //shows the count of mines
    for(int i=0;i<noofcols;++i)
    {
        for(int j=0;j<noofrows;++j)
        {
            if(Matrix[i][j]==-2)
            {
                dmine++;
            }
        }
    }
    
    for(int i=0;i<noofcols;i++)
    {
        for(int j=0;j<noofrows;j++)
        {
            dupMatrix[i][j]= Matrix[i][j];
        }
    }
    for(int i=0;i<noofcols;i++)
    {
        for(int j=0;j<noofrows;j++)
        {
            Matrix1[i][j]= Matrix[i][j];
        }
    }
}

-(int)noOfMineswithrows: (int)noofrows andcolumns:(int)noofcols
{
    int noofmines= (noofrows*noofcols)/5;
    return noofmines;
}

/*-(void) TimerFunction
 {
 [timer invalidate];
 [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
 }
 */
//Set the label that has timer.
-(void)countDown
{
    timercount+=1;
    self.seconds.text= [NSString stringWithFormat:@"%i",timercount];
}


- (void)drawRect:(CGRect)rect
{
    if(!timertype)//boolean value
    {
        [timer invalidate];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        timertype= true;
    }
    //displays the no of mines
    self.MineDisplayer.text= [NSString stringWithFormat:@"%i",dmine];
    //for the first time the best score will be zero
    NSInteger btime= [[NSUserDefaults standardUserDefaults] integerForKey:@"hScore"];
    //btime= 100;
    //NSLog( @"Minesweeper/drawRect() here=============" );
    //NSLog(@"%i",btime);
    self.BestTime.text= [NSString stringWithFormat:@"%ld",(long)btime];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect bounds = [self bounds];        // get bounds of rectangle about owning view
    CGFloat w = CGRectGetWidth(bounds);   // w = width of bounds rectangle
    CGFloat h= CGRectGetHeight(bounds);
    
    //self.dw = w/16.0f,
    float rowcount= noofrows *1.0f;
    float colcount= noofcols * 1.0f;
    
    self.dw= w/colcount;
    self.dh= (h-150)/rowcount;
    //self.dh= (h)/rowcount;
    NSLog( @"Minesweeper/drawRect() here" );
    
    [[UIColor grayColor] setStroke];
    
    for ( int i = 0;  i < noofrows+1;  ++i )//horizontal lines
    {
        CGContextMoveToPoint( context, 0, i*self.dh+downValue);
        CGContextAddLineToPoint( context, w, i*self.dh+downValue);
    }
    for ( int i = 0;  i < noofcols+1;  ++i )//vertical lines
    {
        CGContextMoveToPoint( context, i*self.dw, downValue);
        CGContextAddLineToPoint( context, i*self.dw, downValue+self.dh*noofrows);
    }
    
    CGContextDrawPath( context, kCGPathStroke ); // render the lines
    //added the code here for the rgb values to get from NSUSER defaults
    float rValue=[[NSUserDefaults standardUserDefaults] floatForKey:@"rSlider"];
    float bValue=[[NSUserDefaults standardUserDefaults] floatForKey:@"bSlider"];
    float gValue=[[NSUserDefaults standardUserDefaults] floatForKey:@"gSlider"];
    //setting the default values for RGB
    if(rValue==0.0 && gValue==0.0 && bValue==0.0)
    {
        rValue=0.3;
        gValue=0.4;
        bValue=0.5;
        [[NSUserDefaults standardUserDefaults] setFloat:rValue forKey:@"rSlider"];
        [[NSUserDefaults standardUserDefaults] setFloat:gValue forKey:@"gSlider"];
        [[NSUserDefaults standardUserDefaults] setFloat:bValue forKey:@"bSlider"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    NSLog(@"%f",rValue);
    NSLog(@"%f",bValue);
    NSLog(@"%f",gValue);
    //Filling the background color
    for(int i=0;i<noofcols;i++)
    {
        for(int j=0;j<noofrows;j++)
        {
            //UIImage *img = [UIImage imageNamed:@"mine"];
            CGPoint xy = { 1.75+i*self.dw, downValue + j*self.dh };//--------------------here
            CGRect imageRect = CGRectMake(xy.x, xy.y, self.dw, self.dh);
            //[img drawInRect:imageRect];
            [[UIColor colorWithRed:rValue green:gValue blue:bValue alpha:1] setFill];
            UIRectFill(imageRect);
            [[UIColor blackColor] setFill];
            UIRectFrame(imageRect);
        }
    }
    
    
    //[self TimerFunction];
    //next code is if u want to print the mines
    /*for(int i=0;i<noofcols;++i)
     {
     for(int j=0;j<noofrows;++j)
     {
     if(Matrix[i][j]==-2)
     {
     UIFont *font = [UIFont systemFontOfSize: .75*self.dw];
     NSString *s= @"$";
     CGPoint xy = { 1.75+i*self.dw, downValue + j*self.dh };//--------------------here
     [s drawAtPoint: xy withFont: font];*/
    
    /*UIImage *img = [UIImage imageNamed:@"mine"];
     CGPoint xy = { 1.75+i*self.dw, downValue + j*self.dh };
     CGRect imageRect = CGRectMake(xy.x, xy.y, self.dw, self.dh);
     [img drawInRect:imageRect];
     
     }
     }
     }*/
    
    //game is lost then print all mines
    if(doubleTap== TRUE && lostGame== TRUE)
    {
        //lostGame= false;
        //doubleTap= false;
        for(int i=0;i<noofcols;i++)
        {
            for(int j=0;j<noofrows;j++)
            {
                if(Matrix[i][j]==-2)
                {
                    UIImage *img = [UIImage imageNamed:@"mine"];
                    CGPoint xy = { 1.75+i*self.dw, downValue + j*self.dh };//--------------------here
                    CGRect imageRect = CGRectMake(xy.x, xy.y, self.dw, self.dh);
                    [img drawInRect:imageRect];
                }
            }
        }
    }
    //when click on single or double click enters this
    if(doubleTap==TRUE)
    {
        doubleTap= FALSE;
        for(int i=0;i<noofcols;i++)
            for(int j=0;j<noofrows;j++)
            {
                if(Matrix[i][j]==9 && Matrix[i][j]!=-2)//technically it is 0
                {
                    UIImage *img = [UIImage imageNamed:@"block"];
                    CGPoint xy = { 1.75+i*self.dw, downValue + j*self.dh };
                    CGRect imageRect = CGRectMake(xy.x, xy.y, self.dw, self.dh);
                    [img drawInRect:imageRect];
                }
                if(Matrix[i][j]>0 && Matrix[i][j]!= 9)
                {
                    if(Matrix[i][j]==11)//11 is flag
                    {
                        UIImage *img = [UIImage imageNamed:@"Flag"];
                        CGPoint xy = { 1.75+i*self.dw, downValue + j*self.dh };
                        CGRect imageRect = CGRectMake(xy.x, xy.y, self.dw, self.dh);
                        [img drawInRect:imageRect];
                    }
                    else
                    {
                        int number= Matrix[i][j];
                        UIFont *font = [UIFont systemFontOfSize: .70*self.dh];
                        NSString *t= [NSString stringWithFormat:@" %i",number];
                        CGPoint xy = { 1.75+i*self.dw, downValue + j*self.dh };
                        [t drawAtPoint: xy withFont: font];
                    }
                }
            }
    }
}

//New game button is connected to it.
- (IBAction)newGame:(id)sender
{
    [self initializeAgain];
    [self setNeedsDisplay];
}

//single handler
- (void) tapSingleHandler: (UITapGestureRecognizer *) sender
{
    if(lostGame!= TRUE)
    {
        won=0;
        doubleTap= TRUE;
        bool loop = false;
        NSLog( @"tapSingleHandler" );
        if ( sender.state == UIGestureRecognizerStateEnded )
        {
            NSLog( @"(single tap recognized)" );
            CGPoint xy;
            xy = [sender locationInView: self];
            NSLog( @"(x,y) = (%f,%f)", xy.x, xy.y );
            if(xy.y < downValue || xy.y > downValue + noofrows * self.dh)
                return;
            //self.row = xy.x / self.dw;
            //self.col = (xy.y - downValue) / self.dh;
            self.row = xy.x / self.dw;
            self.col= (xy.y - downValue) / self.dh;
            
            NSLog( @"(row,col) = (%d,%d)", self.row, self.col );
            //if the flag is already set then it sets to the value in matrix1 which isnt changed at all
            if(Matrix[self.row][self.col]==11 && loop== false)
            {
                dmine=0;
                Matrix[self.row][self.col]=Matrix1[self.row][self.col];
                loop= true;
                for(int i= 0;i <noofcols;++i)
                {
                    for(int j=0; j<noofrows;++j)
                    {
                        if(Matrix[i][j]==-2)
                        {
                            dmine++;
                        }
                    }
                }
            }
            //not 11 put 11
            if(Matrix[self.row][self.col]!= 11 && loop== false && Matrix[self.row][self.col]<0)
            {
                dmine=0;
                Matrix[self.row][self.col]= 11;//Flag is 11.
                for(int i= 0;i <noofcols;++i)
                {
                    for(int j=0; j<noofrows;++j)
                    {
                        if(Matrix[i][j]==-2)
                        {
                            dmine++;
                        }
                    }
                }
            }
            
            /*if(dmine>=0)
             {
             if(Matrix1[self.row][self.col]==-2)
             {
             dmine--;
             }
             }*/
            
            //we change the values in dupmatrix
            for(int i=0;i<noofcols;i++)
            {
                for(int j=0;j<noofrows;j++)
                {
                    if(Matrix[i][j]==11)
                    {
                        dupMatrix[i][j]=0;
                        
                    }
                }
            }
            for(int dupi=0;dupi<noofcols;dupi++)
            {
                for(int dupj=0;dupj<noofrows;dupj++)
                {
                    if(dupMatrix[dupi][dupj]==-2)
                    {
                        won++;
                    }
                }
            }
            
            if(won==0)//here the game is won
            {
                int newHighScore= timercount;
                int highscore=(int)[[NSUserDefaults standardUserDefaults] integerForKey:@"hScore"];
                if(highscore== 0)
                {
                    highscore=10000;
                }
                if(newHighScore<highscore)//new time is less than the already time
                {
                    lostGame= TRUE;
                    UIAlertView *message1= [[UIAlertView alloc]initWithTitle:@"YOU WON with High Score!!" message:@"Start Again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [message1 show];
                    //[self initializeAgain];
                    highscore= newHighScore;
                    
                    //[self setNeedsDisplay];
                    [[NSUserDefaults standardUserDefaults] setInteger:highscore forKey:@"hScore"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                    
                    NSLog(@"%i",highscore);
                    [self setNeedsDisplay];
                    //timertype= false;
                    //self.seconds.text= [NSString stringWithFormat:@"%i",timercount];
                    
                }
                if(newHighScore>highscore)
                {
                    lostGame= TRUE;
                    //[[NSUserDefaults standardUserDefaults] setInteger:highscore forKey:@"hScore"];
                    UIAlertView *message1= [[UIAlertView alloc]initWithTitle:@"YOU WON!!" message:@"Start Again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [message1 show];
                    //[self initializeAgain];
                    [self setNeedsDisplay];
                    //[[NSUserDefaults standardUserDefaults] setInteger:100 forKey:@"hScore"];
                }
            }
            else
            {
                [self setNeedsDisplay];
            }
        }
    }
}

//initialized when we click on new game
-(void) initializeAgain
{
    dmine=0;
    timercount=0;
    doubleTap= FALSE;
    lostGame= false;
    //singleTap= FALSE;
    int count1=0;
    noofrows=(int)[[NSUserDefaults standardUserDefaults] integerForKey:@"rStepper"];
    noofcols= (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"cStepper"];
    int noofmines= (noofrows*noofcols)/5;
    for(int i=0;i <noofcols;i++)
    {
        for(int j=0;j<noofrows;j++)
        {
            Matrix[i][j]=-10;
        }
    }
    while(count1<noofmines)
    {
        int randx= arc4random_uniform(noofcols);
        int randy= arc4random_uniform(noofrows);
        Matrix[randx][randy]= -2;
        count1++;
    }
    for(int i=0;i<noofcols;++i)
    {
        for(int j=0;j<noofrows;++j)
        {
            if(Matrix[i][j]==-2)
            {
                dmine++;
            }
        }
    }
    for(int i=0;i<noofcols;i++)
    {
        for(int j=0;j<noofrows;j++)
        {
            dupMatrix[i][j]= Matrix[i][j];
        }
    }
    for(int i=0;i<noofcols;i++)
    {
        for(int j=0;j<noofrows;j++)
        {
            Matrix1[i][j]= Matrix[i][j];
        }
    }
}
//double tap
- (void) tapDoubleHandler: (UITapGestureRecognizer *) sender
{
    if(lostGame!= TRUE)
    {
        doubleTap= TRUE;
        NSLog( @"tapDoubleHandler" );
        CGPoint xy;
        xy = [sender locationInView: self];
        NSLog( @"(x,y) = (%f,%f)", xy.x, xy.y );
        //NSLog( @"(dw,dh) = (%f,%f)", self.dw, self.dh );//--------------------here
        self.row = xy.x / self.dw;
        self.col = (xy.y - downValue) / self.dh;
        NSLog( @"(row,col) = (%d,%d)", self.row, self.col );//--------------------here
        if(Matrix[self.row][self.col]== -2)//if we click on mine
        {
            
            UIAlertView *message= [[UIAlertView alloc]initWithTitle:@"YOU LOST!!" message:@"Lost the game, start again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [message show];
            lostGame= TRUE;
            //[self initializeAgain];
            [self setNeedsDisplay];
        }
        else
            [self checkSurroundings: self.row andArg:self.col];
        [self setNeedsDisplay];
    }
}

//recursive function that checks for surroundings
-(void) checkSurroundings: (int) r andArg:(int)c
{
    int surroundingCount=0;
    for(int i=r-1;i<= r+1;i++)
    {
        for(int j=c-1; j<= c+1;j++)
        {
            if((i==r && j==c))
            {
                continue;
            }
            if((i<0)||(i>noofcols-1))
            {
                continue;
            }
            if((j<0)||(j>noofrows-1))
            {
                continue;
            }
            else
            {
                if(Matrix[i][j]==-2)
                {
                    surroundingCount++;
                }
            }
        }
    }
    //Matrix[self.row][self.col]= surroundingCount;
    if(surroundingCount == 0)
    {
        Matrix[r][c] = 9;
        if(r-1>=0 && Matrix[r-1][c] !=9 && Matrix[r-1][c] !=11)
        {
            [self checkSurroundings:r-1 andArg:c];
            if(c+1 <=noofrows-1 && Matrix[r-1][c+1] !=9 && Matrix[r-1][c+1] !=11)
            {
                [self checkSurroundings:r-1 andArg: c+1];
            }
        }
        if(c-1>=0 && Matrix[r][c-1] !=9 )
        {
            [self checkSurroundings:r andArg: c-1];
            if(r+1 <=noofcols-1 && Matrix[r+1][c-1] !=9 && Matrix[r+1][c-1] !=11 )
            { [self checkSurroundings:r+1 andArg:c-1];
            }
        }
        if(r-1>=0 && c-1 >=0 && Matrix[r-1][c-1] !=9 && Matrix[r-1][c-1] !=11)
        {
            [self checkSurroundings:r-1 andArg:c-1];
        }
        if(c+1 <=noofrows-1 && Matrix[r][c+1] !=9 && Matrix[r][c+1] !=11 )
        {
            [self checkSurroundings:r andArg:c+1];
        }
        if(r+1 <=noofcols-1 && c+1 <=noofrows-1 && Matrix[r+1][c+1] !=9 && Matrix[r+1][c+1] !=11)
        {
            [self checkSurroundings:r+1 andArg:c+1];
        }
        if(r+1 <=noofcols-1 && Matrix[r+1][c] !=9 && Matrix[r+1][c] !=11)
        {
            [self checkSurroundings:r+1 andArg:c];
        }
    }
    else
    {
        
        Matrix[r][c]= surroundingCount;
        //mineGrid[r][c] = mineCount;
    }
    
}
@end
