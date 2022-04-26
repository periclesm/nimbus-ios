//
//  Main.swift
//  nimbus
//
//  Created by Perikles Maravelakis on 26/4/22.
//  Copyright © 2022 Cloudfields. All rights reserved.
//

import SwiftUI

//on load, fetch data
//on start button, present next screen (table list)

struct Main: View {
    var body: some View {
		VStack(alignment: .center, spacing: 64.0) {
			Text("Nimbus is a testing application for iOS, focusing mainly on retrieving data from a REST service.\n\nThe app is simple, without many tricks & treats and it's intented to remain that way.\n\nUpdates will happen whenever needed. :)")
				.padding(.horizontal, 10.0)
			
			Button(/*@START_MENU_TOKEN@*/"Start"/*@END_MENU_TOKEN@*/) {
				debugPrint("Present navigation")
			}
			.frame(width: 120.0, height: 30.0)
			.foregroundColor(.blue)
			.tint(.indigo)
			.border(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
		}
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
		Main()
			.preferredColorScheme(.dark)
    }
}
