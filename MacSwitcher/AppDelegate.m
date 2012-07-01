//
//  AppDelegate.m
//  MacSwitcher
//
//  Created by Fredrik Olsen on 7/1/12.
//  Copyright (c) 2012 Fredrik Olsen. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    // Start watching events to figure out when to close the window
    [NSEvent addGlobalMonitorForEventsMatchingMask: (NSKeyDownMask)
                                           handler:^(NSEvent* event){
                                               if ([event keyCode] == 4) {
                                                   //NSLog(@"Switching");
                                                   execute();
                                               }
                                               NSLog(@"%d", [event keyCode]);
//                                               int flags = [event modifierFlags];
//                                               int altDown = flags & NSFunctionKeyMask;
//                                               if (([event keyCode] == 7) && altDown) {
//                                                   NSLog(@"woo");
//                                               }
//                                               
                                           }];
    
}

void postMouseEvent(CGMouseButton button, CGEventType type, const CGPoint point)
{
    CGEventRef theEvent = CGEventCreateMouseEvent(NULL, type, point, button);
    CGEventSetType(theEvent, type);
    CGEventPost(kCGHIDEventTap, theEvent);
    CFRelease(theEvent);
}

void rightClick(const CGPoint point)
{
    postMouseEvent(kCGMouseButtonRight, kCGEventMouseMoved, point);
    //NSLog(@"Right Click!");
    postMouseEvent(kCGMouseButtonRight, kCGEventRightMouseDown, point);
    postMouseEvent(kCGMouseButtonRight, kCGEventRightMouseUp, point);
    usleep(70*1000);

}

void leftClick(const CGPoint point)
{
    postMouseEvent(kCGMouseButtonLeft, kCGEventMouseMoved, point);
    //NSLog(@"Left Click!");
    postMouseEvent(kCGMouseButtonLeft, kCGEventLeftMouseDown, point);
    postMouseEvent(kCGMouseButtonLeft, kCGEventLeftMouseUp, point);
    usleep(70*1000);
}

void altRightClick(const CGPoint point)
{

    postMouseEvent(kCGMouseButtonRight, kCGEventMouseMoved, point);
    CGEventRef alt = CGEventCreateKeyboardEvent(NULL, 58, true);
    CGEventSetType(alt, kCGEventKeyDown);
    CGEventPost(kCGHIDEventTap, alt);
    CFRelease(alt);
    usleep(50*1000);
    postMouseEvent(kCGMouseButtonRight, kCGEventRightMouseDown, point);
    postMouseEvent(kCGMouseButtonRight, kCGEventRightMouseUp, point);

    usleep(70*1000);
}

void execute()
{
    
    CGEventRef ourEvent = CGEventCreate(NULL);
    CGPoint point = CGEventGetLocation(ourEvent);
    NSLog(@"\nx = %.2f y = %.2f", point.x, point.y);
    //CGPoint p = CGPointMake(20, 20);
    //rightClick(p);
    
    // Inventory Icon
    CGPoint p1 = CGPointMake(814.00, 759.00);
    leftClick(p1);
    
    // Move from right
    CGPoint p2 = CGPointMake(1242.00, 610.00);
    rightClick(p2);
    CGPoint p3 = CGPointMake(1206.00, 610.00);
    rightClick(p3);
    CGPoint p4 = CGPointMake(1172.00, 610.00);
    rightClick(p4);
    CGPoint p5 = CGPointMake(1139.00, 627.00);
    rightClick(p5);
    CGPoint p6 = CGPointMake(1136.00, 594.00);
    rightClick(p6);
    CGPoint p7 = CGPointMake(1099.00, 613.00);
    rightClick(p7);
    CGPoint p8 = CGPointMake(1065.00, 610.00);
    rightClick(p8);
    CGPoint p9 = CGPointMake(1029.00, 593.00); // Left ring
    rightClick(p9);

    CGPoint p10 = CGPointMake(1029.00, 628.00); // Right ring
    altRightClick(p10);

    CGPoint p11 = CGPointMake(993.00, 612.00);
    rightClick(p11);
    CGPoint p12 = CGPointMake(956.00, 612.00);
    rightClick(p12);
    
    //Close inventory again
    leftClick(p1);
    
    
    postMouseEvent(kCGMouseButtonRight, kCGEventMouseMoved, point);

}

@end
