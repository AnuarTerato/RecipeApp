//
//  Helper.swift
//  RecipeApp
//
//  Created by Anuar Nordin on 01/03/2021.
//

import Foundation
import UIKit

extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}

extension UIView {
    func rounded(radius: CGFloat, borderWidth: CGFloat, borderColor: UIColor) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.rounded(radius: radius)
    }
    
    func rounded(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

extension UILabel {
    func lblShadow(color: UIColor , radius: CGFloat, opacity: Float){
        self.textColor = color
        self.layer.masksToBounds = false
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}

extension UIImage {
    func normalizedImage() -> UIImage {
        
        if (self.imageOrientation == UIImage.Orientation.up) {
            return self;
        }
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale);
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        self.draw(in: rect)
        
        let normalizedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return normalizedImage
    }
    
    convenience init?(withContentsOfUrl url: URL) throws {
        let imageData = try Data(contentsOf: url)
    
        self.init(data: imageData)
    }
}

extension UIViewController {
    func displayAlertMessage(message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alertController.view.tintColor = UIColor(red: 22/255, green: 16/255, blue: 21/255, alpha: 1.0)
        let OKAction = UIAlertAction(title: "OK", style: .default) { [weak self] (action:UIAlertAction!) in
            guard let self = self else { return }
            print("Ok button tapped")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
}

