import SwiftUI

struct ContentView: View {
    let names = ["ASD","SADSADSA","ASDASDSA"]
    var body: some View {
        List {
            ForEach(names)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
