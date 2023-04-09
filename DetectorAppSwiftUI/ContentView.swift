import SwiftUI

@available(iOS 16.0, *)
struct ContentView: View {
    var body: some View {
        TabView{
            
            HostedViewController()
//                .ignoresSafeArea()
                .ignoresSafeArea(.container, edges: [.top, .bottom])
                .safeAreaInset(edge: .top, alignment: .center, spacing: 0) {
                                Color.clear
                                    .frame(height: 0)
                                    .background(.ultraThinMaterial)
                            }
                .safeAreaInset(edge: .bottom, alignment: .center, spacing: 0) {
                                Color.clear
                                    .frame(height: 0)
                                    .background(.thickMaterial)
                            }

                .tabItem{
                    Label("Scan Ingredients", systemImage: "camera.viewfinder")
                }
            
            ProducesView()
                .tabItem()
            {
                Label("Produces List", systemImage: "square.stack.3d.up.fill")
            }
            
            
        }
    }
}

@available(iOS 16.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
