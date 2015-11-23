//
//  ViewController.h
//  ZHYUMShare
//
//  Created by 张昊煜 on 15/11/19.
//  Copyright © 2015年 ZhYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocialControllerService.h"
#import "UMSocialShakeService.h"

@interface ViewController : UIViewController
<
UIActionSheetDelegate,
UMSocialUIDelegate,
UMSocialShakeDelegate
>

@end

