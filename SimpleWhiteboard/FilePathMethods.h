//
//  FilePathMethods.h
//  SimpleWhiteboard
//
//  Created by Alberto Morales on 9/9/12.
//  Copyright (c) 2012 Alberto Morales. All rights reserved.
//
//  Misc file system methods

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FilePathMethods : NSObject

+ (NSString *)documentsPathForFileName:(NSString *)name; //path for a new file to store

+ (NSString *) documentsPath; //base path where this app will store files

+ (NSArray *) getSavedImageNames; //array showing the list of files in this path

+ (UIImage *) getImageNamed:(NSString *) imageName;

+(void) deleteImageNamed:(NSString *) imageName;

@end
