//
//  ProducesView.swift
//  DetectorAppSwiftUI
//
//  Created by masbek mbp-m2 on 05/04/23.
//

import SwiftUI
//@available(iOS 16.0, *)
//struct ScaledFont: ViewModifier {
//    @Environment(\.sizeCategory) var sizeCategory
//
//    var size: Double
//    var weight: Font.Weight
//
//    func body(content: Content) -> some View {
//        let scaledSize = UIFontMetrics.default.scaledValue(for: size)
//        return content.font(.title(size: scaledSize)).fontWeight(weight)
//    }
//}
//
//@available(iOS 16.0, *)
//extension View {
//    func scaledFont(size: Double, weight: Font.Weight) -> some View {
//        return self.modifier(ScaledFont(size: size, weight: weight))
//    }
//}


struct Produces : Hashable{
    var id: Int
    let title, imageUrl: String
}

struct jenisProduce{
    var id: Int;
    let content: [Produces]
}



@available(iOS 16.0, *)
struct ProducesView: View {
    @State var searchQuery = ""
    @State private var recentSearches: [String] = ["apple", "brocolli", "beef", "lemon", "chicken meat", "spinach"];
    //    let domain = "http://192.168.0.102/";
    //    let directoryAssets = "";
    //    init(searchQuery: String = "", recentSearches: [String], directoryAssets) {
    //        self.searchQuery = searchQuery
    //        self.recentSearches = recentSearches
    //        directoryAssets = self.domain + "academy23/assets/";
    //        self.directoryAssets = directoryAssets
    //
    //    }
    var fruits: [Produces] = [
        Produces(id: 0, title: "apple", imageUrl: "http://192.168.0.109/academy23/assets/apple.jpg"),
        Produces(id: 1, title: "avocado", imageUrl: "http://192.168.0.109/academy23/assets/avocado.jpg")
    ];
    
    var vegetables: [Produces] = [
        Produces(id: 0, title: "brocolli", imageUrl: "http://192.168.0.109/academy23/assets/broccolli.jpg"),
        Produces(id: 1, title: "carrot", imageUrl: "http://192.168.0.109/academy23/assets/carrot.jpg")
    ];
    
    var allProduces: [[String: Any]] = []
    
    
    init() {
        for produce in fruits {
            allProduces.append(["type": "Fruits", "produce": produce])
        }
        for produce in vegetables {
            allProduces.append(["type": "Vegetables", "produce": produce])
        }
        
    }
    
    var filteredFruits: [Produces] {
        fruits.filter { fruit in
            searchQuery.isEmpty ||
            (fruit.title.lowercased().starts(with: searchQuery.lowercased()) &&
             fruit.title.lowercased().first == searchQuery.lowercased().first)
        }
    }
    
    var filteredVegetables: [Produces] {
        vegetables.filter { vegetable in
            searchQuery.isEmpty ||
            (vegetable.title.lowercased().starts(with: searchQuery.lowercased()) &&
             vegetable.title.lowercased().first == searchQuery.lowercased().first)
        }
    }
    
    var searchResults: [Produces] {
        if searchQuery.isEmpty {
            return fruits + vegetables
        } else {
            return (fruits + vegetables).filter { $0.title.lowercased().contains(searchQuery.lowercased()) } }
    }
    
    
    
