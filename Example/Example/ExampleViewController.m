#import "ExampleViewController.h"

@interface UIColor (NiceColors)

+ (UIColor *)flatBelizeHoleColor;

+ (UIColor *)flatPeterRiverColor;

@end

@implementation UIColor (NiceColors)

+ (UIColor *)flatBelizeHoleColor
{
    return [UIColor colorWithRed:0.1607843137254902
                           green:0.5019607843137255
                            blue:0.7254901960784313
                           alpha:1];
}

+ (UIColor *)flatPeterRiverColor
{
    return [UIColor colorWithRed:0.20392156862745098
                           green:0.596078431372549
                            blue:0.8588235294117647
                           alpha:1];
}

@end

#pragma mark -

@import UICollectionViewLeftAlignedLayout;

static NSString * const kCellIdentifier = @"CellIdentifier";
static BOOL kShouldRefresh = NO;

@interface ExampleViewController () <UICollectionViewDataSource, UICollectionViewDelegateLeftAlignedLayout>

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation ExampleViewController

- (instancetype)init
{
    return [super initWithNibName:@"ExampleViewController" bundle:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    self.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.titleLabel.textColor = [UIColor flatBelizeHoleColor];

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];

    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];

    [self.view addSubview:self.collectionView];

    if (kShouldRefresh) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self.collectionView selector:@selector(reloadData) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [self.timer invalidate];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return section == 0 ? 20 : 80;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];

    cell.contentView.layer.borderColor = [UIColor flatPeterRiverColor].CGColor;
    cell.contentView.layer.borderWidth = 2;

    return cell;
}

#pragma mark - UICollectionViewDelegateLeftAlignedLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat randomWidth = (arc4random() % 120) + 60;
    return CGSizeMake(randomWidth, 60);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return section == 0 ? 15 : 5;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark -

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
