//
//  SidebarModel.m
//  ModelCard
//
//  Created by chenkanghua on 2018/2/27.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "SidebarModel.h"
#import "SegmentView.h"

#import "TenToThirteen.h"
#import "SevenToNine.h"
#import "FiveToSix.h"

@interface SidebarModel ()<UIScrollViewDelegate>
@property (nonatomic,retain) NSArray *viewControllers;
@property (nonatomic,strong) NSArray * modelArray;

@end

@implementation SidebarModel
-(NSArray *)modelArray{
    if (!_modelArray) {
        NSString *plistPath = [[NSBundle mainBundle]pathForResource:self.modelName ofType:@"plist"];
        _modelArray = [[NSArray alloc]initWithContentsOfFile:plistPath];
    }
    return _modelArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createVc];
}
- (void)createVc {
    TenToThirteen * TenToThirteenVc  = [[TenToThirteen alloc] init];
    TenToThirteenVc.modelArray = [[NSArray alloc]initWithArray:self.modelArray];
    
    SevenToNine * SevenToNineVc = [[SevenToNine alloc]init];
    
    FiveToSix * FiveToSixVc = [[FiveToSix alloc]init];
    
    [self addChildViewController:TenToThirteenVc];
    [self addChildViewController:SevenToNineVc];
    [self addChildViewController:FiveToSixVc];
    self.viewControllers = [NSArray arrayWithObjects:TenToThirteenVc,SevenToNineVc,FiveToSixVc,nil];
    SegmentView * main = [[SegmentView alloc] init];
    main.pageScroll.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width*3, 0);
    [self.view addSubview:main];
    main.frame = CGRectMake(0, 0,Width, Height-NavigationTop);
    //设置菜单view 的高度
    main.btnViewHeight = 40;
    //设置按钮下划线高度
    main.btnLineHeight = 2;
    //设置按钮字体大小
    main.btnFont       = 17;
    main.viewControllers = self.viewControllers;
    NSArray * array  = @[@"10-13图",@"7-9图",@"5-6图"];
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
