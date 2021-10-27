// A2Z F16
// Daniel Shiffman
// http://shiffman.net/a2z
// https://github.com/shiffman/A2Z-F16

// Based entirely on: 
// https://github.com/karpathy/recurrentjs
// http://cs.stanford.edu/people/karpathy/recurrentjs/index.html

if (process.argv.length < 3) {
  console.log("I need an text input file and a model file.");
  process.exit();
}

var inputFile = process.argv[2];
var modelFile = process.argv[3];

var R = require('./recurrent');

var fs = require('fs');
// Load file
var input = fs.readFileSync(inputFile, 'utf-8');
// Split into lines
var txt = input.split(/\n/);

// prediction params
var sample_softmax_temperature = 1.0; // how peaky model predictions should be
var max_chars_gen = 100; // max length of generated sentences

// various global var inits
var epoch_size = -1;
var input_size = -1;
var output_size = -1;
var letterToIndex = {};
var indexToLetter = {};
var vocab = [];
var data_sents = [];
var solver = new R.Solver(); // should be class because it needs memory for step caches

// model parameters
var generator = 'lstm'; // can be 'rnn' or 'lstm'
var hidden_sizes = [20, 20]; // list of sizes of hidden layers
var letter_size = 5; // size of letter embeddings

// optimization
var regc = 0.000001; // L2 regularization strength
var learning_rate = 0.01; // learning rate
var clipval = 5.0; // clip gradients at this value

var model;// = {};

var interval;

// I'm adding
var iterations = 0;

// process the input, filter out blanks
data_sents = [];
for (var i = 0; i < txt.length; i++) {
  var sent = txt[i].trim();
  if (sent.length > 0) {
    data_sents.push(sent);
  }
}

var initVocab = function(sents, count_threshold) {
  // go over all characters and keep track of all unique ones seen
  var txt = sents.join(''); // concat all

  // count up all characters
  var d = {};
  for (var i = 0, n = txt.length; i < n; i++) {
    var txti = txt[i];
    if (txti in d) {
      d[txti] += 1;
    } else {
      d[txti] = 1;
    }
  }

  // filter by count threshold and create pointers
  letterToIndex = {};
  indexToLetter = {};
  vocab = [];
  // NOTE: start at one because we will have START and END tokens!
  // that is, START token will be index 0 in model letter vectors
  // and END token will be index 0 in the next character softmax
  var q = 1;
  for (ch in d) {
    if (d.hasOwnProperty(ch)) {
      if (d[ch] >= count_threshold) {
        // add character to vocab
        letterToIndex[ch] = q;
        indexToLetter[q] = ch;
        vocab.push(ch);
        q++;
      }
    }
  }

  // globals written: indexToLetter, letterToIndex, vocab (list), and:
  input_size = vocab.length + 1;
  output_size = vocab.length + 1;
  epoch_size = sents.length;
  console.log('found ' + vocab.length + ' distinct characters: ' + vocab.join(''));
}

initVocab(data_sents, 1); // takes count threshold for characters

var utilAddToModel = function(modelto, modelfrom) {
  for (var k in modelfrom) {
    if (modelfrom.hasOwnProperty(k)) {
      // copy over the pointer but change the key to use the append
      modelto[k] = modelfrom[k];
    }
  }
}

var initModel = function() {
  // letter embedding vectors
  var model = {};
  model['Wil'] = new R.RandMat(input_size, letter_size, 0, 0.08);

  if (generator === 'rnn') {
    var rnn = R.initRNN(letter_size, hidden_sizes, output_size);
    utilAddToModel(model, rnn);
  } else {
    var lstm = R.initLSTM(letter_size, hidden_sizes, output_size);
    utilAddToModel(model, lstm);
  }

  return model;
}

model = initModel();

var costfun = function(model, sent) {
  // takes a model and a sentence and
  // calculates the loss. Also returns the Graph
  // object which can be used to do backprop
  var n = sent.length;
  var G = new R.Graph();
  var log2ppl = 0.0;
  var cost = 0.0;
  var prev = {};
  for (var i = -1; i < n; i++) {
    // start and end tokens are zeros
    var ix_source = i === -1 ? 0 : letterToIndex[sent[i]]; // first step: start with START token
    var ix_target = i === n - 1 ? 0 : letterToIndex[sent[i + 1]]; // last step: end with END token

    lh = forwardIndex(G, model, ix_source, prev);
    prev = lh;

    // set gradients into logprobabilities
    logprobs = lh.o; // interpret output as logprobs
    probs = R.softmax(logprobs); // compute the softmax probabilities

    log2ppl += -Math.log2(probs.w[ix_target]); // accumulate base 2 log prob and do smoothing
    cost += -Math.log(probs.w[ix_target]);

    // write gradients into log probabilities
    logprobs.dw = probs.w;
    logprobs.dw[ix_target] -= 1
  }
  var ppl = Math.pow(2, log2ppl / (n - 1));
  return {
    'G': G,
    'ppl': ppl,
    'cost': cost
  };
}

function median(values) {
  values.sort(function(a, b) {
    return a - b;
  });
  var half = Math.floor(values.length / 2);
  if (values.length % 2) return values[half];
  else return (values[half - 1] + values[half]) / 2.0;
}

