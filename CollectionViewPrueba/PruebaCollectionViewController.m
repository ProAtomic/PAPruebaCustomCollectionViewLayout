//
//  PruebaCollectionViewController.m
//  CollectionViewPrueba
//
//  Created by Guillermo Saenz on 4/9/15.
//  Copyright (c) 2015 Property Atomic Strong SAC. All rights reserved.
//

#import "PruebaCollectionViewController.h"

#import "UIColor+ExtraColors.h"

#import "PruebaLayout.h"

@interface PruebaCollectionViewController () <PruebaLayoutDelegate>

@property (weak, nonatomic) IBOutlet PruebaLayout *pruebaLayout;

@end

@implementation PruebaCollectionViewController{
	CGFloat _widthCelda;
}

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
	PruebaLayout *layout = (PruebaLayout*)self.collectionView.collectionViewLayout;
	[layout setInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
	
	_widthCelda = (self.collectionView.bounds.size.width-layout.insets.left-layout.insets.right-(layout.spaceBetweenCellsHorizontal*2))/3;
    // Do any additional setup after loading the view.
}

- (UIStatusBarStyle)preferredStatusBarStyle{
	return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    [self.pruebaLayout invalidateLayout];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator{
    [self.pruebaLayout invalidateLayout];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
	
	cell.contentView.backgroundColor = [UIColor randomColorWithAlpha:1.0f];
	
	return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width = (self.collectionView.bounds.size.width-self.pruebaLayout.insets.left-self.pruebaLayout.insets.right-(self.pruebaLayout.spaceBetweenCellsHorizontal*2))/3;
    NSLog(@"Width: %f", width);
    if (indexPath.item==0) {
        return CGSizeMake((width*2)+self.pruebaLayout.spaceBetweenCellsHorizontal, 300+self.pruebaLayout.spaceBetweenCellsVertical);
    }else{
        return CGSizeMake(width, 150);
    }
    /*
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        if (indexPath.item==0) {
            return CGSizeMake((width*2)+self.pruebaLayout.spaceBetweenCellsHorizontal, 300+self.pruebaLayout.spaceBetweenCellsVertical);
        }else{
            return CGSizeMake(width, 150);
        }
    }else{
        if (indexPath.item==0) {
            return CGSizeMake((width*2)+self.pruebaLayout.spaceBetweenCellsHorizontal, 300+self.pruebaLayout.spaceBetweenCellsVertical);
        }else{
            return CGSizeMake(width, 150);
        }
    }*/
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
