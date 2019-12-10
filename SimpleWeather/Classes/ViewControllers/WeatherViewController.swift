//
//  WeatherViewController.swift
//  SimpleWeather
//
//  Created by Ryan Nystrom on 11/13/16.
//  Copyright © 2016 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import CoreLocation

class WeatherViewController: UIViewController, ListAdapterDataSource, LocationTrackerDelegate, ErrorSectionControllerDelegate {

    @IBOutlet weak var collectionView: ListCollectionView!
    @IBOutlet weak var alertsButton: UIButton!

    let stateMachine = WeatherStateMachine()

    lazy var pulser: ViewPulser = {
        return ViewPulser(view: self.alertsButton)
    }()

    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 0)
    }()

    var tracker: LocationTracker?
    var task: URLSessionDataTask?
    var weather: Weather?
    var location: SavedLocation? { didSet { updateTitle() } }

    deinit {
        task?.cancel()
    }

    // MARK: Private API

    func updateAlertButton() {
        if WeatherNavigationShouldDisplayAlerts(weather: weather) {
            pulser.enable()
        } else {
            pulser.disable()
        }
    }

    func fetch() {
        guard let location = location else { return }

        if location.userLocation == true {
            fetchCurrentLocation()
        } else {
            fetch(lat: location.latitude, lon: location.longitude)
        }
    }

    func fetchCurrentLocation() {
        tracker = LocationTracker()
        tracker?.delegate = self
        tracker?.getLocation()
    }

    func fetch(lat: Double, lon: Double) {
        guard let url = DarkSkyForecastURL(apiKey: API_KEY, lat: lat, lon: lon),
            task?.originalRequest?.url != url || task?.state != .running
            else { return }

        let request = URLSessionDataTaskResponse(serializeJSON: true) { (data: Data) -> Weather? in
            return try? JSONDecoder().decode(Weather.self, from: data)
        }

        task?.cancel()
        task = URLSession.shared.fetch(url: url, request: request) { [weak self] (result: URLSessionResult) in
            switch result {
            case let .success(weather):
                self?.weather = weather
                self?.updateTitle()
                self?.stateMachine.state = .weather(weather)
            case let .failure(error):
                self?.stateMachine.state = .fetchError(error)
            }

            self?.adapter.performUpdates(animated: true)
            self?.updateAlertButton()
        }
    }

    func updateTitle() {
        guard let location = location else { return }
        title = WeatherNavigationTitle(location: location, weather: weather)
    }

    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        fetch()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(WeatherViewController.applicationWillEnterForeground(notification:)),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
        
        
        
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateAlertButton()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        pulser.disable()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let alertsVC = segue.destination as? AlertsViewController {
            alertsVC.alerts = weather?.alerts
        }
    }

    // MARK: IGListAdapterDataSource

    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return stateMachine.objects
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is ConditionsSection {
            return ConditionsSectionController()
        } else if object is DailyForecastSection {
            return DailyForecastSectionController()
        } else if object is EmbeddedSection {
            return EmbeddedAdapterSectionController(height: 96, dataSource: ForecastHourlyDataSource())
        } else if object is ErrorViewModel {
            let errorSectionController = ErrorSectionController()
            errorSectionController.delegate = self
            return errorSectionController
        }
        return ListSectionController()
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return LoadingView()
    }

    // MARK: Notifications

    @objc func applicationWillEnterForeground(notification: Notification) {
        let expiration: TimeInterval = 60 * 20 // 20 minutes
        if let observationDate = weather?.currently.date, -1 * observationDate.timeIntervalSinceNow >= expiration {
            fetchCurrentLocation()
        }
    }

    // MARK: LocationTrackerDelegate

    func didFinish(tracker: LocationTracker, result: LocationResult) {
        switch result {
        case let .success(location):
            fetch(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
        case let .failure(error):
            stateMachine.state = .locationError(error)
            adapter.performUpdates(animated: true)
        }
    }

    // MARK: ErrorSectionControllerDelegate

    func errorSectionControllerDidTapRetry(errorSectionController: ErrorSectionController) {
        stateMachine.state = .empty
        adapter.performUpdates(animated: true)
        fetch()
    }

}
