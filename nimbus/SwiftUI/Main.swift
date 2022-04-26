//
//  Main.swift
//  nimbus
//
//  Created by Perikles Maravelakis on 26/4/22.
//  Copyright © 2022 Cloudfields. All rights reserved.
//

import SwiftUI

struct Main: View {
	var body: some View {
		NavigationView {
			List(0 ..< 2) { item in
				CloudCell()
			}
			.navigationTitle("Clouds")
		}
	}
}

struct CloudCell: View {
	var body: some View {
		NavigationLink(destination: Detail()) {
			HStack {
				Image(systemName: "photo")
				
				VStack(alignment: .leading) {
					Text("Cloud Type")
						.fontWeight(.semibold)
					Text("cloud description")
						.font(.subheadline)
						.foregroundColor(.secondary)
				}
			}
		}
	}
}

struct Main_Previews: PreviewProvider {
	static var previews: some View {
		Main()
			.preferredColorScheme(.dark)
	}
}
