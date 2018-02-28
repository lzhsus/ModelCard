//
//  TextFieldCell.h
//  ModelCard
//
//  Created by iMac on 2018/2/28.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldCell : UITableViewCell
@property (nonatomic,assign) NSInteger FieldLength;

@property (nonatomic,strong) NSString * placeholder;

@property (nonatomic,strong) NSString * titleString;
@property (nonatomic,strong) NSString * contentString;

@property (nonatomic,strong) RACSubject * subFieldText;
@end
