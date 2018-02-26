//
//  HorizontalVersion.m
//  ModelCard
//
//  Created by chenkanghua on 2018/2/22.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "HorizontalVersion.h"
#import "SelectTemplate.h"
@interface HorizontalVersion ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation HorizontalVersion{
    UIImageView*imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BackgroundColor;
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Width, Height-NavigationTop-40) style:UITableViewStylePlain];
    //记住tableView 一定要设置数据源对象
    tableView.dataSource = self;
    //设置tableView 的delegate
    tableView.delegate = self;
    tableView.tableHeaderView.backgroundColor = [UIColor colorHex:@"#3A3538"];
    [self.view addSubview:tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
//3.每行长什么样子
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    imageView = [cell.contentView viewWithTag:104];
    if (imageView == nil) {
        imageView = [[UIImageView alloc]init];
        imageView.tag = 104;
        imageView.frame =CGRectMake(0, 0, Width, 130);
        [cell.contentView addSubview:imageView];
    }
    if (indexPath.section == 0) {
        imageView.image = [UIImage imageNamed:@"01-H-05-12-1" ];
    }else if (indexPath.section == 1){
        imageView.image = [UIImage imageNamed:@"01-H-04-10-2" ];
    }else if (indexPath.section == 2){
        imageView.image = [UIImage imageNamed:@"01-H-03-10-1" ];
    }else if (indexPath.section == 3){
        imageView.image = [UIImage imageNamed:@"01-H-02-08-1" ];
    }else {
        imageView.image = [UIImage imageNamed:@"01-H-01-10-2" ];
    }
    return cell;
}
//设置分区头的 文本内容
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"浮层式资料栏";
    }else if (section == 1){
        return @"环绕式资料栏";
    }else if (section == 2){
        return @"插入式资料栏";
    }else if (section == 3){
        return @"底部式资料栏";
    }else{
        return @"侧边式资料栏";
    }
    
}
//设置分区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
// 选中每一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SelectTemplate *SelectTemplateVC = [[SelectTemplate alloc]init];
    switch (indexPath.section) {
        case 0:
            SelectTemplateVC.modelName = @"AModel";
            break;
        case 1:
            SelectTemplateVC.modelName = @"BModel";
            break;
        default:
            SelectTemplateVC.modelName = @"CModel";
            break;
    }
    [self.navigationController pushViewController:SelectTemplateVC animated:YES];
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

