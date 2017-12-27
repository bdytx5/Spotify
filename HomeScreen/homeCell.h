//
//  homeCell.h
//  Spotify
//
//  Created by Brett Young on 12/24/17.
//  Copyright © 2017 Brett Young. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "homeCell.h"
#import "homeCollectionCell.h"

@interface homeCell : UITableViewCell <UICollectionViewDelegate, UICollectionViewDataSource>


@property (weak, nonatomic) IBOutlet UILabel *title;

@property (nonatomic) NSMutableArray *collection;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;




@end
