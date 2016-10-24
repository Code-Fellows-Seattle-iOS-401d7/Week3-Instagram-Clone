
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
 
 
 
 
 
 
 
 */