//
//  SearchListController.swift
//  MarvelAppUIKit
//
//  Created by Bartosz Wojtkowiak on 29/06/2023.
//

import UIKit

class SearchListViewController: UIViewController {
    private var searchListComicsVM: SearchComicsListViewModel = SearchComicsListViewModel()
    weak var coordinator: Coordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
//        searchListComicsVM.delegate = self
    }
}

extension SearchListViewController {
    private func layout() {

        // wywalic layout, dodawac widoki gdzies indzie
        // zimportowac ich extension
        // osobny plik na same widoki w projekcie
        // ustawiac tutaj delegate i operowac danymi na widoku
//        view.addSubview(searchTextField)
//        view.addSubview(verticalStackView)
        
//        view.addSubview(searchTextField)
//        view.addSubview(tableView)
//        view.addSubview(emptySearchView)
        
//        NSLayoutConstraint.activate([
////            searchTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
////            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
////            searchTextField.widthAnchor.constraint(equalToConstant: view.frame.size.width),
////            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
////            tableView.topAnchor.constraint(equalToSystemSpacingBelow: searchTextField.bottomAnchor, multiplier: 3),
////            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
////            emptySearchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
////            emptySearchView.topAnchor.constraint(equalToSystemSpacingBelow: tableView.bottomAnchor, multiplier: 2),
////            emptySearchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
////            emptySearchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//
//            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            verticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            verticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//        ])
    }
}

extension SearchListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !searchListComicsVM.filteredComics.isEmpty else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ComicsCell.reuseID, for: indexPath) as! ComicsCell
        let comicVM = searchListComicsVM.filteredComics[indexPath.row]
        cell.configure(with: comicVM)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchListComicsVM.filteredComics.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension SearchListViewController {
    private func getComicsByTitle(title: String) {
        Task {
            await searchListComicsVM.getComicsByTitle(for: title)
        }
    }
    
//    private func displayCorrectView() {
//        if searchListComicsVM.filteredComics.isEmpty {
//            tableView.isHidden = true
//                        emptySearchView.isHidden = false
//            emptySearchView.setListIsEmpty()
//            print("empty view")
//        } else {
//            tableView.isHidden = false
//                        emptySearchView.isHidden = true
//            print("data view")
//        }
//    }
}

//extension SearchListViewController: SearchComicsListViewModelDelegate {
//    func didFetchComics(_ comics: [ComicViewModel]) {
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//            let estimatedHeight = self.tableView.numberOfRows(inSection: SearchListViewControllerParameters.tableNumberOfRowsInSection)
//            let width = self.view.frame.size.width
//            self.tableView.frame = CGRect(x: SearchListViewControllerParameters.tableViewFrameX, y: SearchListViewControllerParameters.tableViewFrameY, width: Int(width), height: estimatedHeight)
//                        self.displayCorrectView()
//        }
//    }
//}

extension SearchListViewController: SearchTextFieldDelegate {
    func editingDidEnd(_ sender: SearchTextField) {
        getComicsByTitle(title: sender.textField.text ?? "")
    }
}

extension SearchListViewController {
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / SearchListViewControllerParameters.keyboardYDivider) * SearchListViewControllerParameters.keyboardYMultiplier
            view.frame.origin.y = newFrameY
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = .zero
    }
}

enum SearchListViewControllerParameters {
    static let tableViewFrameX: Int = 0
    static let tableViewFrameY: Int = 0
    static let tableNumberOfRowsInSection: Int = 0
    static let keyboardYDivider: CGFloat = 2
    static let keyboardYMultiplier: CGFloat = -1
}
