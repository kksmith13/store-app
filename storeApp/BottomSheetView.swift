//
//  StoreLocatorListController.swift
//  storeApp
//
//  Created by Kyle Smith on 6/12/17.
//  Copyright © 2017 Codesmiths. All rights reserved.
//

import UIKit

protocol BottomSheetDelegate: class {
    func sheetDidChange(constant: CGFloat)
}

protocol BottomSheetViewDelegate: BottomSheetDelegate {
        func minimizedSheetHeight() -> CGFloat
        func partialSheetHeight() -> CGFloat
}

public enum Position: Int {
    
    case minimized = 0
    case partial = 1
    case full = 2
    
    public static let all: [Position] = [
        .minimized,
        .partial,
        .full
    ]
}

private let kSheetDefaultMinimizedHeightOffset: CGFloat = 0.7
private let kSheetDefaultPartialHeightOffset: CGFloat = 0.4
private let kSheetDefaultFullHeightOffset: CGFloat = 0.1

class BottomSheetView: BaseView, UITableViewDelegate, UITableViewDataSource, SearchToolbarDelegate, StoreCellDelegate {
    
    let fullSheetHeight = (UIScreen.main.bounds.height - 44 - 20) * 0.9
    let minimizedConstant = kSheetDefaultMinimizedHeightOffset * (UIScreen.main.bounds.height - 44 - 20)
    let partialConstant = kSheetDefaultPartialHeightOffset * (UIScreen.main.bounds.height - 44 - 20)
    
    lazy var storeController: StoreLocatorController? = {
        let sc = StoreLocatorController()
        sc.bottomSheet = self
        return sc
    }()
    
    public var sheetPosition: Position = .partial {
        didSet {
            switch(self.sheetPosition) {
            case .minimized:
                self.storeController?.sheetBottomConstraint?.constant = minimizedConstant
                gesture.isEnabled = true
            case .partial:
                self.storeController?.sheetBottomConstraint?.constant = partialConstant
                gesture.isEnabled = true
            case .full:
                self.storeController?.sheetBottomConstraint?.constant = kSheetDefaultFullHeightOffset
                gesture.isEnabled = false
            }
            
            let y = frame.minY
            var duration =  velocity.y < 0 ? Double((y - 100) / -velocity.y) : Double((150 - y) / velocity.y )
            duration = duration > 1.3 ? 1 : duration
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut, .allowUserInteraction], animations: {
                self.storeController?.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    //MARK: - TableView Initalize
    let gripperView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
        view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        view.layer.borderWidth = 0.25
        view.layer.cornerRadius = 2
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tv.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        return tv
    }()
    
    lazy var toolbar: SearchToolbar = {
        let tb = SearchToolbar()
        tb.delegate = self
        return tb
    }()
    
    let toolbarContainer = UIView()
    var gesture = UIPanGestureRecognizer()
    
    var locations = [Store]()
    let cornerRadius = 13.0
    let cellId = "cellId"
    var preference = "Unleaded"
    var user: User?
    var velocity = CGPoint()

    
    //MARK: -
    override func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 13
        layer.borderWidth = 0.25
        layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.45).cgColor
        
        user = Helpers.getUserData() as? User
        if user != nil {
            preference = (user?.gasPreference)!
        }
        
