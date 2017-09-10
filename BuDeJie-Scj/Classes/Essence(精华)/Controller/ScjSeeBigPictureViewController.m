//
//  ScjSeeBigPictureViewController.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/9/5.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjSeeBigPictureViewController.h"
#import "ScjTopic.h"
#import <Photos/Photos.h>
#import <SVProgressHUD.h>

@interface ScjSeeBigPictureViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@property (nonatomic, weak) UIScrollView *scrollV;

@property (nonatomic, weak) UIImageView *imageV;

/** 当前App对应的自定义相册 */
- (PHAssetCollection *)createdCollection;
- (PHFetchResult<PHAsset *> *)createdAssets;
@end

@implementation ScjSeeBigPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollV = [[UIScrollView alloc] init];
    [scrollV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    scrollV.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollV atIndex:0];
    self.scrollV = scrollV;
    
    UIImageView *imageV = [[UIImageView alloc] init];
    [imageV sd_setImageWithURL:[NSURL URLWithString:self.topic.image1] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!image) return ;
        
        self.saveBtn.enabled = YES;
    }];
    imageV.scj_width = scrollV.scj_width;
    imageV.scj_height = imageV.scj_width * self.topic.height / self.topic.width;
    imageV.scj_x = 0;
    if (imageV.scj_height > ScjScreeenH) {
        imageV.scj_y = 0;
        scrollV.contentSize = CGSizeMake(0, imageV.scj_height);
    } else {
        imageV.scj_centerY = scrollV.scj_height * 0.5;
    }
    [scrollV addSubview:imageV];
    self.imageV = imageV;
    
    CGFloat maxScale = self.topic.width / imageV.scj_width;
    if (maxScale > 1) {
        scrollV.maximumZoomScale = maxScale;
        scrollV.delegate = self;
    }
    
}

#pragma mark - <UIScrollViewDelegate>
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageV;//返回要伸缩的控件
}

#pragma mark - 监听点击
- (IBAction)back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)save {
//    UIImageWriteToSavedPhotosAlbum(self.imageV.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    
    PHAuthorizationStatus oldstatus = [PHPhotoLibrary authorizationStatus];
    // 请求\检查访问权限 :
    // 如果用户还没有做出选择，会自动弹框，用户对弹框做出选择后，才会调用block
    // 如果之前已经做过选择，会直接执行block
    /*Info.plist must contain an NSPhotoLibraryUsageDescription key with a string value explaining to the user how the app uses this data.*/
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusDenied) {
                if (oldstatus != PHAuthorizationStatusNotDetermined) {
                    [SVProgressHUD showInfoWithStatus:@"设置-隐私-相册"];
                }
            } else if(status == PHAuthorizationStatusAuthorized){
                [self saveImageIntoAlbum];
            } else if(status == PHAuthorizationStatusRestricted){
                [SVProgressHUD showErrorWithStatus:@"系统原因，无法使用相册"];
            }
        });
    }];
    
}

#pragma mark - 自定义相册

- (void)saveImageIntoAlbum{
    PHFetchResult<PHAsset *> *createdAssets = self.createdAssets;
    if (createdAssets == nil) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败"];
        return;
    }
    PHAssetCollection *createdCollection = self.createdCollection;
    if (createdCollection == nil) {
        [SVProgressHUD showErrorWithStatus:@"创建或者获取相册失败"];
        return;
    }
    NSError *errer =nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        [[PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection] insertAssets:createdAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&errer];
    
    if (errer) {
        [SVProgressHUD showErrorWithStatus:@"保存图片失败"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存图片成功"];
    }
}

- (PHAssetCollection *)createdCollection{
    // 获得软件名字
    NSString *title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];//@"CFBundleName"
    
    // 抓取所有的自定义相册
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    // 查找当前App对应的自定义相册
    for (PHAssetCollection *assetCollection in assetCollections) {
        if ([assetCollection.localizedTitle isEqualToString:title]) {
            return assetCollection;
        }
    }
    
    /** 当前App对应的自定义相册没有被创建过 **/
    // 创建一个【自定义相册】
    NSError *errer = nil;
    __block NSString *creatCollectionID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        creatCollectionID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
    } error:&errer];
    
    if (errer) {
        [SVProgressHUD showErrorWithStatus:@"创建失败"];
        return nil;
    }
    
    // 根据唯一标识获得刚才创建的相册
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[creatCollectionID] options:nil].firstObject;
}

- (PHFetchResult<PHAsset *> *)createdAssets{
    NSError *error = nil;
    __block NSString *creatAssetID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        creatAssetID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageV.image].placeholderForCreatedAsset.localIdentifier;
    } error:&error];
    if (error) return nil;
    
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[creatAssetID] options:nil];
}

#pragma mark - 自定义相册知识点
/*
 一、保存图片到【自定义相册】
 1.保存图片到【相机胶卷】
 1> C语言函数UIImageWriteToSavedPhotosAlbum
 2> AssetsLibrary框架
 3> Photos框架
 
 2.拥有一个【自定义相册】
 1> AssetsLibrary框架
 2> Photos框架
 
 3.添加刚才保存的图片到【自定义相册】
 1> AssetsLibrary框架
 2> Photos框架
 
 二、Photos框架须知
 1.PHAsset : 一个PHAsset对象就代表相册中的一张图片或者一个视频
 1> 查 : [PHAsset fetchAssets...]
 2> 增删改 : PHAssetChangeRequest(包括图片\视频相关的所有改动操作)
 
 2.PHAssetCollection : 一个PHAssetCollection对象就代表一个相册
 1> 查 : [PHAssetCollection fetchAssetCollections...]
 2> 增删改 : PHAssetCollectionChangeRequest(包括相册相关的所有改动操作)
 
 3.对相片\相册的任何【增删改】操作，都必须放到以下方法的block中执行
 -[PHPhotoLibrary performChanges:completionHandler:]
 -[PHPhotoLibrary performChangesAndWait:error:]
 */

/*
 Foundation和Core Foundation的数据类型可以互相转换，比如NSString *和CFStringRef
 NSString *string = (__bridge NSString *)kCFBundleNameKey;
 CFStringRef string = (__bridge CFStringRef)@"test";
 
 获得相机胶卷相册
 [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil]
 */

/*
 错误信息：This method can only be called from inside of -[PHPhotoLibrary performChanges:completionHandler:] or -[PHPhotoLibrary performChangesAndWait:error:]
 // 异步执行修改操作
 [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
 [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image];
 } completionHandler:^(BOOL success, NSError * _Nullable error) {
 if (error) {
 [SVProgressHUD showErrorWithStatus:@"保存失败！"];
 } else {
 [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
 }
 }];
 
 // 同步执行修改操作
 NSError *error = nil;
 [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
 [PHAssetChangeRequest creationRequestForAssetFromImage:self.imageView.image];
 } error:&error];
 if (error) {
 [SVProgressHUD showErrorWithStatus:@"保存失败！"];
 } else {
 [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
 }
 
 */
@end
