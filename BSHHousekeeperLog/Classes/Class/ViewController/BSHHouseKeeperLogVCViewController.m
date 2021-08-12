//
//  BSHHouseKeeperLogVCViewController.m
//  BSHHousekeeperLog
//
//  Created by 符敏锋 on 2021/8/11.
//

#import "BSHHouseKeeperLogVCViewController.h"
#import "Masonry.h"
#import "BSHSignAlertView.h"

@interface BSHHouseKeeperLogVCViewController ()
@property(nonatomic,strong) UIImage *signImg;
@end

@implementation BSHHouseKeeperLogVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BSHSignAlertView *view = [[BSHSignAlertView alloc] init];
    view.commitblock = ^(UIImage * _Nonnull image) {
        //生成的签名图片
        
        self.signImg = image;
    };
    [self.view addSubview:view];
    
}



@end
