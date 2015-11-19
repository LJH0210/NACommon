//
//  CityListViewController.m
//  Xxjiac
//
//  Created by Bird Fu on 14-7-29.
//  Copyright (c) 2014年 Enways. All rights reserved.
//

#import "XXJCityListViewController.h"
#import "LocatedCityCell.h"
#import "CityHeadView.h"
#import "HotCityCell.h"
#import "CityCell.h"
#import "LetterView.h"
#import "XXJCity.h"
#import "XXJHttpTranscations.h"
#import "AppDelegate.h"
#import <Reachability/Reachability.h>
#import "NSString+XXJFoundation.h"
#import <CoreLocation/CoreLocation.h>

@interface XXJCityListViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UITextFieldDelegate, LetterViewDelegate,
                                         HotCityCellDelegate, CLLocationManagerDelegate>

@property(retain, nonatomic) NSMutableArray *hotCities;
@property(retain, nonatomic) NSMutableArray *allCities;
@property(retain, nonatomic) NSMutableArray *searchCities;
@property(retain, nonatomic) NSString *keyword;
@property(retain, nonatomic) HotCityCell *locatedCell;
@property(retain, nonatomic) HotCityCell *hotCell;
@property(retain, nonatomic) NSMutableDictionary *letterCities;
@property(retain, nonatomic) NSArray *letters;
@property(retain, nonatomic) LetterView *letterView;
@property(strong, nonatomic) IBOutlet UITableView *tableView;
@property(strong, nonatomic) IBOutlet UITextField *textField;
@property(strong, nonatomic) IBOutlet UIView *letterContainerView;

- (IBAction)editValueChanged:(id)sender;

@end

@implementation XXJCityListViewController

+ (XXJCity *)getLocationedCity {
    NSData *loda = [[NSUserDefaults standardUserDefaults] objectForKey:@"locationcity"];
    XXJCity *city = [NSKeyedUnarchiver unarchiveObjectWithData:loda];
    return city;
}

+ (void)setLocationCity:(XXJCity *)city {
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:city] forKey:@"locationcity"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (XXJCity *)getSelectedCity {
    NSData *loda = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectedcity"];
    XXJCity *city = [NSKeyedUnarchiver unarchiveObjectWithData:loda];
    return city;
}

