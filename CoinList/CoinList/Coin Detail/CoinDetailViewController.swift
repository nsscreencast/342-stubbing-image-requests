//
//  CoinDetailViewController.swift
//  CoinList
//
//  Created by Ben Scheirman on 5/21/18.
//  Copyright © 2018 Fickle Bits, LLC. All rights reserved.
//

import UIKit

final class CoinDetailViewController : UIViewController, StoryboardInitializable {
    @IBOutlet weak var coinNameLabel: UILabel!
    @IBOutlet weak var coinSymbolLabel: UILabel!
    @IBOutlet weak var coinImageView: UIImageView!
    @IBOutlet weak var priceTableView: UITableView!
    
    var coin: Coin!
    var cryptoCompareClient: CryptoCompareClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CoinDetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "priceCell", for: indexPath)
        return cell
    }
}
