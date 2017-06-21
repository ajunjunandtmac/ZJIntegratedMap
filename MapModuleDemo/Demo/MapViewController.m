//
//  ViewController.m
//  MapModuleDemo
//
//  Created by jiale on 2017/6/4.
//  Copyright © 2017年 jiale. All rights reserved.
//

#import "MapViewController.h"
#import "MapEngine.h"
#import "ZJAlertBuilder.h"
#import "ZJSegmentedView.h"
#import "InquiryViewController.h"
#import "QMUIConfigurationTemplate.h"
#import "PoiDetailView.h"
#import "IAnnotationView.h"
static NSInteger const MapViewTag = 999;
static CGFloat const segmentHeight = 44.0f;
static CGFloat const poiDetailViewAnimateTime = .5f;
static MapPlatformType mapType = MapPlatformTypeBaidu;
typedef NS_ENUM(NSUInteger,SegmentIndex){
    SegmentIndexMap,
    SegmentIndexLocation,
    SegmentIndexPOI,
    SegmentIndexOther
};

typedef NS_ENUM(NSUInteger,PoiDetailViewAnimationType){
    PoiDetailViewAnimationTypeShow,
    PoiDetailViewAnimationTypeDismiss
};

@interface MapViewController ()<ILocationServiceDelegate,ZJSegmentedViewDelegate,InquiryViewControllerDelegate,IPOIDetailSearcherDelegate,PoiDetailViewDelegate,IMapDelegate,IRouteServiceDelegate>
@property(nonatomic,strong)id<ILocationService>locationService;
@property(nonatomic,strong)id<IMapProtocol>map;
@property(nonatomic,strong)id<IMapFactoryProtocol>factory;
@property(nonatomic,strong)id<IUserLocation>userLocation;
@property(nonatomic,strong)id<IPOIDetailSearcher> PoiDetailSearcher;
@property(nonatomic,strong)id<IDriveRouteService> driveRouteService;

@property(nonatomic,assign)SegmentIndex lastIndex;
@property(nonatomic,weak)ZJSegmentedView *segment;
@property(nonatomic,strong)PoiDetailView *poiDetailView;
@end

@implementation MapViewController
@synthesize PoiDetailSearcher = PoiDetailSearcher;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    [self configureTheme];
    [self setupNaviCenterViewWithSegmentIndex:_lastIndex];
    [self setupHeadSegment];
    [self setupMapWithPlatformType:mapType];
}

- (void)configureTheme
{
    NSString *themeClassName = [[NSUserDefaults standardUserDefaults] stringForKey:QDSelectedThemeClassName] ?: NSStringFromClass([QMUIConfigurationTemplate class]);
    [QDThemeManager sharedInstance].currentTheme = [[NSClassFromString(themeClassName) alloc] init];
}

- (void)setupHeadSegment
{
    NSArray *titles = @[@"地图",@"定位",@"POI检索",@"其它"];
    ZJSegmentedView *segment = [[ZJSegmentedView alloc] initWithTitles:titles delegate:self];
    segment.frame = CGRectMake(0, 0, self.view.bounds.size.width, segmentHeight);
    [self.view addSubview:segment];
    _segment = segment;
}

- (void)setupMapWithPlatformType:(MapPlatformType)type
{
    _factory = [MapEngine mapFactoryWithType:type];
    UIView *lastMapView = [self.view viewWithTag:MapViewTag];
    if (lastMapView) {
        [lastMapView removeFromSuperview];
        _map = nil;
        _locationService = nil;
        PoiDetailSearcher = nil;
        _userLocation  = nil;
    }
    
    //生产地图view
    _map = [_factory mapWithFrame:CGRectMake(0, segmentHeight, self.view.bounds.size.width, self.view.bounds.size.height-segmentHeight)];
    [_map setDelegate:self];
    [_map setUserTrackingMode:ZJMapUserTrackingModeNone];
    [_map showsUserLocation:YES];
    UIView *mapView = [_map getMapView];
    mapView.tag = MapViewTag;
    [self.view addSubview:mapView];
}

//生产定位功能 此处切记用全局变量持有对象，否则viewDidLoad走完locationService也被销毁了，无法定位
- (void)startLocation
{
    _locationService = [_factory getMapLocationServiceWithDelegate:self];
    [_locationService startLocation];
}

