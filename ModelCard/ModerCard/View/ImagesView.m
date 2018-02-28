//
//  ImagesView.m
//  ModelCard
//
//  Created by iMac on 2018/2/25.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import "ImagesView.h"
#import "ImageViewCell.h"

@interface ImagesView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSMutableArray * images;

@property (nonatomic,strong) UICollectionView * collection;
@property (nonatomic,strong) UILabel * countTitle;
@property (nonatomic,strong) UIButton * finish;
@end

@implementation ImagesView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.16 alpha:1.00];
        self.images = [[NSMutableArray alloc]init];
    
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, frame.size.width/2, 15)];
        title.font = [UIFont systemFontOfSize:13];
        title.textColor = [UIColor lightGrayColor];
        [self addSubview:title];
        self.countTitle = title;
        
        UIButton *finish = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width-100, 10, 80, 30)];
        [finish makeCornerRadius:3];
        [finish setBackgroundColor:[UIColor lightGrayColor]];
        [finish setTitle:@"制作" forState:UIControlStateNormal];
        [finish setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [finish setTitle:@"制作" forState:UIControlStateSelected];
        [finish setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [finish addTarget:self action:@selector(didFinish:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:finish];
        self.finish = finish;
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake((frame.size.width-60)/4, (frame.size.height-40)-30);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 20;
        
        UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, frame.size.width, frame.size.height-40) collectionViewLayout:flowLayout];
        collection.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
        collection.delegate=self;
        collection.dataSource=self;
        collection.showsVerticalScrollIndicator = NO;
        collection.showsHorizontalScrollIndicator = NO;
        collection.backgroundColor = self.backgroundColor;
        [collection registerClass:[ImageViewCell class] forCellWithReuseIdentifier:@"ImageViewCell"];
        [self addSubview:collection];
        self.collection = collection;
    }
    return self;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"ImageViewCell" forIndexPath:indexPath];
    cell.image = self.images[indexPath.item];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.images removeObjectAtIndex:indexPath.row];
    self.countTitle.text = [NSString stringWithFormat:@"已添加%ld张照片 (%ld/%ld)",self.images.count,self.images.count,self.count];
    self.finish.selected = NO;
    [self.finish setBackgroundColor:[UIColor lightGrayColor]];
    [collectionView reloadData];
}
-(void)setCount:(NSInteger)count{
    _count = count;
    if (_count == 0) {
        [self.images removeAllObjects];
        self.finish.selected = NO;
        [self.finish setBackgroundColor:[UIColor lightGrayColor]];
        [self.collection reloadData];
        self.hidden = YES;
        self.frame = CGRectMake(0, Height, Width, 150);
    }
    self.countTitle.text = [NSString stringWithFormat:@"已添加%ld张照片 (%ld/%ld)",self.images.count,self.images.count,_count];
}
-(void)didAddImage:(UIImage *)image{
    if (self.images.count < self.count) {
        [self.images addObject:image];
        self.countTitle.text = [NSString stringWithFormat:@"已添加%ld张照片 (%ld/%ld)",self.images.count,self.images.count,self.count];
        if (self.images.count == self.count) {
            self.finish.selected = YES;
            [self.finish setBackgroundColor:[UIColor colorWithRed:0.91 green:0.35 blue:0.43 alpha:1.00]];
        }
        [self.collection reloadData];
        [self.collection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.images.count-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
}
-(void)didFinish:(UIButton *)sender{
    if (sender.isSelected && self.images.count == self.count) {
        [self.delegate didFinishImages:self.images];
    }
}
@end
