//
//  ModelInfoCell.h
//  ModelCard
//
//  Created by iMac on 2018/2/27.
//  Copyright © 2018年 Asher. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ModelInfoCellDelegate <NSObject>
-(void)didChangeIndex:(NSInteger)index Status:(BOOL)status;
@end

@interface ModelInfoCell : UITableViewCell
@property (nonatomic,weak) id<ModelInfoCellDelegate> delegate;
@property (nonatomic,strong) NSArray * titles;
@property (nonatomic,strong) NSArray * contents;
@end
