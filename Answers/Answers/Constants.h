//
//  Constants.h
//  Answers
//
//  Created by Bram Kersten on 17-12-13.
//  Copyright (c) 2013 IntelliCloud. All rights reserved.
//

#ifndef Answers_Constants_h
#define Answers_Constants_h

#define IS_IPHONE    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPAD      (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

static NSString *const kLoggedInNotification = @"LoggedInNotification";
static NSString *const kAnswerCreatedNotification = @"AnswerCreatedNotification";

#endif
