//
//  TodayViewController.m
//  NotiGoogle
//
//  Created by Virindh Borra on 8/6/14.
//  Copyright (c) 2014 Virindh Borra. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController
//Synthesize the text field
@synthesize googleTextField;

-(void)viewDidLoad
{
    //Set the content size so that the widget actually shows up
    self.preferredContentSize = CGSizeMake(320, 80);

    //Set the delegate to the text field
    googleTextField.delegate = self;
}

//Completion handler for widget
- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult result))completionHandler {
    // Update your data and prepare for a snapshot. Call completion handler when you are done
    // with NoData if nothing has changed or NewData if there is new data since the last
    // time we called you
    completionHandler(NCUpdateResultNoData);
}

//Delegate method to indicate that search query has been entered
- (void)controlTextDidEndEditing:(NSNotification *)aNotification
{
   
    NSDictionary *dict  = [aNotification userInfo];  //get the user info dictionary object from the notification
    NSNumber  *reason = [dict objectForKey: @"NSTextMovement"]; //get the text movement value from the dictionary
    int code = [reason intValue];// get the integer value of the movement code
    
    //Compare the code to the enter key, if it is the enter key, then search
    if (code == NSReturnTextMovement)
    {
        //Get the Serach Query
        NSString *textField = googleTextField.stringValue;
        
        //Make the query ready for URLs
        textField = [textField stringByReplacingOccurrencesOfString:@" " withString:@"+"];
        
        //Create the string for the search URL, Google for now
        NSString *googleURLSTring = [NSString stringWithFormat:@"https://www.google.com/search?q=%@", textField];
        
        //Search
        [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:googleURLSTring]];
    }
}
@end

