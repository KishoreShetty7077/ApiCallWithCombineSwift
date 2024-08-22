//
//  PostsViewController.swift
//  CombineApiCallSwift
//
//  Created by Kishore B on 8/22/24.
//

import UIKit
import Combine

class PostsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var posts: [Post] = []
    private var cancellables: Set<AnyCancellable> = []
    
    var urlStr = "https://jsonplaceholder.typicode.com/posts"

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchPosts()
    }

    private func fetchPosts() {
        APIHandler.shared.fetchData(from: urlStr, decodeTo: [Post].self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching posts: \(error)")
                }
            }, receiveValue: { [weak self] posts in
                self?.posts = posts
                self?.tableView.reloadData()
            })
            .store(in: &cancellables)
    }
  
}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailsTableViewCell", for: indexPath) as? PostDetailsTableViewCell {
            let post = posts[indexPath.row]
            cell.setupData(with: post)
            return cell
        }
        return UITableViewCell()
    }
}
