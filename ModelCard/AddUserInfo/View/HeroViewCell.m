//
//  HeroViewCell.m
//  ModelCard
//
//  Created by iMac on 2018/3/1.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "HeroViewCell.h"

@interface HeroViewCell ()
@property (nonatomic,strong) UIImageView * imageView;
@property (nonatomic,strong) UILabel * name;
@end
@implementation HeroViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-30)];
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
        
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height-20, frame.size.width, 20)];
        name.textColor = [UIColor whiteColor];
        name.textAlignment = NSTextAlignmentCenter;
        name.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:name];
        self.name = name;
    }
    return self;
}
-(void)setHeroName:(NSString *)heroName{
    _heroName = heroName;
    self.name.text = heroName;
}
-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    self.imageView.image = [UIImage imageNamed:imageName];
}
-(void)setSelecteds:(BOOL)selecteds{
    _selecteds = selecteds;
    [self.imageView makeBorderWidth:selecteds ? 2:0 withColor:[UIColor colorWithRed:0.91 green:0.35 blue:0.43 alpha:1.00]];
}
@end
