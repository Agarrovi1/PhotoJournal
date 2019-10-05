//
//  PhotoEntryCollectionViewCell.swift
//  PhotoJournal
//
//  Created by Angela Garrovillas on 10/4/19.
//  Copyright © 2019 Angela Garrovillas. All rights reserved.
//

import UIKit

class PhotoEntryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBAction func pageControlPressed(_ sender: UIPageControl) {
    }
}
