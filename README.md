# Movie Case

## You are asked to create a simple movie listing application.

• Application should have a Movie List and a Movie Detail page.

• Movies should be fetched page by page (Use "pagination" strategy).

• Add search bar that works for fetched movies.

• Clicking on a movie will navigate to movie detail page.

• Movie detail page should contain Movie Poster, Name, Description, Vote Count, and a
star button.

• When user clicks the star button on detail page, movie will be added to (or removed
from) the favorite list. A star icon should be shown for favorite movies on the movie
list page.

• Favorite list should be stored on device. (Do not use core data. UserDefaults or keychain is preferable.)

• Write test cases that cover your code.

• Feel free to use any pattern you like (MVC, MVVM, MVVM-C, VIPER etc.) in Swift.

• Minimum iOS deployment target should be 12.0.

• Include a short Readme file to explain the project’s code.

• Please do not use 3rd party libraries; we just want to see your approach.

• Please do not use SwiftUI and Reactive programming.

• Ensure that the improvements made within the project are committed in meaningful chunks.

• While reviewing your design, we first pay attention these topics: Clean Code,
Performance, iOS Human Interface Guideline, Git Usage.

### When you finish your working project, please make your implementations on seperated branch and create a Pull Request to main branch and notify us via E-Mail.

![image](https://github.com/retailioscasereview/Movie/assets/160006695/1c081b54-1586-4461-9289-3f7be12d9dce)

  
## You can use following API services;

First you need an API key. You can use following key or create new one. 

API key = fd2b04342048fa2d5f728561866ad52a

## Popular Movies:
Required Parameters: API Key & Page Id

### Example:

https://api.themoviedb.org/3/movie/popular?language=en-US&api_key=fd2b04342048fa2d5f728561866ad52a&page=1


## Movie Detail:
Required parameters: API Key, Movie Id
Example: https://api.themoviedb.org/3/movie/287947?language=en-US&api_key=fd2b04342048fa2d5f728561866ad52a


You can create image URL with image width (w200) and poster_path parameters; https://image.tmdb.org/t/p/<width><poster_path>

Example: https://image.tmdb.org/t/p/w200/kqjL17yufvn9OVLyXYpvtyrFfak.jpg


For more detail details please visit the official API documentation:
https://developers.themoviedb.org/3
