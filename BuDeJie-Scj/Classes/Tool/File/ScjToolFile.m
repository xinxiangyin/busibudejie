//
//  ScjToolFile.m
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/8/1.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import "ScjToolFile.h"

@implementation ScjToolFile

+ (void)removeDirectoryPath:(NSString *)directoryPath{
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    BOOL isDirectory;
    
    BOOL isFileExists = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (! isFileExists || ! isDirectory) {
        NSException *exp = [NSException exceptionWithName:@"pathError" reason:@"你输入的路径，不存在或不是文件夹路径" userInfo:nil];
        [exp raise];
    }
    
    NSArray *subPaths = [mgr contentsOfDirectoryAtPath:directoryPath error:nil];
    
    for (NSString *subPath in subPaths) {
        NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
        [mgr removeItemAtPath:filePath error:nil];
    }
}

+ (void)getFileSizeWithDirectoryPath:(NSString *)directoryPath completion:(void(^)(NSInteger totalSize))completion{
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    BOOL isDirectory;
    
    BOOL isFileExists = [mgr fileExistsAtPath:directoryPath isDirectory:&isDirectory];
    
    if (!isFileExists || !isDirectory) {
        NSException *exp = [NSException exceptionWithName:@"pathError" reason:@"你输入的路径，不存在或不是文件夹路径" userInfo:nil];
        [exp raise];
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSInteger totalSize = 0;
        
        NSArray *subPaths = [mgr subpathsOfDirectoryAtPath:directoryPath error:nil];
        
        for (NSString *subPath in subPaths) {
            
            NSString *filePath = [directoryPath stringByAppendingPathComponent:subPath];
            
            if ([filePath containsString:@".DS"]) continue;
            
            BOOL isDirectory;
            
            BOOL isFileExists = [mgr fileExistsAtPath:filePath isDirectory:&isDirectory];
            
            if (!isFileExists || isDirectory) continue;
            
            NSDictionary *attr = [mgr attributesOfItemAtPath:filePath error:nil];
            
            NSInteger fileSize = [attr fileSize];
            
            totalSize += fileSize;
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            if (completion) {
                completion(totalSize);
            }
        });
        
    });
    
    
    
}

@end
