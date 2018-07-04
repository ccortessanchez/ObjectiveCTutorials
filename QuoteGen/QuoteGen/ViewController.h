//
//  ViewController.h
//  QuoteGen
//
//  Created by Carlos Cortés Sánchez on 07/06/2018.
//  Copyright © 2018 Carlos Cortés Sánchez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, retain) NSArray *myQuotes;
@property (nonatomic, retain) NSMutableArray *movieQuotes;

@property (nonatomic, retain) IBOutlet UITextView *quote_text;

@property (nonatomic, retain) IBOutlet UISegmentedControl *quote_opt;

- (IBAction)quote_btn_touch:(id)sender;

@end

