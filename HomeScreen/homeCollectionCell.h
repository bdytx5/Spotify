//
//  homeCollectionCell.h
//  Spotify
//
//  Created by Brett Young on 12/24/17.
//  Copyright © 2017 Brett Young. All rights reserved.
//

#import <UIKit/UIKit.h>

// import tableview cell.h

#import "homeCell.h"



@interface homeCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UILabel *txt;

@property (nonatomic) NSString *storageTxt;



@end
