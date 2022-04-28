//
//  Main.swift
//  nimbus
//
//  Created by Perikles Maravelakis on 26/4/22.
//  Copyright © 2022 Cloudfields. All rights reserved.
//

import SwiftUI

struct IntroView: View {
	@State var present: Bool = false
	
	init() {
		DataManager.getData()
	}
	
    var body: some View {
		VStack(alignment: .center, spacing: 64.0) {
			Text("Nimbus is a testing application for iOS, focusing mainly on retrieving data from a REST service.\n\nThe app is simple, without many tricks & treats and it's intented to remain that way.\n\nUpdates will happen whenever needed. :)")
				.padding(.horizontal, 10.0)
			
			Button("Start") {
				debugPrint("Present navigation")
				self.present.toggle()
			}
			.frame(width: 120.0, height: 30.0)
			.foregroundColor(.blue)
			.tint(.indigo)
			.border(.blue, width: 1)
			.fullScreenCover(isPresented: $present) {
				MainView()
			}
		}
    }
}

struct Intro_Previews: PreviewProvider {
    static var previews: some View {
		IntroView()
			.preferredColorScheme(.dark)
    }
}
