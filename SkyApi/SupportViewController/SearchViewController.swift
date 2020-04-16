/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2018B
 Assessment: Project
 Group: Fatal Error
 Author: LE, Minh Truyen
 ID: s3627577
 Created date: 21/09/2018

 Acknowledgment:
 http://theswiftguy.com/index.php/2017/07/03/mapviewsearch/
 */

// this class contains the logics to performe a search for location

import UIKit
import MapKit

class SearchViewController: UIViewController, UINavigationControllerDelegate, UISearchBarDelegate, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mapView.isZoomEnabled = true
        if LocationHandler.location != nil {
            self.addNewAnotation(title: "Current City", latitude: (LocationHandler.location?.coordinate.latitude)!, longitude: (LocationHandler.location?.coordinate.longitude)!)
            self.zoomToAnnotation(latitude: (LocationHandler.location?.coordinate.latitude)!, longitude: (LocationHandler.location?.coordinate.longitude)!)
        }
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func searchBtnAdd(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //Hide searcbar
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        //Search Request
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request: searchRequest)
        activeSearch.start { (response, error) in
            
            //Remove all anotation
            if response != nil {
                self.removeAllAnnotations()
                
                //Get Location
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //Create new anotation
                self.addNewAnotation(title: searchBar.text!, latitude: latitude!, longitude: longitude!)
                
                //Zoom to the annotation
                self.zoomToAnnotation(latitude: latitude!, longitude: longitude!)
            }
            
            
        }
    }
    
    @IBAction func doneBtnTapped(_ sender: Any) {
        if let annotation = mapView.annotations.first{
            let newLocation = CLLocation(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
            (navigationController?.viewControllers.first as! CurrentViewController).locationHandler.locationSelected(location: newLocation)
        }
        
        _ = navigationController?.popToRootViewController(animated: true)
        
    }
    
    func addNewAnotation (title: String, latitude: Double, longitude: Double) {
        let newAnotation = MKPointAnnotation()
        newAnotation.title = title
        newAnotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        self.mapView.addAnnotation(newAnotation)
    }
    
    func removeAllAnnotations() {
        mapView.removeAnnotations(self.mapView.annotations)
    }
    
    func zoomToAnnotation(latitude: Double, longitude: Double) {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2DMake(latitude, longitude), span: MKCoordinateSpan(latitudeDelta: 0.25, longitudeDelta: 0.25))
        mapView.setRegion(region, animated: true)
    }
    
    // MARK: -Map View
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let coordinate = mapView.convert(touch.location(in: mapView), toCoordinateFrom: mapView)
            self.removeAllAnnotations()
            self.addNewAnotation(title: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
    }
    
    
    

}
