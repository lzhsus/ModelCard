//
//  ModelImageController.m
//  ModelCard
//
//  Created by iMac on 2018/2/23.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "ModelImageController.h"
#import "UIDevice+YADevice.h"
#import "AppDelegate.h"
#import "AddUserInfoController.h"

@interface ModelImageController ()

@end

@implementation ModelImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    //允许转成横屏
    appDelegate.allowRotation = YES;
    //调用横屏代码
    [UIDevice switchNewOrientation:UIInterfaceOrientationLandscapeRight];
    
    self.view.backgroundColor = BackgroundColor;
    self.title = @"编辑";
    
    UIButton *done = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [done setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [done setTitle:@"完成" forState:UIControlStateNormal];
    [done setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [done setTitle:@"完成" forState:UIControlStateHighlighted];
    [done addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:done];
    
    UIButton *edit = [[UIButton alloc]initWithFrame:CGRectMake(44, 0, 44, 44)];
    [edit setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [edit setTitle:@"编辑" forState:UIControlStateNormal];
    [edit setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [edit setTitle:@"编辑" forState:UIControlStateHighlighted];
    [edit addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:edit];
    // Do any additional setup after loading the view.
}
-(void)done:(UIButton *)sender{
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = NO;
    [UIDevice switchNewOrientation:UIInterfaceOrientationPortrait];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
