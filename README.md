 README.md
PrinFoodApp
Campus-wide iOS application for my college dining services (Objective-C).

Upon compiling, you can run a simulation of the app in an xcode simulator. You will be able to test it on different 
versions of the iphone as well. Similarly, you can preview the formatting and design with xcode’s “preview” and with 
this you can see what it might look like before you compile. This also allows you to compare the different versions 
of the phone side­by­side.

The application uses database “Parse”. h ttps://www.parse.com/ Please contact Kirill Kudaev (kirill.a.kudaev@gmail.com) 
if you would like to get access to it. 

The database consists of 4 main Classes: 
● MealTimes p rovides current and future mealtimes in the Dining Room 
● PubTimes p rovides the open hours of both the Grill and Shake side of the Pub 
● Menu l ists the names of the dishes for each meal of the day in the Dining Room 
● CheckIn p rovides and stores the username, date, time and current user location

The application consists of a menu view that contains 3 buttons with background graphics (visually indicating the specific 
locations on campus). The buttons are “DINING”, “PUB” and “check in here”. Using the Navigation Controller, the “DINING” 
button is linked to a segue which transitions to a new view called “Menu”. The Menu view displays the current date and time 
at the top of the screen along with a segmented controller which allows access to the next day’s menu as well. Within our 
Menu view we have included a table view element that consists of three rows: Breakfast, Lunch, and Dinner. In each row we 
include the name of the meal and the time each meal is served in the Dining Room. These times are populated from our database 
using “Parse.com”. If there is no internet connection or if query fails, we include exceptions – we provide a message for the 
user indicating that the times were unable to load.

From the rows within the table view, the application navigates to a corresponding new view populated with the current meal 
selection. This data is being passed from the previous view using a “pr epareForSegue” method. The menus are initially 
retrieved and populated from our database using “Parse.com”. This view also handles internet connection errors. CheckIn View 
has 2 buttons that allow user to tell their friends that they are either at the Dining Room or Pub. If the button is pressed 
and the app is able to connect to the database, users name will be found in the database so that the date, time and the 
location of the last check in can be updated. If user’s name wasn’t found in the database then a new row will be created. 
CheckIn View has an embedded table view that displays user’s friends check ins. Data for the table view is being populated 
from the Parse database.
