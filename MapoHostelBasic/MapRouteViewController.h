//
//  MapRouteViewController.h
//  MapoHostelBasic
//
//  Created by Aleksander Makedonski on 6/17/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

#ifndef MapRouteViewController_h
#define MapRouteViewController_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
/** 
 
User selects source and destinations, each of which are selected from separate tableview interfaces presented modally 
 
 Use tab control to switch betwen 3D and 2D map viewing modes
 
 MapKit View is display in the middle of the app
 
 Travel time and distance are displayed at the bottom of the view
 
**/

@interface MapRouteViewController : UIViewController<MKMapViewDelegate>

@property MKMapView* mainMapView;

@end

#endif /* MapRouteViewController_h */


/** Sample Implementation from Location and Maps Programming Guide
 
 Listing 7-4  Requesting directions
 
 MKDirectionsRequest *walkingRouteRequest = [[MKDirectionsRequest alloc] init];
 walkingRouteRequest.transportType = MKDirectionsTransportTypeWalking;
 [walkingRouteRequest setSource:[startPoint mapItem]];
 [walkingRouteRequest setDestination :[endPoint mapItem]];
 
 MKDirections *walkingRouteDirections = [[MKDirections alloc] initWithRequest:walkingRouteRequest];
 [walkingRouteDirections calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * walkingRouteResponse, NSError *walkingRouteError) {
 if (walkingRouteError) {
 [self handleDirectionsError:walkingRouteError];
 } else {
 // The code doesn't request alternate routes, so add the single calculated route to
 // a previously declared MKRoute property called walkingRoute.
 self.walkingRoute = walkingRouteResponse.routes[0];
 }
 }];
 
 A route object defines the geometry for one route and includes a polyline object that you can use as an overlay to show the route on a map. If you requested alternate routes, the response object that gets passed to your completion handler can contain multiple route objects in its routes array. Listing 7-5 shows one way to iterate over an array of routes and display the polyline associated with each alternate route.
 
 Listing 7-5  Displaying alternate routes
 
 - (void) myShowDirections:(MKDirectionsResponse *)response {
 self.response = response;
 for (MKRoute *route in self.response.routes) {
 [self.mapView addOverlay:route.polyline level:MKOverlayLevelAboveRoads];
 }
 }



**/