#pragma mark - 切换地图
- (IBAction)switchMap:(UIBarButtonItem *)sender {
    mapType++;
    mapType = mapType%2?mapType%2:MapPlatformTypeGaode;
    [self setupMapWithPlatformType:mapType];
    //切换地图后保持上次选中的segment功能
    [_segment selectAtIndex:_lastIndex];
    
    //清空poiDetailView
    _poiDetailView = nil;
}

#pragma mark - 点击放大镜 进入自动联想搜索页
- (void)search
{
    InquiryViewController *inquiryController = [[InquiryViewController alloc] init];
    inquiryController.factory = _factory;
    inquiryController.userLocation = _userLocation;
    inquiryController.delegate = self;
    [self.navigationController pushViewController:inquiryController animated:YES];
}

#pragma mark - ILocationServiceDelegate 定位成功后的回调
- (void)didUpdateUserLocation:(id<IUserLocation>)userLocation
{
    _userLocation = userLocation;
    [_map updateUserLocation:userLocation];
    [_map setRegion:ZJMapCoordinateRegionMake(userLocation.location.coordinate, ZJMapCoordinateSpanMake(0.05, 0.05))]; //0.05比较合适
}

#pragma mark - ZJSegmentedViewDelegate
- (void)ZJSegmentedView:(ZJSegmentedView *)segmentedView selectedAtIndex:(NSUInteger)index
{
    _lastIndex = index;
    switch (index) {
        case SegmentIndexMap:
        {
            [self setupMapWithPlatformType:mapType];
            break;
        }
        case SegmentIndexLocation:
        {
            [self startLocation];
            break;
        }
        case SegmentIndexPOI:
        {
            [self startLocation];
            break;
        }
        case SegmentIndexOther:
        {
            break;
        }
            
        default:
            break;
    }
    [self setupNaviCenterViewWithSegmentIndex:index];
}

- (void)setupNaviCenterViewWithSegmentIndex:(SegmentIndex)index
{
    self.navigationItem.title = (mapType==MapPlatformTypeGaode)?@"高德地图":@"百度地图";
    switch (index) {
        case SegmentIndexPOI:
        {
            UIBarButtonItem *rightSwitch = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStylePlain target:self action:@selector(switchMap:)];
            UIBarButtonItem *search = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_green_img"] style:UIBarButtonItemStylePlain target:self action:@selector(search)];
            self.navigationItem.rightBarButtonItems = @[rightSwitch,search];
            break;
        }
        case SegmentIndexMap:
        case SegmentIndexLocation:
        case SegmentIndexOther:
        {
            UIBarButtonItem *rightSwitch = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStylePlain target:self action:@selector(switchMap:)];
            self.navigationItem.rightBarButtonItems = @[rightSwitch];
            break;
        }
        default:
            break;
    }
}

#pragma mark - InquiryViewControllerDelegate 进行poi详情检索
- (void)PoiDetailSearchWithPoiID:(NSString *)poiID
{
    /**
     *  在这里必须要说明一下，searcher最好是全局强引用不让销毁，不然局部走完对象都销毁了
     *  就不会处理回调了
     *  但是百度在这里如果用局部变量引用似乎没事，应该是在发起search请求后百度在内部对searcher的
     *  delegate做了强引用延长生命周期的处理
     */
    PoiDetailSearcher = [_factory getPOIDetailSearcher];
    [PoiDetailSearcher setPoiID:poiID];
    [PoiDetailSearcher setDelegate:self];
    [PoiDetailSearcher startSearching];
}

#pragma mark - IPOIDetailSearcherDelegate poi详情检索回调 在地图上增加大头针
- (void)onGetPOIDetailSearchResult:(id<IPoiDetailSearchResult>)result
{
    [_map addPointAnnotation:nil poi:result];
    [_map setRegion:ZJMapCoordinateRegionMake(result.getLocation, ZJMapCoordinateSpanMake(0.05, 0.05))]; //0.05比较合适
    [result setUserLocation:_userLocation.location.coordinate];
}