    var body: some View {
        NavigationStack()
        {
            ScrollView{
                // if(searchQuery.isEmpty) {
                VStack{
                    // HStack {
                    //     TextField("Fruits, Vegetables, Meats and More", text: $searchQuery)
                    //     Spacer()
                    //     //                        Spacer()
                    //     Image(systemName: "mic.fill")
                    //         .foregroundColor(.gray)
                    //     //                            .padding(.leading, 50)
                    // }
                    // .padding(.horizontal,30)
                    // .padding(.vertical,8)
                    // .background(Color(.systemGray6))
                    // .cornerRadius(8)
                    // .padding()
                    // .overlay(
                    //     HStack {
                    //         Image(systemName: "magnifyingglass")
                    //             .foregroundColor(.gray)
                    //             .padding(.leading, 20)
                    //         Spacer()
                    //     }
                    // )
                    if(searchQuery.isEmpty) {
                        HStack{
                            VStack(alignment: .leading){
                                Text("Discover")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 10)
                                //                        .padding()
                            }
                            //                        Spacer()
                        }
                        
                        //showing recent searches
                        LazyVGrid(columns: [GridItem(.flexible()),
                                            GridItem(.flexible())],
                                  alignment: .leading, spacing: 15) {
                            ForEach(recentSearches, id: \.self) { term in
//                                Link(destination: URL(string: "https://www.apple.com")!, label: {
//                                    Label(term, systemImage: "magnifyingglass")
//                                        .foregroundColor(.blue)
//                                        .underline()
//                                })
                                Button {
                                    searchQuery = term
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                } label: {
                                    Label(term, systemImage: "magnifyingglass")
                                        .underline()
                                        .foregroundColor(.blue)
                                        .font(.body)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                }
                                .simultaneousGesture(TapGesture())

                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    
                    //for fruits
                    VStack(alignment: .leading){
                        HStack{
                            Text("Fruits")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(.leading, 10)
                            //                            if isSearchBarEmpty {
                            NavigationLink(destination: ContentView()){
                                Text("See All")
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.trailing,20)
                            }
                            //                            }
                        }
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(fruits, id: \.id) { fruit in
                                    if(searchQuery.isEmpty)
                                    {
                                        VStack{
                                            AsyncImage(url: URL(string: fruit.imageUrl)) { phase in
                                                switch phase {
                                                case .empty:
                                                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                                                        .fill(.red)
                                                        .frame(width: 80, height: 80)
                                                case .success(let image):
                                                    image.resizable()
                                                        .resizable()
                                                        .cornerRadius(40)
                                                        .frame(width: 80, height: 80)
                                                    
                                                case .failure:
                                                    Image(systemName: "photo")
                                                        .frame(maxWidth: 300, maxHeight: 100)
                                                @unknown default:
                                                    // Since the AsyncImagePhase enum isn't frozen,
                                                    // we need to add this currently unused fallback
                                                    // to handle any new cases that might be added
                                                    // in the future:
                                                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                                                        .fill(.red)
                                                        .frame(width: 80, height: 80)
                                                }
                                            }
                                            Text(fruit.title)
                                                .font(.caption)
                                                .foregroundColor(.black)
                                        }
                                        
                                    }else {
                                        if(searchQuery == fruit.title) {
                                            VStack{
                                                AsyncImage(url: URL(string: fruit.imageUrl)) { phase in
                                                    switch phase {
                                                    case .empty:
                                                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                                                            .fill(.red)
                                                            .frame(width: 80, height: 80)
                                                    case .success(let image):
                                                        image.resizable()
                                                            .resizable()
                                                            .cornerRadius(40)
                                                            .frame(width: 80, height: 80)
                                                        
                                                    case .failure:
                                                        Image(systemName: "photo")
                                                            .frame(maxWidth: 300, maxHeight: 100)
                                                    @unknown default:
                                                        // Since the AsyncImagePhase enum isn't frozen,
                                                        // we need to add this currently unused fallback
                                                        // to handle any new cases that might be added
                                                        // in the future:
                                                        RoundedRectangle(cornerRadius: 25, style: .continuous)
                                                            .fill(.red)
                                                            .frame(width: 80, height: 80)
                                                    }
                                                }
                                                Text(fruit.title)
                                                    .font(.caption)
                                                //                                                        .foregroundColor(.black)
                                            }
                                        }
                                    }
                                    
                                    
                                    
                                }
                                
                            }
                        }
                    }
                    .padding(20)
                }
                
                //for vegetables
                VStack(alignment: .leading){
                    HStack{
                        Text("Vegetables")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.leading, 10)
                        //                            if isSearchBarEmpty {
                        NavigationLink(destination: ContentView()){
                            Text("See All")
                                .font(.subheadline)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing,20)
                        }
                        //                            }
                    }
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(vegetables, id: \.id) { fruit in
                                VStack{
                                    AsyncImage(url: URL(string: fruit.imageUrl)) { phase in
                                        switch phase {
                                        case .empty:
                                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                                .fill(.red)
                                                .frame(width: 80, height: 80)
                                        case .success(let image):
                                            image.resizable()
                                                .resizable()
                                                .cornerRadius(40)
                                                .frame(width: 80, height: 80)
                                            
                                        case .failure:
                                            Image(systemName: "photo")
                                                .frame(maxWidth: 300, maxHeight: 100)
                                        @unknown default:
                                            // Since the AsyncImagePhase enum isn't frozen,
                                            // we need to add this currently unused fallback
                                            // to handle any new cases that might be added
                                            // in the future:
                                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                                .fill(.red)
                                                .frame(width: 80, height: 80)
                                        }
                                    }
                                    Text(fruit.title)
                                        .font(.caption)
                                        .foregroundColor(.black)
                                }
                                
                            }
                            
                        }
                    }
                }
                .padding(20)
            }
            .navigationTitle("Produces")
            .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "Fruits, Vegetables, Meats and More") {
                ForEach(searchResults, id: \.self) { result in
                    Button {
                        searchQuery = result.title
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    } label: {
                        Label("Are you looking for \(result.title)?", systemImage: "magnifyingglass")
                            .foregroundColor(.blue)
                            .font(.body)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .simultaneousGesture(TapGesture())
//                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        
    }
}


@available(iOS 16.0, *)
struct ProducesView_Previews: PreviewProvider {
    static var previews: some View {
        ProducesView()
    }
}
