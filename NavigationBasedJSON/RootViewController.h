//
//  RootViewController.h
//  NavigationBasedJSON
//
//  Created by Swe Win on 04/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "JSON.h"


@interface RootViewController : UITableViewController{
    NSArray *list;
    NSString *connection;
    //NSString *myRawJSON;
    SBJsonParser *_parser;
    SBJsonWriter *_writer;
    NSString *website;
}
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

+ (NSString *) encodeFormPostParameters: (NSDictionary *) parameters;
- (void) setFormPostParameters: (NSDictionary *) parameters;
- (NSData*)generateFormData:(NSDictionary*)dict;
+(NSData *)dataForPOSTWithDictionary:(NSDictionary *)aDictionary boundary:(NSString *)aBoundary;



@end
