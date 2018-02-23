//
//  Work.m
//  ModelCard
//
//  Created by chenkanghua on 2018/2/22.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "Work.h"
#import "UIImage+Category.h"

@interface Work ()

@end

@implementation Work
-(instancetype)init{
    if (self = [super init]) {
        //这里会把 navigationItem.title 和 tabBarItem.title 同时设置
        self.title = @"工作";
        self.view.backgroundColor = [UIColor orangeColor];
        self.tabBarItem.image = [UIImage imageOriginalImageName:@"work_tab"];
        self.tabBarItem.selectedImage = [UIImage imageOriginalImageName:@"work_tab_select"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
