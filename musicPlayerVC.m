//
//  musicPlayerVC.m
//  Spotify
//
//  Created by Brett Young on 12/23/17.
//  Copyright © 2017 Brett Young. All rights reserved.
//

#import "musicPlayerVC.h"

@interface musicPlayerVC ()






@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lyricsTopSpace;
@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverArtTopSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverArtBotSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverArtLeftSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coverArtRightSpace;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lyricsViewLeftSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lyricsViewBotSpace;

@property (weak, nonatomic) IBOutlet UIImageView *lyricsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lyricsViewRightSpace;

@property (weak, nonatomic) IBOutlet UIImageView *coverArtView;

@property (nonatomic) UIPanGestureRecognizer *gesture;
@property (strong,nonatomic) UIPanGestureRecognizer *swipe;
@property (strong,nonatomic) UIPanGestureRecognizer *swipeForLyrics;

@property (strong, nonatomic) UITapGestureRecognizer *coverArtTapped;
@property (strong, nonatomic) UITapGestureRecognizer *lyricsTapped;

@property (weak, nonatomic) IBOutlet UIButton *myTouchInterFaceButton;

@property (nonatomic) BOOL coverArtIsInFront;

@property (nonatomic,copy) NSMutableArray *components;

@end



@implementation musicPlayerVC
- (IBAction)switchViews:(id)sender {
    
    _lyricsTopSpace.constant = 44;
    _lyricsViewBotSpace.constant = 374;
    _lyricsViewRightSpace.constant = 33;
    _lyricsViewLeftSpace.constant = 33;
    
    [self.view sendSubviewToBack:self.coverArtView];
    
    _coverArtTopSpace.constant = 12;
    _coverArtBotSpace.constant = 270;
    _coverArtLeftSpace.constant = 46;
    _coverArtRightSpace.constant = 46;
    
    
}

//spotify green is rgb(30,215,96)



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tabBarController.tabBar setHidden:YES];
    
    _instructionLabel.adjustsFontSizeToFitWidth = YES;
 
    
    self.components = [[NSMutableArray alloc]initWithArray:@[@30,@215,@96]];
    
    _myTouchInterFaceButton.layer.cornerRadius = 10;
    _myTouchInterFaceButton.clipsToBounds = YES;
    
    UIColor *green = [UIColor colorWithRed:30/255.0 green:215/255.0 blue:96/255.0 alpha:1];
    

    

    
    _myTouchInterFaceButton.layer.borderColor = green.CGColor;
    _myTouchInterFaceButton.layer.borderWidth = 2;
    
    
    self.coverArtIsInFront = YES;


    self.gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizer:) ];
    
    [self.view setUserInteractionEnabled:YES];
    
    [self.view addGestureRecognizer:self.gesture];

    
   
    
    [self.coverArtView setUserInteractionEnabled:YES];
    
    [self.lyricsView setUserInteractionEnabled:NO];
    
    
    
    
   self.swipe = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
     self.swipeForLyrics = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    
    [self.coverArtView addGestureRecognizer:self.swipe];
 [self.lyricsView addGestureRecognizer:self.swipeForLyrics];

    
    
    
    
    _lyricsTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    _coverArtTapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    

 

    

    
    
}



