//
//  ModelCard.m
//  ModelCard
//
//  Created by chenkanghua on 2018/2/22.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "ModelCard.h"

#import "HorizontalVersion.h"
#import "VerticalVersion.h"
#import "SegmentView.h"

@interface ModelCard ()<UIScrollViewDelegate>
@property (nonatomic,retain) NSArray *viewControllers;

@end

@implementation ModelCard

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = _titleName;
    self.view.backgroundColor = BackgroundColor;
    [self createVc];
}
-(void)barButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createVc {
    HorizontalVersion * HorizontalVersionVc  = [[HorizontalVersion alloc] init];
    VerticalVersion * VerticalVersionVc = [[VerticalVersion alloc] init];
    VerticalVersionVc.modelName = @"GModel";//竖屏1
    [self addChildViewController:HorizontalVersionVc];
    [self addChildViewController:VerticalVersionVc];
    self.viewControllers = [NSArray arrayWithObjects:HorizontalVersionVc,VerticalVersionVc,nil];
    SegmentView * main = [[SegmentView alloc] init];
    [self.view addSubview:main];
    main.frame = CGRectMake(0, 0,Width, Height-NavigationTop);
    //设置菜单view 的高度
    main.btnViewHeight = 40;
    //设置按钮下划线高度
    main.btnLineHeight = 2;
    //设置按钮字体大小
    main.btnFont       = 17;
    main.viewControllers = self.viewControllers;
    NSArray * array  = @[@"横版",@"竖版"];
    main.titleArray = array;
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

