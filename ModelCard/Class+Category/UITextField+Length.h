//
//  UITextField+Length.h
//  BeautyKnocked
//
//  Created by Mac on 2017/8/7.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Length)
-(BOOL)setRange:(NSRange)range whitString:(NSString *)string whitCount:(NSInteger)count;
-(void)setFieldtext:(NSInteger)count;
@end
