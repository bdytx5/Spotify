//
//  homeCell.m
//  Spotify
//
//  Created by Brett Young on 12/24/17.
//  Copyright © 2017 Brett Young. All rights reserved.
//

#import "homeCell.h"
#import "homeCollectionCell.h"

@implementation homeCell

// table view cell, this is where collection view logic is implemented


- (void)awakeFromNib {
    [super awakeFromNib];
 
}
    - (void)reloadInputViews
    {
        [self.collectionView reloadData];
        [self.collectionView layoutIfNeeded];
        
    }
    
    

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collection.count;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CGRectGetWidth(collectionView.frame)/2.3, CGRectGetHeight(collectionView.frame)/1.2);
}




- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    homeCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
   

    
    NSString *imgName = [NSString stringWithFormat:@"img%@", _collection[indexPath.row]];

    
    cell.img.image = [UIImage imageNamed:imgName];


    [cell reloadInputViews];
   
    [cell layoutIfNeeded];
 
    return cell;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
