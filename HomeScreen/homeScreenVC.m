//
//  homeScreenVC.m
//  Spotify
//
//  Created by Brett Young on 12/24/17.
//  Copyright © 2017 Brett Young. All rights reserved.
//

#import "homeScreenVC.h"
#import "UIKit/UIKit.h"
#import "homeCollectionCell.h"
#import "homeCell.h"
#import "row1cell.h"

@interface homeScreenVC()<UITableViewDataSource, UITableViewDelegate>



@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSMutableArray *collectionImages;

@property (nonatomic) NSMutableArray *model;





@end






@implementation homeScreenVC



- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.collectionImages = [[NSMutableArray alloc]initWithObjects:@"",@"Charts",@"Genres",@"Christmas", nil];
    

    

    
    self.model = [[NSMutableArray alloc] initWithArray:@[ @[],
                                                          @[@"0",@"1",@"2",],
                                                          @[@"3",@"4",@"5"],
                                                          @[@"6",@"7",@"8"]]
                                                            ];
    
    
 
}






-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.model.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     UIColor *green = [UIColor colorWithRed:30/255.0 green:215/255.0 blue:96/255.0 alpha:1];
    
    
    
    if(indexPath.row == 0){
        row1cell *cell = [tableView dequeueReusableCellWithIdentifier:@"row1cell"forIndexPath:indexPath];
        
        cell.row1img.image = [UIImage imageNamed:@"spotifyLogo 2"];
        
        cell.selectionStyle = nil;
        cell.descriptionTextView.textColor = green;
     
        
        
        return cell;
    }
    
    

    homeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell"forIndexPath:indexPath];
    

    cell.selectionStyle = nil;
    cell.title.text = _collectionImages[indexPath.row];
    cell.title.textColor = UIColor.whiteColor;
   cell.collection = [self.model objectAtIndex:indexPath.row];
    cell.collectionView.delegate = cell;
   cell.collectionView.dataSource = cell;

    
    


    
    [cell layoutIfNeeded];
   
    
 
    return cell;

}


- (IBAction)showMusicPlayer:(id)sender {
    
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"musicPlayer"];
    

          
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:vc animated:YES completion:nil];
    
}






@end
