//
//  ViewController.m
//  QuoteGen
//
//  Created by Carlos Cortés Sánchez on 07/06/2018.
//  Copyright © 2018 Carlos Cortés Sánchez. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize myQuotes;
@synthesize movieQuotes;
@synthesize quote_text;
@synthesize quote_opt;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.myQuotes = [NSArray arrayWithObjects:
                     @"Live and let live",
                     @"Don't cry over spilt milk",
                     @"Always look on the bright side of life",
                     @"Nobody's perfect",
                     @"Can't see the woods for the trees",
                     @"Better to have loved and lost than not loved at all",
                     @"The early bird catches the worm",
                     @"As slow as a wet week",
                     nil];
    
    // Load movie quotes
    NSString *plistCatPath = [[NSBundle mainBundle] pathForResource:@"quotes" ofType:@"plist"];
    self.movieQuotes = [[NSMutableArray arrayWithContentsOfFile: plistCatPath] copy];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    myQuotes = nil;
    movieQuotes = nil;
    quote_text = nil;
    quote_opt = nil;
}

- (IBAction)quote_btn_touch:(id)sender {
    // Get personal quotes when final segment is selected
    if (self.quote_opt.selectedSegmentIndex == 2) {
        // Get number of rows in array
        int array_tot = [self.myQuotes count];
        // Get random index
        //int index = (arc4random() % array_tot);
        // Get the quote string for the index
        //NSString *my_quote = [self.myQuotes objectAtIndex:index];
        NSString *all_my_quotes = @"";
        // Iterate through array
        for (int x= 0; x < array_tot; x++) {
            NSString *my_quote = [self.myQuotes objectAtIndex:x];
            all_my_quotes = [NSString stringWithFormat:@"%@\n%@\n",  all_my_quotes,my_quote];
        }
        // Display the quote on the text view
        self.quote_text.text = [NSString stringWithFormat:@"%@", all_my_quotes];
    }
    // Get movie quotes
    else {
        // Determine category
        NSString *selectedCategory = @"classic";
        if (self.quote_opt.selectedSegmentIndex == 1) {
            selectedCategory = @"modern";
        }
        // Filter array by category using predicate
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category == %@", selectedCategory];
        NSArray *filteredArray = [self.movieQuotes filteredArrayUsingPredicate:predicate];
        // Get total number in filtered array
        int array_tot = [filteredArray count];
        // As a safeguard only get quote when the array has rows in it
        if (array_tot > 0) {
            // Get random index
            int index = (arc4random() % array_tot);
            // Get the quote string for the index
            NSString *quote = [[filteredArray objectAtIndex:index] valueForKey:@"quote"];
            // Check if there is a source
            NSString *source = [[filteredArray objectAtIndex:index] valueForKey:@"source"];
            if (![source length] == 0) {
                quote = [NSString stringWithFormat:@"%@\n\n(%@)",  quote, source];
            }
            // Customize quote based on category
            if ([selectedCategory isEqualToString:@"classic"]) {
                quote = [NSString stringWithFormat:@"From Classic Movie\n\n%@",  quote];
            } else {
                quote = [NSString stringWithFormat:@"Movie Quote:\n\n%@",  quote];
            }
            // Display quote
            self.quote_text.text = quote;
            // Update row to indicate it has been displayed
            int movie_array_tot = [self.movieQuotes count];
            NSString *quote1 = [[filteredArray objectAtIndex:index] valueForKey:@"quote"];
            for (int x=0; x < movie_array_tot; x++) {
                NSString *quote2 = [[movieQuotes objectAtIndex:x] valueForKey:@"quote"];
                if ([quote1 isEqualToString:quote2]) {
                    NSMutableDictionary *itemAtIndex = (NSMutableDictionary *)[movieQuotes objectAtIndex:x];
                    [itemAtIndex setValue:@"DONE" forKey:@"source"];
                }
            }
        } else {
            // Display the quote on the text view
            self.quote_text.text = [NSString stringWithFormat:@"No quotes to display"];
        }
    }
}

@end
