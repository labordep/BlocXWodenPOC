# Bloc X Woden - Proof Of Concept

This project is a proof of concept to explore and test to mix Bloc views and Woden view.

![BlocXWoden2](https://user-images.githubusercontent.com/49183340/217097822-446d03aa-b01a-4b63-9aca-0ab8b66ec0b1.gif)
![BlocXWoden3](https://user-images.githubusercontent.com/49183340/217100114-05970966-3c0a-4d43-80ef-9674b19bb26c.gif)

## Loading

```smalltalk
Metacello new
   baseline: 'BlocXWoden';
   repository: 'github://labordep/BlocXWodenPOC:main';
	onConflictUseIncoming;
	ignoreImage;
   load.
```