        setupToolbar()
        setupTableView()
        setupGestures()
    }
    
    //MARK: - Gestures
    fileprivate func setupGestures() {
        let toolbarGesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture(_:)))
        toolbarContainer.addGestureRecognizer(toolbarGesture)
        
        gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture(_:)))
        tableView.addGestureRecognizer(gesture)
    }
    
    func panGesture(_ recognizer: UIPanGestureRecognizer) {
        velocity = recognizer.velocity(in: self)
        
        let constant = (storeController?.sheetBottomConstraint?.constant)!
        if(constant > kSheetDefaultFullHeightOffset) && (constant <= minimizedConstant) {
            storeController?.sheetBottomConstraint?.constant += velocity.y * 0.02
        } else if ((constant <= kSheetDefaultFullHeightOffset) && velocity.y >= 0) || ((constant >= minimizedConstant) && (velocity.y <= 0)){
            storeController?.sheetBottomConstraint?.constant += velocity.y * 0.02
        }
        
        if recognizer.state == .ended {

            
            if velocity.y >= 0 && constant > partialConstant {
                self.sheetPosition = .minimized
            } else if velocity.y <= 0 && constant < partialConstant {
                self.sheetPosition = .full
                
            } else if velocity.y >= 0 {
                switch(self.sheetPosition) {
                case .minimized:
                    break
                case .partial:
                    self.sheetPosition = .minimized
                    break
                case .full:
                    self.sheetPosition = .partial
                    break
                }
            } else {
                switch(self.sheetPosition) {
                case .minimized:
                    self.sheetPosition = .partial
                    break
                case .partial:
                    self.sheetPosition = .full
                    break
                case .full:
                    break
                }
            }
        }
    }
    
    //MARK: - Toolbar
    fileprivate func setupToolbar() {
        addSubview(toolbarContainer)
        
        _ = toolbarContainer.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 64)
        
        toolbarContainer.addSubview(gripperView)
        toolbarContainer.addSubview(toolbar)
        
        gripperView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        _ = gripperView.anchor(toolbarContainer.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 8, leftConstant: 0, bottomConstant: 8, rightConstant: 0, widthConstant: 35, heightConstant: 4)
        _ = toolbar.anchor(gripperView.topAnchor, left: toolbarContainer.leftAnchor, bottom: toolbarContainer.bottomAnchor, right: toolbarContainer.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    //MARK: - SearchToolbar Delegate Methods
    func changeGasType(sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: "Select a gas type...", preferredStyle: .actionSheet)
        let unleaded = UIAlertAction(title: "Unleaded", style: .default) { action in
            sender.setTitle("Unleaded", for: .normal)
            self.preference = "Unleaded"
            self.tableView.reloadData()
        }
        let premium = UIAlertAction(title: "Premium", style: .default) { action in
            sender.setTitle("Premium", for: .normal)
            self.preference = "Premium"
            self.tableView.reloadData()
        }
        let diesel = UIAlertAction(title: "Diesel", style: .default) { action in
            sender.setTitle("Diesel", for: .normal)
            self.preference = "Diesel"
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in }
        
        alertController.addAction(unleaded)
        alertController.addAction(premium)
        alertController.addAction(diesel)
        alertController.addAction(cancelAction)
        
        storeController?.present(alertController, animated: true) {
            // ...
        }
    }
    
    
    //MARK: - TableView
    fileprivate func setupTableView() {
        tableView.register(StoreCell.self, forCellReuseIdentifier: cellId)
        addSubview(tableView)
        
        _ = tableView.anchor(toolbarContainer.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    
    //MARK: - TV Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! StoreCell
        cell.delegate = self
        cell.store = locations[indexPath.item]
        cell.preference = preference
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.contentOffset.y < 0) {
            scrollView.contentOffset = .zero;
            gesture.isEnabled = true
        }
    }
    
    //MARK: - StoreCell Delegate Methods
    func openDirections(cell: StoreCell){
        guard tableView.indexPath(for: cell) != nil else {
            // Note, this shouldn't happen - how did the user tap on a button that wasn't on screen?
            return
        }

//        let index = tableView.indexPath(for: cell)?.row
//        let regionDistance: CLLocationDistance = 10000
//        let coordinates = locations[index!].coordinate
//        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
//        let options = [
//            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
//            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
//        ]
//        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
//        let mapItem = MKMapItem(placemark: placemark)
//
//        mapItem.name = locations[index!].address
//        mapItem.openInMaps(launchOptions: options)

    }

    func openDetails(cell: StoreCell) {
        guard tableView.indexPath(for: cell) != nil else {
            // Note, this shouldn't happen - how did the user tap on a button that wasn't on screen?
            return
        }

        let index = tableView.indexPath(for: cell)?.row
        let storeDetailsController = StoreDetailsController()
        storeDetailsController.store = locations[index!]
        storeController?.navigationController?.pushViewController(storeDetailsController, animated: true)
    }
    
}

