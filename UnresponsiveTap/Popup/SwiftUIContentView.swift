//
//
//

import SwiftUI

struct SwiftUIContentView: View {
    let onHeaderTapAction: () -> Void

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            ZStack {
                Rectangle()
                    .fill(Color.orange)
                    .frame(height: 44.0, alignment: .top)
                .onTapGesture(perform: self.onHeaderTapAction)
                Text("Tap here or swipe down to dismiss")
            }

            Rectangle()
                .fill(Color.blue)
                .frame(maxWidth: .infinity, minHeight: 400)
                .ignoresSafeArea()
        }
    }
}

struct SwiftUIContentView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIContentView(onHeaderTapAction: {})
    }
}
