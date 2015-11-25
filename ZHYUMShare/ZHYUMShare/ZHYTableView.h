//
//  ZHYTableView.h
//  ZHYUMShare
//
//  Created by 张昊煜 on 15/11/23.
//  Copyright © 2015年 ZhYu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocialControllerService.h"
#import "UMSocialShakeService.h"

@class ZHYTableView;
@protocol ZHYTableViewDelegate <NSObject>

@optional
- (void)ZHYTableViewFirstRow:(ZHYTableView*)ZHYTableView;
- (void)ZHYTableViewSecondRow:(ZHYTableView*)ZHYTableView;

@end

@interface ZHYTableView : UITableView
<
UIActionSheetDelegate,
UMSocialUIDelegate,
UMSocialShakeDelegate
>

@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, assign) id<ZHYTableViewDelegate> zhyDelegate;

@end
