# 20211029-Christophe-Vichery-NYCSchools

## ✨ About the app
- all iOS devices friendly
- portrait & landscape mode friendly

## ✨ How to test the app
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
