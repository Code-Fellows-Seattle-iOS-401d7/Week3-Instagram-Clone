
import UIKit


                        ////// CLASS 13 \\\\\\
                        ////// 10/26/16 \\\\\\



/*
 #NOTES:
 
 
 ** DRY **
 --> aims at reducing repetivitve code/tasks and simplifying code maintenance
 
 - "rule of 3" -- if using same chunk of code 3 times --> refactor!
 
 
 ** Magic Numbers **
 --> using numbers directly in your code
 
 - greatly improves readability
    -- hard to figure out why the number was chosen
    -- why did they choose 8?
 - easier to maintain:
    -- often will need to be used in multipe places
    -- instead of changing each magic number, just change the variable that stores the number
 
 
 ** UICollectionView **
 --> a way to present an ordered set of data items using flexible and changeable layout
 
 - "grid layout"
 - can support more than a single column
 - items are the same as rows in a tableiew
 - creating custom layouts allow the possibility of many different layouts(grids, circular layouts, stacks, dynamic, etc)
 - employ same recycle program as tableViews
 - cells --> present the content of a single item
 - supplementary views 
    -- headers and footers
 - decoration views
    -- wholly owned by the layout object and not tied to any data from your data source
 - collection view imposes no styles on your reusable views, for the most part blank canvases for you to work with(unlike tableViews)
 
 -- Workflow
    - provide data(datasource pattern)
    - provide layout object(placement info)
    - merges two pieces above to achieve the final apearance
    - required methods:
        -> numberOfItemsInSection
        -> cellForItemAt
 
 
 ** UICollectionViewCell **
 - similar to tableViewCell
 - layout and presentation of cells is managed by the collectionView and its corresponding layout object
 - have to create own subclass
 
 
 **  UICollectionViewFlowLayout **
 --> computes layout attributes as needed for: Cells, supplemental views, etc
 
 - layout object determines where each view it manages should be placed and behaves on screen
 - provides a concrete subclass of UICVL called UICollectionViewFlowLayout that gives us a line based layout that we can use right out of the box
 - layout is highly customizable. Subclassing flowLayout is "less work", subclassing viewLayout is "more work" and "more intricate"
 
 --> layout attributes
    -- position
 
    -- size
 
    -- opacity
 
    -- zIndex(overlapping cells, above or below)
 
* flowLayout *
    - line-oriented layout(linear path, places as many cells as can fit, then starts below)
    - customizable
 
 -- changing the layout
    - call invalidateLayout to trigger a layout update
    - performBatchUpdates:completion: to change inside the update block and cause animations
    - when bounds changes the layout is invalidated
 
 
 
 
 */
