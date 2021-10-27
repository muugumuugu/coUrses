function preload(){
  marks=loadTable('marks.csv','csv', 'header');
  words=loadTable("words.csv","csv","header");
}
function setup() {
  noCanvas();
  saveJSON(bills,"nill.json")
}

function draw() {
 noLoop();
}