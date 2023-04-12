import SwiftUI


// To make rounded rectangle on specified corners
struct RoundedCorners: View {
    var color: Material = .regularMaterial
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                let w = geometry.size.width
                let h = geometry.size.height
                
                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
                path.closeSubpath()
            }
            .fill(self.color)
        }
    }
}

@available(iOS 16.0, *)
struct ContentView: View {
    @State private var isShowingSheet = false
    @State var status = "Scanning..."
    @Environment(\.colorScheme) var colorScheme
    
    @State var timeRemaining = 2
    @State var timeRemainingModal = 2
    @State var flag = true
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        TabView{
            ZStack{
                HostedViewController()
                
                VStack{
                    Spacer()
                    Button(action: {
                        self.isShowingSheet = true
                    }, label: {
                        Text(status)
                            .foregroundColor(Color.primary)
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: 70)
                            .background(RoundedCorners(color: .ultraThickMaterial, tl: 20, tr: 20, bl: 0, br: 0))
                    })
                    .padding(.bottom, 80)
                }
                // Timer untuk ganti isi variable dari Scanning ke Apple
                Text("")
                    .onReceive(timer) { _ in
                        if timeRemaining > 0 {
                            timeRemaining -= 1
                        } else if timeRemaining == 0 {
                            status = "Meat"
                        }
                        if timeRemainingModal > 0 {
                            timeRemainingModal -= 1
                        } else if timeRemainingModal == 0 && flag == true {
                            // flag agar is showing sheetnya nda muncul2 lagi
                            flag = false
                            isShowingSheet = true
                        }
                    }
            }.sheet(isPresented: $isShowingSheet) {
                // Isi Modal Sheets
                ModalSheetsView()
            }
            
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
