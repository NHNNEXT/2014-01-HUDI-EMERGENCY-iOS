//
//  PolaGallery.h
//  EnjoyGallery
//
//  Created by 이상진 on 2014. 4. 7..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PolaView : UIView<UINavigationBarDelegate,UIScrollViewDelegate>

@property UIImage *polaImage;
@property NSDate *polaDate;
@property UIScrollView *polaScrollView;

- (id)addPolaWithImage:(UIImage*)image Date:(NSDate*)date ScrollView:(UIScrollView*)scrollview;
- (void)deletePola:(NSMutableArray*)array index:(int)index;


@end
