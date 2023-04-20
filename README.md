# Day Count Garmin Widget
Day counting widget for Garmin API 4.1.0+, this was wrote for personal use, so only tested on Epix gen2. This is a widget attempt to do what Days Matter does on iOS. 

## FlowChart

## Bug
1. Handle invalid user input date (such as 2.31)

## Functions so far
1. Glance view of an user-selected Event date, with the set date, and days counting up or down.
2. In the widget, there are three slots to store dates, count up or down is decided by the input date.
3. User can set galnce, edit, or delete events.
2. Completed the info page, show days, and yr,mm,dd.

## To do
1. Notification system.
    a. When the count down reach 0.
2. Refresh after actions in saved events? Depends on the memory usage.
3. Find a way to update teh glance once a day?

## Fixed bugs (maybe improve in the future)
1. Edit -> set glance, will cause error
    Fixed, now edit -> init menu

## Acknowledgement 
The icon is from <a href="https://www.flaticon.com/free-icons/emotion" title="emotion icons">Emotion icons created by Baianat - Flaticon</a>.
Some sample codes from the API package was modified and used.
