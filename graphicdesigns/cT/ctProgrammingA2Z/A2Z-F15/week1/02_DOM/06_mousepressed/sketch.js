
var link;

function setup() {
  noCanvas();
  link = createA("#","click me");
  link.style('padding', '12px');
  link.style('border-style', 'solid');
  link.mousePressed(changeBG);
}

function changeBG() {
  var heading = select('#heading');
  var r = floor(random(255));
  var b = floor(random(255));
  var col = 'rgb(' + r + ',0,' + b + ')';
  heading.style('background-color', col);
}
