
import UIKit


                        ////// CLASS 12 \\\\\\
                        ////// 10/25/16  \\\\\\



/*
 #NOTES:
 
            *** CoreImage, Animating Constraints, UITabBarController ***
 
 ** Core Image **
    --> image processing and analysis technology designed to provide near real-time processing for still and video imaages
 
 - hides away details of low-level graphics processing
 - can use CPU or GPU(typically use the GPU)
 - acceess to 90+ filters
 - feature detection capability
 - automatic image enhancement
 - ability to chain multiple
 
 * CIImage *
    - immutable objwcet the reperesents the recipe for an image
    - can represent a file from disk or the output of a CIFilter
    - can be initialized from Raw Bytes, Data, and many others
 
 * CIFilter *
    - mutable object that represents a filter(not thread safe)
    - produces an output image based on the input
    - inputKey's to alter the effoct of the filter
    - can query for all the supported inputKey's(handled as a dictionary)
 
 * CIContext *
    - object through which Core Image draws results
    - Can be based on CPU or GPU
    - Always use GPU because it yields better performance over CPU(GPU support since iOS 8)
    - use eAGLContext and kCIContextOptions to build CIContext to draw in
 
 ** Animating Constraints **
 
 - constraints created programmatically or storyboarded can be easily animated
 - get a pointer to the constraint you want to animate
 - change the cosntant of the constraint to a new value
 - in animation block, call layoutIfNeeded() on the view containing the constraints
 
 ** UITabBarController **
    --> container view controller(array of viewControllers that they have a relationship to show)
 
 - just like nave controllers
 - use to divide your app into two or more distinct modes of operations
 - the tab bar has multiple tabs, each representing a child view controller
 - selecting a tab causes the tab bar to displat the assoicate view controller's view on screen
 - can be instantiated in code of storyboard
 - use a tab bar if your app displates different types of data to the user, or displays the data in different ways
 - Every UIViewController has a property called tabBarController, which points to the tab bar controller it is in
 - has a properry called viewControllers which is an array of the viewControllers it is managing, ordered left to right
 - item dictates how the VC is represented in the tab bar
 - UITabBarItem initilizer that takes in a title, image and selectedImage(2 versions of image)
 - selected should be "filled-in"
 
*/


for key in CIFilter.filterNames(inCategories: nil) {
    print(key)
}