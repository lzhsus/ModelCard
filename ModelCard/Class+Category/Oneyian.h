//
//  AddObject.h
//  YAFrameWork
//
//  Created by iMac on 2017/12/14.
//  Copyright © 2017年 John. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Oneyian : NSObject

typedef enum : NSInteger {
    ModelTypeMoTe,
    ModelTypeWangZhe,
    ModelTypeYanYuan,
    ModelTypeZhuBo
} ModelType;

/** 获取32位随机数 */
+(NSString *)get32bit;
/** 获取ip */
+(NSString *)getIP;
/** 快速初始化View */
+(UIView *)initViewWithColor:(UIColor *)color;
/** 获取手机型号 */
+(NSString *)getPhoneModel;
/** 压缩图片 */
+(NSData *)compressionImageData:(UIImage *)image;
/** 关闭TableView估算头尾行高 */
+(void)closeTableViewSection:(UITableView *)tableview;
/** 注册通知 */
+(void)initNotification:(id)Observer selector:(SEL)Selector name:(NSString *)Name object:(id)Object;
/** 发送通知 */
+(void)postNotification:(NSString *)Name object:(id)Object;
/** 移除通知 */
+(void)removeAllNotification:(id)observer;
/** 简介文字排版 */
+(NSMutableAttributedString *)sortingContent:(NSString *)content;

@end
