//
//  iSwim_ConverterViewController.m
//  iSwim Converter
//
//  Created by Tony Florida on 6/10/10.
//  Copyright Raddfood 2010. All rights reserved.
//

#import "iSwim_ConverterViewController.h"

@implementation iSwim_ConverterViewController
@synthesize inputTime, segmentedControl, outputcourse, gender, finalTime;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	[super viewDidLoad];	
	minute = [[NSArray alloc] initWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"38", @"39", @"40", @"41", @"42", @"43", @"44", @"45", @"46", @"47", @"48", @"49", @"50", @"51", @"52", @"53", @"54", @"55", @"56", @"57", @"58", @"59", nil ];
	second = [[NSArray alloc] initWithObjects:@"00", @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"38", @"39", @"40", @"41", @"42", @"43", @"44", @"45", @"46", @"47", @"48", @"49", @"50", @"51", @"52", @"53", @"54", @"55", @"56", @"57", @"58", @"59", nil];
	hundred = [[NSArray alloc] initWithObjects:@"00", @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"38", @"39", @"40", @"41", @"42", @"43", @"44", @"45", @"46", @"47", @"48", @"49", @"50", @"51", @"52", @"53", @"54", @"55", @"56", @"57", @"58", @"59", @"60", @"61", @"62", @"63", @"64", @"65", @"66", @"67", @"68", @"69", @"70", @"71", @"72", @"73", @"74", @"75", @"76", @"77", @"78", @"79", @"80", @"81", @"82", @"83", @"84", @"85", @"86", @"87", @"88", @"89", @"90", @"91", @"92", @"93", @"94", @"95", @"96", @"97", @"98", @"99", nil];
	stroke = [[NSArray alloc ] initWithObjects:@"50 Free", @"100 Free", @"200 Free", @"400/500 Free", @"800/1000 Free", @"1500/1650 Free", @"100 Fly", @"200 Fly", @"100 Back", @"200 Back", @"100 Breast", @"200 Breast", @"200 IM", @"400 IM", nil ];
}

//IDK
- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	selectedUnit = segmentedControl.selectedSegmentIndex;
	selectedCourse = outputcourse.selectedSegmentIndex;
	selectedGender = gender.selectedSegmentIndex;
}



//SegmentedControl input course
- (IBAction)segmentedControlValueChanged {
	selectedUnit = segmentedControl.selectedSegmentIndex;
	
}

//SegmentedControl output course
- (IBAction) outputCourseControlValueChanged {
	selectedCourse = outputcourse.selectedSegmentIndex;
}

//SegmentedControl gender
- (IBAction) genderControlValueChange {
	selectedGender = gender.selectedSegmentIndex;
}


//Picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 4;
}

//Picker width
-(CGFloat)pickerView:(UIPickerView *)pickerview widthForComponent:(NSInteger) component {
	if (component == 0 || component == 1 || component == 2) {
		return 45;
	}
	else {
		return 210;
	}
}

