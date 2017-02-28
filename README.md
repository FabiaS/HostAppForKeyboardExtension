# KeyboardExtensionHostApp

## Description

This app serves as a host environment for a custom iOS keyboard extension.

The keyboard can have several horizontally scrollable pages showing several rows of buttons with letters or icons on them. Additionally there is a navigation bar with the obligatory switch-keyboard-button, a delete-button and a left / right button to scroll to the previous / next page.

## Runtime Requirements

iOS 10.2 or later

## Customisable features

The buttons' content is loaded via a json-file, which must be part of the ```CustomKeyboard``` target. Its format looks like this:

```
[{
 "page1": {
    "row1": [".", ".", ".", ".", ".", ".", ".", "."],
    "row2": [".", ".", ".", ".", ".", ".", ".", "."],
    "row3": [".", ".", ".", ".", ".", ".", ".", "."],
 },
 "page2": {
    "row1": [".", ".", ".", ".", ".", ".", ".", "."],
    "row2": [".", ".", ".", ".", ".", ".", ".", "."],
    "row3": [".", ".", ".", ".", ".", ".", ".", "."],
 },
}]
 ```

Custom features can be adjusted in the ```KeyboardSettings``` class (in ```MyCustomFramework```):

* navigation bar height
* maximum number of pages (***must be bigger than 0***)
* maximum number of rows (***must be bigger than 0***)
* background color of the navigation bar
* background color of the scrollable keyboard part
* text color of the navigation bar buttons
* text color of the key buttons

## Installation instructions

To add the keyboard to your project follow these steps: 

1. Add a new target – a custom keyboard extension - to your project and call it ```CustomKeyboard```. ***Make sure to use that name, or the following step will have to be adapted.***
2. Open your project in the Finder and replace the ```CustomKeyboard``` folder with the one from the ```HostApp``` project; then copy and paste ```MyCustomFramework``` into the project folder as well.
3. Drag and drop ```buttonTitles``` from the ```CustomKeyboard``` folder into the respecting folder in Xcode; then drag and drop ```MyCustomFramework.xcodeproj``` from the Finder into your project. ***If the little arrow next to the framework name does not immediately show up, open and close XCode.***
5. Add the framework to both targets, ```YourApp``` and ```CustomKeyboard```. 
6. Finally ```build``` all of them in the following order: ```MyCustomFramework```, ```CustomKeyboard```, ```YourApp```.
7. Run your app and include the new keyboard in the device's settings. 

## More

All of ```MyCustomFramework```'s classes and structs have originally been part of ```CustomKeyboard```, I however recently decided that I wanted to try and make the keyboard testable. Until now, it has not been possible to directly test keyboard extensions. Extracting the code into a separate framework circumvents this problem.

Having started the project under the assumption of not being able to test the code, it neither include tests (yet) nor has it been built with that goal in mind. Changing that will be the next step forward.

## Screenshots 

![page1](https://github.com/FabiaS/HostAppForKeyboardExtension/blob/master/page1.png?)
![page1](https://github.com/FabiaS/HostAppForKeyboardExtension/blob/master/page2.png?)
