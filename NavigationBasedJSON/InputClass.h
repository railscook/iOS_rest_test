//
//  InputClass.h
//  NavigationBasedJSON
//
//  Created by Swe Win on 05/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface InputClass : InputViewController{
    IBOutlet UITextField *textField1;
    IBOutlet UITextField *textField2;
    IBOutlet UILabel *label;
    
}



-(IBAction)calculate;
-(IBAction)clear;
@end
