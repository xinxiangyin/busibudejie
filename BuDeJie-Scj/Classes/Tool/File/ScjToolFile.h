//
//  ScjToolFile.h
//  BuDeJie-Scj
//
//  Created by 施仓健 on 2017/8/1.
//  Copyright © 2017年 施仓健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScjToolFile : NSObject

+ (void)removeDirectoryPath:(NSString *)directoryPath;

+ (void)getFileSizeWithDirectoryPath:(NSString *)directoryPath completion:(void(^)(NSInteger totalSize))completion;

@end
