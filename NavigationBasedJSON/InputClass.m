//
//  InputClass.m
//  NavigationBasedJSON
//
//  Created by Swe Win on 05/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InputClass.h"
#import "JSON.h"
@implementation InputClass

-(IBAction)form_submit{
    float x = ([textField1.text floatValue]);
    float c = x*([textField2.text floatValue]);
    label.text = [[NSString alloc] initWithFormat:@"%g", c];                  
    SBJsonWriter *_writer;
    NSString *website;
    website = @"http://swezin.com/foo_bars.json";
    

    _writer = [[SBJsonWriter alloc] init];
    _writer.humanReadable = YES;
    _writer.sortKeys = YES;
    NSMutableString *httpBodyString;
    NSURL *url;
    NSMutableString *urlString;
    
    httpBodyString=[[NSMutableString alloc] initWithString:@"foo=fooooooo&bar=baarrrrrrrrrrrrrr"];
    NSDictionary *foo = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"fooooo value", @"foo", @"barr value2", @"bar", nil];    
    //NSArray *foo_bar = [NSArray arrayWithObjects:@"foo_bar", nil];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:foo forKey:@"foo_bar"];
    NSString* jsonString = [dict JSONRepresentation];
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *body = [NSString stringWithFormat:@"foo=%@&bar=%@", @"foooooo", @"barrrrrrr"];
    NSData *bodyData = [body dataUsingEncoding:NSUTF8StringEncoding]; 
    
    //NSMutableString *dict = [[NSMutableString alloc] initWithData:<#(NSData *)#> encoding:<#(NSStringEncoding)#>
    
    urlString=[[NSMutableString alloc] initWithString:website];
    url=[[NSURL alloc] initWithString:urlString];
    [urlString release];
    NSMutableURLRequest *urlRequest=[NSMutableURLRequest requestWithURL:url];
    [url release];
    
    [urlRequest setHTTPMethod:@"POST"];
    //    [urlRequest setHTTPBody:jsonData];  //jsonData // dict // body // bodyData //httpBodyString
    [urlRequest setHTTPBody: [httpBodyString dataUsingEncoding: NSUTF8StringEncoding]];
    
    //[urlRequest setValue:jsonString forHTTPHeaderField:@"json"];
    
    // NSString *formPostParams = [NSMutableURLRequest encodeFormPostParameters: dict];
    // [urlRequest setHTTPMethod:@"POST"];
    //    NSString *body = [NSString stringWithFormat:@"{\"foo_bar\":{\"foo\":\"%@\",\"bar\":\"%@\"}}", @"foooooo", @"barrrrrrr"];
    //[urlRequest setHTTPBody: [formPostParams dataUsingEncoding: NSUTF8StringEncoding]];
    //[urlRequest setValue: @"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField: @"Content-Type"];
    
    //    [urlRequest setHTTPBody:jsonData];
    
    //    [urlRequest setValue:[NSString stringWithFormat:@"%u", [bodyData length]] forHTTPHeaderField:@"Content-Length"];  
    //
    //    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];  
    
    //    [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:NSISOLatin1StringEncoding]];
    //[urlRequest setHTTPBody:[NSData dataWithBytes:jsonString length:[jsonString count]]];
    
    
    [httpBodyString release];
    
    NSURLConnection *connectionResponse = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    
    if (!connectionResponse)
    {
        NSLog(@"Failed to submit request");
    }
    else
    {
        NSLog(@"--------- Request submitted ---------");
        NSLog(@"connection: %@ method: %@, encoded body: %@, body: %a", connectionResponse, [urlRequest HTTPMethod], [urlRequest HTTPBody], httpBodyString);
        NSLog(@"New connection retain count: %d", [connectionResponse retainCount]);
        NSMutableData *responseData=[[NSMutableData data] retain];
        NSLog(@"response", responseData);
    }            
    
}

-(IBAction)clear{
    textField1.text = @"";
    textField2.text = @"";
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
