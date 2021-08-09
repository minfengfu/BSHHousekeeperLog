//
//  UIColor+ColorChange.h
//  CollectionViewDemo
//
//  Created by 蒲仁飞 on 16/11/23.
//  Copyright © 2016年 com.aihuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorChange)

// 颜色转换：iOS中（以#开头）十六进制的颜色转换为UIColor(RGB)
+ (UIColor *) colorWithHexString: (NSString *)color;

@end
