//
//  GameHeroController.m
//  ModelCard
//
//  Created by iMac on 2018/3/1.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "GameHeroController.h"
#import "HeroViewCell.h"

@interface GameHeroController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSArray * heroList;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,assign) NSInteger selectRow;
@property (nonatomic,strong) UICollectionView * collection;
@property (nonatomic,strong) NSMutableArray * selectHeros;
@property (nonatomic,strong) UICollectionView * footCollection;
@end

@implementation GameHeroController

-(NSArray *)heroList{
    if (!_heroList) {
        NSString *jsonPath = [[NSBundle mainBundle]pathForResource:@"liwushuo" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:jsonPath];
        _heroList = [[NSArray alloc]initWithArray:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil][@"data"][@"categories"]];
    }
    return _heroList;
}
-(NSMutableArray *)selectHeros{
    if (!_selectHeros) {
        _selectHeros = [[NSMutableArray alloc]initWithCapacity:3];
    }
    return _selectHeros;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"常用英雄";
    self.view.backgroundColor = BackgroundColor;
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setTitleColor:[UIColor colorHex:@"#E7586E"] forState:UIControlStateNormal];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button setTitle:@"保存" forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(rightBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:button];
    [self.navigationItem setRightBarButtonItem:right];
    // Do any additional setup after loading the view.
    NSInteger spe = 6.5;
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 80, Height-NavigationTop-SafeArea(Width/spe+94, Width/spe+60)) style:UITableViewStyleGrouped];
    tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    tableView.backgroundColor = [UIColor colorWithRed:0.11 green:0.11 blue:0.11 alpha:1.00];
    tableView.separatorColor = [UIColor colorWithRed:0.16 green:0.16 blue:0.17 alpha:1.00];
    tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    tableView.estimatedSectionFooterHeight = 0;
    tableView.estimatedSectionHeaderHeight = 0;
    tableView.delegate = self;
    tableView.dataSource = self;
    self.selectRow = 0;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((Width-160)/3, (Width-160)/3+30);
    flowLayout.minimumLineSpacing = 15;
    flowLayout.minimumInteritemSpacing = 20;
    
    UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectMake(tableView.frame.size.width, 0, Width-tableView.frame.size.width, tableView.frame.size.height) collectionViewLayout:flowLayout];
    collection.contentInset = UIEdgeInsetsMake(15, 20, 15, 20);
    collection.delegate=self;
    collection.dataSource=self;
    collection.showsVerticalScrollIndicator = NO;
    collection.showsHorizontalScrollIndicator = NO;
    collection.backgroundColor = tableView.backgroundColor;
    [collection registerClass:[HeroViewCell class] forCellWithReuseIdentifier:@"HeroViewCell"];
    [self.view addSubview:collection];
    self.collection = collection;
    
    {//底部collection
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(Width/spe, Width/spe+30);
        flowLayout.minimumLineSpacing = Width/8;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, tableView.frame.origin.y+tableView.frame.size.height, Width, SafeArea(Width/spe+94, Width/spe+60)) collectionViewLayout:flowLayout];
        collection.contentInset = UIEdgeInsetsMake(15, (Width/8), 15, (Width/8));
        collection.delegate=self;
        collection.dataSource=self;
        collection.showsVerticalScrollIndicator = NO;
        collection.scrollEnabled = NO;
        collection.showsHorizontalScrollIndicator = NO;
        collection.backgroundColor = ThemeColor;
        [collection registerClass:[HeroViewCell class] forCellWithReuseIdentifier:@"HeroViewCell"];
        [self.view addSubview:collection];
        self.footCollection = collection;
    }
}
#pragma mark  =========== UITableView ==========
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.heroList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    cell.selectionStyle = 0;
    cell.backgroundColor = tableView.backgroundColor;
    cell.textLabel.text = self.heroList[indexPath.row][@"name"];
    cell.textLabel.textColor = indexPath.row == self.selectRow ? [UIColor colorWithRed:0.91 green:0.35 blue:0.43 alpha:1.00]:[UIColor whiteColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectRow = indexPath.row;
    [tableView reloadData];
    [self.collection reloadData];
}
#pragma mark  =========== UICollectionView ==========
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return collectionView == self.collection ? [self.heroList[self.selectRow][@"subcategories"] count] : self.selectHeros.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HeroViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeroViewCell" forIndexPath:indexPath];
    if (collectionView == self.collection) {
        cell.imageName = self.heroList[self.selectRow][@"subcategories"][indexPath.item][@"icon_url"];
        cell.heroName = self.heroList[self.selectRow][@"subcategories"][indexPath.item][@"name"];
        cell.selecteds = [self.selectHeros containsObject:cell.heroName];
    }else{
        cell.imageName = self.selectHeros[indexPath.item];
        cell.heroName = self.selectHeros[indexPath.item];
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.collection) {
        HeroViewCell *cell = (HeroViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        if (cell.selecteds) {
            //已选中，执行撤销
            cell.selecteds = !cell.selecteds;
            [self.selectHeros removeObject:cell.heroName];
            [self.footCollection reloadData];
        }else{
            //未选中，执行选中
            if (self.selectHeros.count >= 3) return;
            cell.selecteds = !cell.selecteds;
            [self.selectHeros addObject:cell.heroName];
            [self.footCollection reloadData];
        }
    }else{
        [self.selectHeros removeObjectAtIndex:indexPath.row];
        [collectionView reloadData];
        [self.collection reloadData];
    }
}
-(void)rightBtn:(UIButton *)sender{
    if (self.selectHeros.count == 0) return;
    [self.subHeros sendNext:[self.selectHeros componentsJoinedByString:@","]];
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
