//
//  TableView.swift
//  CarFit
//
//  Copyright © 2020 Test Project. All rights reserved.
//

import UIKit

protocol Refreshable: AnyObject {
    func onRefresh(action: @escaping (() -> Void))
    func endRefresh()
}

final class TableView: UITableView, Refreshable {
    private var onRefreshAction: (() -> Void)?

    func onRefresh(action: @escaping (() -> Void)) {
        self.onRefreshAction = action
        let _refreshControl = UIRefreshControl()
        self.refreshControl = _refreshControl
        _refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }

    @objc private func refreshData () {
        self.onRefreshAction?()
    }

    func endRefresh() {
        self.refreshControl?.endRefreshing()
    }
}
