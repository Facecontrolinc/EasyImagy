import UIKit
import EasyImagy

class ViewController: UIViewController {
	@IBOutlet fileprivate var imageView: UIImageView!

	@IBAction fileprivate func onPressActionButton(_ sender: UIButton) {
        let imageView: UIImageView! = self.imageView
		
		let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

		controller.addAction(UIAlertAction(title: "Reset", style: .default) { action in
			imageView.image = UIImage(named: "Image.jpg")
			sender.isEnabled = true
		})

		controller.addAction(UIAlertAction(title: "Flip Horizontally", style: .default) { action in
			imageView.image = Image<RGBA>(uiImage: imageView.image!)!.flipX().uiImage
			sender.isEnabled = true
		})
		
		controller.addAction(UIAlertAction(title: "Flip Vertically", style: .default) { action in
			imageView.image = Image<RGBA>(uiImage: imageView.image!)!.flipY().uiImage
			sender.isEnabled = true
		})
		
		controller.addAction(UIAlertAction(title: "Rotate clockwise", style: .default) { action in
			imageView.image = Image<RGBA>(uiImage: imageView.image!)!.rotate().uiImage
			sender.isEnabled = true
		})
		
		controller.addAction(UIAlertAction(title: "Rotate counterclockwise", style: .default) { action in
			imageView.image = Image<RGBA>(uiImage: imageView.image!)!.rotate(-1).uiImage
			sender.isEnabled = true
		})
		
		controller.addAction(UIAlertAction(title: "Rotate by 180 degrees", style: .default) { action in
			imageView.image = Image<RGBA>(uiImage: imageView.image!)!.rotate(2).uiImage
			sender.isEnabled = true
		})
		
		controller.addAction(UIAlertAction(title: "Resize", style: .default) { action in
			imageView.image = Image<RGBA>(uiImage: imageView.image!)!.resize(width: 100, height: 100).uiImage
			sender.isEnabled = true
		})
		
		controller.addAction(UIAlertAction(title: "Crop", style: .default) { action in
			imageView.image = Image<RGBA>(Image(uiImage: imageView.image!)![0..<100, 0..<100]).uiImage
			sender.isEnabled = true
		})
		
		controller.addAction(UIAlertAction(title: "Grayscale", style: .default) { action in
			imageView.image = Image<RGBA>(uiImage: imageView.image!)!.map { (pixel: RGBA) -> RGBA in
				RGBA(gray: pixel.gray)
			}.uiImage
			sender.isEnabled = true
		})

		controller.addAction(UIAlertAction(title: "Binarize", style: .default) { action in
			imageView.image = Image<RGBA>(uiImage: imageView.image!)!.map { (pixel: RGBA) -> RGBA in
				pixel.gray < 128 ? RGBA.black : RGBA.white
			}.uiImage
			sender.isEnabled = true
		})
		
		controller.addAction(UIAlertAction(title: "Binarize (Auto threshold)", style: .default) { action in
			let image = Image<RGBA>(uiImage: imageView.image!)!
			let threshold = UInt8(image.reduce(0) { $0 + $1.grayInt } / image.count) // mean of gray values of all pixels
			imageView.image = image.map { $0.gray < threshold ? .black : .white }.uiImage
			sender.isEnabled = true
		})

		controller.addAction(UIAlertAction(title: "Mean filter", style: .default) { action in
			let image = Image<RGBA>(uiImage: imageView.image!)!
            let kernel = Image<Float>(width: 3, height: 3, pixel: 1.0 / 9.0)
			imageView.image = image.convoluted(kernel).uiImage
			sender.isEnabled = true
		})
		
		controller.addAction(UIAlertAction(title: "Gaussian filter", style: .default) { action in
			let image = Image<RGBA>(uiImage: imageView.image!)!
            let kernel = Image<Int>(width: 5, height: 5, pixels: [
                1,  4,  6,  4, 1,
                4, 16, 24, 16, 4,
                6, 24, 36, 24, 6,
                4, 16, 24, 16, 4,
                1,  4,  6,  4, 1,
            ]).map { Float($0) / 256.0 }
			imageView.image = image.convoluted(kernel).uiImage
			sender.isEnabled = true
		})
		
		sender.isEnabled = false
		
		present(controller, animated: true, completion: nil)
	}
}

