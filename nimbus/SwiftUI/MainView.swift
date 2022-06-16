//
//  Main.swift
//  nimbus
//
//  Created by Perikles Maravelakis on 26/4/22.
//  Copyright © 2022 Cloudfields. All rights reserved.
//

import SwiftUI

struct MainView: View {
	var data: MainVM = MainVM()
	
	init() {
		//UINavigationBar.appearance().backgroundColor = .systemIndigo //the fuckup is gargantuan here
		UINavigationBar.appearance().barTintColor = .white //does not exist in swiftUI?
		UITableView.appearance().backgroundColor = .secondarySystemBackground //not in swiftUI?
	}
	
	var body: some View {
		NavigationView {
			List(data.clouds) { item in
				CloudCell(cloud: item)
			}
			.padding(.horizontal, -16.0)
			.frame(height: nil)
			.navigationTitle("Clouds")
			.navigationBarTitleDisplayMode(.automatic)
		}
	}
}

struct CloudCell: View {
	var cloud: Cloud
	
	var body: some View {
		NavigationLink(destination: DetailView(cloud: cloud)) {
			HStack(alignment: .center, spacing: 10.0) {
				Text(cloud.initials)
					.font(.system(size: 26))
					.fontWeight(.light)
					.foregroundColor(Color.white)
					.multilineTextAlignment(.center)
					.frame(width: 48.0, height: 48.0)
					.background(.indigo)
					.cornerRadius(24.0)
				
				VStack(alignment: .leading, spacing: 4.0) {
					Text(cloud.name)
						.font(.system(size: 18))
						.fontWeight(.semibold)
					Text(cloud.excerpt)
						.font(.system(size: 14))
						.fontWeight(.regular)
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
		MainView()
			.preferredColorScheme(.dark)
	}
}
