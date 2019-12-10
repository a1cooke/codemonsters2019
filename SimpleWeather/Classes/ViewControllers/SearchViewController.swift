//
//  SearchViewController.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 1/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import MapKit

class SearchViewController: UIViewController,
UISearchBarDelegate,
    ListAdapterDataSource,
MKLocalSearchCompleterDelegate,
ListSingleSectionControllerDelegate {

    @IBOutlet weak var collectionView: ListCollectionView!

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    var store: SavedLocationStore?

    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.showsCancelButton = true
        bar.sizeToFit()
        bar.delegate = self
        bar.tintColor = .white
        bar.placeholder = NSLocalizedString("Search for locations", comment: "")
        return bar
    }()

    lazy var searchCompleter: MKLocalSearchCompleter = {
        let completer = MKLocalSearchCompleter()
        completer.delegate = self
        completer.filterType = .locationsAndQueries
        return completer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()

        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    // MARK: UISearchBarDelegate

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
    }

    // MARK: MKLocalSearchCompleterDelegate

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        adapter.performUpdates(animated: true)
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {

    }

    // MARK: IGListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return searchCompleter.results
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        let controller = SearchResultSectionController()
        controller.selectionDelegate = self
        return controller
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

    // MARK: ListSingleSectionControllerDelegate

    func didSelect(_ sectionController: ListSingleSectionController, with object: Any) {
        guard let object = adapter.object(for: sectionController) as? MKLocalSearchCompletion else { return }
        let searchRequest = MKLocalSearch.Request(completion: object)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            if let mapItem = response?.mapItems.first,
                let name = mapItem.name {
                let location = SavedLocation(
                    name: name,
                    latitude: mapItem.placemark.coordinate.latitude,
                    longitude: mapItem.placemark.coordinate.longitude,
                    userLocation: false
                )
                self.store?.add(location: location)
                self.dismiss(animated: true)
            } else {
                let alert = UIAlertController(
                    title: NSLocalizedString("Error", comment: ""),
                    message: NSLocalizedString("There was a problem saving the location.", comment: ""),
                    preferredStyle: .alert
                )
                let action = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true)
            }
        }
    }

}
