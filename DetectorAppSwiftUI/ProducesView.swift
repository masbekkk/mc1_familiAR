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


struct Produces{
    var id: Int
    let title, imageUrl: String
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
    @State var produces: [Produces] = [
        Produces(id: 0, title: "apple", imageUrl: "http://192.168.0.102/academy23/assets/apple.jpeg")
    ]
    var body: some View {
        NavigationView()
        {
            ScrollView{
                VStack{
                    HStack {
                        TextField("Fruits, Vegetables, Meats and More", text: $searchQuery)
                        Spacer()
                        //                        Spacer()
                        Image(systemName: "mic.fill")
                            .foregroundColor(.gray)
                        //                            .padding(.leading, 50)
                    }
                    .padding(.horizontal,30)
                    .padding(.vertical,8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding()
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .padding(.leading, 20)
                            Spacer()
                        }
                    )
                    
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
                    
                    LazyVGrid(columns: [GridItem(.flexible()),
                                        GridItem(.flexible())],
                              alignment: .leading, spacing: 15) {
                        ForEach(recentSearches, id: \.self) { term in
                            Link(destination: URL(string: "https://www.apple.com")!, label: {
                                Label(term, systemImage: "magnifyingglass")
                                    .foregroundColor(.blue)
                                    .underline()
                            })
                            //                            Label(term, systemImage: "magnifyingglass")
                            //                                .foregroundColor(.blue)
                        }
                        .padding(.horizontal)
                    }
                    
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
                                VStack{
                                    AsyncImage(url: URL(string: "http://192.168.0.102/academy23/assets/apple.jpg")) { phase in
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
                                    Text("apple")
                                }
                                
                            }
                        }
                    }
                    .padding(20)
                }
            }
            .navigationTitle("Produces")
        }
    }
}

@available(iOS 16.0, *)
struct ProducesView_Previews: PreviewProvider {
    static var previews: some View {
        ProducesView()
    }
}
