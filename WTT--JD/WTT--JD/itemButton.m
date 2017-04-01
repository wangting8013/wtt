//
//  itemButton.m
//  WTT--JD
//
//  Created by W on 2017/4/1.
//  Copyright © 2017年 wangting. All rights reserved.
//

#import "itemButton.h"

@interface itemButton ()



@end

@implementation itemButton

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-2, frame.size.width, 1)];
        self.lineView.backgroundColor = [UIColor redColor];
        self.lineView.hidden = YES;
        [self addSubview:self.lineView];
        
        self.selectImageView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width - 15, frame.size.height - 20, 15,15)];
        self.selectImageView.image = [UIImage imageNamed:@"selected"];
        self.selectImageView.contentMode = UIViewContentModeCenter;
        self.selectImageView.hidden = YES;
        [self addSubview:self.selectImageView];
    }
    
    return self;
}

@end
