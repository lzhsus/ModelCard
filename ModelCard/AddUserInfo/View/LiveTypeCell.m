//
//  LiveTypeCell.m
//  ModelCard
//
//  Created by iMac on 2018/3/1.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "LiveTypeCell.h"

@interface LiveTypeCell ()
@property (nonatomic,strong) UIView * selectView;
@property (nonatomic,strong) UILabel * title;
@end

@implementation LiveTypeCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //背景色
        UIView *selectView = [[UIView alloc]init];
        selectView.backgroundColor = [UIColor colorWithRed:0.22 green:0.21 blue:0.22 alpha:1.00];
        [selectView makeCornerRadius:4];
        [selectView makeBorderWidth:1 withColor:[UIColor lightGrayColor]];
        [self.contentView addSubview:selectView];
        [selectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        self.selectView = selectView;
        
        //title
        UILabel *title = [[UILabel alloc]init];
        title.textColor = [UIColor lightGrayColor];
        title.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(4);
            make.left.equalTo(self.contentView).offset(8);
            make.bottom.equalTo(self.contentView).offset(-4);
            make.right.equalTo(self.contentView).offset(-8);
            make.height.offset(18);
        }];
        self.title = title;
    }
    return self;
}
-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    self.title.text = titleString;
}
-(void)setSelecteds:(BOOL)selecteds{
    _selecteds = selecteds;
    self.title.textColor = selecteds ? [UIColor whiteColor]:[UIColor lightGrayColor];
    [self.selectView makeBorderWidth:selecteds ? 0:1 withColor:[UIColor lightGrayColor]];
    self.selectView.backgroundColor = selecteds ? [UIColor colorWithRed:0.91 green:0.35 blue:0.43 alpha:1.00]:[UIColor colorWithRed:0.22 green:0.21 blue:0.22 alpha:1.00];
}

@end
