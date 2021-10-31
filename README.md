# 20211029-Christophe-Vichery-NYCSchools

## ✨ About the app
- all iOS devices friendly
- portrait & landscape mode friendly

## ✨ How to test the app
- the file ```JpmUxProtoTests.swift``` contains some unitary tests
- the app should detect any iOS devices and adapt the layouts
- if testing with the simulator please
    - open Tool.swift
    - search for the code bellow
    - uncomment the line ```// device = .xPhone```
    - and set device enum with the right device

```sh
// Set the device type when using simulator
// iPad  : old iPad   with bottom home button
// iPhone: old iPhone with bottom home button
// xPad  : new iPad   with bottom home bar
// xPhone: new iPhone with bottom home bar and top notch
        
// device = .xPhone
```
## ✨ How work the app
- launch the app
- the main view will load in a table the 25 first schools
- the alert view class will display any error when fetching data
- when scrolling at the end of the table, it will fetch 25 more schools
- if you click on one of these cells a view controller will show more details about the school
- when the detail view controller will appear we will fetch and display the SATs about that school
