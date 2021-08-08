// The solution here is to add an listener that triggers something when the page is loaded
// In this case, it will call the bezier applet function
// window.addEventListener("load", bezierApp, false);

//window.addEventListener("load", bezierApp, false);

function bezierApp()
{
	var mode = 1;
	canvas = document.getElementById("beziercanvas");
	var context = canvas.getContext("2d");
	var width = canvas.width;
	var height = canvas.height;
	var ctrlPointRadius = 5;
	var dragging; 	// I am dragging a point right now? (bool)

	var shapes;		// array of shapes (control points)
	var numShapes;	// total number of points being drawn on the canvas
	var dragIndex;	// the index of the object that is being dragged
	
	var dragHoldX;
	var dragHoldY;
	
	var numSegments = 50;

	init();

	function init()
	{
		shapes = [];
		numShapes = (mode == 0) ? 4 : 7;
		makeShapes();
		drawShapes();
		//alert("yes I am being initialized " + width + " " + height);
		canvas.addEventListener("mousedown", mouseDownListener, false);
		window.addEventListener("keypress", keyDownListener, false )
	}
	
	function keyDownListener(evt)
	{	
		//alert(evt.keyCode);
		if (evt.keyCode == 114) { // r key
			makeShapes();
			drawShapes();
		}
		else if (evt.keyCode == 109) { // mode
			mode = (mode == 0) ? 1 : 0;
			if (mode == 1) {
				numShapes = 7;
			}
			else {
				numShapes = 4;
			}
			drawShapes();
		}
		else if (evt.keyCode == 112) { // p
			for (i = 0; i < numShapes; ++i) {
				console.log(shapes[i].x + ", " + shapes[i].y);
			}
		}
	}
	
	function mouseDownListener(evt)
	{
		// evt is returning the position of the mouse with respect to the top/left corner
		// of the browser. So it's important we compute the position with respect
		// to the canvas rectangle
		var boundCanvas = canvas.getBoundingClientRect();
		mouseX = evt.clientX - boundCanvas.left;
		mouseY = evt.clientY - boundCanvas.top;
		for (i=0; i < numShapes; i++) {
			if	(hitTest(shapes[i], mouseX, mouseY)) {
				dragging = true;
				dragIndex = i;
				// keep track of the differencer there is between the mouse cursor position
				// and the actual position of the control points
				dragHoldX = mouseX - shapes[dragIndex].x;
				dragHoldY = mouseY - shapes[dragIndex].y;
				//alert("oh you clicked on a point!");
			}
		}
		
		// if we drag then we need to track the mouse motion
		if (dragging) {
			window.addEventListener("mousemove", mouseMoveListener, false);
		}
		
		// The next thing we need to do is to listen for a mouse up event (the user
		// releases the mouse, we need to stop the dragging at this point, but 
		// also remove the current event listening (mousedown) and re-activate
		// the listener for the mousedown. Note too sure about the whole process
		// but can always experiment with this later on
		canvas.removeEventListener("mousedown", mouseDownListener, false);
		window.addEventListener("mouseup", mouseUpListener, false);
	}
	
	function mouseUpListener(evt)
	{
		// not sure why we add it now if we removed it just before?
		canvas.addEventListener("mousedown", mouseDownListener, false);
		// remove myself, no need to listen to mouse up events
		window.removeEventListener("mouseup", mouseUpListener, false);
		// if we used to be dragging a point then we can stop this as well
		if (dragging) {
			dragging = false;
			// no need to listen to mouse move events either
			window.removeEventListener("mousemove", mouseMoveListener, false);
		}
	}
	
	function mouseMoveListener(evt)
	{
		// we need to avoid moving the points behind the bounds of the canvas - the point radius
		var minX = ctrlPointRadius;
		var minY = ctrlPointRadius;
		var maxX = canvas.width - ctrlPointRadius;
		var maxY = canvas.height - ctrlPointRadius;
		var boundCanvas = canvas.getBoundingClientRect();
		// where is the mouse now?
		var mouseX = evt.clientX - boundCanvas.left;
		var mouseY = evt.clientY - boundCanvas.top;
		
		var x = mouseX - dragHoldX;
		var y = mouseY - dragHoldY;
		x = (x < minX) ? minX : ((x > maxX) ? maxX : x);
		y = (y < minY) ? minY : ((y > maxY) ? maxY : y);
		
		// update the position of the shape
		shapes[dragIndex].x = x;
		shapes[dragIndex].y = y;
		
		// if we change something we need to update the drawing
		drawShapes();
	}
	
	// Is the mouse close to the control points enough?
	function hitTest(shape,mx,my)
	{
		var dx;
		var dy;
		dx = mx - shape.x;
		dy = my - shape.y;
		
		//a "hit" will be registered if the distance away from the center is less than the radius of the circular object		
		return (dx * dx + dy * dy < ctrlPointRadius * ctrlPointRadius);
	}

	function makeShapes()
	{
		if (shapes.length == 0) {	
			var defaultPos = [89, 432, 546, 432, 546, 241, 335, 241, 175.68, 241, 176, 113, 544, 110];
			for (i = 0; i < 7; ++i) { // init with max number of points
				shape = {x:defaultPos[2 * i], y:defaultPos[2 * i + 1]};
				shapes.push(shape);
			}
			return;
		}

		var minX = ctrlPointRadius;
		var minY = ctrlPointRadius;
		var maxX = canvas.width - ctrlPointRadius;
		var maxY = canvas.height - ctrlPointRadius;
		var boundCanvas = canvas.getBoundingClientRect();
		
		for (i = 0; i < numShapes; ++i) {
			var _x = Math.random() * width;
			var _y = Math.random() * height;
			_x = (_x < minX) ? minX : ((_x > maxX) ? maxX : _x);
			_y = (_y < minY) ? minY : ((_y > maxY) ? maxY : _y);
		
			shapes[i] = {x:_x, y:_y};
		}
		
		// put the middle point in the center of the screen and align tangent point around that pt
		if (mode == 1) {
			var mx = width / 2;
			var my = height / 2;
			shapes[3] = {x:mx, y:my};
			var vx = (1 - Math.random());
			var vy = (1 - Math.random());
			var length = Math.sqrt(vx * vx + vy * vy);
			vx /= length;
			vy /= length;
			mx = mx + vx * 50;
			my = my + vy * 50;
			shapes[2] = {x:mx, y:my};
			mx = 2 * shapes[3].x - shapes[2].x;
			my = 2 * shapes[3].y - shapes[2].y;
			shapes[4] = {x:mx, y:my};
		}
	}
	
	function drawShapes()
	{
		//bg
		context.fillStyle = "#000000";
		context.fillRect(0, 0, canvas.width, canvas.height);

		context.save();
		context.fillStyle = 'rgb(50, 50, 255)';
		context.strokeStyle = 'rgb(50, 50, 255)';
		context.lineWidth = 2;
		for (i = 0; i < numShapes - 1; ++i) {
			if (mode == 1 && (i == 1 || i == 4))
				context.setLineDash([5,2]);
			else
				context.setLineDash([1,0]);
			context.beginPath();
			context.moveTo(shapes[i].x, shapes[i].y);
			context.lineTo(shapes[i + 1].x, shapes[i + 1].y);
			context.stroke();
		}
		context.restore();
		
		context.fillStyle = 'rgb(255, 50, 50)';
		context.strokeStyle = 'rgb(255, 50, 50)';
		context.lineWidth = 2;
		var nloops = (numShapes == 4) ? 1 : 2;
		for (j = 0; j < nloops; ++j) { // draw each curve seperatly
			var off = (j == 0) ? 0 : j * 4 - 1;
			var PtX = shapes[off].x;
			var PtY = shapes[off].y;
			for (i = 1; i <= numSegments; ++i) { 
				var t = i / numSegments; 
				// compute coefficients
				var k1 = (1 - t) * (1 - t) * (1 - t); 
				var k2 = 3 * (1 - t) * (1 - t) * t; 
				var k3 = 3 * (1 - t) * t * t; 
				var k4 = t * t * t; 
				context.beginPath();
				context.moveTo(PtX, PtY);
				// weight the four control points using coefficients
				PtX = shapes[off].x * k1 + shapes[off + 1].x * k2 + shapes[off + 2].x * k3 + shapes[off + 3].x * k4;
				PtY = shapes[off].y * k1 + shapes[off + 1].y * k2 + shapes[off + 2].y * k3 + shapes[off + 3].y * k4; 
				context.lineTo(PtX, PtY);
				context.stroke();
			}
		}
		
		
		context.fillStyle = 'rgb(50, 50, 255)';
		context.strokeStyle = 'rgb(50, 50, 255)';
		for (i = 0; i < numShapes; i++) {
			//context.fillStyle = 'rgb(50, 150, 100)';
			//alert("draw " + i " shape ");
			context.beginPath();
			context.arc(shapes[i].x, shapes[i].y, ctrlPointRadius, 0, 2 * Math.PI, false);
			context.closePath();
			context.fill();
		}
		
		context.fillStyle = 'rgb(255, 255, 255)';
		context.font = "12px Courier";
		context.fillText("Interactive Applet: drag the control points around", 8, 18);
		context.fillText("r: randomize points position", 8, 34);
		if (mode == 1)
			context.fillText("m: display 1 bezier curve (4 control points)", 8, 50);
		else
			context.fillText("m: display 2 bezier curves (7 control points)", 8, 50);
		for (i = 0; i < numShapes; ++i) {
			var x = shapes[i].x;
			var y = shapes[i].y;
			if (y < height - 20) y += 18;
			else y -= 10;
			context.fillText("P" + i, x - 6, y);
		}
		context.font = "12px Arial";
		context.fillText("(c) www.scratchapixel.com", 8, height - 8);
	}
}