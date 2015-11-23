//
//  ViewController.m
//  ZHYUMShare
//
//  Created by 张昊煜 on 15/11/19.
//  Copyright © 2015年 ZhYu. All rights reserved.
//

#import "ViewController.h"
#import "UMSocialSnsService.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(50, 50, 100, 100);
    [shareBtn setTitle:@"share" forState:UIControlStateNormal];
    shareBtn.backgroundColor = [UIColor redColor];
    [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
}

- (void)shareBtnClick
{
    NSString *shareText = @"友盟社会化组件可以让移动应用快速具备社会化分享、登录、评论、喜欢等功能，并提供实时、全面的社会化数据统计分析服务。 http://www.umeng.com/social";             //分享内嵌文字
    UIImage *shareImage = [UIImage imageNamed:@"UMS_social_demo"];          //分享内嵌图片
    
    NSArray *array = [NSArray arrayWithObjects:UMShareToWechatTimeline, UMShareToWechatSession, UMShareToQzone, UMShareToQQ, UMShareToSina, nil];
    
    //调用快速分享接口
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"53290df956240b6b4a0084b3"
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:array
                                       delegate:self];

}

@end
