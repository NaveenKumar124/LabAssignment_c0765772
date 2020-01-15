//
//  ViewController.swift
//  LabAssignment_c0765772
//
//  Created by Navi Malhotra on 2020-01-14.
//  Copyright © 2020 Naveen Kumar. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var findMyWay: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var stepper: UIStepper!
    
        private let locationManager = CLLocationManager()
    
        private var currentCoordinate: CLLocationCoordinate2D?

        @IBOutlet weak var mapView: MKMapView!

        override func viewDidLoad() {
            
            super.viewDidLoad()
            
            configureLocationServices()
            
        }

        private func configureLocationServices() {
            
            locationManager.delegate = self

            let status = CLLocationManager.authorizationStatus()

            if status == .notDetermined {
                
                locationManager.requestWhenInUseAuthorization()
                
            }
            
            else if status == .authorizedAlways || status == .authorizedWhenInUse {
                
               beginLocationsUpdate(locationManager: locationManager)
                
            }
        }

    @IBAction func sTepper(_ sender: UIStepper) {
        
    }
    
    private func beginLocationsUpdate(locationManager: CLLocationManager) {
        
           mapView.showsUserLocation = true
           
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
           locationManager.startUpdatingLocation()
            
            self.locationManager.requestWhenInUseAuthorization()

        }

        private func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D) {
    
            let zoomRegion = MKCoordinateRegion.init(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(zoomRegion, animated: true)
            
        }
    
    //    let uilpgr = UITapGestureRecognizer(target: self, action: #selector(Tap))
      //  mapView.addGestureRecognizer(uilpgr)

    @IBAction func FindMyWay(_ sender: UIButton) {
        
        //FindMyWay Button
        
    }
}

//let latDelta: CLLocationDegrees = 0.05
//let longDelta: CLLocationDegrees = 0.05
//
//// define span
//let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
//
//// define location
//let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//
//// define the region
//let region = MKCoordinateRegion(center: location, span: span)
//
//// set the region on the map
//mapView.setRegion(region, animated: true)
//
//let annotation = MKPointAnnotation()
//    annotation.title = "Toronto City"
//    annotation.subtitle = "City of Dreams"
//    annotation.coordinate = location
//    mapView.addAnnotation(annotation)
//
//    // add double press gesture
//    let uilpgr = UITapGestureRecognizer(target: self, action: #selector(Tap))
//    mapView.addGestureRecognizer(uilpgr)
//}
//

//@objc func doublePress(gestureRecognizer: UIGestureRecognizer) {
//
//   UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: tableViewController action: @selector (handleDoubleTapOnView:)]
//
//[doubleTapRecognizer setNumberOfTouchesRequired:2]
//
//[singleTapRecognizer requireGestureRecognizerToFail: doubleTapRecognizer]
//
//[view addGestureRecognizer: doubleTapRecognizer]
//
//}

//
//    let annotation = MKPointAnnotation()
//    annotation.title = "place to visit"
//    annotation.coordinate = coordinate
//    mapView.addAnnotation(annotation)

//MKMapView.CameraZoomRange(maxCenterCoordinateDistance: <#T##CLLocationDistance#>)

