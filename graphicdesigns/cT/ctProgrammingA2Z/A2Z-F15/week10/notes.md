---
title: Programming from A to Z Week 10 Notes
layout: default
---

# Chrome Extensions

## Example extensions
* [Basic "hello world" extension -- Browser Action](https://github.com/shiffman/A2Z-F15/tree/gh-pages/week10/00_extension_basics_browser)
* [Basic "hello world" extension -- Page action](https://github.com/shiffman/A2Z-F15/tree/gh-pages/week10/01_extension_basics_page)
* [Extension with pop-up (using p5)](https://github.com/shiffman/A2Z-F15/tree/gh-pages/week10/02_extension_browser_popup_p5)
* [Extension with pop-up controlling content](https://github.com/shiffman/A2Z-F15/tree/gh-pages/week10/03_extension_browser_popup_messaging)
* [Extension with pop-up querying wordnik](https://github.com/shiffman/A2Z-F15/tree/gh-pages/week10/04_extension_browser_popup_messaging_2)
* [Image swap and content altering](https://github.com/shiffman/A2Z-F15/tree/gh-pages/week10/05_content_changer)
* [Content script with p5 canvas overlay](https://github.com/shiffman/A2Z-F15/tree/gh-pages/week10/06_with_p5)
* [Searching and redacting a word](https://github.com/shiffman/A2Z-F15/tree/gh-pages/week10/07_word_redacter)
* [Override "new tab"](https://github.com/shiffman/A2Z-F15/tree/gh-pages/week10/08_override)
* [OmniBox](https://github.com/shiffman/A2Z-F15/tree/gh-pages/week10/09_omnibox)
* [Alarms](https://github.com/shiffman/A2Z-F15/tree/gh-pages/week10/10_alarms)

## Examples of Creative Extensions
* [girlsvsgit](https://github.com/wheresaddie/girlsvsgit) by [wheresaddie](https://twitter.com/wheresaddie)
* [wordless web](http://pleaseenjoy.com/projects/personal/wordless-web/#image454) (this is actually a bookmarklet but as a content script could be an extension).
* [code doodles](http://codedoodl.es/)

## Resources / Tutorials
* [Official Google guide to chrome extensions](https://developer.chrome.com/extensions/getstarted)
* [Building your first chrome extension video tutorial](https://www.youtube.com/watch?v=pT-b2SpFIWo)
* [How to make a chrome extension](https://robots.thoughtbot.com/how-to-make-a-chrome-extension)
* [Developing chrome extensions tutorial](http://code.tutsplus.com/tutorials/developing-google-chrome-extensions--net-33076)

## Basics

A chrome extension is a way of adding functionality to the chrome browser.  You can add interface elements, open and close tabs, interact with the address bar, as well as modify the contents of any page the browser is currently on.  The lovely thing for us is that extensions can be built with the same open web tools that we are already using -- HTML, CSS, JavaScript.

All chrome extensions require a `manifest.json` file.  This file includes metadata about the extensions, sets its permissions, and references all the JavaScript, CSS, and other files associated with the extension.

Here is an example:

{% highlight javascript %}
{
  "manifest_version": 2,
  "name": "My Extension",
  "version": "0.1"
}
{% endhighlight %}

The [manifest_version](https://developer.chrome.com/extensions/manifestVersion) should always be 2 as this is the current manifest specification.  [Here is the full spec](https://developer.chrome.com/extensions/manifest) for manifest.json.

## Content Scripts

The first thing you might try with an extension is making a content script.  A content script is a piece of JavaScript code (which can also include and reference CSS) that runs after the page loads.  It has full access to the DOM so you can do things like alter content, styles, layout, images, anything that is on the page.  The manifest.json file should reference your content script.

{% highlight javascript %}
{
  "manifest_version": 2,
  "name": "My Extension",
  "version": "0.1",
  "content_scripts": [
    {
      "js": ["content.js"]
    }
  ]
}
{% endhighlight %}

You also need to specify which URLs the content script should run on.  For example for all URLs, you would add:

{% highlight javascript %}
  "content_scripts": [
    {
      "matches": [
        "<all_urls>"
      ],
      "js": ["content.js"]
    }
  ]
{% endhighlight %}

You can also specify individual unique URLs and using the wildcard `*` to encompass all paths on a given domain.  For example, the following would run the content script on any github.com page:

{% highlight javascript %}
  "content_scripts": [
    {
      "matches": [
        "http://github.com/*",
        "https://github.com/*",
        "http://*.github.com/*",
        "https://*.github.com/*"
      ],
      "js": ["content.js"]
    }
  ]
{% endhighlight %}

Let's look at some very basic code that just takes every paragraph element and changes its background color to purple.  I'll use native JavaScript below, but it is possible to use a DOM library like JQuery or p5.

{% highlight javascript %}
var elts = document.getElementsByTagName('p');
for (var i = 0; i < elts.length; i++) {
  elts[i].style['background-color'] = '#F0C';
}
{% endhighlight %}

By default, Chrome runs the code in the content scripts after the DOM is completely loaded.  So there's no need wrap the code inside a "ready" event.

This is all you need for a working chrome extension!  To test the extension, go to the browser's extension page via `chrome://extensions/`.  Check "Developer mode" and then "Load unpacked extension".  Browse to the directory where you've stored your `manifest.json` and `content.js` file.

![unpacked](images/unpacked_extension.png)

Once the extension is installed you can enable or disable it, as well as delete it.  Also note that if you change the code you'll need to select "reload" before the new code will run.

## Browser Actions

User interface elements can be added as part of chrome extension via "browser" or "page" actions.  A browser action creates a button that lives on the top right of the browser.  A page action is an icon that appears in the address bar itself.

Browser and page actions can't access the DOM itself, however, they can communicate with the content script via the chrome "messaging" API.  A browser action should have an icon (for the button) as well as a JavaScript file for the code. 

{% highlight javascript %}
  "browser_action": {
    "default_icon": "icon.png"
  },
  "background": {
    "scripts": ["background.js"],
  }
{% endhighlight %}

When the user clicks the button, it triggers an "onClick" event.  This code would go in `background.js`.

{% highlight javascript %}
// Add a listener for the browser action
chrome.browserAction.onClicked.addListener(buttonClicked);

function buttonClicked(tab) {
  // The user clicked the button!
  // 'tab' is an object with information about the current open tab
}
{% endhighlight %}

## Messaging

Let's say you want to execute some code in the content script (to manipulate the DOM) whenever the user triggers the browser action.  This is where you need to use "messaging".  A message is just a JavaScript object of your own design that you send from the background script to the content script.  Here is the sending:

{% highlight javascript %}
function buttonClicked(tab) {
  var msg = {
    message: "user clicked!"
  }
  chrome.tabs.sendMessage(tab.id, msg);
}
{% endhighlight %}

And then in the content script you can receive the message and perform an action.  Lots of data comes in with the message, but the actual object you sent is in the `request` variable.

{% highlight javascript %}
// Listen for messages
chrome.runtime.onMessage.addListener(receiver);

// Callback for when a message is received
function receiver(request, sender, sendResponse) {
  if (request.message === "user clicked!") {
    // Do something!
  }
}
{% endhighlight %}

## Pop-ups

The browser action can also trigger a pop-up, which is just an HTML page.  For example, you could run a p5 sketch in the pop-up as in [this example](https://github.com/shiffman/A2Z-F15/tree/gh-pages/week10/02_extension_browser_popup_p5).  To do this, reference the pop-up HTML file in `manifest.json`.

{% highlight javascript %}
"browser_action": {
  "default_title": "you can also add a tool tip here",
  "default_popup": "popup.html"
}
{% endhighlight %}

The pop-up can also communicate with the content script via messaging.  There are two examples that demonstrate this functionality.  [This first one](https://github.com/shiffman/A2Z-F15/tree/gh-pages/week10/03_extension_browser_popup_messaging) uses a slider and text field in the pop-up to alter the DOM content.  [This second one](https://github.com/shiffman/A2Z-F15/tree/gh-pages/week10/04_extension_browser_popup_messaging_2) uses text that is selected on the page itself to make an API query.  Any JavaScript associated with the pop-up is not triggered unless the user clicks the button.  So in the second example, it's worth noting that the message goes from the content script to the background script.  A pop-up can then access variables in the background script.  For example if the background script has a variable called `word`, you would say:

{% highlight javascript %}
var word = chrome.extension.getBackgroundPage().word;
{% endhighlight %}

## Omnibox

Actions can also be triggered by typing a keyword into the "omnibox" (also known as "address bar").  The keyword is specified in `manifest.json`.

{% highlight javascript %}
  "omnibox": { 
    "keyword": "a2z" 
  }
{% endhighlight %}

What to do after the user types a2z is handled in the background script.

{% highlight javascript %}
// This event is fired when the user hits "enter"
chrome.omnibox.onInputEntered.addListener(omniChanged);

function omniChanged(text) {
  // The variable "text" has the text the user typed
  // You could open a new tab on a specific page that uses that text
  // or send a message to a content script
  // etc.
}
{% endhighlight %}

## Override Page

Chrome extensions allow you to replace the default chrome pages for bookmarks, history, and new tab. To replace new tab, for example, add the following to manifest.json.

{% highlight javascript %}
  "chrome_url_overrides": {
    "newtab": "newtab.html"
  }
{% endhighlight %}

Then you can create `newtab.html` with any HTML, CSS, or JavaScript. [Here's an example that picks a random "word of the day" from Wordnik](https://github.com/shiffman/A2Z-F15/tree/gh-pages/week10/08_override).


## APIs

One of the benefits of using a chrome extension is [all of the APIs](https://developer.chrome.com/extensions/api_index) that are available for controlling the behavior of the browser.  Some that might interest you are:

* [Alarms API](https://developer.chrome.com/extensions/alarms)
* [tabs](https://developer.chrome.com/extensions/tabs) and [windows](https://developer.chrome.com/extensions/windows)
* [tts (text-to-speech)](https://developer.chrome.com/extensions/tts)
* [webRequest](https://developer.chrome.com/extensions/webRequest)
