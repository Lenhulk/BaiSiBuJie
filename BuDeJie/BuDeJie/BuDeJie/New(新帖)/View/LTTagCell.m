//
//  LTTagCell.m
//  BuDeJie
//
//  Created by Lenhulk on 16/10/19.
//  Copyright © 2016年 Lenhulk. All rights reserved.
//

#import "LTTagCell.h"
#import <UIImageView+WebCache.h>
#import "LTSubTagItem.h"
#import "UIImage+LTRender.h"

@interface LTTagCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameView;
@property (weak, nonatomic) IBOutlet UILabel *numView;
@end

@implementation LTTagCell

+ (instancetype)cell{
    return [[[NSBundle mainBundle]loadNibNamed:@"LTTagCell" owner:nil options:nil]firstObject];
}

- (void)setFrame:(CGRect)frame{
//    LTLog(@"%@", NSStringFromCGRect(frame));
    frame.size.height -= 5;    //下边距
    frame.origin.y += 5;    //上边距
    frame.origin.x += 5;    //左边距
    frame.size.width -= 10;
    [super setFrame:frame];
}

//当cell要显示的时候，系统会自动调用setFrame方法

- (void)setSubTagItem:(LTSubTagItem *)item{
    _subTagItem = item;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:item.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    _nameView.text = item.theme_name;
    
    //处理订阅数字
    CGFloat num = [item.sub_number floatValue];
    NSString *numStr = [NSString stringWithFormat:@"%f人订阅", num];
    if (num > 10000) {
        num = num / 10000.0;
        numStr = [NSString stringWithFormat:@"%.1f万人订阅", num];
        numStr = [numStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }
    _numView.text = numStr;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
