# SwiftMVVM+C Blogs

 Blogging app using Swift
 
 ## Design Pattern

 - I have used MVVM design pattern becuase it seprates UI from logic, seperate unit tests are easier and code is event driven. Coordinator Pattern is used to segregate and manage UI routing independently. 

 ## Dependcies

 - No external Library is used.

 ## Project Structure

 - Project is divided into respective folders as the folder name describes.
 - Features Folder has UI: Posts. Each of the has its own Model, View and View Model folders.
 - There are commons and helper folder which have global app constans and common utility functions.
 - Netwok Folder has API Service. Basic networking is implemented which can be improved based on needs. Usually I prefer moya for network layer abstraction this project doesn't use any dependency.

 ## Logic

 - All views are added programmatically using autolayouts constraints, there is no storyborad or xib.
 - There are base classes for view controller and tablle view cell.
 - Data is fetched from API service assuming URL is valid. In case of invalid URL error is shown. 
 - Simple Loader is shown.
 - View Model handles all the logic and notifies the view controller whenever data is fetched successfully or if there is an error. 
 - Posts view shows title in 2 lines and body in 3 lines.
 - Detail view shows complete post with comments.
 - I implemented minimum required features, I didn't add anything extra due to busy scheduele in current week.

 ## Testing 

 - I have included basic unit and UI tests as well. Tests are divided into respective folder structure.



