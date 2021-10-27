// Daniel Shiffman
// Programming from A to Z, Fall 2014
// https://github.com/shiffman/Programming-from-A-to-Z-F14

// An array of lines from a text file
var lines;
// The Markov Generator object
var markov;
// An output element
var output;

// Preload some seed data
function preload() {
  lines = loadStrings('data/frankenstein.txt');
}

function setup() {
  // Join everything together in one long string
  // Keep carriage returns so these will show up in the markov generator
  var text = lines.join('\n');

  // N-gram length and maximum length
  markov = new MarkovGenerator(6, 10000);
  markov.feed(text);

  // Make the button
  var button = select('#button');
  button.mousePressed(generate);

  // Make the output element
  output = select('#output');

  noCanvas();
}

function generate() {
  // Generate some text
  var text = markov.generate();
  // Put in HTML line breaks wherever there was a carriage return
  text = text.replace(/\n/g,'<br/><br/>');
  output.html(text);
}
