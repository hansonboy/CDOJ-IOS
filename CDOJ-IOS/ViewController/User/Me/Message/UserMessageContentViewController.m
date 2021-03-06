//
//  UserMessageContentViewController.m
//  CDOJ-IOS
//
//  Created by GuessEver on 2016/9/23.
//  Copyright © 2016年 UESTCACM QKTeam. All rights reserved.
//

#import "UserMessageContentViewController.h"

@interface UserMessageContentViewController ()

@end

@implementation UserMessageContentViewController

- (instancetype)initWithMessageId:(NSString*)messageId {
    if(self = [super init]) {
        self.data = [[MessageContentModel alloc] init];
        [self.data fetchDataWithMessageId:messageId];
//        [self loadWebActionBarButtonsWithUrl:STRF(@"%@/#/article/show/%@", APIURL, articleId)];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:NOTIFICATION_MESSAGE_DATA_REFRESHED object:nil];
        
        self.webView = [[DefaultWebView alloc] init];
        [self.view addSubview:self.webView];
        // self.webView Constraints
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.view.mas_width);
            make.height.equalTo(self.view.mas_height);
        }];
    }
    return self;
}

- (void)refreshData {
    [self.webView loadWithData:self.data.content andRenderName:@"articleRender"];
}

@end
