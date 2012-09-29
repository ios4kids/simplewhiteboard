//
//  FilePathMethods.m
//  SimpleWhiteboard
//
//  Created by Alberto Morales on 9/9/12.
//  Copyright (c) 2012 Alberto Morales. All rights reserved.
//

#import "FilePathMethods.h"

@implementation FilePathMethods


+ (NSString *)documentsPathForFileName:(NSString *)name
{
    NSString *documentsPath = [FilePathMethods documentsPath];
    return [documentsPath stringByAppendingPathComponent:name];
}

+(NSString *) documentsPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}


+(NSArray *) getSavedImageNames
{
    NSString *path = [FilePathMethods documentsPath];
    NSArray *directoryContent = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:NULL];
    return directoryContent;
}

+(UIImage *) getImageNamed:(NSString *)imageName {
    NSString *filePath = [FilePathMethods documentsPathForFileName:imageName];
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    
    return [UIImage imageWithData:pngData];
}


+(void) deleteImageNamed:(NSString *)imageName {
    NSError *error;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString * filepath = [FilePathMethods documentsPathForFileName:imageName];
    [fileMgr removeItemAtPath:filepath error:&error];
}

@end
