//
//  SelectTemplate.m
//  ModelCard
//
//  Created by chenkanghua on 2018/2/23.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "SelectTemplate.h"
#import "AppDelegate.h"
#import "AddUserInfoController.h"
#import "ImagesView.h"

@interface SelectTemplate ()<UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ImagesViewDelegae>
@property (nonatomic,strong) ImagesView * selectImages;
@property (nonatomic,strong) NSArray * modelArray;
@end

@implementation SelectTemplate{
    UIImageView *imageView;
    NSDictionary *_ModelDict;
}

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
    self.view.backgroundColor = BackgroundColor;
    self.title = @"选择模板";
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Width, Height-NavigationTop) style:UITableViewStylePlain];
    //记住tableView 一定要设置数据源对象
    tableView.dataSource = self;
    //设置tableView 的delegate
    tableView.delegate = self;
    tableView.tableHeaderView.backgroundColor = [UIColor colorHex:@"#3A3538"];
    [self.view addSubview:tableView];
    
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.window addSubview:self.selectImages];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.modelArray.count;
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
        imageView.frame =CGRectMake(0, 0, self.view.frame.size.width, 130);
        [cell.contentView addSubview:imageView];
    }
    imageView.image = [UIImage imageNamed:@"01-H-05-12-1"];
//    if (indexPath.section == 0) {
//        imageView.image = [UIImage imageNamed:@"01-H-05-12-1"];
//    }else if (indexPath.section == 1){
//        imageView.image = [UIImage imageNamed:@"01-H-04-10-2" ];
//    }else if (indexPath.section == 2){
//        imageView.image = [UIImage imageNamed:@"01-H-03-10-1" ];
//    }else if (indexPath.section == 3){
//        imageView.image = [UIImage imageNamed:@"01-H-02-08-1" ];
//    }else if (indexPath.section == 4){
//        imageView.image = [UIImage imageNamed:@"01-H-02-08-1" ];
//    }else if (indexPath.section == 5){
//        imageView.image = [UIImage imageNamed:@"01-H-02-08-1" ];
//    }else if (indexPath.section == 6){
//        imageView.image = [UIImage imageNamed:@"01-H-02-08-1" ];
//    }else if (indexPath.section == 7){
//        imageView.image = [UIImage imageNamed:@"01-H-02-08-1" ];
//    }else {
//        imageView.image = [UIImage imageNamed:@"01-H-01-10-2" ];
//    }
    return cell;
}
//设置分区头的 文本内容
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.modelArray[section];
//    if (section == 0) {
//        return @"12图① - 9竖图3横图";
//    }else if (section == 1){
//        return @"13图② - 13竖图";
//    }else if (section == 2){
//        return @"11图① - 5竖图6方图";
//    }else if (section == 3){
//        return @"10图① - 7竖图3横图";
//    }else if (section == 4){
//        return @"10图② - 10竖图";
//    }else if (section == 5){
//        return @"10图③ - 10竖图";
//    }else if (section == 6){
//        return @"9图① - 9竖图";
//    }else if (section == 7){
//        return @"9图② - 9竖图";
//    }else{
//        return @"7图① - 7竖图";
//    }
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
    NSString *modelPath = [[NSBundle mainBundle]pathForResource:self.modelArray[indexPath.section] ofType:@"plist"];
    
    _ModelDict = [[NSDictionary alloc]initWithContentsOfFile:modelPath];
    self.selectImages.count = [NSArray arrayWithArray:_ModelDict[@"SubViewArray"]].count;
        
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    self.selectImages.popViewController = ipc;
    ipc.delegate = self;
    
    [self presentViewController:ipc animated:YES completion:^{
        self.selectImages.hidden = NO;
    }];
}
-(ImagesView *)selectImages{
    if (!_selectImages) {
        _selectImages = [[ImagesView alloc]initWithFrame:CGRectMake(0, Height-150, Width, 150)];
        _selectImages.count = 0;
        _selectImages.delegate = self;
    }
    return _selectImages;
}
-(void)didFinishImages:(NSArray *)images{
    AddUserInfoController *add = [[AddUserInfoController alloc]init];
    add.model = [[NSDictionary alloc]initWithDictionary:_ModelDict];
    add.images = [[NSArray alloc]initWithArray:images];
    [self.navigationController pushViewController:add animated:YES];
    [self.selectImages.popViewController dismissViewControllerAnimated:YES completion:nil];
    self.selectImages.count = 0;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    self.selectImages.count = 0;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self.selectImages didAddImage:info[UIImagePickerControllerOriginalImage]];
}
@end
