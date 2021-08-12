//
//  BSHSignView.h
//  SignDemo
//
//  Created by 符敏锋 on 2021/8/12.
//  Copyright © 2021 yunlong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSHSignView : UIView

/**
 * 获取签名图片
 */
- (UIImage *)getSignatureImage;
/**
 * 清除签名
 */
- (void)clearSignature;
@end

NS_ASSUME_NONNULL_END
