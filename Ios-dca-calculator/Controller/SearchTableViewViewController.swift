//
//  ViewController.swift
//  Ios-dca-calculator
//
//  Created by saul corona on 06/01/22.
//

import UIKit
import Combine

class SearchTableViewViewController: UITableViewController {
    
    private enum Mode {
        case onboarding
        case search
    }
    
    private lazy var searchController:  UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.delegate = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Enter a company name of symbol"
        sc.searchBar.autocapitalizationType = .allCharacters
        return sc
    }()
    
    private let apiService = APIService()
    private var subscribers = Set<AnyCancellable>()
    private var searchResults: SearchResults?
    @Published private var mode: Mode = .onboarding
    @Published private var searchQuery = String()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBar()
        setUpTableView()
        observeForm()
    }
    
    private func setUpNavigationBar(){
        navigationItem.searchController = searchController
    }
    
    private func setUpTableView(){
        tableView.tableFooterView = UIView()
    }
    
    private func observeForm(){
        $searchQuery
            .debounce(for: .milliseconds(750), scheduler: RunLoop.main)
            .sink{ [unowned self] (searchQuery) in
                self.apiService.fetchSymbolsPublisher(keywords: searchQuery).sink { (completion) in
                    switch completion {
                    case .failure(let error):
                        print(error.localizedDescription)
                    case .finished: break
                    }
                } receiveValue: { (searchResults) in
                    self.searchResults = searchResults
                    self.tableView.reloadData()
                    print(searchResults )
                }.store(in: &self.subscribers)
                print(searchQuery)
            }.store(in: &subscribers)
        
        $mode.sink { [unowned  self](mode) in
            switch mode {
            case .onboarding:
                let redView = UIView()
                redView.backgroundColor = .red
                self.tableView.backgroundView = redView
            case .search:
                self.tableView.backgroundView = nil
            }
        }.store(in: &subscribers)
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.items.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for:  indexPath) as! SearchTableViewCell
        if let searchResults = self.searchResults {
            let searchResult = searchResults.items[indexPath.row]
            cell.configure(with: searchResult)
        }
        return cell
    }
}


extension SearchTableViewViewController: UISearchResultsUpdating,
   UISearchControllerDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchQuery = searchController.searchBar.text,
                !searchQuery.isEmpty else {return}
        print(searchQuery)
        self.searchQuery = searchQuery
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        mode = .search
    }
}
