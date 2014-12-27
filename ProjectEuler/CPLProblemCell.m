//
//  CPLProblemCell.m
//  ProjectEuler
//
//  Created by Caio Lima on 2014-12-26.
//  Copyright (c) 2014 Caio Lima. All rights reserved.
//

#import "CPLProblemCell.h"

@implementation CPLProblemCell

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        [_label setBackgroundColor:[UIColor clearColor]];
        [_label setFont:[UIFont systemFontOfSize:30]];
        [_label setTextColor:[UIColor darkTextColor]];
        [_label setCenter:self.contentView.center];
        [self.contentView addSubview:_label];
        [self.contentView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [self.contentView.layer setBorderWidth:1];
        [self.contentView.layer setCornerRadius:5];
    }
    return _label;
}

- (void)setProblemNumber:(NSString *)text
{
    [self.label setText:text];
    [self.label sizeToFit];
    [self.label setCenter:self.contentView.center];
}

@end
