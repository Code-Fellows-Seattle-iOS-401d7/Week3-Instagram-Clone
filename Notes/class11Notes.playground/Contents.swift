
import UIKit


                        ////// CLASS 11 \\\\\\
                        ///// 10/24/16 \\\\\


/*
 #NOTES:
 
 
 ** CloudKit **
    -> service for movgin data to/from iCloud and sharing between users of your app
 
 - CloudKit framework should not be userd to relace model objects in your app, not for storing locally
 - requires conversion of model objects
 - organizes data using containers
    -- app's iCloud storage or user's iCloud storage
    -- CKContainer object
- supports private and public databases
    -- private is things you don't want shared globally b/w all user
    -- public is visible to all users(stored in app's iCloud storage
 * CK Objects *
    - CKContainer --> like a sandbox for your app, contain instances of CKDatabase
    - CKDatabase --> place to put all data(private, public, shared)
    - CKRecordZone --> records are not scattered, located in record zones(custom only can live in private record zones)
    - CKRecord --> piece of data inside your database, stored as a key-value pair
    - CKShare --> subclass of CKRecord and lives inside record zones. manage their records and how those records are shared. Shared databases cna have shared zones.
    - CKRecordIdentifier --> unique label of a record
    - CKReference - realtionship b/w different objects(Player - Team)
    - CKAsset - Assets are resources, like binary files or bulk data(user's picture should be stored as a CKAsset)
 
 ** UIImagePickerController **
    -> manages user interactions and delivers results of those interactions to a delegate object

 - AVFoundation Framework is more difficult and complex version of UIImagePickerController
 
 * workflow *
    - check if device has a camera
        -- add UIRequiredDeviceCapabilities key to info.plist orrrrr
        -- use isSoruceTypeAvailable class method to check if there is a camera
    - instantiate UIImagePickerController
    - set desired properties such as sourceType, allowsEditing(Bool), delgeate, videoQuality, mediaTypes
    - conform to the UIIPCDelegate and UINavControllerDelegate
    - present UIIPC to the user
 
 * delegate workflow *
    - imagePickerControllerDidCancel - tells the delegate that the user cancelled the pick operation
    - imagePickerController:didFinishPickingMediaWithInfo: String
 
 
 ** UIAlertController **
    -> object that displays an alert
 
 - 2 ways to present
    -- action sheet(alert from bottom)
    -- alert - superimposed over the middle of the screen
 - to add "options", create UIAlertAction objects and add those actions to the alert controller
 - UIAlertActions can have text field inputs
 - presenting...
    -- present(viewController:animated:completion:) on the parentVC
    -- on ipad you have to tell the alertController where to come from
 
 ** Size Classes **
    -> enable a storyboard or XIB to work with all available screen sizes

 - together with a displayScale and userInterfaceIdiom(iphone/ipad/tv/watch) make up a trait collection
 - everything on the screen has a trait collection(including the screen itself and vc's)
 - usually only care about vc's trait collection
 - storyboard use vc's trait collection to display to user
 - allow you to have diff constraints and layouts for each configuration on the storyboard
 - if you change the configuration, certain changes will only apply in the specific size class
 
 * changeable qualities *
    -- constraint constants
    -- font and font sizes
    -- turning constraints on and off
    -- turning view on or off
 
 ** developing for ipad **

 - 99% of the time the same as developing for iphone
 - consider designing for ipad before
 - consider multiple storyboard file/separatr storyboard files for iphone & ipad
 - identifying the ipad...
    -- UIUserInterfaceIdiom is the enum to figure out which device is currently being used
    -- class called UIDevice that gives you a singleton the represents the current device of type userInterfaceIdiom
 
 
 
 
 
 */
