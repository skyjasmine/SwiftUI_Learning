//
//  NetworkManager.swift
//  H4X0R News
//
//  Created by jasmine on 2023/8/30.
//

import Foundation

class NetworkManager: ObservableObject {
    // 当变量有任何改变，都会通知监听对象
    @Published var posts = [Post]()
    
    func fetchData() {
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results =  try decoder.decode(Results.self, from: safeData)
                            // 有视图正在监听，要放到主线程执行
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
