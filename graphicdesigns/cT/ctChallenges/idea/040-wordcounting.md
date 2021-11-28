* load a string stream and join all lines into a single string.
* split it according to regex "/W+/"
* create a count hashmap/associative array.
* lowercase/uppercase each token.
* loop thru all tokens extracted
	add word to dictionary/hash map if not already there
	else increment count.
* visualize as word cloud.
	* positioned randomly
	* textsize= word count
* check for mood using word count ratio of + and - words
* the secret life of pronouns.
* Term Frequency - Inverse Document Frequency
	Score = frequency in document * log( Corpus Size/ frequency in all of document space).
```
IntDict counts;

void setup() {
size(600, 600);
background(0);
counts = new IntDict();
String[] lines = loadStrings("rainbow.txt");
String allwords = join(lines, "\n");
String[] tokens = allwords.split("\\W+");

//printArray(tokens);
for (int i = 0; i <tokens.length; i++) {
String word = tokens[i].toLowerCase();
if (counts.hasKey(word)) {
counts.increment(word);
} else {
counts.set(word, 1);
}
}

String[] keys = counts.keyArray();
for (String k : keys) {
int count = counts.get(k);
textSize(count);
float x = random(width);
float y = random(height);
text(k, x, y);
}
}

```