//
//  XMLReader.h
//  ToucanNetwork
//
//  Created by bing wang on 26/9/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    XMLReaderOptionsProcessNamespaces           = 1 << 0, // Specifies whether the receiver reports the namespace and the qualified name of an element.
    XMLReaderOptionsReportNamespacePrefixes     = 1 << 1, // Specifies whether the receiver reports the scope of namespace declarations.
    XMLReaderOptionsResolveExternalEntities     = 1 << 2, // Specifies whether the receiver reports declarations of external entities.
};
typedef NSUInteger XMLReaderOptions;

NS_ASSUME_NONNULL_BEGIN

@interface XMLReader : NSObject <NSXMLParserDelegate>

+ (NSDictionary *)dictionaryForXMLData:(NSData *)data error:(NSError **)errorPointer;

+ (NSDictionary *)dictionaryForXMLString:(NSString *)string error:(NSError **)errorPointer;

+ (NSDictionary *)dictionaryForXMLData:(NSData *)data options:(XMLReaderOptions)options error:(NSError **)errorPointer;

+ (NSDictionary *)dictionaryForXMLString:(NSString *)string options:(XMLReaderOptions)options error:(NSError **)errorPointer;

+ (NSDictionary *)parserToDictionary:(NSXMLParser *)parser error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
