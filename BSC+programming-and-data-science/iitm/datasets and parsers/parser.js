function preload(){
  marks=loadTable('marks.csv','csv', 'header');
  words=loadTable("words.csv","csv","header");
}
function setup() {
  noCanvas();
  console.log("data accesible thru variables :")
  console.log("marks,")
  console.log("words,")
  console.log("bills")
}

function draw() {
 noLoop();
}