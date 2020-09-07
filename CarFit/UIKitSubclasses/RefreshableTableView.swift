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

/// UITableView subclass for adding refresh control on UITableView
final class RefreshableTableView: UITableView, Refreshable {
    private var onRefreshAction: (() -> Void)?

    /// Adds refresh control
    /// - Parameter action: Callback to receive when Pull To Refresh is performed by the user
    func onRefresh(action: @escaping (() -> Void)) {
        self.onRefreshAction = action
        let _refreshControl = UIRefreshControl()
        self.refreshControl = _refreshControl
        _refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }

    @objc private func refreshData () {
        self.onRefreshAction?()
    }

    /// Stops refresh animation
    func endRefresh() {
        self.refreshControl?.endRefreshing()
    }
}
