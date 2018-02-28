//
//  TextFieldCell.m
//  ModelCard
//
//  Created by iMac on 2018/2/28.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "TextFieldCell.h"
#import "UITextField+Length.h"

@interface TextFieldCell ()<UITextFieldDelegate>
@property (nonatomic,strong) UILabel * title;
@property (nonatomic,strong) UITextField * contentField;
@end

@implementation TextFieldCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = 0;
        self.backgroundColor = ThemeColor;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 80, 20)];
        title.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:title];
        self.title = title;
        
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(Width-185, 10, 150, 30)];
        textField.textAlignment = NSTextAlignmentRight;
        textField.textColor = [UIColor whiteColor];
        textField.borderStyle = UITextBorderStyleNone;
        textField.delegate = self;
        [self.contentView addSubview:textField];
        self.contentField = textField;
    }
    return self;
}
-(void)setPlaceholder:(NSString *)placeholder{
    NSMutableAttributedString *Mplaceholder = [[NSMutableAttributedString alloc]initWithString:placeholder];
    [Mplaceholder addAttribute:NSForegroundColorAttributeName
                        value:[UIColor lightGrayColor]
                        range:NSMakeRange(0, placeholder.length)];
    [Mplaceholder addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:15]
                        range:NSMakeRange(0, placeholder.length)];
    self.contentField.attributedPlaceholder = Mplaceholder;
}
-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    self.title.text = titleString;
}
-(void)setContentString:(NSString *)contentString{
    _contentString = contentString;
    self.contentField.text = contentString;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [textField setFieldtext:self.FieldLength];
    [self.subFieldText sendNext:textField.text];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    return [textField setRange:range whitString:string whitCount:self.FieldLength];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
