//
//  ModelInfoCell.m
//  ModelCard
//
//  Created by iMac on 2018/2/27.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "ModelInfoCell.h"
#import "UIButton+Category.h"

@implementation ModelInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = 0;
        self.backgroundColor = ThemeColor;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 40, 20, 20)];
        imageView.image = [UIImage imageNamed:@"personal_d"];
        [self.contentView addSubview:imageView];
        
        UILabel *infoLabel = [[UILabel alloc]initWithFrame:CGRectMake(45, 40, 160, 20)];
        infoLabel.textColor = [UIColor colorHex:@"#E7586E"];
        infoLabel.text = @"模卡显示资料选项";
        [self.contentView addSubview:infoLabel];
        
        for (int i=0; i<2; i++) {
            UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(15, 80 + i*60, 80, 20)];
            title.textColor = [UIColor lightGrayColor];
            title.tag = i+10;
            title.hidden = YES;
            [self.contentView addSubview:title];
            
            UIButton *showButton = [[UIButton alloc]initWithFrame:CGRectMake(Width-90, title.frame.origin.y-10, 60, 40)];
            showButton.tag = i+1;
            showButton.hidden = YES;
            [showButton setTitle:@"不展示" forState:UIControlStateNormal];
            [showButton setImage:[UIImage imageNamed:@"personal_data_choice"] forState:UIControlStateNormal];
            [showButton setTitle:@"展示" forState:UIControlStateSelected];
            [showButton setImage:[UIImage imageNamed:@"personal_data"] forState:UIControlStateSelected];
            [showButton setImgViewStyle:ButtonStyleLeft imageSize:[UIImage imageNamed:@"personal_data_choice"].size space:10];
            [showButton addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:showButton];
        }
    }
    return self;
}
-(void)setTitles:(NSArray *)titles{
    for (int i=0; i<titles.count; i++) {
        UILabel *title = (UILabel *)[self.contentView viewWithTag:i+10];
        title.hidden = NO;
        title.text = titles[i];
    }
}
-(void)setContents:(NSArray *)contents{
    for (int i=0; i<contents.count; i++) {
        UIButton *showButton = (UIButton *)[self.contentView viewWithTag:i+1];
        showButton.hidden = NO;
        showButton.selected = [contents[i] integerValue] > 0;
    }
}
-(void)selectType:(UIButton *)sender{
    sender.selected = !sender.isSelected;
    [self.delegate didChangeIndex:sender.tag-1 Status:sender.isSelected];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