//let region = MKCoordinateRegionMake(self.mapView.region.center, MKCoordinateSpanMake(mapView.region.span.latitudeDelta*0.7, mapView.region.span.longitudeDelta*0.7))
//mapView.setRegion(region, animated: true)
//
//let zoom = getZoom() // to get the value of zoom of your map.
//if zoom > 3.5{ // **here i have used the condition that avoid the mapview to zoom less then 3.5 to avoid crash.**
//
//         let region = MKCoordinateRegionMake(self.mapView.region.center, MKCoordinateSpanMake(mapView.region.span.latitudeDelta/0.7, mapView.region.span.longitudeDelta/0.7))
//         mapView.setRegion(region, animated: true)
//     }
//
//func getZoom() -> Double {
//
//    var angleCamera = self.mapView.camera.heading
//    if angleCamera > 270 {
//        angleCamera = 360 - angleCamera
//    } else if angleCamera > 90 {
//        angleCamera = fabs(angleCamera - 180)
//    }
//    let angleRad = Double.pi * angleCamera / 180
//    let width = Double(self.view.frame.size.width)
//    let height = Double(self.view.frame.size.height)
//    let heightOffset : Double = 20
//    let spanStraight = width * self.mapView.region.span.longitudeDelta / (width * cos(angleRad) + (height - heightOffset) * sin(angleRad))
//    return log2(360 * ((width / 256) / spanStraight)) + 1;
//}


    extension ViewController: CLLocationManagerDelegate {

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            print("Did Get Latest Location")

            guard let latestLocation = locations.first else {return}

            if currentCoordinate == nil {
                zoomToLatestLocation(with: latestLocation.coordinate)
            }

            currentCoordinate = latestLocation.coordinate
            
        }

//        func NSLocationWhenInUseUsageDescription(){
//
//        }
        
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            
            print("The Status Changed")
            
            if status == .authorizedAlways || status == .authorizedWhenInUse {
               beginLocationsUpdate(locationManager: manager)
                
            }

    
//     var locationManager = CLLocationManager()
//
//
//    @IBOutlet weak var mapView: MKMapView!
//
//        let places = Place.getPlaces()
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            // Do any additional setup after loading the view.
//            mapView.showsUserLocation = true
//
//            locationManager.delegate = self as! CLLocationManagerDelegate
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.requestWhenInUseAuthorization()
//            //        locationManager.startUpdatingLocation()
//
//            addAnnotations()
//    //        addPolyLine()
//            addPolygon()
//        }
//
//        func addAnnotations() {
//            mapView.delegate = self
//            mapView.addAnnotations(places)
//
//            let overlays = places.map { (MKCircle(center: $0.coordinate, radius: 1000)) }
//            mapView.addOverlays(overlays)
//        }
//
//        func addPolyLine() {
//            let locations = places.map {$0.coordinate}
//            let polyline = MKPolyline(coordinates: locations, count: locations.count)
//            mapView.addOverlay(polyline)
//        }
//
//        func addPolygon() {
//            let locations = places.map{$0.coordinate}
//            let polygon = MKPolygon(coordinates: locations, count: locations.count)
//            mapView.addOverlay(polygon)
//        }
//
//    }
//
//    extension ViewController: MKMapViewDelegate {
//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            if annotation is MKUserLocation {
//                return nil
//            } else {
//                let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotionView") ?? MKAnnotationView()
//                annotationView.image = UIImage(named: "ic_place")
//                annotationView.canShowCallout = true
//                annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//                return annotationView
//            }
//        }
//
//
//        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//            if overlay is MKCircle {
//                let rendrer = MKCircleRenderer(overlay: overlay)
//                rendrer.fillColor = UIColor.black.withAlphaComponent(0.5)
//                rendrer.strokeColor = UIColor.green
//                rendrer.lineWidth = 2
//                return rendrer
//            } else if overlay is MKPolyline {
//                let rendrer = MKPolylineRenderer(overlay: overlay)
//                rendrer.strokeColor = UIColor.blue
//                rendrer.lineWidth = 3
//                return rendrer
//            } else if overlay is MKPolygon {
//                let rendrer = MKPolygonRenderer(overlay: overlay)
//                rendrer.fillColor = UIColor.black.withAlphaComponent(0.5)
//                rendrer.strokeColor = UIColor.orange
//                rendrer.lineWidth = 2
//                return rendrer
//            }
//            return MKOverlayRenderer()
//        }
//
//        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//            guard let annotation = view.annotation as? Place, let title = annotation.title else {
//                return
//            }
//
//            let alertController = UIAlertController(title: "Welcome to \(title)", message: "Have a good time in \(title)", preferredStyle: .alert)
//            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//            alertController.addAction(cancelAction)
//            present(alertController, animated: true, completion: nil)
//        }
        
}

}
