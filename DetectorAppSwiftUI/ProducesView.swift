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



@available(iOS 16.0, *)
struct ProducesView: View {
    @State var searchQuery = ""
    @State private var recentSearches: [String] = ["apple", "brocolli", "beef", "lemon", "chicken meat", "spinach"]
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
                                .font(.title)
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
                    
                    
                    Text("Okeee")
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
