//
//  RootViewController.m
//  NavigationBasedJSON
//
//  Created by Swe Win on 04/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set up the edit and add buttons.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
    
    // Step 1
    website = @"http://swezin.com/foo_bars.json";
    NSString *s =website;
    NSLog(@"%@", s);
//    NSlog(@"website %@", website);
    
    NSString *myRawJSON = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:website]];
//    SBJsonStreamParser *request = [[SBJsonStreamParser alloc]init];
//    NSString *authenticityToken = [[request responseHeaders] objectForKey:@"X-Authenticity-Token"];

    if([myRawJSON length] == 0){
        [myRawJSON release];
        return;
    }
    
    // Step 2 
    _parser = [[SBJsonParser alloc] init];
    list = [[_parser objectWithString:myRawJSON error:nil] copy];
    NSLog(@"list %@", list);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    // Configure the cell.
    NSMutableString *text = [NSMutableString stringWithString:@"\n"];
    NSDictionary *dictionary = [list objectAtIndex:indexPath.row];
    [text appendFormat:@"%@", [dictionary objectForKey:@"foo"]];
	[text appendFormat:@":%@", [dictionary objectForKey:@"bar"]];
    cell.textLabel.text = text;  
    
    
/*    NSMutableString *text = [NSMutableString stringWithString:@"\n"];
    for (int i = 0; i < [list count]; i++){
        NSDictionary *dictionary = [list objectAtIndex:i];
        
		[text appendFormat:@"Foo=%@\n", [dictionary objectForKey:@"foo"]];
		[text appendFormat:@"Bar=%@\n", [dictionary objectForKey:@"bar"]];
        
    }
    
    cell.textLabel.text = text;
//    NSString *record =[list objectAtIndex:0];
    
    NSDictionary *dictionary = [list objectAtIndex:0];
    
    NSLog(@"index 0 %@", dictionary);
    NSLog(@"Dictionary value for \"foo\" is \"%@\"", [dictionary objectForKey:@"foo"]);
    
    NSLog(@"index 1 %@", [list objectAtIndex:1]);

    NSLog(@"index 2 %@", [list objectAtIndex:2]);

//    cell.textLabel.text = [list objectAtIndex:1]; //[list objectAtIndex:indexPath.row];
    //cell.textLabel.text = @"Hello World";//[list objectAtIndex:indexPath.row];
    //NSLog(@"cell.textLabel.textG: %@" , cell.textLabel.text);
*/
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"CLick Delete button");
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the managed object for the given index path
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        // Save the context.
        NSError *error = nil;
        if (![context save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            //abort();
            
            // find by id
            // delete
            // post delete
/*            NSDictionary*foo_bar = [[NSDictionary alloc] initWithObjectsAndKeys:
                                @"BMW",@"foo",
                                @"123",@"bar",
                                nil];

            NSDictionary*obj = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     @"BMW",@"foo_bar",
                                     nil];
            
            NSMutableString *httpBodyString=[[NSMutableString alloc] initWithString:@"foo_bar=The Big Bopper"];
            
            NSString *content = [@"foo=" stringByAppendingString:@"Something to Post"];
            NSLog(@"content %@", content);
            NSURL *url = [NSURL URLWithString:@"http://swezin.com/foo_bars/create"];
            NSMutableURLRequest* urlRequest = [[NSMutableURLRequest alloc] initWithURL:url];
            [urlRequest setHTTPMethod:@"POST"];
            [urlRequest setHTTPBody:[httpBodyString dataUsingEncoding:
                                     NSASCIIStringEncoding]];            
            NSDictionary*cardict1 = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     @"BMW",@"name",
                                     @"123",@"number",
                                     @"1",@"carid",	
                                     nil];
            
            NSDictionary*cardict2 = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     @"Honda",@"name",
                                     @"123",@"number",
                                     @"2",@"carid",	
                                     nil];
            
            NSArray *arr = [[NSArray alloc] initWithObjects: cardict1, cardict2,nil];
            
            
            
            SBJsonWriter *writer = [[SBJsonWriter alloc] init];
            NSString *jsonConvertedObj = [[writer stringWithObject:obj] copy];
            NSLog(@"%@", jsonConvertedObj);
            [urlRequest setHTTPMethod:@"POST"];
            [urlRequest setHTTPBody:[jsonConvertedObj dataUsingEncoding:
                                     NSASCIIStringEncoding]];            
*/  
            
        }
    }   
}

