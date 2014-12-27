//
//  CPLProblemParser.h
//  ProjectEuler
//
//  Created by Caio Lima on 2014-12-26.
//  Copyright (c) 2014 Caio Lima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPLProblemParser : NSObject

- (NSString *)parseProblemWithNumberString:(NSString *)numberString;
- (void)grabProblemWithNumberString:(NSString *)numberString
                            success:(void (^)(NSString *response))success
                            failure:(void (^)(NSError *error))failure;
@end
