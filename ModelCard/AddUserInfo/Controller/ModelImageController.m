//
//  ModelImageController.m
//  ModelCard
//
//  Created by iMac on 2018/2/23.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "ModelImageController.h"

@interface ModelImageController ()

@end

@implementation ModelImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackgroundColor;
    self.title = @"编辑";
    
    UIButton *done = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [done setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [done setTitle:@"完成" forState:UIControlStateNormal];
    [done setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [done setTitle:@"完成" forState:UIControlStateHighlighted];
    [done addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightDone = [[UIBarButtonItem alloc]initWithCustomView:done];
    
    UIButton *edit = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [edit setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [edit setTitle:@"编辑" forState:UIControlStateNormal];
    [edit setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [edit setTitle:@"编辑" forState:UIControlStateHighlighted];
    [edit addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightEdit = [[UIBarButtonItem alloc]initWithCustomView:edit];
    
    [self.navigationItem setRightBarButtonItems:@[rightDone,rightEdit]];
    // Do any additional setup after loading the view.
}
-(void)done:(UIButton *)sender{
    
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