- (void)insertNewObject
{
/*    
    NSMutableDictionary* post_dict = [[NSMutableDictionary alloc] initWithCapacity:1];
    [post_dict setObject:@"test_value" forKey:@"test_key"];
//    [post_dict setObject:[NSURL fileURLWithPath:@"/Butterfly.tif"] forKey:@"file1"];
    NSData* regData = [self generateFormData:post_dict];
    [post_dict release];
    NSLog(@"%@", regData);
    NSMutableURLRequest* post = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:website]];
    [post addValue: @"multipart/form-data; boundary=_insert_some_boundary_here_" forHTTPHeaderField: @"Content-Type"];
    [post setHTTPMethod: @"POST"];
    [post setHTTPBody:regData];
    NSURLResponse* response;
    NSError* error;
    NSData* result = [NSURLConnection sendSynchronousRequest:post returningResponse:&response error:&error];
    NSLog(@"%@", [[[NSString alloc] initWithData:result encoding:NSASCIIStringEncoding] autorelease]);
  */  
    
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

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSLog(@"CLick move Row");

}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    NSLog(@"CLick canMoveRow");
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath");
/*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"Nib name" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
*/
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [_parser release];    
    [_writer release];
    [super dealloc];
}

     + (NSString *) encodeFormPostParameters: (NSDictionary *) parameters {
         NSMutableString *formPostParams = [[[NSMutableString alloc] init] autorelease];
         
         NSEnumerator *keys = [parameters keyEnumerator];
         
         NSString *name = [keys nextObject];
         while (nil != name) {
             NSString *encodedValue = [((NSString *) CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef) [parameters objectForKey: name], NULL, CFSTR("=/:"), kCFStringEncodingUTF8)) autorelease];
             
             [formPostParams appendString: name];
             [formPostParams appendString: @"="];
             [formPostParams appendString: encodedValue];
             
             name = [keys nextObject];
             
             if (nil != name) {
                 [formPostParams appendString: @"&"];
             }
         }
         
         return formPostParams;
     }
/*     
     - (void) setFormPostParameters: (NSDictionary *) parameters {
         NSString *formPostParams = [NSMutableURLRequest encodeFormPostParameters: parameters];
         
         [self setHTTPBody: [formPostParams dataUsingEncoding: NSUTF8StringEncoding]];
         [self setValue: @"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField: @"Content-Type"];
     }
*/    

- (NSData*)generateFormData:(NSDictionary*)dict
{
	NSString* boundary = [NSString stringWithString:@"_insert_some_boundary_here_"];
	NSArray* keys = [dict allKeys];
	NSMutableData* result = [[NSMutableData alloc] initWithCapacity:100];
    
	int i;
	for (i = 0; i < [keys count]; i++) 
	{
		id value = [dict valueForKey: [keys objectAtIndex: i]];
		[result appendData:[[NSString stringWithFormat:@"--%@\n", boundary] dataUsingEncoding:NSASCIIStringEncoding]];
		if ([value class] == [NSString class] || [value class] == [NSConstantString class])
		{
			[result appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\n\n", [keys objectAtIndex:i]] dataUsingEncoding:NSASCIIStringEncoding]];
			[result appendData:[[NSString stringWithFormat:@"%@",value] dataUsingEncoding:NSASCIIStringEncoding]];
		}
		else if ([value class] == [NSURL class] && [value isFileURL])
		{
//			[result appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\n", [keys objectAtIndex:i], [[value path] lastPathComponent]] dataUsingEncoding:NSASCIIStringEncoding]];
			[result appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; \n", [keys objectAtIndex:i]] dataUsingEncoding:NSASCIIStringEncoding]];            
			[result appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\n\n"] dataUsingEncoding:NSASCIIStringEncoding]];
			[result appendData:[NSData dataWithContentsOfFile:[value path]]];
		}
		[result appendData:[[NSString stringWithString:@"\n"] dataUsingEncoding:NSASCIIStringEncoding]];
	}
	[result appendData:[[NSString stringWithFormat:@"--%@--\n", boundary] dataUsingEncoding:NSASCIIStringEncoding]];
	
	return [result autorelease];
}

+(NSData *)dataForPOSTWithDictionary:(NSDictionary *)aDictionary boundary:(NSString *)aBoundary {
    NSArray *myDictKeys = [aDictionary allKeys];
    NSMutableData *myData = [NSMutableData dataWithCapacity:1];
    NSString *myBoundary = [NSString stringWithFormat:@"--%@\r\n", aBoundary];
    
    for(int i = 0;i < [myDictKeys count];i++) {
        id myValue = [aDictionary valueForKey:[myDictKeys objectAtIndex:i]];
        [myData appendData:[myBoundary dataUsingEncoding:NSUTF8StringEncoding]];
        //if ([myValue class] == [NSString class]) {
        if ([myValue isKindOfClass:[NSString class]]) {
            [myData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", [myDictKeys objectAtIndex:i]] dataUsingEncoding:NSUTF8StringEncoding]];
            [myData appendData:[[NSString stringWithFormat:@"%@", myValue] dataUsingEncoding:NSUTF8StringEncoding]];
        } else if(([myValue isKindOfClass:[NSURL class]]) && ([myValue isFileURL])) {
            [myData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", [myDictKeys objectAtIndex:i], [[myValue path] lastPathComponent]] dataUsingEncoding:NSUTF8StringEncoding]];
            [myData appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [myData appendData:[NSData dataWithContentsOfFile:[myValue path]]];
        } else if(([myValue isKindOfClass:[NSData class]])) {
            [myData appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", [myDictKeys objectAtIndex:i], [myDictKeys objectAtIndex:i]] dataUsingEncoding:NSUTF8StringEncoding]];
            [myData appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [myData appendData:myValue];
        } // eof if()
        
        [myData appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    } // eof for()
    [myData appendData:[[NSString stringWithFormat:@"--%@--\r\n", aBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    return myData;
} // eof dataForPOSTWithDictionary:boundary:

@end
