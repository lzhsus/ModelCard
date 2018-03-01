//
//  HeroViewCell.h
//  ModelCard
//
//  Created by iMac on 2018/3/1.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeroViewCell : UICollectionViewCell
@property (nonatomic,strong) NSString * imageName;
@property (nonatomic,strong) NSString * heroName;
@property (nonatomic,assign) BOOL selecteds;
@end
