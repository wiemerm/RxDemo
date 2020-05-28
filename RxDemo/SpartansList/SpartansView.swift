import UIKit
import RxSwift

class SpartansView: UIView {
    private let disposeBag = DisposeBag()

    let retryObservable: Observable<Void>
    let dismissObservable: Observable<Void>
    private(set) var spartanObservable: Observable<Spartan>?

    private var spartans = [Spartan]()

    private let tableview = UITableView()
    private let errorView = ErrorView()
    private let dismissButton = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))

    init() {
        retryObservable = errorView.retryObservable
        dismissObservable = dismissButton.rx.tap.asObservable()

        super.init(frame: .zero)

        backgroundColor = .white

        tableview.dataSource = self
        tableview.delegate = self
        tableview.rowHeight = 100
        tableview.tableFooterView = UIView()
        tableview.register(SpartanTableViewCell.self, forCellReuseIdentifier: SpartanTableViewCell.reuseIdentifier)

        dismissButton.setTitle("X", for: .normal)
        dismissButton.setTitleColor(.black, for: .normal)

        addSubview(tableview)
        addSubview(errorView)
        addSubview(dismissButton)

        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.constrainToSidesOfView(self, padding: 8)
        tableview.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 16).isActive = true
        tableview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true

        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.constrainToSidesOfView(self, padding: 8)
        errorView.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 16).isActive = true
        errorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.constrainToTopOfView(self, padding: 8)
        dismissButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true

        errorView.isHidden = true
        tableview.isHidden = true

        spartanObservable = tableview.rx.itemSelected.map { [unowned self] in self.spartans[$0.row] }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

/**
     Most commonly found code for tableviews in iOS codebase (Android uses typical RecyclerView setup with Adapter and ViewHolder)

     iOS most often still employs UITableViewDataSource and UITableViewDelegate, but
     occasionally can find items bound to the tableview instead using RxCocoa
     */
    func update(_ spartans: [Spartan]) {
        errorView.isHidden = true
        tableview.isHidden = false

        //DataSource
        self.spartans = spartans
        tableview.reloadData()

        //RxCocoa version found in iOS codebase
        Observable.of(spartans)
            .bind(to: tableview.rx.items(cellIdentifier: SpartanTableViewCell.reuseIdentifier)) { index, spartan, cell in
                (cell as? SpartanTableViewCell)?.update(spartan)
        }.disposed(by: disposeBag)
    }

    func handleError() {
        errorView.isHidden = false
        tableview.isHidden = true
    }

    func handle(_ error: Error) {
        handleError()
    }
}

extension SpartansView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spartans.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SpartanTableViewCell.reuseIdentifier) as? SpartanTableViewCell ?? SpartanTableViewCell()
        cell.update(spartans[indexPath.row])

        return cell
    }
}