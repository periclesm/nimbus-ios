//
//  Main.swift
//  nimbus
//
//  Created by Perikles Maravelakis on 26/4/22.
//  Copyright © 2022 Cloudfields. All rights reserved.
//

import SwiftUI

struct Main: View {
	var data: MainVM = MainVM()
	
	var body: some View {
		NavigationView {
			List(data.clouds) { item in
				CloudCell(cloud: item)
			}
			.padding(.horizontal, -10.0)
			.frame(height: nil)
			.navigationTitle("Clouds")
		}
	}
}

struct CloudCell: View {
	var cloud: Cloud
	
	var body: some View {
		NavigationLink(destination: Detail(cloud: cloud)) {
			HStack(alignment: .center, spacing: 10.0) {
				Text(cloud.initials)
					.font(.system(size: 24))
					.fontWeight(.light)
					.multilineTextAlignment(.center)
					.frame(width: 48.0, height: 48.0)
					.background(.indigo)
					.cornerRadius(24.0)
				
				VStack(alignment: .leading, spacing: 4.0) {
					Text(cloud.name)
						.font(.system(size: 16))
						.fontWeight(.semibold)
					Text(cloud.excerpt)
						.font(.system(size: 14))
						.fontWeight(.light)
						.foregroundColor(.secondary)
						.lineLimit(3)
				}
				.padding(.vertical, 8.0)
			}
			.padding(0.0)
		}
	}
}

struct Main_Previews: PreviewProvider {
	static var previews: some View {
		Main()
			.preferredColorScheme(.dark)
	}
}