var forwardIndex = function(G, model, ix, prev) {
  var x = G.rowPluck(model['Wil'], ix);
  // forward prop the sequence learner
  if (generator === 'rnn') {
    var out_struct = R.forwardRNN(G, model, hidden_sizes, x, prev);
  } else {
    var out_struct = R.forwardLSTM(G, model, hidden_sizes, x, prev);
  }
  return out_struct;
}

var predictSentence = function(model, samplei, temperature) {
  if (typeof samplei === 'undefined') {
    samplei = false;
  }
  if (typeof temperature === 'undefined') {
    temperature = 1.0;
  }

  var G = new R.Graph(false);
  var s = '';
  var prev = {};
  while (true) {

    // RNN tick
    var ix = s.length === 0 ? 0 : letterToIndex[s[s.length - 1]];
    var lh = forwardIndex(G, model, ix, prev);
    prev = lh;

    // sample predicted letter
    logprobs = lh.o;
    if (temperature !== 1.0 && samplei) {
      // scale log probabilities by temperature and renormalize
      // if temperature is high, logprobs will go towards zero
      // and the softmax outputs will be more diffuse. if temperature is
      // very low, the softmax outputs will be more peaky
      for (var q = 0, nq = logprobs.w.length; q < nq; q++) {
        logprobs.w[q] /= temperature;
      }
    }

    probs = R.softmax(logprobs);
    if (samplei) {
      var ix = R.samplei(probs.w);
    } else {
      var ix = R.maxi(probs.w);
    }

    if (ix === 0) break; // END token predicted, break out
    if (s.length > max_chars_gen) {
      break;
    } // something is wrong

    var letter = indexToLetter[ix];
    s += letter;
  }
  return s;
}

function map(n, start1, stop1, start2, stop2) {
  return ((n-start1)/(stop1-start1))*(stop2-start2)+start2;
};

var tick = function() {
  // Lowering learning rate over time
  learning_rate = map(iterations, 0, 200000, 0.01, 0.0001);

  // sample sentence fromd data
  var sentix = R.randi(0, data_sents.length);
  var sent = data_sents[sentix];

  var t0 = +new Date(); // log start timestamp

  // evaluate cost function on a sentence
  var cost_struct = costfun(model, sent);

  // use built up graph to compute backprop (set .dw fields in mats)
  cost_struct.G.backward();
  // perform param update
  var solver_stats = solver.step(model, learning_rate, regc, clipval);
  //$("#gradclip").text('grad clipped ratio: ' + solver_stats.ratio_clipped)

  var t1 = +new Date();
  var tick_time = t1 - t0;

  // evaluate now and then
  // draw samples

  if (iterations % 100 == 0) {
    console.log('\n\n');
    console.log('--------predictions----------');
    for (var q = 0; q < 5; q++) {
      var pred = predictSentence(model, true, sample_softmax_temperature);
      console.log(pred);
    }
    console.log('\n--------argmax---------------');
    // draw argmax prediction
    var pred = predictSentence(model, false);
    console.log(pred);
    console.log('\n--------stats----------------');

    // keep track of perplexity
    console.log('epoch: ' + (iterations / epoch_size).toFixed(2));
    console.log('perplexity: ' + cost_struct.ppl.toFixed(2));
    console.log('forw/bwd time per example: ' + tick_time.toFixed(1) + 'ms');
    console.log('iterations: ' + iterations);
    console.log('learning_rate: ' + learning_rate);

    saveModel();
  }

  iterations++;
}


var loadModel = function(j) {
  //learning_rate = 0.0001;

  hidden_sizes = j.hidden_sizes;
  generator = j.generator;
  letter_size = j.letter_size;
  model = {};
  for(var k in j.model) {
    if(j.model.hasOwnProperty(k)) {
      var matjson = j.model[k];
      model[k] = new R.Mat(1,1);
      model[k].fromJSON(matjson);
    }
  }
  letterToIndex = j['letterToIndex'];
  indexToLetter = j['indexToLetter'];
  vocab = j['vocab'];

  iterations = Number(j['iterations']) | 0;
  console.log(iterations);

  // reinit these
  ppl_list = [];
  tick_iter = 0;
  solver = new R.Solver(); // have to reinit the solver since model changed
}

if (fs.existsSync(modelFile)) {
  var data = fs.readFileSync(modelFile);
  loadModel(JSON.parse(data));
  console.log("Loaded model");
}

setInterval(tick, 1);

var saveModel = function() {
  var out = {};
  out['hidden_sizes'] = hidden_sizes;
  out['generator'] = generator;
  out['letter_size'] = letter_size;
  var model_out = {};
  for(var k in model) {
    if(model.hasOwnProperty(k)) {
      model_out[k] = model[k].toJSON();
    }
  }
  out['model'] = model_out;
  var solver_out = {};
  solver_out['decay_rate'] = solver.decay_rate;
  solver_out['smooth_eps'] = solver.smooth_eps;
  step_cache_out = {};
  for(var k in solver.step_cache) {
    if(solver.step_cache.hasOwnProperty(k)) {
      step_cache_out[k] = solver.step_cache[k].toJSON();
    }
  }
  solver_out['step_cache'] = step_cache_out;
  out['solver'] = solver_out;
  out['letterToIndex'] = letterToIndex;
  out['indexToLetter'] = indexToLetter;
  out['vocab'] = vocab;

  out['iterations'] = iterations;

  var json = JSON.stringify(out);
  fs.writeFile(modelFile, json, saved);
  function saved(err) {
    if (err) {
      console.log(err);
    }
    console.log('saved file');
  }
}
