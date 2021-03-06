//
//  ProblemContentModel.m
//  CDOJ-IOS
//
//  Created by GuessEver on 16/5/16.
//  Copyright © 2016年 UESTCACM QKTeam. All rights reserved.
//

#import "ProblemContentModel.h"

@implementation ProblemContentModel

- (instancetype)init {
    if (self = [super init]) {
        self.content = [[NSDictionary alloc] init];
    }
    return self;
}

- (void)fetchDataWithProblemId:(NSString *)problemId {
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_HTTP_CONNECTING object:nil];
    [[AFHTTPSessionManager manager] GET:API_PROBLEM_DATA(problemId) parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_HTTP_CONNECTED object:nil];
        if([[responseObject objectForKey:@"result"] isEqualToString:@"success"]) {
            self.content = [responseObject objectForKey:@"problem"];
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PROBLEM_DATA_REFRESHED object:nil];
        }
        else {
            [Message show:STRF(@"没有编号为%@的题目，请检查是否正确，或者是否拥有足够权限！", problemId) withTitle:@"Opps"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(error.code == NSURLErrorBadServerResponse || error.code == NSURLErrorResourceUnavailable) {
            [Message show:@"请输入正确的题目数字编号" withTitle:@"错误！"];
        }
        else {
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_HTTP_ERROR object:nil];
        }
    }];
}

@end
