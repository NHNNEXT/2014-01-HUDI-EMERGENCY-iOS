//
//  PolaGallery.h
//  EnjoyGallery
//
//  Created by 이상진 on 2014. 4. 7..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PolaGallery : UIView<UINavigationBarDelegate,UIScrollViewDelegate>

- (id)initWithImage:(UIImage*)image Date:(NSDate*)date ScrollView:(UIScrollView*)scrollview;

@end
