//
//  SavedLocationsViewController.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 12/18/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

class SavedLocationsViewController: UIViewController, ListAdapterDataSource, SavedLocationStoreListener {
    
    @IBOutlet weak var collectionView: ListCollectionView!

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    var store: SavedLocationStore?

    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.collectionView = collectionView
        adapter.dataSource = self

        store?.add(listener: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nav = segue.destination as? UINavigationController,
            let controller = nav.viewControllers.first as? SearchViewController {
            controller.store = store
        }
    }

    // MARK: IGListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return store?.locations ?? []
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        guard let store = store else { return ListSectionController() }
        return SavedLocationSectionController(store: store)
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }

    // MARK: SavedLocationStoreListener

    func storeDidUpdate(store: SavedLocationStore) {
        adapter.performUpdates(animated: true)
    }

}
