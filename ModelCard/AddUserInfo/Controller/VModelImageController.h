//
//  VModelImageController.h
//  ModelCard
//
//  Created by iMac on 2018/2/26.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VModelImageController : UIViewController
@property (nonatomic,strong) NSDictionary * modelDictionary;

@property (nonatomic,assign) ModelType modelType;
@property (nonatomic,strong) NSArray * images;
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * content;
@end
