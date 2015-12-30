//
//  PictureSelectionViewController.swift
//  Virtual Tourist
//
//  Created by Ayush Saraswat on 12/20/15.
//  Copyright © 2015 Ayush Saraswat. All rights reserved.
//

import Foundation
import CoreData
import MapKit

class PictureSelectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, NSFetchedResultsControllerDelegate {
    
    var currentStatus : Bool!
    var selectedLocation : CLLocationCoordinate2D!
    var pin : Pin!
    var selectedIndexes = [NSIndexPath]()
    var page = 1
    
    // Keep the changes
    var changes: [(NSFetchedResultsChangeType, NSIndexPath)]?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomButton: UIBarButtonItem!
    @IBOutlet weak var noImagesFoundLabel: UILabel!

    var cancelButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noImagesFoundLabel.alpha = 0.0
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let width = floor(self.collectionView.frame.size.width/3)
        layout.itemSize = CGSize(width: width, height: width)
        collectionView.collectionViewLayout = layout
        
        mapView.userInteractionEnabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        if (pin != nil){
            
            let count = pin.pictures.count
            
            if(count == 0){
            }
            
            do {
                // Start the controller up
                try fetchedResultsController.performFetch()
            } catch _ {
            }
            
            if pin.pictures.count == 0 {
                fetchNewCollection()
            }
            
            // Set the map
            let center = CLLocationCoordinate2D(latitude: CLLocationDegrees(pin.lat), longitude: CLLocationDegrees(pin.long))
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let myRegion = MKCoordinateRegionMake(center, span)
            
            self.mapView.setRegion(myRegion, animated: true)
            
            // Add the pin
            let annotation = MKPointAnnotation()
            annotation.coordinate = center
            self.mapView.addAnnotation(annotation)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        Flickr.sharedInstance().cancelAllTasks()
    }
    
    
    // MARK: - Configure Cell
    
    func configureCell(cell: CollectionViewCellForPicture, atIndexPath indexPath: NSIndexPath) {
        
        let picture = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Picture
        _ = picture.managedObjectContext
        
        cell.image.image = UIImage(named: "placeholder")
        
        cell.setPictureForCell(picture)
        
        if picture.image == nil {
            Flickr.sharedInstance().taskForPictureData(picture) { (data, error) -> (Void) in
                
                if let error = error {
                    print(error)
                }
                
                if let data = data {
                    picture.image = UIImage(data: data)
                    picture.hasBeenDownloaded = true
                    
                    CoreDataStackManager.sharedInstance.saveContext()
                }
            }
        }
        
        if (selectedIndexes.contains(indexPath)){
            cell.removeImage.hidden = true
            cell.image.alpha = 0.2
        } else {
            cell.removeImage.hidden = true
            cell.image.alpha = 1.0
        }
    }
    
    
    // MARK: - UICollectionView
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCellForPicture
        
        self.configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCellForPicture

        if let index = selectedIndexes.indexOf(indexPath) {
            selectedIndexes.removeAtIndex(index)
            cell.image.alpha = 1.0
        } else {
            selectedIndexes.append(indexPath)
            cell.image.alpha = 0.2
        }
        
        updateBottomButton()
    }
    
    
    // MARK: - NSFetchedResultsController

    lazy var fetchedResultsController: NSFetchedResultsController = {
        
        
        let fetchRequest = NSFetchRequest(entityName: Picture.entityName())
        fetchRequest.predicate = NSPredicate(format: "pin == %@", self.pin)
        fetchRequest.fetchBatchSize = 100
        fetchRequest.sortDescriptors = []
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStackManager.sharedInstance.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        return fetchedResultsController
    }()
    
    
    // MARK: - Fetched Results Controller Delegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        changes = [(NSFetchedResultsChangeType, NSIndexPath)]()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        collectionView.performBatchUpdates({() -> Void in
            for change in self.changes! {
                switch (change) {
                    
                case (.Insert, let indexPath):
                    self.collectionView.insertItemsAtIndexPaths([indexPath])
                case (.Update, let indexPath):
                    self.collectionView.reloadItemsAtIndexPaths([indexPath])
                case (.Delete, let indexPath):
                    self.collectionView.deleteItemsAtIndexPaths([indexPath])
                default:
                    break
                }
            }
        }, completion: { (success: Bool) -> Void in
        })
    }

    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type{
        case .Insert:
            let change = (type, newIndexPath!)
            changes!.append(change)
            break
        case .Delete:
            let change = (type, indexPath!)
            changes!.append(change)
            break
        case .Update:
            let change = (type, indexPath!)
            changes!.append(change)
            break
        case .Move:
            break
        }
    }
    

    @IBAction func buttonClicked(sender: AnyObject) {
        
        if selectedIndexes.isEmpty {
            disableUserInteraction()
            Flickr.sharedInstance().cancelAllTasks()
            deleteTheOldCollection()
            fetchNewCollection()
        } else {
            deleteSelectedPictures()
        }
        
        CoreDataStackManager.sharedInstance.saveContext()

        
        updateBottomButton()
    }
    
    func deleteSelectedPictures() {
        var picturesToDelete = [Picture]()
        
        for indexPath in selectedIndexes {
            picturesToDelete.append(fetchedResultsController.objectAtIndexPath(indexPath) as! Picture)
        }
        
        for picture in picturesToDelete {
            CoreDataStackManager.sharedInstance.managedObjectContext.deleteObject(picture)

        }
        
        selectedIndexes = [NSIndexPath]()
    }
    
    func deleteTheOldCollection() {
        pin.pictures.enumerateObjectsUsingBlock { (elem, idx, stop) -> Void in
            CoreDataStackManager.sharedInstance.managedObjectContext.deleteObject(elem as! Picture)

        }
    }
    
    func fetchNewCollection() {
        
        disableUserInteraction()
        
        Flickr.sharedInstance().taskForFetchingPicturesForPin(pin, page: page++) { results, error in
            
            if let error = error {
                print(error)
                abort()
            }
            
            if let results = results {
                
                if results.isEmpty {
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        UIView.animateWithDuration(0.2) {
                            self.noImagesFoundLabel.alpha = 1.0
                        }
                    }
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    for dictionary in results {
                        let picture = Picture.insertNewObjectForDictionary(dictionary, inContext: CoreDataStackManager.sharedInstance.managedObjectContext)

                        picture.pin = self.pin
                    }
                    CoreDataStackManager.sharedInstance.saveContext()
                }
                
            }
        }
    
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "enableUserInteraction", userInfo: nil, repeats: false)
    }
    
    func disableUserInteraction() {
        self.view.userInteractionEnabled = false
        self.bottomButton.enabled = false
    }

    func enableUserInteraction() {
        self.view.userInteractionEnabled = true
        self.bottomButton.enabled = true
    }

    func updateBottomButton() {
        if selectedIndexes.count > 0 {
            bottomButton.title = "Remove Selected Pictures"
        } else {
            bottomButton.title = "New Collection"
        }
    }
    
    @IBAction func cancel(sender: AnyObject) {
        self.navigationController!.popViewControllerAnimated(true)
    }
}