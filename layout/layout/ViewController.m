//
//  ViewController.m
//  textKit
//
//  Created by lawyee on 16/8/1.
//  Copyright © 2016年 163. All rights reserved.
//

#import "ViewController.h"
#import "SupplementaryView.h"
#import "Info.h"
#import "LineLayout.h"

#define Cell_ReuseIdentifier @"Cell_ReuseIdentifier"
#define Supplementary_ReuseIdentifier @"Supplementary_ReuseIdentifier"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectView;

@property (nonatomic, strong) NSMutableArray *dataList;
@end

@implementation ViewController

- (NSMutableArray *)dataList
{
    if (nil == _dataList) {
        NSArray *array = @[
                               @{
                                   @"title": @"尺码",
                                   @"descArray": @[@"超级小尺码容不下", @"M", @"L", @"XL", @"XXL", @"超级大尺码容不下"]
                                   },
                               @{
                                   @"title": @"颜色",
                                   @"descArray": @[@"红白", @"赤橙黄绿青蓝紫", @"卡其", @"黑色", @"屎黄", @"赤橙黄绿青蓝紫",]}
                               ];
        
        _dataList = [NSMutableArray arrayWithCapacity:array.count];
        for (NSDictionary *dict in array) {
            Info *model = [[Info alloc] initWithDict:dict];
            [self.dataList addObject:model];
        }
    }
    
    return _dataList;
}

- (UICollectionView *)collectView
{
    if (nil == _collectView) {

        LineLayout *layout = [[LineLayout alloc] init];
        
        _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 300) collectionViewLayout:layout];
        _collectView.backgroundColor = [UIColor purpleColor];
        _collectView.dataSource = self;
        _collectView.delegate = self;
        [_collectView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:Cell_ReuseIdentifier];

        NSString *kind = NSStringFromClass([SupplementaryView class]);
        [_collectView registerNib:[UINib nibWithNibName:kind bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    }
    
    return _collectView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectView];
    
}

#pragma mark - UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataList.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    Info *model = self.dataList[section];
    return model.descArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Info *model = self.dataList[indexPath.section];
    NSString *info = model.descArray[indexPath.row];
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_ReuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cell.layer.borderWidth = 1;
    
    UILabel *label = [cell viewWithTag:110];
    if (nil == label) {
        label = [UILabel new];
        label.tag = 110;
        label.text = info;
        label.frame = cell.bounds;
        [cell.contentView addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        [cell setHighlighted:YES];
        label.font = [UIFont systemFontOfSize:13.0];
    }
    
    label.text = info;

    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    Info *model = self.dataList[indexPath.section];
    NSString *info = model.descArray[indexPath.row];
    
    CGRect rect = [info boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 50) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} context:nil];
    
    return CGSizeMake(rect.size.width + Padding * 2, 35);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    SupplementaryView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    Info *model = self.dataList[indexPath.section];
    view.label.text = model.title;
    
    return view;
}

@end
