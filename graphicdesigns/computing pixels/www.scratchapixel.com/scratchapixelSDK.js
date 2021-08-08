/***************************************************************************************************
 **
 ** CODE BEAUTIFIERS & CODE PAGE RELATED FUNCTIONS
 **
 **************************************************************************************************/

// see comment in code.php
function onMouseDownCodeCtxt(caller, link)
{
	// link when on right click/contextual menu, when user wants to download file
	// see comment in code.php
	caller.href = link;
}

function pad(n, width, z) 
{
  z = z || '0';
  n = n + '';
  return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
}

function codePretty(parent, text, startLine)
{
	//col2.style.id = "code_" + n; 
	var lines = text.split('\n');
	var code = '';
	var numbers = '';

	for (var i = 0; i < lines.length; i++)
	{
		numbers += pad(startLine + i + 1, 3) + '<br/>';
		var whiteSpaces = lines[i].search(/[^\s\\]/); // match anything that is not a white space
		//console.log(whiteSpaces);
		var words = lines[i].trim().split(' ');
		var line = '';
		//console.log(words[0]);
		if (words[0].search('//') == 0)
		{
			//console.log('toto ' + words[0]);
			line = "<span style='color: rgb(100, 100, 100);'>" + lines[i].substr(whiteSpaces, lines[i].length) + "</span>";
		}
		else
		{
			for (j = 0; j < words.length; ++j)
			{
				var word = words[j];
				/*
				for (k = 0; k < word.length; ++k)
				{
					var c = word.charAt(k);
					if (c == '<') c = '&#60';
					else if (c == '>') c = '&#62';
					line = line.concat('x');
				}
				*/
				var keywords = ['if', 'for', 'public', 'class', 'return', 'const', 'int', 'float', 'char', 'double', 'unsigned', 'template', 'typename'];
				var pos = -1;
				var k = 0;
				
				for (; k < keywords.length; ++k)
				{
					//console.log(word.search(keywords[n]));
					pos = word.search(keywords[k]);
					/*
					// we may have found the occurence but it could be int in Point for example
					// so we also need to check the character before and after the occurence.
					// for an int it can only be (int for instance or for something like
					// public it can only be followed by ':'
					*/
					if (pos >= 0)
					{
						var cStart = (pos > 0) ? word.charAt(pos - 1) : '';
						var cEnd = word.charAt(pos + keywords[k].length);
						//console.log(word + ', ' + cStart);
						if ((cStart == '(' || cStart == '') && (cEnd == ';' || cEnd == ':' || cEnd == ''))
						{
							break;
						}
					}
				}
				if (k < keywords.length)
				{
					line = line.concat(word.substr(0, pos) + '<b>' + word.substr(pos, keywords[k].length) + '</b>' + word.substr(keywords[k].length + pos, word.length) + ' ');
				}
				else
				{
					/*
					var tmp = '';
					for (k = 0; k < word.length; ++k)
					{
						var c = word.charAt(k);
						if (c == '<') c = '&#60';
						else if (c == '>') c = '&#62';
						tmp += c;
					}
					*/
					line = line.concat(word + ' ');
				}
			}
		}
		code += lines[i].substr(0, whiteSpaces) + line + '<br/>';
	}

	var col1 = document.createElement("div");
	var col2 = document.createElement("div");
	col1.style.cssText = "margin: 0px 10px 0px 10px; display: inline-block; float: left; width: auto; text-align: center; color: rgb(100, 100, 100);";
	col2.style.cssText = "width: 100%; border-left: 1px solid rgb(100, 100, 100); padding-left: 10px; display: inline-block; width: auto; color: rgb(50, 50, 50);";
	col1.innerHTML = numbers;
	col2.innerHTML = code;
	parent.appendChild(col1);
	parent.appendChild(col2);
}

