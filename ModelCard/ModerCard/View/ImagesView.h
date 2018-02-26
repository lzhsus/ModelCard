//
//  ImagesView.h
//  ModelCard
//
//  Created by iMac on 2018/2/25.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImagesViewDelegae <NSObject>
-(void)didFinishImages:(NSArray *)images;
@end

@interface ImagesView : UIView
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) UIViewController * popViewController;
-(void)didAddImage:(UIImage *)image;
@property (nonatomic,weak) id<ImagesViewDelegae> delegate;
@end