#pragma mark - pop up view related to poiDetail view
- (void)showPoiDetailViewWithPoiDetailInfo:(id<IPoiDetailSearchResult>)poiDetailInfo
{
    PoiDetailViewFrameTool *tool = [[PoiDetailViewFrameTool alloc] init];
    [tool configureFrameWithPoiDetailInfo:poiDetailInfo viewWidth:self.view.bounds.size.width];
    if (_poiDetailView) {//说明已经上弹 只刷新页面
         [_poiDetailView configureWithPoiDetailViewTool:tool delegate:self];
    }
    else{//动画上弹
        _poiDetailView = [[PoiDetailView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame), tool.viewHeight)];
        [self.view addSubview:_poiDetailView];
        [_poiDetailView configureWithPoiDetailViewTool:tool delegate:self];
        [self animatePoiDetailView:_poiDetailView withAnimationType:PoiDetailViewAnimationTypeShow];
    }
}

#pragma mark - dismiss poiDetail view
- (void)dismissPoiDetailView
{
    if (_poiDetailView==nil) {//为空说明已经popdown并销毁了
        return;
    }
    [self animatePoiDetailView:_poiDetailView withAnimationType:PoiDetailViewAnimationTypeDismiss];
}

- (void)animatePoiDetailView:(PoiDetailView *)poiDetailView withAnimationType:(PoiDetailViewAnimationType)animationType
{
    UIView *mapView = _map.getMapView;
    CGFloat mapViewMoveDistance = 0;
    CGFloat poiDetailViewMoveDistance = 0;
    if (animationType==PoiDetailViewAnimationTypeShow) {
        mapViewMoveDistance = -poiDetailView.tool.animateVerticalMoveDistance;
        poiDetailViewMoveDistance = -poiDetailView.tool.viewHeight;
    }
    else{
        mapViewMoveDistance = poiDetailView.tool.animateVerticalMoveDistance;
        poiDetailViewMoveDistance = poiDetailView.tool.viewHeight;
    }
    [UIView animateWithDuration:poiDetailViewAnimateTime delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
       poiDetailView.transform = CGAffineTransformTranslate(poiDetailView.transform, 0,poiDetailViewMoveDistance);
        
//        CGRect mapViewFrame = mapView.frame ;
//        CGSize mapViewSize = mapViewFrame.size;
//        mapViewSize.height += mapViewMoveDistance;
//        mapViewFrame.size = mapViewSize;
//        mapView.frame = mapViewFrame;
    } completion:^(BOOL finished) {
        if (animationType==PoiDetailViewAnimationTypeDismiss) {
            [poiDetailView removeFromSuperview];
            _poiDetailView = nil;
        }
    }];
}

#pragma mark - PoiDetailViewDelegate
- (void)arrowDownButtonClicked
{
    [_map deselectAnnotationView];
    [self dismissPoiDetailView];
}

- (void)goThereButtonClickedWithPoiInfo:(id<IPoiDetailSearchResult>)poiDetailInfo
{
    [self arrowDownButtonClicked];
    _driveRouteService = [_factory getDriveRouteService];
    [_driveRouteService setDelegate:self];
    [_driveRouteService setStartPoint:poiDetailInfo.userLocation endPoint:poiDetailInfo.getLocation];
    [_driveRouteService startRouteSearching];
    
}

#pragma mark - IMapDelegate
- (void)mapViewDidAddAnnotationView:(id<IAnnotationView>)annotationView poiDetailInfo:(id<IPoiDetailSearchResult>)poiDetailInfo
{
    [_map storeSelectedAnnotationView:annotationView];
    [self showPoiDetailViewWithPoiDetailInfo:poiDetailInfo];
}

- (void)mapViewDidSelectAnnotationView:(id<IAnnotationView>)annotationView poiDetailInfo:(id<IPoiDetailSearchResult>)poiDetailInfo
{   
    [self showPoiDetailViewWithPoiDetailInfo:poiDetailInfo];
}

- (void)mapViewDidDeselectAnnotationView:(id<IAnnotationView>)annotationView poiDetailInfo:(id<IPoiDetailSearchResult>)poiDetailInfo
{
    //[self dismissPoiDetailView];
}

#pragma mark - 路径规划成功后的回调
- (void)onGetRoutesSuccess:(NSArray<NSDictionary<NSNumber *,NSArray<id<INaviRoutePoint>> *> *> *)routes
{
    [_map addRouteLinesWithRoutes:routes];
}
@end