-(void)pan:(UIPanGestureRecognizer *)gesture{
    [self.view layoutIfNeeded];
    
    CGPoint translation = [gesture translationInView:gesture.view];
    
    CGPoint dir = [gesture velocityInView:self.view];
    
    if(dir.y < 0){
        gesture.enabled = false;
        
        gesture.enabled = YES;
        gesture.view.alpha = 1;
           [self.view setNeedsLayout];
        return;
 
    }
    
   
    
    
    gesture.view.center = CGPointMake(gesture.view.center.x,gesture.view.center.y + translation.y);
    
   
    [gesture setTranslation:CGPointZero inView:gesture.view];
    
    gesture.view.alpha = 1.8 - (gesture.view.center.y)/450;
    
    if (gesture.view.center.y > 450){
        gesture.enabled = NO;
        self.coverArtIsInFront = NO;
        
    [UIView animateWithDuration:.3 animations:^{
        
        [self.view layoutIfNeeded];
        
        
        if (gesture.view == self.coverArtView) {
            
            
            _lyricsTopSpace.constant = 84;
            _lyricsViewBotSpace.constant = 235;
            _lyricsViewRightSpace.constant = 33;
            _lyricsViewLeftSpace.constant = 33;
            
            [self.view sendSubviewToBack:self.coverArtView];
            
            _coverArtTopSpace.constant = 54;
            _coverArtBotSpace.constant = 374;
            _coverArtLeftSpace.constant = 46;
            _coverArtRightSpace.constant = 46;
            
            
           

            [self.view sendSubviewToBack:gesture.view];

            gesture.enabled = YES;
            
   

            
            [self.view layoutIfNeeded];


            
        }
    
        else{
            self.coverArtIsInFront = YES;
            _coverArtTopSpace.constant = 84;
            _coverArtBotSpace.constant = 270;
            _coverArtRightSpace.constant = 33;
            _coverArtLeftSpace.constant = 33;
            
            [self.view sendSubviewToBack:self.lyricsView];
            
             _lyricsTopSpace.constant = 54;
             _lyricsViewBotSpace.constant = 320;
             _lyricsViewLeftSpace.constant = 46;
            _lyricsViewRightSpace.constant = 46;
            
            
            [self.view sendSubviewToBack:gesture.view];
            
            gesture.enabled = YES;
            
            [self.view layoutIfNeeded];
            
        }
        
    
    } completion:^(BOOL finished) {
        
        if (gesture.view == _coverArtView){
            [self.lyricsView setUserInteractionEnabled:YES];
            [self.coverArtView setUserInteractionEnabled:NO];


             gesture.view.alpha = 1;
      
          
            
        }else{
            [self.lyricsView setUserInteractionEnabled:NO];
            [self.coverArtView setUserInteractionEnabled:YES];
             gesture.view.alpha = 1;

            
        }
       
       
        
      
        
        
      
        
    } ];
        
    }
    
    
    
    
    
    
    if(gesture.state == UIGestureRecognizerStateEnded)
    {
        
        //All fingers are lifted.
        gesture.view.alpha = 1.0;
        
        printf("moved");
       
        [self.view setNeedsLayout];
        
        
        
        
        
    }
    
    
    
    
    
}

- (IBAction)dismissPlayer:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
}



- (IBAction)myTouchInterface:(UIButton *)sender {
    
    
    
    [self.coverArtView removeGestureRecognizer:self.swipe];
    
    [self.lyricsView removeGestureRecognizer:self.swipeForLyrics];
    
    
    [self.lyricsView addGestureRecognizer:self.lyricsTapped];
    
    [self.coverArtView addGestureRecognizer:self.coverArtTapped];
   
    if(self.coverArtIsInFront){
        
    }

    
    
    
}




- (IBAction)goToOtherView:(id)sender {
    
   
    

    
    
    
    
    
    
    
    
    
    
    

}















