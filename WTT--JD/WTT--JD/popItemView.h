//
//  popItemView.h
//  WTT--JD
//
//  Created by W on 2017/4/1.
//  Copyright © 2017年 wangting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface popItemView : UIView

@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)NSArray *itemArray;

@property (nonatomic, copy) void (^selectDataBlock)(NSDictionary *);

@end
