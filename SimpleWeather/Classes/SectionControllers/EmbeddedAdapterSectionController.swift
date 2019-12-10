//
//  EmbeddedAdapterSectionController.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/24/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

protocol EmbeddedAdapterDataSource {
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController
}

class EmbeddedAdapterSectionController: ListSectionController, ListAdapterDataSource {

    let height: CGFloat
    let dataSource: EmbeddedAdapterDataSource

    var model: EmbeddedSection?

    lazy var adapter: ListAdapter = {
        let adapter = ListAdapter(updater: ListAdapterUpdater(), viewController: self.viewController, workingRangeSize: 0)
        adapter.dataSource = self
        return adapter
    }()

    init(height: CGFloat, dataSource: EmbeddedAdapterDataSource) {
        self.height = height
        self.dataSource = dataSource
        super.init()
        inset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 0)
    }

    override func numberOfItems() -> Int {
        return 1
    }

    override func sizeForItem(at index: Int) -> CGSize {
        guard let width = collectionContext?.containerSize.width else { return .zero }
        return CGSize(width: width - inset.left - inset.right, height: height - inset.top - inset.bottom)
    }

    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let context = collectionContext,
            let cell = context.dequeueReusableCellFromStoryboard(withIdentifier: "EmbeddedCollectionViewCell", for: self, at: index) as? EmbeddedCollectionViewCell
            else { return UICollectionViewCell() }
        adapter.collectionView = cell.collectionView
        return cell
    }

    override func didUpdate(to object: Any) {
        model = object as? EmbeddedSection
        adapter.performUpdates(animated: true)
    }

    override func didSelectItem(at index: Int) {}

    // MARK: IGListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return model?.items ?? []
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return dataSource.listAdapter(listAdapter, sectionControllerFor: object)
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? { return nil }

}
