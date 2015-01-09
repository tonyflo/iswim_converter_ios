//
//  iSwim_ConverterViewController.h
//  iSwim Converter
//
//  Created by Tony Florida on 11/4/10.
//  Copyright 2010 Raddfood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iSwim_ConverterViewController : UIViewController {
	//picker
	IBOutlet UILabel *finalTime; 
	IBOutlet UIPickerView *inputTime;
	NSArray* minute;
	NSArray* second;
	NSArray* hundred;
	NSArray* stroke;
	//input course
	UISegmentedControl *segmentedControl;
	NSUInteger selectedUnit;
	//output course
	UISegmentedControl *outputcourse;
	NSUInteger selectedCourse;
	//gender
	UISegmentedControl *gender;
	NSUInteger selectedGender;
	//Output time lable
}
@property (retain, nonatomic) UILabel *finalTime;
@property (nonatomic, retain) UIPickerView* inputTime;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, retain) IBOutlet UISegmentedControl *outputcourse;
@property (nonatomic, retain) IBOutlet UISegmentedControl *gender;

- (IBAction) sendButtonTapped: (id) sender;
- (IBAction) segmentedControlValueChanged;
- (IBAction) outputCourseControlValueChanged;
- (IBAction) genderControlValueChange;


@end

