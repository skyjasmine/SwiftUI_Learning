//
//  ContentView.swift
//  H4X0R News
//
//  Created by jasmine on 2023/8/30.
//

import SwiftUI

struct ContentView: View {
    // 监听 networkManager 中 published 的属性
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            List(networkManager.posts, rowContent: { post in
                NavigationLink(destination: DetailView(url: post.url)) {
                    HStack {
                        Text(String(post.points))
                        Text(post.title)
                    }
                }
            })
            .navigationTitle("H4X0R News")
        }
        .onAppear {
            self.networkManager.fetchData()
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