//Button
- (IBAction) sendButtonTapped: (id) sender 
{
	int min = [inputTime selectedRowInComponent:0] * 60;
	int sec = [inputTime selectedRowInComponent:1];
	double hun = ( double ) ( [inputTime selectedRowInComponent:2] ) / 100;
	double timeInSeconds = min + sec + hun;
	//	NSString* themessage = [NSString stringWithFormat:@"%f", timeInSeconds];
	double outputTimeInSeconds;
	
	//LC converstin factors (NCAA)
	double LC50FreeM = 0.860, LC50FreeF = 0.871;
	double LC100FreeM = 0.863, LC100FreeF = 0.874;
	double LC200FreeM = 0.865, LC200FreeF = 0.874;
	double LC400FreeM = 1.105, LC400FreeF = 1.112;
	double LC1500FreeM = 0.965, LC1500FreeF = 0.975;
	double LC100FlyM = 0.868, LC100FlyF = 0.877;
	double LC200FlyM = 0.866, LC200FlyF = 0.881;
	double LC100BackM = 0.835, LC100BackF = 0.853;
	double LC200BackM = 0.849, LC200BackF = 0.857;
	double LC100BreastM = 0.856, LC100BreastF = 0.870;
	double LC200BreastM = 0.858, LC200BreastF = 0.878;
	double LC200IMM = 0.857, LC200IMF = 0.867;
	double LC400IMM = 0.865, LC400IMF = 0.876;
	double LC1000FreeM = 1.105, LC1000FreeF = 1.120;
	
	//SC converstion factors (NCAA)
	double allStrokes = 0.896;
	double yards400ToMeters500 = 1.143; // 400 meters to 500 yards AND 800 meters to 1000 yards
	double meters1500ToYards1650 = 1.003;
	
	
	//Male
	if (selectedGender == 0 ) {
		NSLog(@"Gender: Male");
		
		//input course SCY
		if ( selectedUnit == 0 ) {
			NSLog(@"Input Course: SCY");
			
			//output course SCY
			if (selectedCourse == 0 ) {
				NSLog(@"Output Course: SCY... same as input");
				
				//All strokes
				if ([inputTime selectedRowInComponent:3] == 0 ||
					[inputTime selectedRowInComponent:3] == 1 ||
					[inputTime selectedRowInComponent:3] == 2 ||
					[inputTime selectedRowInComponent:3] == 3 ||
					[inputTime selectedRowInComponent:3] == 4 ||
					[inputTime selectedRowInComponent:3] == 5 || 
					[inputTime selectedRowInComponent:3] == 6 ||
					[inputTime selectedRowInComponent:3] == 7 ||
					[inputTime selectedRowInComponent:3] == 8 ||
					[inputTime selectedRowInComponent:3] == 9 ||
					[inputTime selectedRowInComponent:3] == 10 || 
					[inputTime selectedRowInComponent:3] == 11 ||
					[inputTime selectedRowInComponent:3] == 12 || 
					[inputTime selectedRowInComponent:3] == 13) {
					outputTimeInSeconds = timeInSeconds;
					NSLog(@"Output Time: %f", outputTimeInSeconds);
				}
			}
			
			//output course SCM
			if (selectedCourse == 1 ) {
				NSLog(@"Output Course: SCM");
				
				//50 free
				if ([inputTime selectedRowInComponent:3] == 0 ) {
					NSLog(@"50 free");
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 free
				if ([inputTime selectedRowInComponent:3] == 1 ) {
					NSLog(@"100 free");
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 free
				if ([inputTime selectedRowInComponent:3] == 2 ) {
					NSLog(@"200 free");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 free
				if ([inputTime selectedRowInComponent:3] == 3 ) {
					NSLog(@"400 free");					
					outputTimeInSeconds = ( timeInSeconds / yards400ToMeters500 );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//800 free
				if ([inputTime selectedRowInComponent:3] == 4 ) {
					NSLog(@"800 free");					
					outputTimeInSeconds = ( timeInSeconds / yards400ToMeters500 );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//1500 free
				if ([inputTime selectedRowInComponent:3] == 5 ) {
					NSLog(@"1500 free");					
					outputTimeInSeconds = ( timeInSeconds / meters1500ToYards1650 );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 fly
				if ([inputTime selectedRowInComponent:3] == 6 ) {
					NSLog(@"100 fly");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 fly
				if ([inputTime selectedRowInComponent:3] == 7 ) {
					NSLog(@"200 fly");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 back
				if ([inputTime selectedRowInComponent:3] == 8 ) {
					NSLog(@"100 back");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 back
				if ([inputTime selectedRowInComponent:3] == 9 ) {
					NSLog(@"200 back");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 breast
				if ([inputTime selectedRowInComponent:3] == 10 ) {
					NSLog(@"100 breast");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 breast
				if ([inputTime selectedRowInComponent:3] == 11 ) {
					NSLog(@"200 breast");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 IM
				if ([inputTime selectedRowInComponent:3] == 12 ) {
					NSLog(@"200 IM");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 IM
				if ([inputTime selectedRowInComponent:3] == 13 ) {
					NSLog(@"400 IM");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
			}
			
			//output course LCM
			if (selectedCourse == 2 ) {
				NSLog(@"Output Course: LCM");
				
				//50 free
				if ([inputTime selectedRowInComponent:3] == 0 ) {
					NSLog(@"50 free");
					outputTimeInSeconds = ( timeInSeconds / LC50FreeM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 free
				if ([inputTime selectedRowInComponent:3] == 1 ) {
					NSLog(@"100 free");
					outputTimeInSeconds = ( timeInSeconds / LC100FreeM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 free
				if ([inputTime selectedRowInComponent:3] == 2 ) {
					NSLog(@"200 free");					
					outputTimeInSeconds = ( timeInSeconds / LC200FreeM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 free
				if ([inputTime selectedRowInComponent:3] == 3 ) {
					NSLog(@"400 free");					
					outputTimeInSeconds = ( timeInSeconds / LC400FreeM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}			
				
				//800 free
				if ([inputTime selectedRowInComponent:3] == 4 ) {
					NSLog(@"800 free");					
					outputTimeInSeconds = ( timeInSeconds / LC1000FreeM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//1500 free
				if ([inputTime selectedRowInComponent:3] == 5 ) {
					NSLog(@"1500 free");					
					outputTimeInSeconds = ( timeInSeconds / LC1500FreeM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 fly
				if ([inputTime selectedRowInComponent:3] == 6 ) {
					NSLog(@"100 fly");					
					outputTimeInSeconds = ( timeInSeconds / LC100FlyM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 fly
				if ([inputTime selectedRowInComponent:3] == 7 ) {
					NSLog(@"200 fly");					
					outputTimeInSeconds = ( timeInSeconds / LC200FlyM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 back
				if ([inputTime selectedRowInComponent:3] == 8 ) {
					NSLog(@"100 back");					
					outputTimeInSeconds = ( timeInSeconds / LC100BackM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 back
				if ([inputTime selectedRowInComponent:3] == 9 ) {
					NSLog(@"200 back");					
					outputTimeInSeconds = ( timeInSeconds / LC200BackM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 breast
				if ([inputTime selectedRowInComponent:3] == 10 ) {
					NSLog(@"100 breast");					
					outputTimeInSeconds = ( timeInSeconds / LC100BreastM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 breast
				if ([inputTime selectedRowInComponent:3] == 11 ) {
					NSLog(@"200 breast");					
					outputTimeInSeconds = ( timeInSeconds / LC200BreastM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 IM
				if ([inputTime selectedRowInComponent:3] == 12 ) {
					NSLog(@"200 IM");					
					outputTimeInSeconds = ( timeInSeconds / LC200IMM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 IM
				if ([inputTime selectedRowInComponent:3] == 13 ) {
					NSLog(@"400 IM");					
					outputTimeInSeconds = ( timeInSeconds / LC400IMM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
			}
			}
		
		//input course SCM
		else if ( selectedUnit == 1 ) {
			NSLog (@"Input Course: SCM");
			
			//output course SCY
			if (selectedCourse == 0 ) {
				NSLog(@"Output Course: SCY");
				
				//50 free
				if ([inputTime selectedRowInComponent:3] == 0 ) {
					NSLog(@"50 free");
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 free
				if ([inputTime selectedRowInComponent:3] == 1 ) {
					NSLog(@"100 free");
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 free
				if ([inputTime selectedRowInComponent:3] == 2 ) {
					NSLog(@"200 free");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 free
				if ([inputTime selectedRowInComponent:3] == 3 ) {
					NSLog(@"400 free");					
					outputTimeInSeconds = ( timeInSeconds * yards400ToMeters500 );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}		
				
				//800 free
				if ([inputTime selectedRowInComponent:3] == 4 ) {
					NSLog(@"800 free");					
					outputTimeInSeconds = ( timeInSeconds * yards400ToMeters500 );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//1500 free
				if ([inputTime selectedRowInComponent:3] == 5 ) {
					NSLog(@"1500 free");					
					outputTimeInSeconds = ( timeInSeconds * meters1500ToYards1650 );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 fly
				if ([inputTime selectedRowInComponent:3] == 6 ) {
					NSLog(@"100 fly");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 fly
				if ([inputTime selectedRowInComponent:3] == 7 ) {
					NSLog(@"200 fly");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 back
				if ([inputTime selectedRowInComponent:3] == 8 ) {
					NSLog(@"100 back");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 back
				if ([inputTime selectedRowInComponent:3] == 9 ) {
					NSLog(@"200 back");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 breast
				if ([inputTime selectedRowInComponent:3] == 10 ) {
					NSLog(@"100 breast");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 breast
				if ([inputTime selectedRowInComponent:3] == 11 ) {
					NSLog(@"200 breast");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 IM
				if ([inputTime selectedRowInComponent:3] == 12 ) {
					NSLog(@"200 IM");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 IM
				if ([inputTime selectedRowInComponent:3] == 13 ) {
					NSLog(@"400 IM");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}			
				
			}
			
			//output course SCM
			if (selectedCourse == 1 ) {
				NSLog(@"Output Course: SCM... same as input");
				
				//All strokes
				if ([inputTime selectedRowInComponent:3] == 0 ||
					[inputTime selectedRowInComponent:3] == 1 ||
					[inputTime selectedRowInComponent:3] == 2 ||
					[inputTime selectedRowInComponent:3] == 3 ||
					[inputTime selectedRowInComponent:3] == 4 ||
					[inputTime selectedRowInComponent:3] == 5 || 
					[inputTime selectedRowInComponent:3] == 6 ||
					[inputTime selectedRowInComponent:3] == 7 ||
					[inputTime selectedRowInComponent:3] == 8 ||
					[inputTime selectedRowInComponent:3] == 9 ||
					[inputTime selectedRowInComponent:3] == 10 || 
					[inputTime selectedRowInComponent:3] == 11 ||
					[inputTime selectedRowInComponent:3] == 12 ||
					[inputTime selectedRowInComponent:3] == 13) {
					outputTimeInSeconds = timeInSeconds;
					NSLog(@"Output Time: %f", outputTimeInSeconds);
				}
			}
			
			//output course LCM
			if (selectedCourse == 2 ) {
				NSLog(@"Output Course: LCM");
				
				//50 free
				if ([inputTime selectedRowInComponent:3] == 0 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC50FreeM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 free
				if ([inputTime selectedRowInComponent:3] == 1 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC100FreeM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 free
				if ([inputTime selectedRowInComponent:3] == 2 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200FreeM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 free
				if ([inputTime selectedRowInComponent:3] == 3 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC400FreeM/yards400ToMeters500) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//800 free
				if ([inputTime selectedRowInComponent:3] == 4 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC1000FreeM/yards400ToMeters500) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}			
				
				//1500 free
				if ([inputTime selectedRowInComponent:3] == 5 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC1500FreeM/meters1500ToYards1650) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 fly
				if ([inputTime selectedRowInComponent:3] == 6 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC100FlyM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 fly
				if ([inputTime selectedRowInComponent:3] == 7 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200FlyM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 back
				if ([inputTime selectedRowInComponent:3] == 8 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC100BackM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 back
				if ([inputTime selectedRowInComponent:3] == 9 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200BackM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 breast
				if ([inputTime selectedRowInComponent:3] == 10 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC100BreastM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 breast
				if ([inputTime selectedRowInComponent:3] == 11 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200BreastM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 IM
				if ([inputTime selectedRowInComponent:3] == 12 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200IMM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 IM
				if ([inputTime selectedRowInComponent:3] == 13 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC400IMM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
			}			
		}
		
		//input course LCM
		else {
			NSLog(@"Input Course: LCM");
			
			//output course SCY
			if (selectedCourse == 0 ) {
				NSLog(@"Output Course: SCY");
				
				//50 free
				if ([inputTime selectedRowInComponent:3] == 0 ) {
					outputTimeInSeconds = ( timeInSeconds * LC50FreeM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 free
				if ([inputTime selectedRowInComponent:3] == 1 ) {
					outputTimeInSeconds = ( timeInSeconds * LC100FreeM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 free
				if ([inputTime selectedRowInComponent:3] == 2 ) {
					outputTimeInSeconds = ( timeInSeconds * LC200FreeM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 free
				if ([inputTime selectedRowInComponent:3] == 3 ) {
					outputTimeInSeconds = ( timeInSeconds * LC400FreeM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//800 free
				if ([inputTime selectedRowInComponent:3] == 4 ) {
					outputTimeInSeconds = ( timeInSeconds * LC1000FreeM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//1500 free
				if ([inputTime selectedRowInComponent:3] == 5 ) {
					outputTimeInSeconds = ( timeInSeconds * LC1500FreeM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 fly
				if ([inputTime selectedRowInComponent:3] == 6 ) {
					outputTimeInSeconds = ( timeInSeconds * LC100FlyM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 fly
				if ([inputTime selectedRowInComponent:3] == 7 ) {
					outputTimeInSeconds = ( timeInSeconds * LC200FlyM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 back
				if ([inputTime selectedRowInComponent:3] == 8 ) {
					outputTimeInSeconds = ( timeInSeconds * LC100BackM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 back
				if ([inputTime selectedRowInComponent:3] == 9 ) {
					outputTimeInSeconds = ( timeInSeconds * LC200BackM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 breast
				if ([inputTime selectedRowInComponent:3] == 10 ) {
					outputTimeInSeconds = ( timeInSeconds * LC100BreastM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 breast
				if ([inputTime selectedRowInComponent:3] == 11 ) {
					outputTimeInSeconds = ( timeInSeconds * LC200BreastM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 IM
				if ([inputTime selectedRowInComponent:3] == 12 ) {
					outputTimeInSeconds = ( timeInSeconds * LC200IMM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 IM
				if ([inputTime selectedRowInComponent:3] == 13 ) {
					outputTimeInSeconds = ( timeInSeconds * LC400IMM );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
			}
			
			//output course SCM
			if (selectedCourse == 1 ) {
				NSLog(@"Output Course: SCM");
				
				//50 free
				if ([inputTime selectedRowInComponent:3] == 0 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC50FreeM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 free
				if ([inputTime selectedRowInComponent:3] == 1 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC100FreeM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 free
				if ([inputTime selectedRowInComponent:3] == 2 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC200FreeM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 free
				if ([inputTime selectedRowInComponent:3] == 3 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC400FreeM/yards400ToMeters500) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//800 free
				if ([inputTime selectedRowInComponent:3] == 4 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC1000FreeM/yards400ToMeters500) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//1500 free
				if ([inputTime selectedRowInComponent:3] == 5 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC1500FreeM/meters1500ToYards1650) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 fly
				if ([inputTime selectedRowInComponent:3] == 6 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC100FlyM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 fly
				if ([inputTime selectedRowInComponent:3] == 7 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC200FlyM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 back
				if ([inputTime selectedRowInComponent:3] == 8 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC100BackM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 back
				if ([inputTime selectedRowInComponent:3] == 9 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC200BackM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 breast
				if ([inputTime selectedRowInComponent:3] == 10 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC100BreastM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 breast
				if ([inputTime selectedRowInComponent:3] == 11 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC200BreastM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 IM
				if ([inputTime selectedRowInComponent:3] == 12 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC200IMM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 IM
				if ([inputTime selectedRowInComponent:3] == 13 ) {
					outputTimeInSeconds = ( timeInSeconds * (LC400IMM/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}	
			}
			
			//output course LCM
			if (selectedCourse == 2 ) {
				NSLog(@"Output Course: LCM...same as input");
				
				//All strokes
				if ([inputTime selectedRowInComponent:3] == 0 ||
					[inputTime selectedRowInComponent:3] == 1 ||
					[inputTime selectedRowInComponent:3] == 2 ||
					[inputTime selectedRowInComponent:3] == 3 ||
					[inputTime selectedRowInComponent:3] == 4 ||
					[inputTime selectedRowInComponent:3] == 5 || 
					[inputTime selectedRowInComponent:3] == 6 ||
					[inputTime selectedRowInComponent:3] == 7 ||
					[inputTime selectedRowInComponent:3] == 8 ||
					[inputTime selectedRowInComponent:3] == 9 ||
					[inputTime selectedRowInComponent:3] == 10 || 
					[inputTime selectedRowInComponent:3] == 11 ||
					[inputTime selectedRowInComponent:3] == 12 ||
					[inputTime selectedRowInComponent:3] == 13) {
					outputTimeInSeconds = timeInSeconds;
					NSLog(@"Output Time: %f", outputTimeInSeconds);
				}
			}							
		}
	}
	
	
	//Female
	else {
		NSLog(@"Gender: Female");
		
		//input course SCY
		if ( selectedUnit == 0 ) {
			NSLog(@"Input Course: SCY");
			
			//output course SCY
			if (selectedCourse == 0 ) {
				NSLog(@"Output Course: SCY... same as input");
				
				//All strokes
				if ([inputTime selectedRowInComponent:3] == 0 ||
					[inputTime selectedRowInComponent:3] == 1 ||
					[inputTime selectedRowInComponent:3] == 2 ||
					[inputTime selectedRowInComponent:3] == 3 ||
					[inputTime selectedRowInComponent:3] == 4 ||
					[inputTime selectedRowInComponent:3] == 5 || 
					[inputTime selectedRowInComponent:3] == 6 ||
					[inputTime selectedRowInComponent:3] == 7 ||
					[inputTime selectedRowInComponent:3] == 8 ||
					[inputTime selectedRowInComponent:3] == 9 ||
					[inputTime selectedRowInComponent:3] == 10 || 
					[inputTime selectedRowInComponent:3] == 11 ||
					[inputTime selectedRowInComponent:3] == 12 ||
					[inputTime selectedRowInComponent:3] == 13) {
					outputTimeInSeconds = timeInSeconds;
					NSLog(@"Output Time: %f", outputTimeInSeconds);
				}
			}
			
			//output course SCM
			if (selectedCourse == 1 ) {
				NSLog(@"Output Course: SCM");
				
				//50 free
				if ([inputTime selectedRowInComponent:3] == 0 ) {
					NSLog(@"50 free");
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 free
				if ([inputTime selectedRowInComponent:3] == 1 ) {
					NSLog(@"100 free");
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 free
				if ([inputTime selectedRowInComponent:3] == 2 ) {
					NSLog(@"200 free");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 free
				if ([inputTime selectedRowInComponent:3] == 3 ) {
					NSLog(@"400 free");					
					outputTimeInSeconds = ( timeInSeconds / yards400ToMeters500 );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}		
				
				//800 free
				if ([inputTime selectedRowInComponent:3] == 4 ) {
					NSLog(@"800 free");					
					outputTimeInSeconds = ( timeInSeconds / yards400ToMeters500 );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//1500 free
				if ([inputTime selectedRowInComponent:3] == 5 ) {
					NSLog(@"1500 free");					
					outputTimeInSeconds = ( timeInSeconds / meters1500ToYards1650 );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 fly
				if ([inputTime selectedRowInComponent:3] == 6 ) {
					NSLog(@"100 fly");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 fly
				if ([inputTime selectedRowInComponent:3] == 7 ) {
					NSLog(@"200 fly");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 back
				if ([inputTime selectedRowInComponent:3] == 8 ) {
					NSLog(@"100 back");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 back
				if ([inputTime selectedRowInComponent:3] == 9 ) {
					NSLog(@"200 back");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 breast
				if ([inputTime selectedRowInComponent:3] == 10 ) {
					NSLog(@"100 breast");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 breast
				if ([inputTime selectedRowInComponent:3] == 11 ) {
					NSLog(@"200 breast");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 IM
				if ([inputTime selectedRowInComponent:3] == 12 ) {
					NSLog(@"200 IM");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 IM
				if ([inputTime selectedRowInComponent:3] == 13 ) {
					NSLog(@"400 IM");					
					outputTimeInSeconds = ( timeInSeconds / allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}			
			}
			
			//output course LCM
			if (selectedCourse == 2 ) {
				NSLog(@"Output Course: LCM");
				
				//50 free
				if ([inputTime selectedRowInComponent:3] == 0 ) {
					outputTimeInSeconds = ( timeInSeconds / LC50FreeF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 free
				if ([inputTime selectedRowInComponent:3] == 1 ) {
					outputTimeInSeconds = ( timeInSeconds / LC100FreeF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 free
				if ([inputTime selectedRowInComponent:3] == 2 ) {
					outputTimeInSeconds = ( timeInSeconds / LC200FreeF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 free
				if ([inputTime selectedRowInComponent:3] == 3 ) {
					outputTimeInSeconds = ( timeInSeconds / LC400FreeF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}		
				
				//800 free
				if ([inputTime selectedRowInComponent:3] == 4 ) {
					outputTimeInSeconds = ( timeInSeconds / LC1000FreeF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}	
				
				//1500 free
				if ([inputTime selectedRowInComponent:3] == 5 ) {
					outputTimeInSeconds = ( timeInSeconds / LC1500FreeF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 fly
				if ([inputTime selectedRowInComponent:3] == 6 ) {
					outputTimeInSeconds = ( timeInSeconds / LC100FlyF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 fly
				if ([inputTime selectedRowInComponent:3] == 7 ) {
					outputTimeInSeconds = ( timeInSeconds / LC200FlyF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 back
				if ([inputTime selectedRowInComponent:3] == 8 ) {
					outputTimeInSeconds = ( timeInSeconds / LC100BackF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 back
				if ([inputTime selectedRowInComponent:3] == 9 ) {
					outputTimeInSeconds = ( timeInSeconds / LC200BackF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 breast
				if ([inputTime selectedRowInComponent:3] == 10 ) {
					outputTimeInSeconds = ( timeInSeconds / LC100BreastF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 breast
				if ([inputTime selectedRowInComponent:3] == 11 ) {
					outputTimeInSeconds = ( timeInSeconds / LC200BreastF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 IM
				if ([inputTime selectedRowInComponent:3] == 12 ) {
					outputTimeInSeconds = ( timeInSeconds / LC200IMF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 IM
				if ([inputTime selectedRowInComponent:3] == 13 ) {
					outputTimeInSeconds = ( timeInSeconds / LC400IMF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}							
			}
		}
		
		//input course SCM
		else if ( selectedUnit == 1 ) {
			NSLog (@"Input Course: SCM");
			
			//output course SCY
			if (selectedCourse == 0 ) {
				NSLog(@"Output Course: SCY");				
				
				//50 free
				if ([inputTime selectedRowInComponent:3] == 0 ) {
					NSLog(@"50 free");
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 free
				if ([inputTime selectedRowInComponent:3] == 1 ) {
					NSLog(@"100 free");
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 free
				if ([inputTime selectedRowInComponent:3] == 2 ) {
					NSLog(@"200 free");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 free
				if ([inputTime selectedRowInComponent:3] == 3 ) {
					NSLog(@"400 free");					
					outputTimeInSeconds = ( timeInSeconds * yards400ToMeters500 );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
					
				//800 free
				if ([inputTime selectedRowInComponent:3] == 4 ) {
					NSLog(@"800 free");					
					outputTimeInSeconds = ( timeInSeconds * yards400ToMeters500 );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//1500 free
				if ([inputTime selectedRowInComponent:3] == 5 ) {
					NSLog(@"1500 free");					
					outputTimeInSeconds = ( timeInSeconds * meters1500ToYards1650 );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 fly
				if ([inputTime selectedRowInComponent:3] == 6 ) {
					NSLog(@"100 fly");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 fly
				if ([inputTime selectedRowInComponent:3] == 7 ) {
					NSLog(@"200 fly");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 back
				if ([inputTime selectedRowInComponent:3] == 8 ) {
					NSLog(@"100 back");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 back
				if ([inputTime selectedRowInComponent:3] == 9 ) {
					NSLog(@"200 back");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 breast
				if ([inputTime selectedRowInComponent:3] == 10 ) {
					NSLog(@"100 breast");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 breast
				if ([inputTime selectedRowInComponent:3] == 11 ) {
					NSLog(@"200 breast");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 IM
				if ([inputTime selectedRowInComponent:3] == 12 ) {
					NSLog(@"200 IM");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 IM
				if ([inputTime selectedRowInComponent:3] == 13 ) {
					NSLog(@"400 IM");					
					outputTimeInSeconds = ( timeInSeconds * allStrokes );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}			
			}
			
			//output course SCM
			if (selectedCourse == 1 ) {
				NSLog(@"Output Course: SCM... same as input");
				
				//All strokes
				if ([inputTime selectedRowInComponent:3] == 0 ||
					[inputTime selectedRowInComponent:3] == 1 ||
					[inputTime selectedRowInComponent:3] == 2 ||
					[inputTime selectedRowInComponent:3] == 3 ||
					[inputTime selectedRowInComponent:3] == 4 ||
					[inputTime selectedRowInComponent:3] == 5 || 
					[inputTime selectedRowInComponent:3] == 6 ||
					[inputTime selectedRowInComponent:3] == 7 ||
					[inputTime selectedRowInComponent:3] == 8 ||
					[inputTime selectedRowInComponent:3] == 9 ||
					[inputTime selectedRowInComponent:3] == 10 || 
					[inputTime selectedRowInComponent:3] == 11 ||
					[inputTime selectedRowInComponent:3] == 12 ||
					[inputTime selectedRowInComponent:3] == 13) {
					outputTimeInSeconds = timeInSeconds;
					NSLog(@"Output Time: %f", outputTimeInSeconds);
				}
			}
			
			//output course LCM
			if (selectedCourse == 2 ) {
				NSLog(@"Output Course: LCM");
				
				//50 free
				if ([inputTime selectedRowInComponent:3] == 0 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC50FreeF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 free
				if ([inputTime selectedRowInComponent:3] == 1 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC100FreeF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 free
				if ([inputTime selectedRowInComponent:3] == 2 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200FreeF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 free
				if ([inputTime selectedRowInComponent:3] == 3 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC400FreeF/yards400ToMeters500) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}		
				
				//800 free
				if ([inputTime selectedRowInComponent:3] == 4 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC1000FreeF/yards400ToMeters500) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//1500 free
				if ([inputTime selectedRowInComponent:3] == 5 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC1500FreeF/meters1500ToYards1650) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 fly
				if ([inputTime selectedRowInComponent:3] == 6 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC100FlyF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 fly
				if ([inputTime selectedRowInComponent:3] == 7 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200FlyF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 back
				if ([inputTime selectedRowInComponent:3] == 8 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC100BackF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 back
				if ([inputTime selectedRowInComponent:3] == 9 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200BackF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 breast
				if ([inputTime selectedRowInComponent:3] == 10 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC100BreastF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 breast
				if ([inputTime selectedRowInComponent:3] == 11 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200BreastF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 IM
				if ([inputTime selectedRowInComponent:3] == 12 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200IMF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 IM
				if ([inputTime selectedRowInComponent:3] == 13 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC400IMF/allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}	
			}			
		}
			
		//input course LCM
		else {
			NSLog(@"Input Course: LCM");
			
			//output course SCY
			if (selectedCourse == 0 ) {
				NSLog(@"Output Course: SCY");
				
				//50 free
				if ([inputTime selectedRowInComponent:3] == 0 ) {
					outputTimeInSeconds = ( timeInSeconds * LC50FreeF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 free
				if ([inputTime selectedRowInComponent:3] == 1 ) {
					outputTimeInSeconds = ( timeInSeconds * LC100FreeF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 free
				if ([inputTime selectedRowInComponent:3] == 2 ) {
					outputTimeInSeconds = ( timeInSeconds * LC200FreeF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 free
				if ([inputTime selectedRowInComponent:3] == 3 ) {
					outputTimeInSeconds = ( timeInSeconds * LC400FreeF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}	
				
				//800 free
				if ([inputTime selectedRowInComponent:3] == 4 ) {
					outputTimeInSeconds = ( timeInSeconds * LC1000FreeF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//1500 free
				if ([inputTime selectedRowInComponent:3] == 5 ) {
					outputTimeInSeconds = ( timeInSeconds * LC1500FreeF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 fly
				if ([inputTime selectedRowInComponent:3] == 6 ) {
					outputTimeInSeconds = ( timeInSeconds * LC100FlyF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 fly
				if ([inputTime selectedRowInComponent:3] == 7 ) {
					outputTimeInSeconds = ( timeInSeconds * LC200FlyF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 back
				if ([inputTime selectedRowInComponent:3] == 8 ) {
					outputTimeInSeconds = ( timeInSeconds * LC100BackF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 back
				if ([inputTime selectedRowInComponent:3] == 9 ) {
					outputTimeInSeconds = ( timeInSeconds * LC200BackF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 breast
				if ([inputTime selectedRowInComponent:3] == 10 ) {
					outputTimeInSeconds = ( timeInSeconds * LC100BreastF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 breast
				if ([inputTime selectedRowInComponent:3] == 11 ) {
					outputTimeInSeconds = ( timeInSeconds * LC200BreastF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 IM
				if ([inputTime selectedRowInComponent:3] == 12 ) {
					outputTimeInSeconds = ( timeInSeconds * LC200IMF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 IM
				if ([inputTime selectedRowInComponent:3] == 13 ) {
					outputTimeInSeconds = ( timeInSeconds * LC400IMF );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
			}
			
			//output course SCM
			if (selectedCourse == 1 ) {
				NSLog(@"Output Course: SCM");
				
				//50 free
				if ([inputTime selectedRowInComponent:3] == 0 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC50FreeF * allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 free
				if ([inputTime selectedRowInComponent:3] == 1 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC100FreeF * allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 free
				if ([inputTime selectedRowInComponent:3] == 2 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200FreeF * allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//400 free
				if ([inputTime selectedRowInComponent:3] == 3 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC400FreeF * yards400ToMeters500) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}		
				
				//800 free
				if ([inputTime selectedRowInComponent:3] == 4 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC1000FreeF * yards400ToMeters500) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//1500 free
				if ([inputTime selectedRowInComponent:3] == 5 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC1500FreeF * meters1500ToYards1650) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 fly
				if ([inputTime selectedRowInComponent:3] == 6 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC100FlyF * allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 fly
				if ([inputTime selectedRowInComponent:3] == 7 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200FlyF * allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 back
				if ([inputTime selectedRowInComponent:3] == 8 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC100BackF * allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//200 back
				if ([inputTime selectedRowInComponent:3] == 9 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200BackF * allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//100 breast
				if ([inputTime selectedRowInComponent:3] == 10 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC100BreastF * allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}				
				
				//200 breast
				if ([inputTime selectedRowInComponent:3] == 11 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200BreastF * allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}
				
				//200 IM
				if ([inputTime selectedRowInComponent:3] == 12 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC200IMF * allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}					
				
				//400 IM
				if ([inputTime selectedRowInComponent:3] == 13 ) {
					outputTimeInSeconds = ( timeInSeconds / (LC400IMF * allStrokes) );
					NSLog(@"Output time: %f", outputTimeInSeconds);
				}	
			}
			
			//output course LCM
			if (selectedCourse == 2 ) {
				NSLog(@"Output Course: LCM...same as input");
				
				//All strokes
				if ([inputTime selectedRowInComponent:3] == 0 ||
					[inputTime selectedRowInComponent:3] == 1 ||
					[inputTime selectedRowInComponent:3] == 2 ||
					[inputTime selectedRowInComponent:3] == 3 ||
					[inputTime selectedRowInComponent:3] == 4 ||
					[inputTime selectedRowInComponent:3] == 5 || 
					[inputTime selectedRowInComponent:3] == 6 ||
					[inputTime selectedRowInComponent:3] == 7 ||
					[inputTime selectedRowInComponent:3] == 8 ||
					[inputTime selectedRowInComponent:3] == 9 ||
					[inputTime selectedRowInComponent:3] == 10 || 
					[inputTime selectedRowInComponent:3] == 11 ||
					[inputTime selectedRowInComponent:3] == 12 ||
					[inputTime selectedRowInComponent:3] == 13) {
					outputTimeInSeconds = timeInSeconds;
					NSLog(@"Output Time: %f", outputTimeInSeconds);
				}
			}							
		}
	}
	int m = 0;
	while ( outputTimeInSeconds >= 60.0 ) {
		outputTimeInSeconds -= 60.0;
		m++;
	}
	
	NSLog(@"minute: %i", m);	
	
	int s = outputTimeInSeconds;
	
	NSLog(@"second: %i", s);
	
	double hh = (outputTimeInSeconds - s);
	double h = hh * 100;
	
	NSLog(@"hundred: %f", h);	
	
	if ( h >= 99.5 ) {
		s += 1;
		h = 0;
	}
	
	if ( s >= 60 ) {
		m += 1;
		s = 0;
	}
	
	NSNumberFormatter *minuteFormat = [[NSNumberFormatter alloc] init];
	[minuteFormat setPositiveFormat:@"00:"];
	NSString *M = [minuteFormat stringForObjectValue:[NSNumber numberWithInt:m]];
	
	NSNumberFormatter *secondFormat = [[NSNumberFormatter alloc] init];
	[secondFormat setPositiveFormat:@"00."];
	NSString *S = [secondFormat stringForObjectValue:[NSNumber numberWithInt:s]];
	
	NSNumberFormatter *hundredFormat = [[NSNumberFormatter alloc] init];
	[hundredFormat setPositiveFormat:@"00"];
	NSString *H = [hundredFormat stringForObjectValue:[NSNumber numberWithDouble:h]];
	
	NSMutableString *done;
	done = [NSMutableString stringWithString: M];
	[done insertString: S atIndex: [done length]];
	[done insertString: H atIndex: [done length]];
	NSLog(done);
	
	finalTime.text = done;
	
	
	
}

//Picker
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent :(NSInteger)component 
{
	if (component == 0) 
	{
		return [minute count];
	}
	else if (component == 1) 
	{
		return [second count];
	}
	else if (component == 2 )
	{
		return [hundred count];
	}
	else
	{
		return [stroke count];
	}
	
}


//Memory
- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

//Picker
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent: (NSInteger)component{
	switch (component) {
		case 0:
			return [minute objectAtIndex:row];
		case 1:
			return [second objectAtIndex:row];
		case 2:
			return [hundred objectAtIndex:row];
		case 3:
			return [stroke objectAtIndex:row];
	}
	return nil;
}


//Memory
- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

//Memory
- (void)dealloc 
{
	[inputTime release];
	[minute release];
	[second release];
	[hundred release];
	[stroke release];
	[segmentedControl release];
	[outputcourse release];
	[gender release];
	//	[timeFormat release];
    [super dealloc];
}

@end
