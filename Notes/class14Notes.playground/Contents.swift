
import UIKit


                        ////// CLASS 14 \\\\\\
                        ////// 10/26/16 \\\\\\



/*
 #NOTES:
 
 
 ** Event Patterns **
 
 -- Delegation
    - one to one
    - great for when you want to communicate info back to another object(back from a view controller)
 
 -- Callback blacks/closures
    - one to one
    - great for keeping related code close together
 
 -- Notification Center
    - one to many
    - great because you can emit a notification and many listeners can receive it
 
 -- Key Value Observing(KVO)
    - one to many(bunch of listeners to one change)
    - if a property is key-value Coding compliatn, any object can observe it for changes
 
 -- Singleton
    - one to many
    - able to subscribe to and change all info whenever
 
 ** Convention **
    
 - delegation methods should begin with the name of object doing the delegating(application, control, controller, etc)
 - name is followed by a verb of what just occurred(willSelect, didSelect, openFile, etc)
 - once protocol is setup, add a delegate property to whatever class is going to be delegated
 
 ** retain cycle **
 
 - delegate property should always be weak
 - delegator should never own the delegate, because if it does, it might end up causing a retain cycle
 - to make a protocol-property weak, must make the protocol inherit from class
 
 *** Gesture Recognizers ***
    --> convert low-level event-handling code into higher-level actions
 
 - can be added programamatically or storyboarded
 - gesture recognizers are attched to views
 - the target is usually the view's view controller
 - gestures(if detected on the view) notfify target by means of sending a message(selector)
 - UIKit has a good amount of predefined gesture recognizers that you should always use when possible
 - UIKit also supports custom gesture recognizers
 
 * Built-ins *
    - Tap
    - Pinch
    - Pan/drag
    - Swipe
    - Rotation
    - LongPress
 
 * Discrete         vs                  Continuous *
    - can only happen once detected     - pan
    - tap, swipe
 
 -- Setup
    -> create GR instance
    -> attach to a view
    -> implement action that handles gesture(can switch over states)
        ----> case began, case changed, case etc...

 *** Social Sharing ***
 
 - SLComposerController
    -- class presents a view to the user to compose a post for the supported social networking services
 
 * Workflow *
    - check oif the service type is available
    - instantiate an SLComposerViewController object, and use the init that takes in SLServiceType
    - more steps...
 
 */
