//
//  CPLProblemCell.h
//  ProjectEuler
//
//  Created by Caio Lima on 2014-12-26.
//  Copyright (c) 2014 Caio Lima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPLProblemCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *label;

- (void)setProblemNumber:(NSString *)text;
- (void)showActivityIndicator;
- (void)hideActivityIndicator;

@end
