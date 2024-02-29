# challenge-conchalabs-ios

We’d love to continue with the technical assessment phase with a short project creating an iOS app.. 

This take-home project focuses on iOS coding skills.
The app should be written using Swift and SwiftUI.
The code should be saved to a git repository that can be pulled and run locally.

Problem Statement: create an iOS app that:
Pulls data from a REST API.
Uses that data to display a series of slider views.
As the user changes the slider the tick value is displayed on top.
Next button submits the slider value and session_id and receives the next set of data from the server.
Displays the final slider values and ticks selected by the user and starts over when the start over button is clicked.
The app should support Dynamic Type

# REST API

There are 2 REST APIs:

Starts the test 
Type: POST
URL: https://iostestserver-su6iqkb5pq-uc.a.run.app/test_start
Body (JSON):  `{ “choice”: “start” }`
Returns:
```
"{"ticks": [-96.33, -96.33, -93.47, -89.03999999999999, -84.61, -80.18, -75.75, -71.32, -66.89, -62.46, -58.03, -53.6, -49.17, -44.74, -40.31], "session_id": 3448, "step_count": 1}"
```
Note: session_id is required the next step and ticks for the values of the slider.

User selection, as an integer, for the slider (with the session ID) which generates values for the next slider.
Type: POST
URL: https://iostestserver-su6iqkb5pq-uc.a.run.app/test_next
Body (JSON):  `{“session_id”: <from above>, “choice”: “8”} // valid 0-14`
Returns:
```
"{"ticks": [-96.33, -96.33, -93.47, -89.03999999999999, -84.61, -80.18, -75.75, -71.32, -66.89, -62.46, -58.03, -53.6, -49.17, -44.74, -40.31], "session_id": 3448, "step_count": 2}"
```
Note: the following is returned when complete: 
 
"{"session_id": 3448, "complete": "true"}"
 
# UI/UX

The following are screenshots of what the application should look like:

![image](https://user-images.githubusercontent.com/15699775/157340468-12e0e2e7-307e-4914-ab60-e0cc6c5f6f7a.png)
![image](https://user-images.githubusercontent.com/15699775/157340489-bc576705-1be2-4606-9aa7-9a51f7a509bd.png)
