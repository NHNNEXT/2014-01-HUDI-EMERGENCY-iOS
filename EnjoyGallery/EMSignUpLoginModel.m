//
//  EMSignUpLoginModel.m
//  EnjoyGallery
//
//  Created by LeeYoungNam on 4/20/14.
//  Copyright (c) 2014 EntusApps. All rights reserved.
//

#import "EMSignUpLoginModel.h"

@implementation EMSignUpLoginModel


- (void)testParsingJSON
{
    NSString *jsonString = @"{\"name\":\"saltfactory\",\"e-mail\":\"saltfactory@gmail.com\"}";
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *jsonInfo = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    NSAssert([[jsonInfo valueForKey:@"name"] isEqualToString:@"saltfactory"], @"not equals");
}

- (void)testGeneratingJSON
{
    NSError *error;
    NSString *jsonInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"saltfactory",@"name",@"saltfactory@gmail.com",@"e-mail", nil];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonInfo options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"jsonString => %@", jsonString);
}

@end
