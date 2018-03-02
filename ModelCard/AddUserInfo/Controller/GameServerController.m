//
//  GameServerController.m
//  ModelCard
//
//  Created by iMac on 2018/3/1.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "GameServerController.h"
#import "SegmentView.h"
#import "ServerController.h"

@interface GameServerController ()<UIScrollViewDelegate>
@property (nonatomic,strong) NSArray * serverList;
@property (nonatomic,strong) NSString * select;
@end

@implementation GameServerController

-(NSArray *)serverList{
    if (!_serverList) {
        NSString *jsonPath = [[NSBundle mainBundle]pathForResource:@"gameServer" ofType:@"plist"];
        _serverList = [[NSArray alloc]initWithContentsOfFile:jsonPath];
    }
    return _serverList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"游戏区服";
    self.view.backgroundColor = BackgroundColor;
    // Do any additional setup after loading the view.
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setTitleColor:[UIColor colorHex:@"#E7586E"] forState:UIControlStateNormal];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button setTitle:@"保存" forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:button];
    [self.navigationItem setRightBarButtonItem:right];
    
    NSMutableArray *titles = [NSMutableArray new];
    NSMutableArray *viewControllers = [NSMutableArray new];
    @weakify(self);
    for (NSDictionary *dict in self.serverList) {
        ServerController *server = [[ServerController alloc]init];
        server.subName = [RACSubject subject];
        [server.subName subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            self.select = x;
        }];
        server.ServerList = [[NSArray alloc]initWithArray:dict[dict.allKeys.firstObject]];
        [self addChildViewController:server];
        [titles addObject:dict.allKeys.firstObject];
        [viewControllers addObject:server];
    }
    
    SegmentView * main = [[SegmentView alloc] init];
    main.backgroundColor = [UIColor colorWithRed:0.11 green:0.11 blue:0.11 alpha:1.00];
    main.pageScroll.contentSize = CGSizeMake(Width*self.serverList.count, 0);
    [self.view addSubview:main];
    main.frame = CGRectMake(0, 0,Width, Height-NavigationTop);
    //设置菜单view 的高度
    main.btnViewHeight = 40;
    //设置按钮下划线高度
    main.btnLineHeight = 2;
    //设置按钮字体大小
    main.btnFont = 17;
    main.viewControllers = viewControllers;
    main.titleArray = titles;
}
-(void)rightBtn:(UIButton *)sender{
    if (isStringEmpty(self.select)) return;
    [self.subName sendNext:self.select];
    [self.navigationController popViewControllerAnimated:YES];
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
