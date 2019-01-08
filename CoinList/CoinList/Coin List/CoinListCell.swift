//
//  CoinListCell.swift
//  CoinList
//
//  Created by Ben Scheirman on 4/30/18.
//  Copyright © 2018 Fickle Bits, LLC. All rights reserved.
//

import UIKit
import Kingfisher

class CoinListCell : UITableViewCell {
    
    @IBOutlet weak var coinListImage: UIImageView!
    @IBOutlet weak var coinSymbolLabel: UILabel!
    @IBOutlet weak var coinNameLabel: UILabel!
    
    override func prepareForReuse() {
        coinListImage.kf.cancelDownloadTask()
        coinSymbolLabel.text = nil
        coinNameLabel.text = nil
    }
}
