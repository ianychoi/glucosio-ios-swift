//
//  IntrinsicSizedTableView.swift
//  glucosio
//
//  Created by Eugenio Baglieri on 20/09/16.
//  Copyright © 2016 Eugenio Baglieri. All rights reserved.
//

import UIKit

/// This tableView is "Autolayout" compatible, 
/// this tableview have an intrinsic contentsize equal to its content size
class IntrinsicSizedTableView: UITableView {

    /// The natural size for the receiving view, considering the content size.
    override var intrinsicContentSize: CGSize {
        // force my contentSize to be updated immediately
        layoutIfNeeded()
        return CGSize(width: UIViewNoIntrinsicMetric, height: contentSize.height)
    }

}
