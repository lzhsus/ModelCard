//
//  LiveTypeCell.m
//  ModelCard
//
//  Created by iMac on 2018/3/1.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "LiveTypeCell.h"

@interface LiveTypeCell ()
@property (nonatomic,strong) UILabel * title;
@end

@implementation LiveTypeCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *title = [[UILabel alloc]init];
        title.textColor = self.isSelected ? [UIColor whiteColor]:[UIColor lightGrayColor];
        title.text = @"映客";
        [self.contentView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(5);
            make.left.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(-5);
            make.right.equalTo(self.contentView).offset(-10);
            make.height.offset(20);
        }];
        self.title = title;
    }
    return self;
}
-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    self.title.text = titleString;
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
}
@end
