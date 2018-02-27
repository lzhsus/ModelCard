//
//  AddUserInfoController.h
//  ModelCard
//
//  Created by iMac on 2018/2/23.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger {
    ModelTypeMoTe,
    ModelTypeWangZhe,
    ModelTypeYanYuan,
    ModelTypeZhuBo
} ModelType;

@interface AddUserInfoController : UIViewController
@property (nonatomic,strong) NSDictionary * model;
@property (nonatomic,strong) NSArray * images;
@property (nonatomic,assign) ModelType modelType;
@end
