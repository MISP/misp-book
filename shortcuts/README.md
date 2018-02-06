<!-- toc -->

## Keyboard shortcuts in MISP

Since v2.4.88, MISP has keyboard shortcuts managed using JSON files.
To see the list of shortcuts for a given page, press the small black triangle at the bottom of the page.
**Demo:**
![peek 2018-02-05 16-31](https://user-images.githubusercontent.com/14599855/35829840-2faaff36-0a92-11e8-8f7c-da995dc01e8c.gif)

**Q: Is it possible to customize the shortcuts in the GUI once they are there?**
**A:** Not at the moment.

**Q: How do I add keyboard shortcuts to my MISP instance?**
**A:**
1. Add a JSON file in `app/webroots/shortcuts` named after the page from which it will be included (for exemple `event_view.json`).
2. Set your shortcuts using this format: 
![image](https://user-images.githubusercontent.com/14599855/35830021-c80426f4-0a92-11e8-986f-49ded4414010.png)
(`action` field is JS code) 

2. Include the keyboard shortcut config in the `.ctp` file you wish it to be used in using an `input type="hidden"` tag like this: 
![image](https://user-images.githubusercontent.com/14599855/35830084-02f880ac-0a93-11e8-86fa-9cb4f0f95480.png)

3. Test your shortcuts.