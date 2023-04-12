//
//  SeeAllView.swift
//  familiAR
//
//  Created by masbek mbp-m2 on 10/04/23.
//

import SwiftUI

struct SeeAllView: View {
    let category : String
    let produces: [Produces]
    
    var body: some View {
        List{
            ForEach(produces, id: \.id) { produce in
                NavigationLink(destination:
                                DetailProduceView()){
                    CardView(eachProduce: produce)
                }
            }
        }
        .navigationTitle(category)
//        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CardView: View{
    let eachProduce: Produces
    var body: some View{
        HStack{
            AsyncImage(url: URL(string: eachProduce.imageUrl)) { phase in
                switch phase {
                case .empty:
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .fill(.red)
                        .frame(width: 80, height: 80)
                case .success(let image):
                    image.resizable()
//                        .aspectRatio(contentMode: .fill)
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
            if #available(iOS 16.0, *) {
                Text(eachProduce.title)
                    .padding(.leading,20)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            //                .foregroundColor(Color.primary)
        }
    }
}
struct SeeAllView_Previews: PreviewProvider {
    static var previews: some View {
        SeeAllView(category: "Vegetables", produces: [Produces(id: 0, title: "Wortel", imageUrl: "http://192.168.0.109/academy23/assets/carrot.jpg")])
    }
}
