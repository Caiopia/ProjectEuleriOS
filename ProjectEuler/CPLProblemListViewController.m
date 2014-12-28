//
//  CPLProblemListViewController.m
//  ProjectEuler
//
//  Created by Caio Lima on 2014-12-26.
//  Copyright (c) 2014 Caio Lima. All rights reserved.
//

#import "CPLProblemListViewController.h"
#import "CPLProblemCell.h"
#import "CPLProblemParser.h"

#define kProblemCell @"ProblemCell"
#define kProblemHeader @"ProblemHeader"
#define kCollectionViewPadding 10

@interface CPLProblemListViewController ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *problemCollectionView;
@property (nonatomic, strong) NSArray *problemArray;

@end

@implementation CPLProblemListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
//    [self setExtendedLayoutIncludesOpaqueBars:YES];
    
    [self setUpProblemList];
    [self setUpCollectionView];
    
    [self.problemCollectionView registerClass:[CPLProblemCell class]
                   forCellWithReuseIdentifier:kProblemCell];
    [self.problemCollectionView registerClass:[UICollectionReusableView class]
                   forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                          withReuseIdentifier:kProblemHeader];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Setup Methods

// Set up problem list
- (void)setUpProblemList
{
    // TODO: put on different thread
    
}

// Set up collection view
- (void)setUpCollectionView
{
    [self.view addSubview:self.problemCollectionView];
}

#pragma mark Setters & Getters

- (NSArray *)problemArray
{
    if (!_problemArray) {
        NSInteger numberOfProblems = 24;
        NSMutableArray *temporaryProblemList = [NSMutableArray array];
        for (NSInteger i = 1; i <= numberOfProblems; i++) {
            [temporaryProblemList addObject:[@(i) stringValue]];
        }
        _problemArray = [NSArray arrayWithArray:temporaryProblemList];
        temporaryProblemList = nil;
    }
    return _problemArray;
}

- (UICollectionView *)problemCollectionView
{
    if (!_problemCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        [flowLayout setMinimumLineSpacing:kCollectionViewPadding];
        [flowLayout setMinimumInteritemSpacing:kCollectionViewPadding];
        [flowLayout setHeaderReferenceSize:CGSizeMake(self.view.bounds.size.width, 50)];

        _problemCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        [_problemCollectionView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin |UIViewAutoresizingFlexibleRightMargin |UIViewAutoresizingFlexibleWidth];
        [_problemCollectionView setDelegate:self];
        [_problemCollectionView setDataSource:self];
        [_problemCollectionView setBackgroundColor:[UIColor clearColor]];
    }
    return _problemCollectionView;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.problemArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CPLProblemCell *problemCell = [collectionView dequeueReusableCellWithReuseIdentifier:kProblemCell
                                                                           forIndexPath:indexPath];
    [problemCell setProblemNumber:[self.problemArray objectAtIndex:indexPath.row]];
    
    return problemCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *problemHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                               withReuseIdentifier:kProblemHeader
                                                                      forIndexPath:indexPath];
    NSInteger labelTag = 2562457;
    
    for (UIView *subView in [problemHeader subviews]) {
        if (subView.tag == labelTag) {
            [subView removeFromSuperview];
            break;
        }
    }
    
    UILabel *headerLabel = [[UILabel alloc] init];
    [headerLabel setTextColor:[UIColor darkTextColor]];
    [headerLabel setText:@"Problems"];
    [headerLabel setFont:[UIFont systemFontOfSize:30]];
    [headerLabel sizeToFit];
    [headerLabel setCenter:CGPointMake(problemHeader.center.x, problemHeader.center.y+10)];
    [headerLabel setTag:labelTag];
    [headerLabel setAutoresizingMask:UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin];
    [problemHeader addSubview:headerLabel];
    return problemHeader;
}

#pragma mark UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Add activity indicator
    CPLProblemCell *selectedCell = (CPLProblemCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [selectedCell showActivityIndicator];
    
    __weak CPLProblemListViewController *weakSelf = self;
    CPLProblemParser *problemParser = [[CPLProblemParser alloc] init];
    [problemParser grabProblemWithNumberString:[self.problemArray objectAtIndex:indexPath.row]
                                                    success:^(NSString *response){
                                                        [selectedCell hideActivityIndicator];
                                                        [weakSelf openProblemView:response];
                                                    }
                                                    failure:^(NSError *error) {
                                                        NSLog(@"%@", error);
                                                        [selectedCell hideActivityIndicator];
                                                        [weakSelf grabNumberError:error];
                                                    }];
    problemParser = nil;
}

- (void)openProblemView:(NSString *)problemString
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Problem received"
                                                    message:problemString
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)grabNumberError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error fetching problem"
                                                    message:[error description]
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    NSInteger screenWidth = screenRect.size.width;
    NSInteger numberOfTilesPerRow = 4;
    return CGSizeMake((screenWidth-(numberOfTilesPerRow+1)*kCollectionViewPadding)/numberOfTilesPerRow,
                      (screenWidth-(numberOfTilesPerRow+1)*kCollectionViewPadding)/numberOfTilesPerRow);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(kCollectionViewPadding,
                            kCollectionViewPadding,
                            kCollectionViewPadding,
                            kCollectionViewPadding);
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self.problemCollectionView.collectionViewLayout invalidateLayout];
}

@end
