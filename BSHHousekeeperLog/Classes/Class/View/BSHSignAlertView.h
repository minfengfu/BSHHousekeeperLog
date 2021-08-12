//
//  BSHSignAlertView.h
//  SignDemo
//
//  Created by 符敏锋 on 2021/8/12.
//  Copyright © 2021 yunlong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BSHSignAlertView : UIView


@property (nonatomic,copy) void (^commitblock)(UIImage *image);



NS_ASSUME_NONNULL_END
@end
