//
//  XMLWriter.m
//  ToucanNetwork
//
//  Created by bing wang on 26/9/18.
//  Copyright © 2018年 bing wang. All rights reserved.
//

#import "XMLWriter.h"

#define PREFIX_STRING_FOR_ELEMENT @"@" //From XMLReader

@implementation XMLWriter

-(void)serialize:(id)root
{
    if([root isKindOfClass:[NSArray class]])
    {
        int mula = (int)[root count];
        mula--;
        [nodes addObject:[NSString stringWithFormat:@"%i",(int)mula]];
        
        for(id objects in root)
        {
            if ([[nodes lastObject] isEqualToString:@"0"] || [nodes lastObject] == NULL || ![nodes count])
            {
                [nodes removeLastObject];
                [self serialize:objects];
            }
            else
            {
                [self serialize:objects];
                if(!isRoot)
                    xml = [xml stringByAppendingFormat:@"</%@><%@>",[treeNodes lastObject],[treeNodes lastObject]];
                else
                    isRoot = FALSE;
                int value = [[nodes lastObject] intValue];
                [nodes removeLastObject];
                value--;
                [nodes addObject:[NSString stringWithFormat:@"%i",(int)value]];
            }
        }
    }
    else if ([root isKindOfClass:[NSDictionary class]])
    {
        for (NSString* key in root)
        {
            if(!isRoot)
            {
                [treeNodes addObject:key];
                xml = [xml stringByAppendingFormat:@"<%@>",key];
                [self serialize:[root objectForKey:key]];
                xml =[xml stringByAppendingFormat:@"</%@>",key];
                [treeNodes removeLastObject];
            } else {
                isRoot = FALSE;
                xml = [xml stringByAppendingFormat:@"<%@>",key];
                [self serialize:[root objectForKey:key]];
                xml =[xml stringByAppendingFormat:@"</%@>",key];
            }
        }
    }
    else if ([root isKindOfClass:[NSString class]] || [root isKindOfClass:[NSNumber class]] || [root isKindOfClass:[NSURL class]])
    {
        //            if ([root hasPrefix:"PREFIX_STRING_FOR_ELEMENT"])
        //            is element
        //            else
        xml = [xml stringByAppendingFormat:@"%@",root];
        
        
    }
}

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        // Initialization code here.
        xml = @"";
        if (withHeader)
            xml = @"<?xml version=\"1.0\" encoding=\"UTF-8\" ?> \n<appNewUser version=\"1.0\" xmlns=\"urn:skylight\"> \n";
        nodes = [[NSMutableArray alloc] init];
        treeNodes = [[NSMutableArray alloc] init];
        isRoot = YES;
        [self serialize:dictionary];
    }
    
    return self;
}
- (id)initWithDictionary:(NSDictionary *)dictionary withHeader:(BOOL)header {
    withHeader = header;
    self = [self initWithDictionary:dictionary];
    return self;
}

-(void)dealloc
{
    //    [xml release],nodes =nil;
    //    [nodes release], nodes = nil ;
    //    [treeNodes release], treeNodes = nil;
    //    [super dealloc];
}

-(NSString *)getXML
{
    xml = [xml stringByReplacingOccurrencesOfString:@"</(null)><(null)>" withString:@"\n"];
    xml = [xml stringByAppendingFormat:@"</appNewUser>"];
    return xml;
}

- (NSString*)convertDictionaryToXML:(NSDictionary*)dictionary withStartElement:(NSString*)startElement isFirstElement:(BOOL) isFirstElement
{
    NSMutableString *xml = [[NSMutableString alloc] initWithString:@""];
    NSArray *arr = [dictionary allKeys];
    if (isFirstElement)
    {
        [xml appendString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"];
    }
    for(int i=0; i < [arr count]; i++)
    {
        NSString *nodeName = [arr objectAtIndex:i];
        id nodeValue = [dictionary objectForKey:nodeName];
        if([nodeValue isKindOfClass:[NSArray class]])
        {
            if([nodeValue count]>0)
            {
                for(int j=0;j<[nodeValue count];j++)
                {
                    id value = [nodeValue objectAtIndex:j];
                    if([value isKindOfClass:[NSDictionary class]])
                    {
                        [xml appendString:[self convertDictionaryToXML:value withStartElement:nodeName isFirstElement:NO]];
                    }
                }
            }
        }
        else if([nodeValue isKindOfClass:[NSDictionary class]])
        {
            [xml appendString:[self convertDictionaryToXML:nodeValue withStartElement:nodeName isFirstElement:NO]];
        }
        else
        {
            [xml appendString:[NSString stringWithFormat:@"<%@>",nodeName]];
            [xml appendString:[NSString stringWithFormat:@"%@",[dictionary objectForKey:nodeName]]];
            [xml appendString:[NSString stringWithFormat:@"</%@>",nodeName]];
        }
    }
    // [xml appendString:[NSString stringWithFormat:@"</%@>\n",startElement]];
    NSString *finalxml=[xml stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    return finalxml;
}


+(NSString *)XMLStringFromDictionary:(NSDictionary *)dictionary
{
    if (![[dictionary allKeys] count])
        return NULL;
    XMLWriter* fromDictionary = [[XMLWriter alloc]initWithDictionary:dictionary];
    return [fromDictionary getXMLNoHeader];
}

+ (NSString *) XMLStringFromDictionary:(NSDictionary *)dictionary withHeader:(BOOL)header {
    if (![[dictionary allKeys] count])
        return NULL;
    XMLWriter* fromDictionary = [[XMLWriter alloc]initWithDictionary:dictionary withHeader:header];
    return [fromDictionary getXML];
}



+ (NSString *) XMLStringFromDictionaryHeader:(NSDictionary *)dictionary withHeader:(BOOL)header name:(NSString*)name {
    if (![[dictionary allKeys] count])
        return NULL;
    XMLWriter* fromDictionary = [[XMLWriter alloc]initWithDictionary:dictionary headerName:name];
    return [fromDictionary getXML:name];
}
-(NSString *)getXMLNoHeader
{
    xml = [xml stringByReplacingOccurrencesOfString:@"</(null)><(null)>" withString:@"\n"];
    return xml;
}
-(NSString *)getXML:(NSString *)name
{
    xml = [xml stringByReplacingOccurrencesOfString:@"</(null)><(null)>" withString:@"\n"];
    xml = [xml stringByAppendingFormat:@"</%@>",name];
    return xml;
}
- (id)initWithDictionary:(NSDictionary *)dictionary headerName:(NSString *)headerName
{
    self = [super init];
    if (self) {
        // Initialization code here.
        xml = @"";
        xml = [NSString stringWithFormat: @"<?xml version=\"1.0\" encoding=\"UTF-8\" ?> \n<%@ version=\"1.0\" xmlns=\"urn:skylight\"> \n",headerName];
        nodes = [[NSMutableArray alloc] init];
        treeNodes = [[NSMutableArray alloc] init];
        isRoot = YES;
        [self serialize:dictionary];
    }
    
    return self;
}
+(BOOL)XMLDataFromDictionary:(NSDictionary *)dictionary toStringPath:(NSString *) path  Error:(NSError **)error
{
    
    XMLWriter* fromDictionary = [[XMLWriter alloc]initWithDictionary:dictionary];
    [[fromDictionary getXML] writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:error];
    if (error)
        return FALSE;
    else
        return TRUE;
    
}



@end
