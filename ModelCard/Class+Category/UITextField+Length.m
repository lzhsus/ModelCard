//
//  UITextField+Length.m
//  BeautyKnocked
//
//  Created by Mac on 2017/8/7.
//  Copyright © 2017年 Dadichushi. All rights reserved.
//

#import "UITextField+Length.h"

@implementation UITextField (Length)
-(BOOL)setRange:(NSRange)range whitString:(NSString *)string whitCount:(NSInteger)count{
    if (string.length == 0) return YES;
    NSInteger existedLength = self.text.length;
    NSInteger selectedLength = range.length;
    NSInteger replaceLength = string.length;
    if (existedLength - selectedLength + replaceLength > count) {
        return NO;
    }
    return YES;
}
-(void)setFieldtext:(NSInteger)count{
    if (self.text.length > count) {
        self.text = [self.text substringToIndex:count];
    }
}
@end
