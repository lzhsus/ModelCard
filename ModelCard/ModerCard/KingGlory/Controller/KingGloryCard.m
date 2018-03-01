//
//  KingGloryCard.m
//  ModelCard
//
//  Created by chenkanghua on 2018/2/28.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "KingGloryCard.h"
#import "KGHorizontalVersion.h"
#import "KGVerticalVersion.h"
#import "SegmentView.h"
@interface KingGloryCard ()<UIScrollViewDelegate>
@property (nonatomic,retain) NSArray *viewControllers;
@property (nonatomic,strong) NSArray * modelArray;
@end

@implementation KingGloryCard
-(NSArray *)modelArray{
    if (!_modelArray) {
        NSString *plistPath = [[NSBundle mainBundle]pathForResource:self.modelName ofType:@"plist"];
        _modelArray = [[NSArray alloc]initWithContentsOfFile:plistPath];
    }
    return _modelArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"王者荣耀卡";
    // Do any additional setup after loading the view.
    [self createVc];
}
- (void)createVc {
    KGHorizontalVersion * HorizontalVersionVc  = [[KGHorizontalVersion alloc] init];
    HorizontalVersionVc.modelArray = self.modelArray;
    KGVerticalVersion * VerticalVersionVc = [[KGVerticalVersion alloc] init];
    VerticalVersionVc.modelName = @"HModel";//竖屏2
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
