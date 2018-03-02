//
//  KGHorizontalVersion.m
//  ModelCard
//
//  Created by chenkanghua on 2018/2/28.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "KGHorizontalVersion.h"
#import "AppDelegate.h"
#import "AddUserInfoController.h"
#import "ImagesView.h"
@interface KGHorizontalVersion ()<UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ImagesViewDelegae>
@property (nonatomic,strong) ImagesView * selectImages;

@end

@implementation KGHorizontalVersion{
    UIImageView *imageView;
    NSDictionary *_ModelDict;
}
-(NSArray *)modelArray{
    if (!_modelArray) {
        
        _modelArray = [[NSArray alloc]init];
    }
    return _modelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BackgroundColor;
    self.title = @"侧边模版";
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Width, Height-NavigationTop-40) style:UITableViewStylePlain];
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
    return cell;
}
//设置分区头的 文本内容
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.modelArray[section];
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
    
    self.selectImages.hidden = NO;
    @weakify(self);
    [UIView animateWithDuration:0.21 animations:^{
        @strongify(self);
        self.selectImages.frame = CGRectMake(0, Height-150, Width, 150);
    }];
    
    [self presentViewController:ipc animated:YES completion:nil];
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
    add.modelType = ModelTypeWangZhe;//分类
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
