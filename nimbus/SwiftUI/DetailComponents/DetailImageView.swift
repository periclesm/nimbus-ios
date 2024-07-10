//
//  DetailImageView.swift
//  nimbus-SwiftUI
//
//  Created by Perikles Maravelakis on 28/4/22.
//  Copyright © 2022 Cloudfields. All rights reserved.
//

import SwiftUI
import Combine

struct DetailImageView_Previews: PreviewProvider {
    static var previews: some View {
        DetailImageView(imageURL: "https://api.clfd.eu/nimbusapp/Cirrus.jpg")
    }
}

struct DetailImageView: View {
	@ObservedObject var imageLoader: ImageDownloader
	@State var image: UIImage = UIImage()
	
	init(imageURL: String?) {
		if let urlString = imageURL {
			imageLoader = ImageDownloader(imageURLString: urlString)
		}
		else {
			imageLoader = ImageDownloader(imageURLString: "https://api.clfd.eu/nimbusapp/Cirrus.jpg")
		}
	}
	
	var body: some View {
		Image(uiImage: image)
			.resizable()
			.aspectRatio(contentMode: .fill)
			.padding(.horizontal, 4.0)
			.frame(height: 180.0)
			.onReceive(imageLoader.didChange) { data in
				self.image = data
			}
			.clipped()
			.cornerRadius(12.0)
	}
}

//must move this class elsewhere...
class ImageDownloader: ObservableObject {
	var didChange = PassthroughSubject<UIImage, Never>()
	var data = UIImage() {
		didSet {
			didChange.send(data)
		}
	}
	
	init(imageURLString: String) {
		guard let url = URL(string: imageURLString) else {
			return
		}
		
		let config = NetConfig(HTTPMethod: .GET, timeout: 10, url: url)
		Networker.getImage(config: config) { (response) in
			if response.completed {
				self.data = response.data as! UIImage
			}
		}
	}
}
