//
//  ViewController.m
//  ZHYUMShare
//
//  Created by 张昊煜 on 15/11/19.
//  Copyright © 2015年 ZhYu. All rights reserved.
//

#import "ViewController.h"
#import "UMSocialSnsService.h"
#import "ZHYTableView.h"
#import "AppDelegate.h"
#import "HYActivityView.h"
#import <Accounts/Accounts.h>

#import <MessageUI/MessageUI.h>
#import <Social/Social.h>
#import <iAd/iAd.h>
#import "EvernoteSDK.h"

@interface ViewController ()<ZHYTableViewDelegate, MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate,ADBannerViewDelegate>

@property (nonatomic, strong) ZHYTableView *tableView;
@property (nonatomic, strong) NSMutableArray *array;
@property(strong,nonatomic)HYActivityView *hyActivityView;
@property(strong,nonatomic)ADBannerView *bannerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"share";
    
    [self setupDate];
    [self setupUI];
}

- (void)setupDate
{
    [self.array addObject:[NSString stringWithFormat:@"友盟社会化分享"]];
    [self.array addObject:[NSString stringWithFormat:@"ios系统分享"]];
}

- (void)setupUI
{
    self.tableView.frame = self.view.bounds;
    self.tableView.array = self.array;
    self.tableView.zhyDelegate = self;
    [self.view addSubview:self.tableView];
}

#pragma mark - ZHYTableViewDelegate

- (void)ZHYTableViewFirstRow:(ZHYTableView *)ZHYTableView
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

- (void)ZHYTableViewSecondRow:(ZHYTableView *)ZHYTableView
{
    if (!self.hyActivityView) {
        self.hyActivityView=[[HYActivityView alloc]initWithTitle:@"分享到" referView:self.view];
        
        ButtonView *bv=[[ButtonView alloc]initWithText:@"Email" image:[UIImage imageNamed:@"share_platform_email"] handler:^(ButtonView *buttonView) {
            NSLog(@"你点击了邮件分享");
            [self shareEmail];
        }];
        [self.hyActivityView addButtonView:bv];
        
        bv=[[ButtonView alloc]initWithText:@"短信" image:[UIImage imageNamed:@"share_platform_email" ] handler:^(ButtonView *buttonView) {
            NSLog(@"你点击了短信分享");
            [self shareSMS];
            
            
        }];
        [self.hyActivityView addButtonView:bv];
        
        bv=[[ButtonView alloc]initWithText:@"系统自带" image:[UIImage imageNamed:@"share_platform_email"] handler:^(ButtonView *buttonView) {
            NSLog(@"你点击系统自带分享");
            [self shareSystem];
        }];
        [self.hyActivityView addButtonView:bv];
        
        bv=[[ButtonView alloc]initWithText:@"印象笔记" image:[UIImage imageNamed:@"share_platform_evernote@2x.png"] handler:^(ButtonView *buttonView) {
            NSLog(@"你点印象笔记分享");
            [self sharEvernote];
        }];
        [self.hyActivityView addButtonView:bv];
    }
    [self.hyActivityView show];
}

#pragma mark - getters

