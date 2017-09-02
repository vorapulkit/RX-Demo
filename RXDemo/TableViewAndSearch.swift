//
//  ViewController.swift
//  RXDemo
//
//  Created by Pulkit's Mac on 04/08/17.
//  Copyright © 2017 Pulkit's Mac. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TableViewAndSearch : UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    //MARK:
    //MARK: Defination
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    
    var shownCities = [String]() // Data source for UITableView
    let allCities = ["New York", "London", "Oslo", "Warsaw", "Berlin", "Praga"] // Our mocked API data source        // Do any additional setup after loading the view, typically from a nib.
    let disposeBag = DisposeBag() // Bag of disposables to release them when view is being deallocated
    
    //MARK:
    //MARK: Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        
        implementSearch()
        
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:
    //MARK: Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownCities.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityPrototypeCell", for: indexPath)
        cell.textLabel?.text = shownCities[indexPath.row]
        return cell
    }
    

    //MARK:
    //MARK: Searching
    func implementSearch(){
        
        searchBar
            .rx.text // Observable property thanks to RxCocoa
            .orEmpty // Make it non-optional
            .debounce(0.5, scheduler: MainScheduler.instance) // Wait 0.5 for changes.
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old.
            //.filter { !$0.isEmpty } // If the new value is really new, filter for non-empty query.
            .subscribe(onNext: { [unowned self] query in // Here we subscribe to every new value, that is not empty (thanks to filter above).
                self.shownCities = self.allCities.filter { $0.hasPrefix(query) } // We now do our "API Request" to find cities.
                self.tblView.reloadData() // And reload table view data.
            })
            .addDisposableTo(disposeBag)

    }
    
    
}

