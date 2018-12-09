//
//  XMLWriter.h
//  ToucanNetwork
//
//  Created by bing wang on 26/9/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMLWriter : NSObject {
@private
    NSMutableArray* nodes;
    NSString* xml;
    NSMutableArray* treeNodes;
    BOOL isRoot;
    NSString* passDict;
    BOOL withHeader;
    NSString *headerName;
}

+(NSString *)XMLStringFromDictionary:(NSDictionary *)dictionary;

+(NSString *)XMLStringFromDictionary:(NSDictionary *)dictionary withHeader:(BOOL)header;

+(BOOL)XMLDataFromDictionary:(NSDictionary *)dictionary toStringPath:(NSString *) path  Error:(NSError **)error;

+ (NSString *) XMLStringFromDictionaryHeader:(NSDictionary *)dictionary withHeader:(BOOL)header name:(NSString*)name;

@end

NS_ASSUME_NONNULL_END
