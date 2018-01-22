//
//  CustomTableViewCell.m
//  GFSwipActionCell
//
//  Created by XinKun on 2018/1/16.
//  Copyright © 2018年 North_feng. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell
{
    UILabel *_label;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createView];
    }
    
    return self;
}

///创建视图
- (void)createView{
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(30, 20, 260, 60)];
    _label.font = [UIFont systemFontOfSize:20];
    _label.textAlignment = NSTextAlignmentLeft;
    _label.backgroundColor = [UIColor grayColor];
    
#warning 警告！这里别出错了！
    //不能是self.contentView
    [self.cellScroller addSubview:_label];
}


- (void)setDataModel:(NSString *)index{
    
    _label.text = [NSString stringWithFormat:@"这是第000%@行",index];
    
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
