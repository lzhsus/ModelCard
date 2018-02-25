//
//  AddUserInfoController.m
//  ModelCard
//
//  Created by iMac on 2018/2/23.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "AddUserInfoController.h"
#import "ModelImageController.h"

@interface AddUserInfoController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * tableView;
@end

@implementation AddUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加个人资料";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button setTitle:@"下一步" forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:button];
    [self.navigationItem setRightBarButtonItem:right];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NavigationTop, Width, Height-NavigationTop) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor colorHex:@"#3A3538"];
    tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 40;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    // Do any additional setup after loading the view.
}
-(void)rightBtn:(UIButton *)sender{
    ModelImageController *model = [[ModelImageController alloc]init];
    model.modelDictionary = [[NSDictionary alloc]initWithDictionary:self.model];
    model.images = [[NSArray alloc]initWithArray:self.images];
    model.name = @"安";
    model.content = @"info";
    model.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:model animated:YES completion:nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < 8) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = 0;
        cell.backgroundColor = ThemeColor;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"测试";
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.detailTextLabel.text = @"啊";
        cell.detailTextLabel.textColor = [UIColor whiteColor];
        return cell;
    }else{
        UITableViewCell *cell = [UITableViewCell new];
        cell.selectionStyle = 0;
        cell.backgroundColor = ThemeColor;
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
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