-(void)tap:(UITapGestureRecognizer *)tap{
    
   
    
    
    
    [UIView animateWithDuration:.3 animations:^{
        
        [self.view layoutIfNeeded];
        
        
        if (self.coverArtIsInFront) {
            
            self.coverArtIsInFront = NO;
            
            
            _lyricsTopSpace.constant = 84;
            _lyricsViewBotSpace.constant = 230;
            _lyricsViewRightSpace.constant = 33;
            _lyricsViewLeftSpace.constant = 33;
            
            [self.view sendSubviewToBack:self.coverArtView];
            
            _coverArtTopSpace.constant = 54;
            _coverArtBotSpace.constant = 374;
            _coverArtLeftSpace.constant = 46;
            _coverArtRightSpace.constant = 46;
            
            
            
            
            [self.view sendSubviewToBack:tap.view];
            
            tap.enabled = YES;
            
            
            
            
            [self.view layoutIfNeeded];

            
            self.coverArtIsInFront = NO;
        }
        
        else{
            
            self.coverArtIsInFront = YES;
            
            _coverArtTopSpace.constant = 84;
            _coverArtBotSpace.constant = 270;
            _coverArtRightSpace.constant = 33;
            _coverArtLeftSpace.constant = 33;
            
            [self.view sendSubviewToBack:self.lyricsView];
            
            _lyricsTopSpace.constant = 54;
            _lyricsViewBotSpace.constant = 330;
            _lyricsViewLeftSpace.constant = 46;
            _lyricsViewRightSpace.constant = 46;
            
            
            [self.view sendSubviewToBack:tap.view];
            
            tap.enabled = YES;
            
            [self.view layoutIfNeeded];
            
        }
        
        
    } completion:^(BOOL finished) {
        
        if (tap.view == _coverArtView){
            [self.lyricsView setUserInteractionEnabled:YES];
            [self.coverArtView setUserInteractionEnabled:NO];
            
            
            tap.view.alpha = 1;
            
            
            
        }else{
            [self.lyricsView setUserInteractionEnabled:NO];
            [self.coverArtView setUserInteractionEnabled:YES];
            tap.view.alpha = 1;
            
            
        }
        
        
        
        
        
        
        
        
    } ];
    
    
    
}

















-(void)gestureRecognizer:(UIPanGestureRecognizer *)panGesture{
    CGPoint orginalPosition;
    
    CGPoint translation = [panGesture translationInView:self.view];
    
    
    //if gesture begins
    if(panGesture.state == UIGestureRecognizerStateBegan){
       
        CGPoint velocity = [panGesture velocityInView:self.view];
        if (velocity.y < 0){
            
        panGesture.enabled = NO;
        panGesture.enabled = YES;
        return;
        }
        orginalPosition = CGPointMake(self.view.frame.origin.x, self.view.frame.origin.y);
        
        // called right after gesture begins, this adjusts the view as you drag it.
    }else if(panGesture.state == UIGestureRecognizerStateChanged){
     
        
        
        CGRect frame1 = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + translation.y, self.view.frame.size.width, self.view.frame.size.height);
        
        [self.view setFrame:frame1];
        
        // reset the translation numbers
        [panGesture setTranslation:CGPointZero inView:self.view];
        
        
        
    }else if (panGesture.state == UIGestureRecognizerStateEnded){
        
        CGPoint velocity = [panGesture velocityInView:self.view];
        
        
        
        
        if (velocity.y < 0){
         
            
            [UIView animateWithDuration:0.3 animations:^{
                
                CGRect frame = self.view.frame;
                frame.origin = orginalPosition;
                self.view.frame = frame;
                
         
                
            } completion:^(BOOL finished) {
        
                
            }];
            
     
            return;
        }
        
        if (velocity.y >= 150){
            
            [UIView animateWithDuration:0.4 animations:^{
                
                CGRect frame1 = CGRectMake(self.view.frame.origin.x, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
                
                [self.view setFrame:frame1];
                
            } completion:^(BOOL finished) {
                if (finished){
                    
                    [self dismissViewControllerAnimated:true completion:NULL];
                }
                
                
            }];
        }else {
            
            [UIView animateWithDuration:.2 animations:^{
                
                // if view is pulled past a certain point, disimiss
                
                
                if (self.view.frame.origin.y > 65 && velocity.y>=0){
                    [self dismissViewControllerAnimated:true completion:NULL];
                }
                else{
                    // otherwise, put the view back
                    CGRect frame = self.view.frame;
                    frame.origin = orginalPosition;
                    self.view.frame = frame;
                }
                
                
            }];
            
        }}
    
    
    
    
};




@end
