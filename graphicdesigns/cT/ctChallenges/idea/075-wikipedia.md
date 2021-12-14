# Std In:
	take text input from user
# bind to input entering/ button
# end points
search end point : =
	https://en.wikipedia.org/w/api/php?action=opensearch&format=json&search=keyword
content end point:= https://en.wikipedia.org/w/api/php?action=query&prop=revisions&rvprop=content&format=json&titles=keywordarray
# requesting
load jsonp, bypassing cors, requesting url,
	push to callback function
# goWiki function the recursisve crawler
search data comes as array of arrays,
	and 2nd element gives you the title of pages matching keyword
content comes back, pick a word at random from the content, crawl again with this word.
LOOPADELOOP