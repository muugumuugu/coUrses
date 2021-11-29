# Alphabet
say A,B
# Axiom
say AAAB
# Rules
say
* A → AB
* B → A
# string replacement structure
make replace all calls to , with replaced chars being uppercase
lowercase the result

# turtle function
parse string character by character and perform a drawing operation acc to character


```
float angle;
String axiom = "F";
String sentence = axiom;
int len = 100;
Rule[] rules;


void setup(){
  size(400,400);

  rules = new Rule[1];
  rules[0] = new Rule('F', "FF+[+F-F-F]-[-F+F+F]");

  angle = radians(45);
  background(51);
  println(axiom);
  turtle();
}

void draw(){
}


void mouseClicked(){
  println("click");
  generate();
}


class Rule {
  char a;
  String b;
  Rule(char _a, String _b){
    a = _a;
    b = _b;
  }
}

void generate(){
  len *= 0.5;
  String next_sentence = "";
  for (int i = 0; i < sentence.length(); i++){
    char current = sentence.charAt(i);
    boolean found = false;
    for (int j = 0; j < rules.length; j++){
      if (current == rules[j].a){
        found = true;
        next_sentence += rules[j].b;
        break;
      }
    }
    if (!found){
      next_sentence += current;
    }
  }
  sentence = next_sentence;
  println(sentence);
  turtle();
}


void turtle(){
  background(51);
  resetMatrix();
  translate(width/2, height);
  stroke(255, 100);
  for (int i = 0; i < sentence.length(); i++) {
    char current = sentence.charAt(i);

    if (current == 'F') {
      line(0, 0, 0, -len);
      translate(0, -len);
    } else if (current == '+') {
      rotate(angle);
    } else if (current == '-') {
      rotate(-angle);
    } else if (current == '[') {
      pushMatrix();
    } else if (current == ']') {
      popMatrix();
    }
  }
}
```