+ (void)setSelectedCity:(XXJCity *)city {
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:city] forKey:@"selectedcity"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)dealloc {
    NSLog(@"%@ dealloc", self);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CLLocationManager *loactionManager = [[CLLocationManager alloc] init];
    loactionManager.desiredAccuracy = kCLLocationAccuracyBest;
    loactionManager.delegate = self;
    if ([loactionManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [loactionManager performSelector:@selector(requestWhenInUseAuthorization)];
    }
    [loactionManager startUpdatingLocation];
}

- (void)viewDidLoad {

    [super viewDidLoad];

    if (([[[UIDevice currentDevice] systemVersion] doubleValue] >= 7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

    self.title = [NSString stringWithFormat:@"当前城市-%@", ([[XXJCityListViewController getLocationedCity].cityname isEqualToString:@""] ||
                                                                 [XXJCityListViewController getLocationedCity].cityname == nil)
                                                                    ? @"未定位"
                                                                    : [XXJCityListViewController getLocationedCity].cityname];

    UIControl *menuControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIImageView *imv;
    if (self.navigationController.viewControllers.count <= 1) {
        imv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icx_button_ xx"]];
    } else {
        imv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icx_button_ xx"]];
    }
    imv.frame = CGRectMake(0, 10, 22, 22);
    [menuControl addSubview:imv];
    [menuControl addTarget:self action:@selector(actionLeft) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:menuControl];
    self.navigationItem.leftBarButtonItem = item;

    _hotCities = [[NSMutableArray alloc] init];
    _allCities = [[NSMutableArray alloc] init];
    _searchCities = [[NSMutableArray alloc] init];
    _letterCities = [[NSMutableDictionary alloc] init];
    _letterView = [[LetterView alloc] init];
    _letterView.delegate = self;
    _letterView.backgroundColor = [UIColor clearColor];

    if ([XXJCityListViewController getLocationedCity] != nil) {
        _locatedCell = [[HotCityCell alloc] init];
        _locatedCell.delegate = self;
        _locatedCell.cities = @[ [XXJCityListViewController getLocationedCity] ];
        [_tableView reloadData];
    }

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
        _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    }

    _tableView.sectionIndexColor = [UIColor colorWithRed:80.0 / 255 green:80.0 / 255 blue:80.0 / 255 alpha:1];

    if ([_dataSource respondsToSelector:@selector(xxjHotCitys)]) {
        NSMutableArray *hot = [[_dataSource xxjHotCitys] mutableCopy];
        [self setHotCities:hot];
    }

    if ([_dataSource respondsToSelector:@selector(xxjAllCitys)]) {
        NSMutableArray *all = [[_dataSource xxjAllCitys] mutableCopy];
        [self setAllCities:all];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [manager stopUpdatingLocation];
    manager.delegate = nil;
    if (![self isConnectionAvailable]) {
        UIAlertView *asr =
            [[UIAlertView alloc] initWithTitle:@"定位失败" message:@"当前无网络" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [asr show];
        return;
    }

    UIAlertView *asr =
        [[UIAlertView alloc] initWithTitle:@"定位服务未开启"
                                   message:[NSString stringWithFormat:@"请在系统设置中开启定位服务\n(设置>隐私>定位服务>开启%@)",
                                                                      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]]
                                  delegate:nil
                         cancelButtonTitle:@"确定"
                         otherButtonTitles:nil, nil];
    [asr show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    [manager stopUpdatingLocation];
    manager.delegate = nil;
    if ([_dataSource respondsToSelector:@selector(xxjLocationCity:)]) {
        XXJCity *city = [_dataSource xxjLocationCity:newLocation];
        [XXJCityListViewController setLocationCity:city];
        [self.tableView reloadData];
    }
}

- (BOOL)isConnectionAvailable {

    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
    case NotReachable:
        isExistenceNetwork = NO;
        // NSLog(@"notReachable");
        break;
    case ReachableViaWiFi:
        isExistenceNetwork = YES;
        // NSLog(@"WIFI");
        break;
    case ReachableViaWWAN:
        isExistenceNetwork = YES;
        // NSLog(@"3G");
        break;
    }
    return isExistenceNetwork;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)actionLeft {
    //未选择
    if ([[XXJCityListViewController getLocationedCity].citycode isEqualToString:@""] || [XXJCityListViewController getLocationedCity].citycode == nil) {
        if ([XXJCityListViewController getLocationedCity] != nil && [XXJCityListViewController getLocationedCity].enable) {
            [XXJCityListViewController getSelectedCity].citycode = [XXJCityListViewController getLocationedCity].citycode;
            [XXJCityListViewController getSelectedCity].citycode = [XXJCityListViewController getLocationedCity].citycode;
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - IBAction
- (void)dismissKeyboard:(id)sender {
    [_textField resignFirstResponder];
}

- (void)editValueChanged:(id)sender {
    NSString *str = [_textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (str == nil || [str isEqualToString:@""]) {
        [self initLetterCities:_allCities];
        [_tableView reloadData];
    }
}

- (void)doSearch {
    [self dismissKeyboard:nil];
    if ([NSString isEmptyString:_textField.text]) {
        [_textField becomeFirstResponder];
        UIAlertView *aer = [[UIAlertView alloc] initWithTitle:@"请输入关键字" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [aer show];
        return;
    }

    _keyword = _textField.text;
    //"[^?!@#$%\\^&*()]+
    NSString *keywordRegex = @"^[A-Za-z0-9\u4e00-\u9fa5 ]+$";
    NSPredicate *keywordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", keywordRegex];
    BOOL isMatch = [keywordPredicate evaluateWithObject:_keyword];
    if (!isMatch) {
        [_textField becomeFirstResponder];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您输入的关键字中包含非法字符，请重新输入"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }

    if ([_dataSource respondsToSelector:@selector(xxjSearchCity:)]) {
        NSMutableArray *sea = [[_dataSource xxjSearchCity:_keyword] mutableCopy];
        [self setSearchCities:sea];
    }
}

- (void)setHotCities:(NSMutableArray *)hotCities {
    [_hotCities removeAllObjects];
    [_hotCities addObjectsFromArray:hotCities];

    if (_hotCities.count > 0) {
        _hotCell = [[NSBundle mainBundle] loadNibNamed:@"HotCityCell" owner:self options:nil].firstObject;
        _hotCell.delegate = self;
        _hotCell.cities = _hotCities;
    }
    [_tableView reloadData];
}

- (void)setAllCities:(NSMutableArray *)allCities {
    [_allCities removeAllObjects];
    [_allCities addObjectsFromArray:allCities];

    [self initLetterCities:_allCities];
    [_tableView reloadData];
}

- (void)setSearchCities:(NSMutableArray *)searchCities {
    [_searchCities removeAllObjects];
    [_searchCities addObjectsFromArray:searchCities];

    [self initLetterCities:_searchCities];
    [_tableView reloadData];
}

- (void)initLetterCities:(NSArray *)cities {
    [_letterCities removeAllObjects];
    for (XXJCity *city in cities) {
        NSString *letter = city.py;
        if (!city.py || city.py.length < 1) {
            return;
        }
        letter = [letter substringToIndex:1];
        letter = [letter uppercaseString];
        NSMutableArray *_cities = [_letterCities objectForKey:letter];
        if (_cities == nil) {
            _cities = [[NSMutableArray alloc] init];
            [_letterCities setValue:_cities forKey:letter];
        }

        [_cities addObject:city];
    }

    NSArray *array = [_letterCities allKeys];
    array = [array sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSMutableDictionary *newLetterCities = [[NSMutableDictionary alloc] init];
    for (NSString *key in array) {
        NSMutableArray *_cities = [_letterCities objectForKey:key];
        [newLetterCities setValue:_cities forKey:key];
    }

    _letters = array;
    _letterCities = newLetterCities;

    _letterView.letters = _letters;
    for (UIView *v in _letterContainerView.subviews) {
        [v removeFromSuperview];
    }
    [_letterContainerView addSubview:_letterView];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2 + _letterCities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    static NSString *cityCellIndentifier = @"AllCity";

    if (section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell = [[UITableViewCell alloc] init];
        UIButton *bt = [[UIButton alloc] initWithFrame:CGRectMake(0, 10, 160, 29)];
        [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        NSString *strWarm = ([XXJCityListViewController getLocationedCity].enable) ? @"" : @" - 暂未开通";
        [bt setTitle:[NSString stringWithFormat:@"%@%@", [XXJCityListViewController getLocationedCity].cityname, strWarm] forState:UIControlStateNormal];
        bt.titleLabel.font = [UIFont systemFontOfSize:13];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:bt];

        return cell;
    } else if (section == 1) {
        _hotCell.cities = _hotCities;
        return _hotCell;
    } else {
        NSString *key = _letters[section - 2];
        NSArray *_cities = [_letterCities objectForKey:key];

        CityCell *cell = [_tableView dequeueReusableCellWithIdentifier:cityCellIndentifier];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"CityCell" owner:nil options:nil].lastObject;
        }

        XXJCity *city = _cities[row];
        cell.cityNameValue.text = city.cityname;
        return cell;
    }

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section >= 2) {
        NSString *key = _letters[section - 2];
        NSArray *_cities = [_letterCities objectForKey:key];
        [self selectHotCity:_cities[row]];
        return;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 0 && [XXJCityListViewController getLocationedCity] == nil) {
        return 0;
    }

    if (section == 1 && _hotCities.count == 0) {
        return 0;
    }

    return 29;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [XXJCityListViewController getLocationedCity] == nil ? 0 : 1;
    } else if (section == 1) {
        return _hotCities.count > 0 ? 1 : 0;
    }

    NSString *key = _letters[section - 2];
    NSArray *_cities = [_letterCities objectForKey:key];
    return _cities.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        if ([XXJCityListViewController getLocationedCity] != nil) {
            CityHeadView *headView = [[[NSBundle mainBundle] loadNibNamed:@"CityHeadView" owner:self options:nil] firstObject];
            headView.titleValue.text = @"定位城市";
            return headView;
        } else {
            return nil;
        }
    } else if (section == 1) {
        if (_hotCities.count > 0) {
            CityHeadView *headView = [[[NSBundle mainBundle] loadNibNamed:@"CityHeadView" owner:self options:nil] firstObject];
            headView.titleValue.text = @"热门城市";
            return headView;
        } else {
            return nil;
        }
    }

    NSString *key = _letters[section - 2];
    CityHeadView *headView = [[[NSBundle mainBundle] loadNibNamed:@"CityHeadView" owner:self options:nil] firstObject];
    headView.titleValue.text = key;
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    if (section == 1) {
        return _hotCell.tileView.frame.size.height;
    }

    return 51;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= 2) {
        return YES;
    }
    return NO;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index + 2;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _letters;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self doSearch];
    return YES;
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [self doSearch];
        return true;
    }

    if ([string isEqualToString:@""]) {
        return true;
    }

    if (_textField.text.length >= 32) {
        return false;
    }

    return true;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_textField resignFirstResponder];
}

#pragma mark - LetterViewDelegate
- (void)clickLetter:(NSInteger)index {
    if (index >= _letters.count) {
        return;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index + 2];
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:true];
}

#pragma mark - HotCityCellDelegate
- (void)selectHotCity:(XXJCity *)city {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [XXJCityListViewController setSelectedCity:city];
    });

    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
