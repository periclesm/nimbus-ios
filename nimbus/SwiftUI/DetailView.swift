//
//  Detail.swift
//  nimbus
//
//  Created by Perikles Maravelakis on 26/4/22.
//  Copyright © 2022 Cloudfields. All rights reserved.
//

import SwiftUI

struct Detail_Previews: PreviewProvider {
	static var previews: some View {
		Group {
//			let cdetail = CloudDetail(objectId: "r4wVv8eAQe", detail: "Dummy cloud", image: "https://stage.clfd.eu/nimbusapp/Cirrus.jpg", wiki: "https://en.wikipedia.org/wiki/Cirrus_cloud")
//			let type = CloudType(objectId: "5nbKrIsWXp", name: "High", detail: "High altitude clouds (over 9km)")
//
//			let cloud = Cloud(objectId: "txcNB8oP6D", name: "Cirrus", order: 1, type: type, detail: cdetail, initials: "Ci")
			
			DetailView(/*cloud: cloud*/)
				.preferredColorScheme(.dark)
			
		}
	}
}

struct DetailView: View {
	//var vm = DetailVM()
	var cloud: Cloud = Cloud()
	
	var body: some View {
		NavigationView {
			ScrollView {
				DetailImageView(imageURL: cloud.detail?.image)
				DetailHeaderView(cloud: cloud)
				DetailInfoView(cloud: cloud)
			}
		}
		.navigationTitle(cloud.name)
	}
	
	func getImage(imageURL: String?) -> UIImage {
		return UIImage(named: "")!
	}
}










