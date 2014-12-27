//
//  CPLProblemParser.m
//  ProjectEuler
//
//  Created by Caio Lima on 2014-12-26.
//  Copyright (c) 2014 Caio Lima. All rights reserved.
//

#import "CPLProblemParser.h"
#import "AFNetworking.h"

@implementation CPLProblemParser

- (NSString *)parseProblemWithNumberString:(NSString *)numberString
{
    NSString *fetchedProblemHTML = [self fetchProblemDataWithNumberString:numberString];
    
    return fetchedProblemHTML;
}

- (void)grabProblemWithNumberString:(NSString *)numberString
                            success:(void (^)(NSString *response))success
                            failure:(void (^)(NSError *error))failure
{
    NSString *urlString = [NSString stringWithFormat:@"http://projecteuler.net/problem=%@", numberString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    __block NSString *stringResponse = nil;
    
    AFHTTPRequestOperation *httpRequestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpRequestOperation setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [httpRequestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        stringResponse = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"stringResponse = %@", stringResponse);
        success(stringResponse);
    }
                                                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                    NSLog(@"Error: %@", error);
                                                    failure(error);
                                                }];
    [httpRequestOperation start];
}

- (NSString *)fetchProblemDataWithNumberString:(NSString *)numberString
{
    NSString *urlString = [NSString stringWithFormat:@"http://projecteuler.net/problem=%@", numberString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    __block NSString *stringResponse = nil;
    
    AFHTTPRequestOperation *httpRequestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpRequestOperation setResponseSerializer:[AFHTTPResponseSerializer serializer]];
    [httpRequestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        stringResponse = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"stringResponse = %@", stringResponse);
    }
                                                failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                    NSLog(@"Error: %@", error);
                                                }];
    [httpRequestOperation start];
    return stringResponse;
}

@end
