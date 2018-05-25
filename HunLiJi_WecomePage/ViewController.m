//
//  ViewController.m
//  HunLiJi_WecomePage
//
//  Created by DR_Kun on 2018/5/17.
//  Copyright © 2018年 DR_Kun. All rights reserved.
//

#import "ViewController.h"
#import "WecomePageFlowLayout.h"
#import "WecomePageCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet WecomePageFlowLayout *flowLayout;

@property (nonatomic, copy) NSArray *imagesArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.flowLayout.itemSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds),CGRectGetHeight([UIScreen mainScreen].bounds));
    self.flowLayout.minimumLineSpacing = 0;
    //注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"WecomePageCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"WecomePageCellID"];
}

- (NSArray *)imagesArray {
    if (!_imagesArray) {
        self.imagesArray = @[@"1", @"2", @"3", @"4"];
//        self.imagesArray = @[@"1", @"2", @"3"];
    }
    return _imagesArray;
}

#pragma mark --- UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imagesArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WecomePageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WecomePageCellID" forIndexPath:indexPath];

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    WecomePageCell *wCell = (WecomePageCell *)cell;
    NSString *imageName = self.imagesArray[indexPath.item];
    [wCell updateImage:[UIImage imageNamed:imageName]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