function codeBeautifier()
{
	var x = document.getElementsByName("code");
	// iterate over all code blocks you can find in the page and process each block individually
	for (n = 0; n < x.length; ++n) {
		var lines = x[n].innerHTML.split('\n');
		x[n].innerHTML = '';
		var k = 0, kStart = 0;
		var text = '';
		while (1)
		{
			//var words = lines[k].trim().split(' ');
			var textInTag = '';
			var tag = '';
			var pos = lines[k].search(/[^\s\\]/);
			//console.log(pos);
			if (lines[k].charAt(pos) == '/' && ((lines[k].length > pos + 1) && lines[k].charAt(pos + 1) == '/'))
			{
				// look for a tag?
				//console.log("look for tag?");
				var l = pos + 2;
				for (; l < lines[k].length; ++l)
				{
					//console.log('here ' + lines[k].charAt(l));
					if (lines[k].charAt(l) == '[')
					{
						while (lines[k].charAt(++l) != ']' && l < lines[k].length) tag += lines[k].charAt(l);
						//console.log("tag name " + tag);
						break; // break from look if we have our tag
					}
					else if (lines[k].charAt(l) != ' ')
						break;
				}
				if (tag.length > 0)
				{
					// we have a tag, extract the content
					for (++l; l < lines[k].length; ++l)
					{
						textInTag += lines[k].charAt(l);
					}
					var extract = true;
					var lastInsertWasNewLine = true;
					while (extract)
					{
						if ((k + 1) == lines.length) break;
						k++;
						//textInTag += (textInTag.length > 0) ? '\n' : '';
						// if the lines starts with '//' add text until we find closing tag?
						pos = lines[k].search(/[^\s\\]/);
						if (lines[k].charAt(pos) == '/' && ((pos + 1 < lines[k].length) && lines[k].charAt(pos + 1) == '/')) {
							var lineContent = '';
							for (var m = pos + 2; m < lines[k].length && extract == true; ++m)
							{
								if (lines[k].charAt(m) == '[')
								{
									//console.log("here " + lines[k].charAt(m + 1));
									// It has to be a closing tag or some text such as 'v[0]' otherwise it's a syntax error. 
									// We don't deal with nested tags (for now)
									if ((m + 1) < lines[k].length && lines[k].charAt(++m) == '/')
									{
										// extract tag
										var tmp = '';
										while (lines[k].charAt(++m) != ']' && m < lines[k].length) tmp += lines[k].charAt(m);
										//console.log("tag name " + tmp + ', ' + tag);
										if (tmp != tag) 
										{
											tag = '';
										}
										else
										{
											extract = false;
										}
									}
									else
									{
										lineContent += '[' + lines[k].charAt(m);
									}
								}
								else
								{
									lineContent += lines[k].charAt(m);
								}
							}
							if (lineContent.length > 0)
							{
								if (lastInsertWasNewLine && lineContent.charAt(0) == ' ')
								{
									lineContent = lineContent.substr(1);
								}
								textInTag += lineContent;
								lastInsertWasNewLine = false;
							}
							else
							{
								textInTag += '\n';
								lastInsertWasNewLine = true;
							}
						}
					}
					if (tag != '')
					{
						// if we have text, export it
						if (text.length > 0)
						{
							codePretty(x[n], text, kStart);
							text = '';
						}
						//console.log(k + '>> ' + tag + ', ' + textInTag + '<<');
						var tagContent = document.createElement("div");
						if (tag == 'compile')
						{
							tagContent.style.cssText = 'padding: 10px; white-space: pre-wrap; border-left: 8px none rgb(73, 139, 234); background-color: #C8E6C9;';
							tagContent.innerHTML = "Instructions to compile this program:<br/>" + textInTag;
						} 
						else if (tag != 'ignore')
						{
							tagContent.style.cssText = 'width: 100%; padding: 10px; white-space: pre-wrap; border-left: 8px none rgb(73, 139, 234); background-color: #FFE0B2;';	
							tagContent.innerHTML = textInTag;
						}
						x[n].appendChild(tagContent);
						textInTag = '';
						tag = '';
						kStart = k + 1;
					}
				}
				else
				{
					// it's a comment just add it
					text += (text.length > 0 ? '\n' : '') + lines[k];
				}
			}
			else
			{
				text += (text.length > 0 ? '\n' : '') + lines[k];
			}
			if (++k == lines.length) break;
		}
		// dump what's left of the text if any
		if (text.length > 0)
		{
			codePretty(x[n], text, kStart);
			text = '';
		}
		//console.log("test " + x[n].innerHTML);
	}
}

// I had to change that code. Before I was using an onclick mechanism to get to the content
// section when you'd click on the content link. However the problem is that when you do
// this, the javascript is executed before the page is loaded, thus, you just get
// an error reported in the console and the script fails going any further, and you had
// to click another time (once the page was loaded) to actually get to the content section.
// So this is changed so that now I pass as a GET the keyword ?content. And this function
// is executed on page load() (once the page is loaded). This is workng however the problem
// is that onload() is now called and used by every single page (since I am using templates
// to build pages. However this is light enough probably and also this mechanism might
// be useful in the future for other pages (I can extent it, using other keywords).
// 14/08/2014
function onload()
{
	var isPage = document.getElementById('sap-root');
	if (isPage != null)
	{
		// you need to find all the H2 in the document
		var allH2 = document.getElementsByTagName("h2");
		if (allH2.length > 0)
		{
			//alert("i found " + allH2.length + " elements");
			var rand = Math.floor(Math.random() * allH2.length);
			if (rand == allH2.length) rand = rand - 1;
			//var text = document.createTextNode('the text');
			var newDiv = document.createElement('div');
			
			//newDiv.setAttribute('class', 'donate-style');
			//newDiv.innerHTML = "If Scratchapixel is important to you, make a big difference with a small monthly <a href=\'https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&amp;hosted_button_id=78FWLXMM9YGPN'\'>donation</a>.\
			//</br><span style='font-size: 12px;'>All the lessons on Scratchapixel are free, but we now need your help to keep adding new content on the website. This will help recovering the cost of running the project. Making a donation is also a way\
			//of showing that you care about this website because you think it's cool and that it is valuable to you! If you do it, it will help us developing the project further\
			//but more importantly you will secure access to free high quality content for yourself and the generations to come. Everybody should have equal access to knowledge and this is why we are here. To give everybody an equal opportunity to learn something we believe is fun and important.\
			//We try to make a difference but you also play a critical part in that chain.</br><b>Contribute to Scratchapixel in your own way, with a donation, and show it matters to you</b>.</span>";
			newDiv.innerHTML = "<a href=\'https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&amp;hosted_button_id=78FWLXMM9YGPN'\'><img class='left' src='/images/design/donate.png'></a>";
			
			allH2[rand].parentNode.insertBefore(newDiv, allH2[rand]);
		}
	}
	
	codeBeautifier();
}