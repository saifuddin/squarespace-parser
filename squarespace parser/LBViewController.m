//
//  LBViewController.m
//  squarespace parser
//
//  Created by saifuddin on 2/10/13.
//  Copyright (c) 2013 saifuddin. All rights reserved.
//

#import "LBViewController.h"
#import "XPathQuery.h"

@interface LBViewController ()
@end

@implementation LBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"blog_response" ofType:@"json"];
    NSString *jsonString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    id obj = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
    NSString *htmlBody = [[obj objectForKey:@"item"] objectForKey:@"body"];
    
    NSData *data = [htmlBody dataUsingEncoding:NSUTF8StringEncoding];

    NSArray *htmlArr = PerformHTMLXPathQuery(data, @"//div[@class='sqs-block-content']");
    NSString *subtitle = [[htmlArr[0] objectForKey:@"nodeChildArray"][0] objectForKey:@"nodeContent"];
    NSString *body = [[htmlArr[0] objectForKey:@"nodeChildArray"][1] objectForKey:@"nodeContent"];
    htmlArr = PerformHTMLXPathQuery(data, @"//img[@src]");
    NSString *imgURL = [[htmlArr[0] objectForKey:@"nodeAttributeArray"][0] objectForKey:@"nodeContent"];
    NSLog(@"subtitle = %@\nbody = %@\nimgURL = %@",subtitle,body,imgURL);
}

@end
