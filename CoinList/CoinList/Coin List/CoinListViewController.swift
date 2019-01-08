//
//  CoinListViewController.swift
//  CoinList
//
//  Created by Ben Scheirman on 4/30/18.
//  Copyright © 2018 Fickle Bits, LLC. All rights reserved.
//

import UIKit
import Kingfisher

final class CoinListViewController : UITableViewController, StoryboardInitializable {
    
    var cryptoCompareClient: CryptoCompareClient = CryptoCompareClient(session: URLSession.shared)
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.hidesWhenStopped = true
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        
        return indicator
    }()
    
    var coins: [Coin]?
    var searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "coinDetailSegue" {
            let coinDetailVC = segue.destination as! CoinDetailViewController
            guard let selectedIndex = tableView.indexPathForSelectedRow else { return }
            let selectedCoin = coins?[selectedIndex.row]
            coinDetailVC.coin = selectedCoin
            coinDetailVC.cryptoCompareClient = cryptoCompareClient
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for symbol or name"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        activityIndicator.startAnimating()
        cryptoCompareClient.fetchCoinList { result in
            self.activityIndicator.stopAnimating()
            
            switch result {
            case .success(let coinList):
                self.coins = Coin.convert(coinList)
                self.tableView.reloadData()
            default:
                fatalError()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoinListCell", for: indexPath) as! CoinListCell
        guard let coin = coins?[indexPath.row] else { return cell }
        
        cell.coinNameLabel.text = coin.name
        cell.coinSymbolLabel.text = coin.symbol
        cell.coinListImage.kf.setImage(with: coin.imageURL)
        
        return cell
    }
}

extension CoinListViewController : UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let term = searchController.searchBar.text, !term.isEmpty {
            search(for: term)
        } else {
            tableView.reloadData()
        }
    }
    
    func search(for term: String) {
        // TODO: filter coins
        tableView.reloadData()
    }
}

