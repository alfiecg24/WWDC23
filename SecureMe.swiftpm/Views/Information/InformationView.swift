import SwiftUI

struct InformationView: View {
    let information = getInformation()
    @State private var selected = ""
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                GradientBackground()
                    .blur(radius: 10)
                HStack {
                    VStack {
                        if information == Information() {
                            Text("⚠️ Error: failed to get information! This wasn't meant to happen...")
                        } else {
                            ForEach(information, id: \.self) { info in
                                HStack {
                                    Image(systemName: info.image)
                                        .padding(.trailing)
                                    Text(info.title)
                                        .font(Font(UIFont(name: "WorkSans-Bold", size: 25.0)!))
                                }
                                .frame(height: geometry.size.height / CGFloat(information.count))
                                .foregroundColor(selected == "\(info.hashValue)" ? .accentColor : .white)
                                
                                .onTapGesture {
                                    selected = "\(info.hashValue)"
                                }
                                
                                // Don't put a divider under the last item
                                if info.hashValue != information[information.count - 1].hashValue {
                                    Divider()
                                        .frame(width: geometry.size.width / 4 - 30)
                                }
                            }
                        }
                    }
                    .frame(width: geometry.size.width / 4, height: geometry.size.height, alignment: .center)
                    
                    Divider()
                        .padding(.leading)
                    VStack {
                        ForEach(information, id: \.self) { info in
                            if selected == "\(info.hashValue)" {
                                VStack(alignment: .leading) {
                                    ForEach(info.content, id: \.self) { item in
                                        Text(item.heading)
                                            .font(Font(UIFont(name: "WorkSans-Bold", size: 25.0)!))
                                        Text(try! AttributedString(markdown: item.content))
                                            .font(Font(UIFont(name: "WorkSans-Regular", size: 17.0)!))
                                            .padding(.bottom)
                                    }
                                }
                                .foregroundColor(.white)
                                .frame(width: ((geometry.size.width / 4) * 2), height: geometry.size.height - 30)
                                .padding(.horizontal)
                            }
                                
                        }
                    }
                    .frame(width: ((geometry.size.width / 4) * 3) - 100, height: geometry.size.height - 30)
                }
            }
            .onAppear {
                selected = "\(information[0].hashValue)"
            }
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}
