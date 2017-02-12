# KeyboardExtensionHostApp

This app serves as a host environment for a custom keyboard extension (iOS).

The keyboard can have several horizontally scrollable pages showing several rows of buttons with letters or icons on them. 
Additionally there is a top bar with the obligatory switch-keyboard-button, a delete-button and a left / right button to scroll to the previous / next page of buttons.

In the keyboard settings you can set your own values for: 
- keyboard height 
- navigation bar height
- maximum number of pages (must be bigger than 0)
- maximum number of rows (must be bigger than 0)
- background color of the buttons/keys
- background color of the navigation bar 
- tint color of the buttons/keys
- tint color of the navigation bar 

The "content" of the buttons is loaded via .json that must be put into the 'CustomKeyboard' folder.
Their current format is as follows: 
[{
 "row1": [".", ".", ".", ".", ".", ".", ".", ".", "."],
 "row2": [".", ".", ".", ".", ".", ".", ".", ".", "."],
 "row3": [".", ".", ".", ".", ".", ".", ".", ".", "."],
 }]
