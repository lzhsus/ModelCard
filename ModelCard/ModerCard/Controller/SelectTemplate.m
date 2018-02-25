//
//  SelectTemplate.m
//  ModelCard
//
//  Created by chenkanghua on 2018/2/23.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "SelectTemplate.h"

//photo
#import "AddUserInfoController.h"

@interface SelectTemplate ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation SelectTemplate
{
    UIImageView*imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BackgroundColor;
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    //记住tableView 一定要设置数据源对象
    tableView.dataSource = self;
    //设置tableView 的delegate
    tableView.delegate = self;
    [self.view addSubview:tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 9;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
//3.每行长什么样子
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    imageView = [cell.contentView viewWithTag:104];
    if (imageView == nil) {
        imageView = [[UIImageView alloc]init];
        imageView.tag = 104;
        imageView.frame =CGRectMake(0, 0, self.view.frame.size.width, 130);
        imageView.backgroundColor = [UIColor redColor];
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
    }else if (indexPath.section == 4){
        imageView.image = [UIImage imageNamed:@"01-H-02-08-1" ];
    }else if (indexPath.section == 5){
        imageView.image = [UIImage imageNamed:@"01-H-02-08-1" ];
    }else if (indexPath.section == 6){
        imageView.image = [UIImage imageNamed:@"01-H-02-08-1" ];
    }else if (indexPath.section == 7){
        imageView.image = [UIImage imageNamed:@"01-H-02-08-1" ];
    }else {
        imageView.image = [UIImage imageNamed:@"01-H-01-10-2" ];
    }
    return cell;
}
//设置分区头的 文本内容
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"12图① - 9竖图3横图";
    }else if (section == 1){
        return @"13图② - 13竖图";
    }else if (section == 2){
        return @"11图① - 5竖图6方图";
    }else if (section == 3){
        return @"10图① - 7竖图3横图";
    }else if (section == 4){
        return @"10图② - 10竖图";
    }else if (section == 5){
        return @"10图③ - 10竖图";
    }else if (section == 6){
        return @"9图① - 9竖图";
    }else if (section == 7){
        return @"9图② - 9竖图";
    }else{
        return @"7图① - 7竖图";
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
    {
        NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"AllModel" ofType:@"plist"];
        NSArray *plist = [[NSArray alloc]initWithContentsOfFile:plistPath];
        NSString *modelPath = [[NSBundle mainBundle]pathForResource:plist[indexPath.section] ofType:@"plist"];
        NSDictionary *model = [[NSDictionary alloc]initWithContentsOfFile:modelPath];
        NSInteger count = [[NSArray alloc]initWithArray:model[@"SubViewArray"]].count;
        /** 返回图片 */{
            NSArray *imageNames = [[NSArray alloc]initWithObjects:@"width",@"height",@"width",@"height",@"width",@"height",@"width",@"height",@"width",@"height",@"width",@"height",@"width",@"height",@"width",@"height", nil];
            NSMutableArray *images = [NSMutableArray new];
            for (int i=0; i<count; i++) {
                UIImage *image = [UIImage imageNamed:imageNames[i]];
                [images addObject:image];
            }
            NSLog(@"图片数量：%ld",images.count);
            AddUserInfoController *add = [[AddUserInfoController alloc]init];
            add.model = [[NSDictionary alloc]initWithDictionary:model];
            add.images = [[NSArray alloc]initWithArray:images];
            [self.navigationController pushViewController:add animated:YES];
        }
    }
}
@end