- (ZHYTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[ZHYTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tableView;
}

- (NSMutableArray *)array
{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

#pragma mark
#pragma mark -邮件分享-
//1.导入框架<MessageUI/MessageUI.h>
//2.加入MFMailComposeViewControllerDelegate
-(void)shareEmail{
    Class mailClass=(NSClassFromString(@"MFMailComposeViewController"));
    if (mailClass!=nil) {
        if ([mailClass canSendMail]) {
            MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
            picker.mailComposeDelegate=self;
            [picker setSubject:@"分享主题"];
            [picker setMessageBody:@"分享的内容写在这儿"isHTML:NO];
            [self presentViewController:picker animated:YES completion:nil];
        }
    }else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"该设备不支持邮件分享" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    
    
}
#pragma mark -<MFMailComposeViewControllerDelegate>-
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    // NSLog(@"%@",error);
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark-
#pragma mark -短信分享
//1.导入框架<MessageUI/MessageUI.h>
//2.加入MFMessageComposeViewControllerDelegate

-(void)shareSMS{
    Class messageClass=(NSClassFromString(@"MFMessageComposeViewController"));
    if (messageClass!=nil) {
        if ([messageClass canSendText]) {
            MFMessageComposeViewController *picker=[[MFMessageComposeViewController alloc]init];
            picker.messageComposeDelegate=self;
            picker.body=@"分享内容";
            [self presentViewController:picker animated:YES completion:nil];
        }
        else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"该设备不支持短信分享" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }
}
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark
#pragma mark -系统自带分享
//1.导入框架 <Social/Social.h>
//SLServiceTypeTencentWeibo 腾讯微博
//SLServiceTypeSinaWeibo 新浪微博
//SLServiceTypeTwitter twitter
//SLServiceTypeFacebook facebook
//SLServiceTypeLinkedIn

-(void)shareSystem{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
        
        SLComposeViewController *slVc=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
        SLComposeViewControllerCompletionHandler myBlock=^(SLComposeViewControllerResult result){
            if (result==SLComposeViewControllerResultDone) {
                NSLog(@"done");
            }
            else{
                NSLog(@"else");
            }
            [slVc dismissViewControllerAnimated:YES completion:nil];
        };
        slVc.completionHandler=myBlock;
        [slVc setInitialText:@"分享内容"];
        [slVc addImage:[UIImage imageNamed:@"share_platform_qqfriends@2x.png"]];
        [slVc addURL:[NSURL URLWithString:@"http://www.sina.com"]];
        [self presentViewController:slVc animated:YES completion:nil];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您还未绑定新浪微博,请到设置里面绑定" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
    
}

#pragma mark
#pragma mark -<ADViewDelegate>-
-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"error:%@",error);
}
-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    NSLog(@"ad loaded");
}
-(void)bannerViewWillLoadAd:(ADBannerView *)banner{
    NSLog(@"ad will loaded");
}
-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
    NSLog(@"ad finish loaded");
}


#pragma mark
#pragma mark -印象笔记-
//http://dev.yinxiang.com/doc/start/ios.php
-(void)sharEvernote{
    EvernoteSession *session = [EvernoteSession sharedSession];
    NSLog(@"Session host: %@", [session host]);
    NSLog(@"Session key: %@", [session consumerKey]);
    NSLog(@"Session secret: %@", [session consumerSecret]);
    
    [session authenticateWithViewController:self completionHandler:^(NSError *error) {
        if (error || !session.isAuthenticated){
            if (error) {
                NSLog(@"Error authenticating with Evernote Cloud API: %@", error);
            }
            if (!session.isAuthenticated) {
                NSLog(@"Session not authenticated");
            }
        } else {
            // We're authenticated!
            EvernoteUserStore *userStore = [EvernoteUserStore userStore];
            [userStore getUserWithSuccess:^(EDAMUser *user) {
                // success
                NSLog(@"Authenticated as %@", [user username]);
                
                EvernoteNoteStore *noteStore = [EvernoteNoteStore noteStore];
                [noteStore listNotebooksWithSuccess:^(NSArray *notebooks) {
                    // success... so do something with the returned objects
                    NSLog(@"notebooks: %@", notebooks);
                }
                                            failure:^(NSError *error) {
                                                // failure... show error notification, etc
                                                if([EvernoteSession isTokenExpiredWithError:error]) {
                                                    // trigger auth again
                                                    // auth code is shown in the Authenticate section
                                                }
                                                NSLog(@"error %@", error);
                                            }];
                
                
            } failure:^(NSError *error) {
                // failure
                NSLog(@"Error getting user: %@", error);
            } ];
        }
    }];
}


@end
