//
//  ScrollViewController.m
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/17/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScrollViewController.h"
#import "ScrollableContentController.h"


static NSString *kTitleKey = @"TitleKey";
static NSString *kImageKey = @"ImageKey";


@interface ScrollViewController ()


@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;

@property (nonatomic, strong) NSMutableArray *viewControllers;


@end


@implementation ScrollViewController

-(void)viewWillLayoutSubviews{
    
    
    [super viewWillLayoutSubviews];
    
    /**
    [self.view setBackgroundColor:[UIColor orangeColor]];
    
    /
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:_scrollView];
    
    NSArray<NSLayoutConstraint*>* scrollViewConstraints = [NSArray arrayWithObjects:[[_scrollView topAnchor] constraintEqualToAnchor:[self.view topAnchor] constant:0.00],
        [[_scrollView leftAnchor] constraintEqualToAnchor:[self.view leftAnchor] constant:0.00],
        [[_scrollView rightAnchor] constraintEqualToAnchor:[self.view rightAnchor] constant:0.00],
        [[_scrollView heightAnchor] constraintEqualToAnchor:[self.view heightAnchor] multiplier:0.80],
        nil];
    
    [NSLayoutConstraint activateConstraints:scrollViewConstraints];
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:_pageControl];
    
    NSArray<NSLayoutConstraint*>* pageControlConstraints = [NSArray arrayWithObjects:[[_pageControl centerXAnchor] constraintEqualToAnchor:[self.view centerXAnchor] constant:0.00],
        [[_pageControl bottomAnchor] constraintEqualToAnchor:[self.view bottomAnchor] constant:-20.00],
        [[_pageControl topAnchor] constraintEqualToAnchor:[_scrollView bottomAnchor] constant:10.00],
        [[_pageControl widthAnchor] constraintEqualToAnchor:[self.view widthAnchor] multiplier:0.50],
        nil];
    
    [NSLayoutConstraint activateConstraints:pageControlConstraints];
    **/
    
}

-(void) viewWillAppear:(BOOL)animated{
   
}

/** Configure the scroll view and page control, and load the view controllers array with null placeholder values; set the initial page in the scroll view as well as the adjacent pages to avoid causing flahses when scrolling occurs **/

-(void) viewDidLoad{
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"contentList" ofType:@"plist"];
    
    NSArray* contentList = [NSArray arrayWithContentsOfFile:path];
    
    [self setContentList:contentList];
    
    
    NSLog(@"Loading the view for the scroll view controller....");
    
    [super viewDidLoad];
    
    NSUInteger numberOfPages = [[self contentList] count];
    
    //Load the viewcontrollers array with placeholders that will replaced on demand
    
    NSMutableArray* controllers = [[NSMutableArray alloc]init];
    
    for(NSUInteger i = 0; i < numberOfPages; i++){
        
        [controllers addObject:[NSNull null]];
    }
    
    [self setViewControllers:controllers];
    
    
    //Configure the scroll view properties
    
    [[self scrollView] setPagingEnabled:YES];
    [[self scrollView] setDelegate:self];
    [[self scrollView] setScrollsToTop:NO];
    [[self scrollView] setShowsVerticalScrollIndicator:NO];
    [[self scrollView] setShowsHorizontalScrollIndicator:NO];
    [[self scrollView] setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.frame)*numberOfPages, CGRectGetHeight(self.scrollView.frame))];
    
    [[self scrollView] setScrollEnabled:YES];
    
    //Configure page control properties
    
    [[self pageControl] setNumberOfPages:numberOfPages];
    [[self pageControl] setCurrentPage:0];
    
    
    //TODO: Load the pages on either side of the current page
    
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
   
    NSLog(@"Finished loading the view for the scroll view controller....");

    
}


- (void) loadScrollViewWithPage:(NSUInteger)page{
    
    /** The currentPageIndex begins at zero and can be incremented to one less than the total number of pages **/
    
    if(page >= [[self contentList] count]){
        return;
    }
    
    
    /** replace the placeholder if necessary **/
    
    ScrollableContentController* controller = [[self viewControllers] objectAtIndex:page];
    
    if((NSNull*)controller == [NSNull null]){
        
        UIStoryboard* mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        controller = [mainStoryBoard instantiateViewControllerWithIdentifier:@"ScrollableContentController"];
        
        [[self viewControllers] replaceObjectAtIndex:page withObject:controller];
    }
    
    
    /** add the controllers view to the subview; although the controller will have been allocated and initialized, it's view's superview will remain null until the view is loaded **/
    
    if(controller.view.superview == nil){
        
        //Configure the frame fo the view to be loaded so that the x-coordinate of it's origin is offset by a multiple of the page width equal to its corresponding page number
        CGRect frame = self.scrollView.frame;
        frame.origin.x = CGRectGetWidth(frame)*page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        
        
        [self addChildViewController:controller];
        [self.view addSubview:controller.view];
        [controller didMoveToParentViewController:self];
        
        
        NSDictionary* pageConfigurationInfo = [[self contentList] objectAtIndex:page];
        controller.previewImage.image = [UIImage imageNamed:[pageConfigurationInfo valueForKey:kImageKey]];
        controller.previewTitle.text = [pageConfigurationInfo valueForKey:kTitleKey];
        
        
        NSLog(@"The content size is width: %f, height:%f",[self.scrollView contentSize].width,[self.scrollView contentSize].height);
        
    }
    
}

/** Helper Function (for optimization: Not yet fully tested **/
- (void) unloadNonvisiblePagesFromScrollView{
    
    NSUInteger currentPage = [[self pageControl] currentPage];
    
    for(NSUInteger pageIndex = 0; pageIndex < [[self contentList] count]; pageIndex++){
        
        if(pageIndex < currentPage-1 | pageIndex > currentPage+1){
            
            
            if(![[self viewControllers] objectAtIndex:pageIndex]){
                
                ScrollableContentController* viewController = [[self viewControllers] objectAtIndex:pageIndex];
                
                //Remove the view controller's view from the scroll view container
                [viewController.view removeFromSuperview];
                
                //Remove the view controller from its parent view controller
                [viewController removeFromParentViewController];
                
                [[self viewControllers] replaceObjectAtIndex:pageIndex withObject:[NSNull null]];
            }
        }
    }
}

- (IBAction)changePage:(id)sender {
    [self goToPage:YES];
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat contentOffsetX = self.scrollView.contentOffset.x;
    CGFloat contentOffsetY = self.scrollView.contentOffset.y;
    
    
    NSLog(@"Scroll view scrolled. Current content offset is x: %f, y: %f",contentOffsetX,contentOffsetY);
    /**
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    NSUInteger page = floor((self.scrollView.contentOffset.x - pageWidth)/2)/pageWidth + 1;
    self.pageControl.currentPage = page;
    
    [self loadScrollViewWithPage:page-1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page+1];
     **/
}

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat pageWidth = CGRectGetWidth(self.scrollView.frame);
    NSUInteger page = floor((self.scrollView.contentOffset.x - pageWidth)/2)/pageWidth + 1;
    self.pageControl.currentPage = page;
    
    [self loadScrollViewWithPage:page-1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page+1];
    
}

- (void) goToPage:(BOOL)animated{
    NSInteger page = self.pageControl.currentPage;
    
    [self loadScrollViewWithPage:page-1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page+1];
    
    CGRect bounds = self.scrollView.bounds;
    bounds.origin.x = CGRectGetWidth(bounds)*page;
    bounds.origin.y = 0;
    [self.scrollView scrollRectToVisible:bounds animated:animated];
}

@end
