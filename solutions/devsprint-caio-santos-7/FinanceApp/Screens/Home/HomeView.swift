//
//  HomeView.swift
//  FinanceApp
//
//  Created by Rodrigo Borges on 30/12/21.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func showActivityDetails()
    func didSelectActivity()
}

struct HomeViewConfiguration {
    let homeData: HomeData
}

final class HomeView: UIView {

    private var activities: [Activity] = []
    weak var delegate: HomeViewDelegate?
    
    private lazy var accountSummaryView: AccountSummaryView = {
        let element = AccountSummaryView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var activityListView: ActivityListView = {
        let element = ActivityListView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    init() {
        super.init(frame: .zero)
        self.activityListView.configTableViewProtocol(delegate: self, dataSource: self)
        self.setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateView(with configuration: HomeViewConfiguration) {
        activities = configuration.homeData.activity
        accountSummaryView.updateValues(balance: configuration.homeData.balance,
                                        savings: configuration.homeData.savings,
                                        spending: configuration.homeData.spending)
        activityListView.reloadData()
    }
}

private extension HomeView {

    func setupViews() {
        backgroundColor = .white
        configureSubviews()
        configureSubviewsConstraints()
    }

    func configureSubviews() {
        addSubview(accountSummaryView)
        addSubview(activityListView)
    }

    func configureSubviewsConstraints() {
        NSLayoutConstraint.activate([
            accountSummaryView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            accountSummaryView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            accountSummaryView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),

            activityListView.topAnchor.constraint(equalTo: accountSummaryView.bottomAnchor, constant: 16),
            activityListView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            activityListView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            activityListView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//MARK: - Tableview
extension HomeView: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        activities.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ActivityCellView = .createCell(for: tableView, at: indexPath),
              indexPath.row < activities.count else {
            return .init()
        }
        cell.updateValues(activity: activities[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.showActivityDetails()
        print("touched")
        //delegate?.didSelectActivity()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Activity"
    }
}
