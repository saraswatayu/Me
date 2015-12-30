//
//  MKMapViewController.swift
//  Virtual Tourist
//
//  Created by Ayush Saraswat on 12/20/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

import Foundation
import CoreData
import MapKit

class MKMapViewController: UIViewController, MKMapViewDelegate,  NSFetchedResultsControllerDelegate {
    
    let EditLabelHeight: CGFloat = 70
    
    var managedObjectContext: NSManagedObjectContext? = nil
    
    @IBOutlet var mapView: MKMapView!
    var editLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: Selector("longPressToLocation:"))
        mapView.addGestureRecognizer(gestureRecognizer)
        
        self.managedObjectContext = CoreDataStackManager.sharedInstance.managedObjectContext

        self.fetchedResultsController
        
        self.restoreMapRegion(false)
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.title = "Virtual Tourist"
        
        editLabel = UILabel(frame: editLabelFrameForSize(view.frame.size))
        editLabel.backgroundColor = UIColor.redColor()
        editLabel.textColor = UIColor.whiteColor()
        editLabel.textAlignment = NSTextAlignment.Center
        editLabel.text = "Tap Pins to Delete"
        
        self.view.addSubview(editLabel)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "OK", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
    }
    
    func  editLabelFrameForSize(size: CGSize) -> CGRect {
        let editingShift:CGFloat = EditLabelHeight * (editing ? -1 : 0)
        let labelY = size.height + editingShift
        let labelRect = CGRectMake(0, labelY, size.width, EditLabelHeight)
        
        return labelRect
    }
    
    func  mapFrameForSize(size: CGSize) -> CGRect {
        let editingShift:CGFloat = EditLabelHeight * (editing ? -1 : 0)
        let labelY = editingShift
        let labelRect = CGRectMake(0, labelY, size.width, size.height)
        
        return labelRect
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        
        coordinator.animateAlongsideTransition({ context -> Void in
            self.editLabel.frame = self.editLabelFrameForSize(size)
            self.mapView.frame = self.mapFrameForSize(size)
            }, completion: nil)
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        let yOffset = EditLabelHeight * (editing ? -1 : 1)
        
        if (animated) {
            UIView.animateWithDuration(0.15) {
                self.mapView.frame = CGRectOffset(self.mapView.frame, 0, yOffset)
                self.editLabel.frame = CGRectOffset(self.editLabel.frame, 0, yOffset)
            }
        } else {
            mapView.frame = CGRectOffset(mapView.frame, 0, yOffset)
            editLabel.frame = CGRectOffset(editLabel.frame, 0, yOffset)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Add Pin
    func addPin(selectedLocation : CLLocationCoordinate2D?){
        if let selectedLocation = selectedLocation {
            let pin = Pin.insertNewObjectInManagedObjectContext(self.managedObjectContext!)
            pin.lat = Float(selectedLocation.latitude)
            pin.long = Float(selectedLocation.longitude)
            pin.timeStamp = NSDate().timeIntervalSince1970
            pin.title = "Pin"
        }
    }
    
    // MARK: - Long Press Gesture Recognizer - Add annotation
    func longPressToLocation(gestureRecognizer: UIGestureRecognizer!) ->(){
        if(gestureRecognizer.state == UIGestureRecognizerState.Began && !editing){
            let touchPoint = gestureRecognizer.locationInView(mapView)
            let selectedLocation = self.mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
            
            self.addPin(selectedLocation)
            
        }
    }
    
    func addAnnotationView(selectedLocation : CLLocationCoordinate2D?){
        //Add annotation to location
        if let selectedLocation = selectedLocation {
            let newAnnotation = MKPointAnnotation()
            newAnnotation.coordinate = selectedLocation
            self.mapView.addAnnotation(newAnnotation)
        }
    }
    
    
    // MARK: - MapView Delegate
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation, animated: false)
        
        if self.editing {
            if let pin = pinForAnnotation(view.annotation!) {
                // Perform as seperate events, to remove tiny pause before pin dissapears.
                dispatch_async(dispatch_get_main_queue()) {self.mapView.removeAnnotation(view.annotation!)}
                dispatch_async(dispatch_get_main_queue()) {self.managedObjectContext!.deleteObject(pin)}
            } else {
                print("cannot find pin to delete it")
            }
            
            
        } else {
            self.performSegueWithIdentifier("PictureSelectionStoryboardSegue", sender: view.annotation)
        }
    }
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        self.saveMapRegion()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PictureSelectionStoryboardSegue"{
            let destination = segue.destinationViewController as! PictureSelectionViewController
            let annotation = sender as! MKAnnotation
            
            destination.pin = pinForAnnotation(annotation)
        }
    }
    
    func pinForAnnotation(annotation: MKAnnotation) -> Pin? {
        for obj in _fetchedResultsController?.fetchedObjects as! [Pin]{
            if CLLocationDegrees(obj.lat) == annotation.coordinate.latitude && CLLocationDegrees(obj.long) == annotation.coordinate.longitude{
                return obj
            }
        }
        
        print("cannot find pin")
        return nil
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationReuseIdentifier")
        pinAnnotationView.animatesDrop = true
        return pinAnnotationView
    }
    
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest(entityName: "Pin")
        fetchRequest.fetchBatchSize = 100
        fetchRequest.sortDescriptors = []
        
        
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStackManager.sharedInstance.managedObjectContext, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
            
            for obj in _fetchedResultsController?.fetchedObjects as! [Pin]{
                self.addAnnotationView(CLLocationCoordinate2D(latitude: CLLocationDegrees(obj.lat), longitude: CLLocationDegrees(obj.long)))
            }
        } catch {
            abort()
        }
        
        return _fetchedResultsController!
    }
    
    // TODO: change to lazy var
    var _fetchedResultsController: NSFetchedResultsController? = nil
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            let pin = self.fetchedResultsController.objectAtIndexPath(newIndexPath!) as! Pin
            
            self.addAnnotationView(CLLocationCoordinate2D(latitude: CLLocationDegrees(pin.lat), longitude: CLLocationDegrees(pin.long)))
            
        default:
            return
        }
    }
    
    
    // MARK: - Save the zoom level helpers
    
    let MapRegionKey = "MKMapKitViewController.MapRegionData"
    
    func saveMapRegion() {
        let dictionary = [
            "latitude" : mapView.region.center.latitude,
            "longitude" : mapView.region.center.longitude,
            "latitudeDelta" : mapView.region.span.latitudeDelta,
            "longitudeDelta" : mapView.region.span.longitudeDelta
        ]
        
        NSUserDefaults.standardUserDefaults().setObject(dictionary, forKey: MapRegionKey)
    }
    
    func restoreMapRegion(animated: Bool) {
        if let regionDictionary = NSUserDefaults.standardUserDefaults().valueForKey(MapRegionKey) as? [String : AnyObject] {
            
            let longitude = regionDictionary["longitude"] as! CLLocationDegrees
            let latitude = regionDictionary["latitude"] as! CLLocationDegrees
            let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            let longitudeDelta = regionDictionary["latitudeDelta"] as! CLLocationDegrees
            let latitudeDelta = regionDictionary["latitudeDelta"] as! CLLocationDegrees
            let span = MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta)
            
            let savedRegion = MKCoordinateRegion(center: center, span: span)
            
            mapView.setRegion(savedRegion, animated: animated)
        }
    }
}