```
function leftTurn() {
  rotate(-angle_s.value());
}

function rightTurn() {
  rotate(angle_s.value());

}
function forward() {

  line(0, 0, length.value(), 0);
  translate(length.value(), 0);
} //Forward motion is based on the user's inputed length values.

function setpoint() {
  push();
}

function backtrack() {
  pop();
} // These functions are called based on the turtle ruleset, and whatever letter it is on. If the user so wanted to, or did so by accident, they could call a lot of push or pop functions unevenly. The rotate and translate functions will stack on each other as they are called in order

function turtleDraw() {

  for (let t = 0; t < sentence.length; t++) { //The turtle will act based on each letter in the sentance, and restarts when it reaches the end.
    let t_current = sentence.charAt(t); //Selects the current letter the turtle is on. I could just use the charAt function throughout this, but maybe it's faster to only call it one and put it into a variable? IDK if it make a difference or not in terms of speed.

    for (let r = 0; r < turtle.length; r++) {

      if (turtle[r].in == t_current) { //The turtle will check each rule per letter until it finds a match.

        turtle[r].out(); //Once a match is found, the function (turn, go forward, save location, load location) for that specific rule in the turtle is activated.
        break;

      }
    }
  }
}

function generate() {

  let nextSentence = ""; //Starts a new sentance, that will be created from the old one.

  for (let i = 0; i < sentence.length; i++) {
//Runs for each letter in the sentance
    let current = sentence.charAt(i); //Possible saving on cpu time
    let found = false; //This flag is set so that if non of the rule match, a default one runs.

    for (let j = 0; j < rules.length; j++) {
//Checks each rule against each letter.
      if (current == rules[j].cur) {
        found = true; //Once a match is found, it sets the found flag
        nextSentence += rules[j].next; //Adds the output of the specific letter to the new sentance
        break; //Once a rule is found, don't check the others (assuming a single rule per character here)
      }
    }

    if (!found) {
//If the letter matches non of the rule's inputs, the letter is just pushed forward into the new sentence unaltered.
      nextSentence += current;
    }
  }
//Finally once the sentence is done, the new one rewrites the old one.
  sentence = nextSentence;
  //createP(sentence);
}


//==============Turtle===============/
let ruleOptions = []; //Holds the rule data for iterations

let turtleOptions = []; //Holds the five different instruction types, as seen below. This is just a template function to copy from. The copy is needed as I can't (or at least, don't know how to) set functions in arays after the program has started (a.k.a, all the out's).
turtleOptions[0] = {
  in: "",
  out: leftTurn
}

turtleOptions[1] = {
  in: "",
  out: rightTurn
}
turtleOptions[2] = {
  in: "",
  out: forward
}
turtleOptions[3] = {
  in: "",
  out: setpoint
}
turtleOptions[4] = {
  in: "",
  out: backtrack
}

function setrules() {
//Called anytime the user changes how many rules there are.
  for (let d = 0; d < n_rule.length; d++) {
    n_rule[d][0].remove()
    n_rule[d][1].remove()
    n_rule[d][2].remove()
  } // Deletes all the old rule html boxes

  n_rule = []; //And does a clean sweap of the old rule data.

  for (let ru = 0; ru < ruleSelect.value(); ru++) {
    n_rule.push([]);
    n_rule[ru][0] = createInput();
    n_rule[ru][0].changed(newRuleSet);
    n_rule[ru][1] = createInput();
    n_rule[ru][1].changed(newRuleSet);
    n_rule[ru][2] = createP("");
  }
//This runs repeatedly based on how many new rules the user wants, which could be a thousand if they wanted to. Creates two input boxes for the input and output of each rule.
  newRuleSet(); //Seen below
}

function newRuleSet() {
  rules = [];
  sentence = axiom.value();
  //This resets the sentence string and clears out the old ruleset. This runs after changing how many rules there are, and any time the user makes any changes to the ruleset input boxes.

  for (let nr = 0; nr < n_rule.length; nr++) {

    rules[nr] = {
      cur: n_rule[nr][0].value(),
      next: n_rule[nr][1].value() //And taking from the user input, remakes the ruleset.
    }
  }
}

function setTurtle() {
//This does more or less the same thing as the ruleset functions above, but pulls from a template instead of creating the ruleset from scratch.
  for (let dt = 0; dt < n_turtle.length; dt++) {
    n_turtle[dt][0].remove()
    n_turtle[dt][1].remove()
    n_turtle[dt][2].remove()
  } //Clears out the old rules

  n_turtle = []; //Freshen up the array

  for (let tu = 0; tu < turtleSelect.value(); tu++) {
    n_turtle.push([]);
    n_turtle[tu][0] = createInput();
    n_turtle[tu][0].changed(newTurtleSet);
    n_turtle[tu][1] = createSelect();
    n_turtle[tu][1].option("Left");
    n_turtle[tu][1].option("Right");
    n_turtle[tu][1].option("Forward");
    n_turtle[tu][1].option("Save Position");
    n_turtle[tu][1].option("Back to Save");
    n_turtle[tu][1].selected("Forward");
    n_turtle[tu][1].changed(newTurtleSet);
    n_turtle[tu][2] = createP("");
  } //Same old, just adding dropdown boxes for the right side instead of another input. The turtle rules only have five options.

  newTurtleSet();
}

function newTurtleSet() {
  turtle = [];
  sentence = axiom.value(); //Resets the drawing string. This is called anytime a change is made to the turtle ruleset.

  for (let nt = 0; nt < n_turtle.length; nt++) {

    //I could probably do the same thing with a switch statment, but don't want to fiddle with this. Looks for and matches the value of each dropdown box to the turtle template, and copies it over. The it updates the 'in' value to the user input.
    if (n_turtle[nt][1].value() == "Left") {

      turtle[nt] = turtleOptions[0];

        turtle[nt].in = n_turtle[nt][0].value();


    } else if (n_turtle[nt][1].value() == "Right") {
   turtle[nt] = turtleOptions[1];
        turtle[nt].in = n_turtle[nt][0].value();
    } else if (n_turtle[nt][1].value() == "Forward") {
     turtle[nt] = turtleOptions[2];
        turtle[nt].in = n_turtle[nt][0].value();

    } else if (n_turtle[nt][1].value() == "Save Position") {
    turtle[nt] = turtleOptions[3];
        turtle[nt].in = n_turtle[nt][0].value();

    } else if (n_turtle[nt][1].value() == "Back to Save") {
      turtle[nt] = turtleOptions[4];
        turtle[nt].in = n_turtle[nt][0].value();
    }
  }

}
//================options==============
let angle;
let angle_s;
let length;
let make;
let restart;
let spin;
let x_shift;
let y_shift;
let ruleSelect;
let n_rule = [];
let turtleSelect;
let n_turtle = [];
let axiom;
let sentence;
let turtle = [];

function setup() {

  angleMode(DEGREES); //User input is used for angles, so degrees is used
  createCanvas(800, 800);

  make = createButton("Step");
  make.mousePressed(generate); //Each press iterates the function
  restart = createButton("Clear");
  restart.mousePressed(clearSentence); //Clears the sentence string that holds all the drawing data

  createP("Line Length");
  length = createSlider(0, width / 20, 10, 0); //This sets the length of the lines used for iterations, 'scaling' the image

  createP("Rotate full Image");
  spin = createSlider(-180, 180, -45);

  createP("Move Left and Right")
  x_shift = createSlider(0, width, 0);

  createP("Move Up and Down")
  y_shift = createSlider(0, height, height);

  createP("Set angle");
  angle = createInput("25"); //Manual set, for specific functions.
  angle_s = createSlider(-180, 180, 25);

  createP("Set Axiom (This is your 'starter seed'). Will Clear the board when updated.");
  axiom = createInput("X");
  axiom.changed(clearSentence);
  sentence = axiom.value();

  createP("How many rules would you like?");
  ruleSelect = createInput("2");
  ruleSelect.changed(setrules);
  createP("The input on the left will be converted into the output on the right. Only Single letters may be given as input, output can be whatever you want. (Note: Some special characters don't work properly)");
  n_rule.push([], []) //n_rule, or 'new rule' is the array the holds the settings for each rule.
  n_rule[0][0] = createInput("X");
  n_rule[0][0].changed(newRuleSet);
  n_rule[0][1] = createInput("F+[[X]-X]-F[-FX]+X");
  n_rule[0][1].changed(newRuleSet);
  n_rule[0][2] = createP("");

  n_rule[1][0] = createInput("F");
  n_rule[1][0].changed(newRuleSet);
  n_rule[1][1] = createInput("FF");
  n_rule[1][1].changed(newRuleSet);
  n_rule[1][2] = createP("");

  newRuleSet(); //The above generates a starting ruleset, a barnsley fern

  createP("Set the drawing rules for each character for the turtle to follow.");
  turtleSelect = createInput("5");
  turtleSelect.changed(setTurtle);
  createP("The drawing turtle takes the input from these rules and applies an action. One letter cannot be assigned two rules (it will default to the first rule found), but two letters can be assigned the same rule 'action' by making two seperate rules for each character. The Save Position and Return to Save may act oddly if there is not an equal amount of saves and returns, and a save must come before a return action.");

  for (let tu = 0; tu < turtleSelect.value(); tu++) {
    let DI1;
    let DI2;

    switch (tu) {
      case 0:
        DI1 = "+"
        DI2 = "Left"
        break;
      case 1:
        DI1 = "-"
        DI2 = "Right"
        break;
      case 2:
        DI1 = "F"
        DI2 = "Forward"
        break;
      case 3:
        DI1 = "["
        DI2 = "Save Position"
        break;
      case 4:
        DI1 = "]"
        DI2 = "Back to Save"
        break;

    }
    n_turtle.push([]); //n_turtle, 'new turtle' is the array that holds the rule set for drawing.
    n_turtle[tu][0] = createInput(DI1);
    n_turtle[tu][0].changed(newTurtleSet);
    n_turtle[tu][1] = createSelect();
    n_turtle[tu][1].option("Left");
    n_turtle[tu][1].option("Right");
    n_turtle[tu][1].option("Forward");
    n_turtle[tu][1].option("Save Position");
    n_turtle[tu][1].option("Back to Save");
    n_turtle[tu][1].selected(DI2);
    n_turtle[tu][1].changed(newTurtleSet);
    n_turtle[tu][2] = createP("");
  }

  newTurtleSet(); //Setting the rest of the user inputs. The switch function manualy sets each default value to the barnsley fern, otherwise this could be a lot shorter.

}

function draw() {
  if (mouseIsPressed) {
  angle.value(angle_s.value());
  }
  angle.changed(angleChanged);

  translate(x_shift.value(), y_shift.value());
  rotate(spin.value()); //The translate and spin are user controlled to get the best look at whatever is made.
  background(190);
  turtleDraw(); //This function takes the turtle ruleset and draw it each frame. Located in turtleFunctions.js

}

function clearSentence() {
  sentence = axiom.value();
} //Just clears the sentence which provides the drawing and fractle data, a restart.

function angleChanged() {

  angle_s.value(int(angle.value()));

}
//=========driver=========
```