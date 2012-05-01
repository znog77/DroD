//--------------- Generic utility functions -------------------
// Function to get the Max value in Array
Array.max = function( array ){
return Math.max.apply( Math, array );
};

// Function to get the Min value in Array
Array.min = function( array ){
return Math.min.apply( Math, array );
};

// -------------- Graphic specific functionns -----------------
// --- Board initializer
function plotInit(container){
  var brd = JXG.JSXGraph.initBoard(container, {boundingbox: [-2, 4, 6, -4], axis:true, grid:false, showCopyright:false});
  return brd;
}

// --- Create X axis
function xAxis(brd){
  // this.boubdingBox = [minX,maxY,maxX,minY];
  boundingBox = brd.getBoundingBox();
  this.axis = brd.create('axis', [[boundingBox[0],boundingBox[3]], [boundingBox[2],boundingBox[3]]],{drawLabels:true});
}

// --- Create Y axis
function yAxis(brd){
  // this.boubdingBox = [minX,maxY,maxX,minY];
  boundingBox = brd.getBoundingBox();
//  this.axis = brd.create('axis', [[boundingBox[0],boundingBox[3]], [boundingBox[0],boundingBox[1]]],{drawLabels:true});
  this.axis = brd.create('axis', [[boundingBox[0],0], [boundingBox[0],boundingBox[1]]],{drawLabels:true});
}

// --- Line plot
function plotLine(data){
	var color = ['blue','red','magenta', 'green', 'black','yellow'];
	var i, x=[], y=[];
	var d = JSON.parse(data);
  var curveCount=0;
  this.container = brd.objects;
  this.minX;
  this.minY;
  this.maxX;
  this.maxY;
  //this.boundingBox=[Math.min(), Math.max(),Math.max(), Math.min() ];

	for(i=0;i<d.length;i++){
		  x[i] = d[i].x;
		  y[i] = d[i].y;
		}
    //Sweep the board to find curves, if there is none, just set the limits to those of the curve
  for (var obj in container){
    var element = obj;
    if ( container[element].elementClass == 4 ){
      curveCount++;
    }
  }

  minX=Array.min(x)
  maxX=Array.max(x)
  minY=Array.min(y)
  maxY=Array.max(y)

  if (curveCount>0) {
    this.boundingBox = brd.getBoundingBox();
    if ( boundingBox [0] > minX ) boundingBox [0]=minX;
    if ( boundingBox [2] < maxX ) boundingBox [2]=maxX;
    if ( boundingBox [3] > minY ) boundingBox [3]=minY;
    if ( boundingBox [1] < maxY ) boundingBox [1]=maxY;
  } else {
    this.boundingBox = [minX,maxY,maxX,minY];
  }

	brd.setBoundingBox(this.boundingBox);
	this.c = brd.create('curve',[x,y],{strokeColor:color[curveCount%color.length]});
	brd.update();
}

// --- Scatter (points) plot
function plotXY(data){
	var color = ['blue','red','magenta', 'green', 'black','yellow'];
	var i, x=[], y=[], p=[];
	var d = JSON.parse(data);
  var curveCount=0;
  this.container = brd.objects;
  this.minX;
  this.minY;
  this.maxX;
  this.maxY;
  //this.boundingBox=[Math.min(), Math.max(),Math.max(), Math.min() ];

	for(i=0;i<d.length;i++){
		  x[i] = d[i].x;
		  y[i] = d[i].y;
      p[i] = brd.create('point',[x[i],y[i]],{name:''});
		}
    //Sweep the board to find curves, if there is none, just set the limits to those of the curve
  for (var obj in container){
    var element = obj;
    if ( container[element].elementClass == 4 ){
      curveCount++;
    }
  }

  minX=Array.min(x)
  maxX=Array.max(x)
  minY=Array.min(y)
  maxY=Array.max(y)

  if (curveCount>0) {
    this.boundingBox = brd.getBoundingBox();
    if ( boundingBox [0] > minX ) boundingBox [0]=minX;
    if ( boundingBox [2] < maxX ) boundingBox [2]=maxX;
    if ( boundingBox [3] > minY ) boundingBox [3]=minY;
    if ( boundingBox [1] < maxY ) boundingBox [1]=maxY;
  } else {
    this.boundingBox = [minX,maxY,maxX,minY];
  }

	brd.setBoundingBox(this.boundingBox);
//	this.c = brd.create('curve',[x,y],{strokeColor:color[curveCount%color.length]});
	brd.update();
}
