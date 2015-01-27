//
//  UIImage+Extensions.swift
//  Photog
//
//  Created by Dhiraj Laddha on 24/01/15.
//  Copyright (c) 2015 One Month. All rights reserved.
//

import Foundation

extension UIImage
{
    func resize(targetWidth: CGFloat) -> UIImage
    {
    
        var originalWidth = self.size.width
        if originalWidth <= targetWidth
        {
            return self
        }
        
        var scaleFactor = targetWidth / originalWidth
        var targetHeight = self.size.height  * scaleFactor
        
        var newSize = CGSizeMake(targetWidth, targetHeight)
        UIGraphicsBeginImageContext(newSize)
        
        self.drawInRect(CGRectMake(0, 0, targetWidth, targetHeight))
        
        var newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
        
        return newImage
    }
}


