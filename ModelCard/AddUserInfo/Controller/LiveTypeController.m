//
//  LiveTypeController.m
//  ModelCard
//
//  Created by iMac on 2018/3/1.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "LiveTypeController.h"
#import "LiveTypeCell.h"

@interface LiveTypeController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView * collection;
@end

@implementation LiveTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ThemeColor;
    self.title = @"直播平台";
    // Do any additional setup after loading the view.
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 40, 15, 15)];
    imageView.image = [UIImage imageNamed:@"online_live_fans"];
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 37.5, 200, 20)];
    label.text = @"点击选择（可多选）";
    label.textColor = [UIColor lightGrayColor];
    [self.view addSubview:label];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.estimatedItemSize = CGSizeMake(50, 30);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 20;
    
    UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectMake(10, 95, Width-20, Height/2) collectionViewLayout:flowLayout];
    collection.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    collection.delegate=self;
    collection.dataSource=self;
    collection.showsVerticalScrollIndicator = NO;
    collection.showsHorizontalScrollIndicator = NO;
    collection.backgroundColor = self.view.backgroundColor;
    [collection registerClass:[LiveTypeCell class] forCellWithReuseIdentifier:@"LiveTypeCell"];
    [self.view addSubview:collection];
    self.collection = collection;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 30;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LiveTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LiveTypeCell" forIndexPath:indexPath];
    //cell.selected
    return cell;
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
