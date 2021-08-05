

function setup() {
  noCanvas();

  let editors = selectAll('.editor');

  for (let i = 0; i < editors.length; i++) {
    let editor = ace.edit("editor"+(i+1));
    editor.setTheme("ace/theme/monokai");
    editor.getSession().setMode("ace/mode/javascript");
    editor.setOptions({
        maxLines: 20
    });
    //editors[i].style('height', )
    let button = select('#run'+(i+1));
    //button.mousePressed(evaluateIt.bind(editor));
    button.mousePressed(evaluateIt(editor));
  }

  function evaluateIt(editor) {
    return function() {
      let code = editor.getValue();

      // This is a terrible idea for a lot of reasons!
      // But we don't really care here so I'm doing it anyway
      // More: http://stackoverflow.com/questions/86513/why-is-using-the-javascript-eval-function-a-bad-idea
      // http://blog.namangoel.com/replacing-eval-with-a-web-worker
      // eval(code);

      // This is slightly better b/c it doesn't pollute scope
      // but still a security problem
      let func = new Function(code);
      func();
    };
  }


}
