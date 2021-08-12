//
//  BSHSignAlertView.m
//  SignDemo
//
//  Created by 符敏锋 on 2021/8/12.
//  Copyright © 2021 yunlong. All rights reserved.
//

#import "BSHSignAlertView.h"
#import "BSHSignView.h"
//获取屏幕宽度与高度
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface BSHSignAlertView (){
    CGPoint points[5];
}
@property(nonatomic,assign) NSInteger control;
@property(nonatomic,strong) UIBezierPath *beizerPath;

@property(nonatomic,strong) UIView *alertView; //弹框



@property(nonatomic,strong) BSHSignView *signView;  //签名背景view

@property(nonatomic,strong) UILabel *titleLabel; //标题
@property(nonatomic,strong) UIButton *closeBtn;//关闭按钮
@property(nonatomic,strong) UIButton *clearBtn; //清除按钮

@property(nonatomic,strong) UIView *lineView;  //分割线

@property(nonatomic,strong) UIImageView *descImage;
@property(nonatomic,strong) UILabel *descLabel;

@property(nonatomic,strong) UIView *photoView; //拍照View
@property(nonatomic,strong) UILabel *photoTipsLabel; //拍照提示label
@property(nonatomic,strong) UIImageView *photoDefaultIMG; //拍照背景图

@property(nonatomic,strong) UIButton *commitBtn; //提交按钮
@end

@implementation BSHSignAlertView


-(instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.5;
    self.hidden =NO;
    if (self) {
        
        
        [self addSubview: self.alertView];
        [[UIApplication sharedApplication].delegate.window addSubview:self];

    }
    return self;
}


#pragma mark - 按钮点击事件
-(void)closeBtnClick
{
    // 第一步：将view宽高缩至无限小（点）
    [UIView animateWithDuration:0.3
                     animations:^{
                         // 第二步： 以动画的形式将view慢慢放大至原始大小的1.2倍
                         self.frame = CGRectMake(0, SCREENH_HEIGHT, SCREEN_WIDTH, 197);
                         self.hidden =YES;
        
                     }completion:nil];
}

-(void)commitBtnClick
{
    
   UIImage *image =  [self.signView getSignatureImage];
    if (self.commitblock) {
        self.commitblock(image);
    }
}

-(void)clearBtnClick
{
    [self.signView clearSignature];
}

#pragma mark - 懒加载子view

-(UIView *)alertView
{
    if (!_alertView) {
        _alertView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENH_HEIGHT/6, SCREEN_WIDTH, SCREENH_HEIGHT/6*5)];
        _alertView.backgroundColor = [UIColor whiteColor];
        
        [self.alertView addSubview:self.closeBtn];
        [self.alertView addSubview:self.titleLabel];
        [self.alertView addSubview:self.lineView];
        [self.alertView addSubview:self.descImage];
        [self.alertView addSubview:self.descLabel];
        [self.alertView addSubview:self.clearBtn];
        [self.alertView addSubview:self.signView];
        [self.alertView addSubview:self.photoView];
        [self.alertView addSubview:self.commitBtn];
        
        
        
    }
    return _alertView;
}

-(UIView *)signView
{
    if (!_signView) {
        _signView = [[BSHSignView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.descLabel.frame)+8, SCREEN_WIDTH-15*2, SCREEN_WIDTH/5*3)];
        _signView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _signView.layer.borderWidth =1;
        _signView.layer.cornerRadius =5;
        _signView.clipsToBounds = YES;
        _signView.backgroundColor = [UIColor whiteColor];
        
        
        [self setMultipleTouchEnabled:NO];
        self.beizerPath = [UIBezierPath bezierPath];
        [self.beizerPath setLineWidth:2];
        
    }
    return _signView;
}



-(UIButton *)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 15, 30, 30)];
        _closeBtn.backgroundColor = [UIColor redColor];
        [_closeBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_closeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _closeBtn;
}

-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100/2, 20, 100, 20)];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text =@"业主签名";
    }
    return _titleLabel;
}

-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.titleLabel.frame)+20, SCREEN_WIDTH-10*2, 0.5)];
    
        _lineView.backgroundColor = [UIColor grayColor];
    }
    return _lineView;
}

-(UIImageView *)descImage
{
    if (!_descImage) {
        _descImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.lineView.frame)+30, 15, 15)];
        _descImage.image = [UIImage imageNamed:@""];
        
        _descImage.backgroundColor = [UIColor greenColor];
    }
    return _descImage;
}

-(UILabel *)descLabel
{
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.descImage.frame)+10, self.descImage.center.y-10, SCREEN_WIDTH-20, 20)];
        _descLabel.font = [UIFont systemFontOfSize:14];
        _descLabel.textColor = [UIColor blackColor];
        _descLabel.textAlignment = NSTextAlignmentLeft;
        _descLabel.text =@"请在下方手写框内签名";
    }
    return _descLabel;
}
-(UIButton *)clearBtn
{
    if (!_clearBtn) {
        _clearBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100-15, self.descLabel.center.y-15, 100, 30)];
        [_clearBtn setTitle:@"清除签名" forState:UIControlStateNormal];
        [_clearBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_clearBtn addTarget:self action:@selector(clearBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _clearBtn;
}


-(UIView *)photoView
{
    if (!_photoView) {
        _photoView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-100/2, CGRectGetMaxY(self.signView.frame)+15, 100, 80)];
        _photoView.backgroundColor = [UIColor whiteColor];
        _photoView.layer.borderWidth =1;
        _photoView.layer.borderColor = [UIColor grayColor].CGColor;
        [self.photoView addSubview:self.photoDefaultIMG];
        [self.photoView addSubview:self.photoTipsLabel];
    }
    return _photoView;
}

-(UIImageView *)photoDefaultIMG
{
    if (!_photoDefaultIMG) {
        _photoDefaultIMG = [[UIImageView alloc] initWithFrame:CGRectMake(100/2-50/2, 10, 50, 30)];
        _photoDefaultIMG.image = [UIImage imageNamed:@""];
        _photoDefaultIMG.backgroundColor = [UIColor orangeColor];
    }
    return _photoDefaultIMG;
}

-(UILabel *)photoTipsLabel
{
    if (!_photoTipsLabel) {
        _photoTipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(100/2-60/2, CGRectGetMaxY(self.photoDefaultIMG.frame)+5, 60, 35)];
        _photoTipsLabel.numberOfLines =2;
        _photoTipsLabel.font = [UIFont systemFontOfSize:13];
        _photoTipsLabel.textColor = [UIColor blackColor];
        _photoTipsLabel.textAlignment = NSTextAlignmentCenter;
        _photoTipsLabel.text =@"拍照上传\n签名";
    }
    return _photoTipsLabel;
}


-(UIButton *)commitBtn
{
    if (!_commitBtn) {
        _commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/3, CGRectGetMaxY(self.photoView.frame)+30, SCREEN_WIDTH/3, 30)];
        _commitBtn.layer.cornerRadius = 5;
        [_commitBtn setTitle:@"提交" forState:0];
        _commitBtn.backgroundColor = [UIColor orangeColor];
        [_commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _commitBtn;
}


@end
