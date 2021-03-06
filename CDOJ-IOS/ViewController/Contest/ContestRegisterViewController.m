//
//  ContestRegisterViewController.m
//  CDOJ-IOS
//
//  Created by GuessEver on 16/8/14.
//  Copyright © 2016年 UESTCACM QKTeam. All rights reserved.
//

#import "ContestRegisterViewController.h"
#import "String.h"
#import "Api.h"

@implementation ContestRegisterViewController

- (instancetype)initWithContestId:(NSString*)contestId {
    if(self = [super init]) {
        self.contestId = contestId;
        self.webView = [[DefaultWebView alloc] init];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:STRF(@"%@/#/contest/register/%@", APIURL, contestId)]]];
        [self.view addSubview:self.webView];
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top);
            make.left.equalTo(self.view.mas_left);
            make.width.equalTo(self.view.mas_width);
            make.height.equalTo(self.view.mas_height);
        }];
    }
    return self;
}

@end
