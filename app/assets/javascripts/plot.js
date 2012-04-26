// Function to get the Max value in Array
Array.max = function( array ){
return Math.max.apply( Math, array );
};

// Function to get the Min value in Array
Array.min = function( array ){
return Math.min.apply( Math, array );
};


function plotInit(container){
  var brd = JXG.JSXGraph.initBoard(container, {boundingbox: [-2, 4, 6, -4], axis:true, grid:false, showCopyright:false});
  return brd;
}

function plotLine(data){
	var color = ['blue','red','magenta', 'green', 'black','yellow'];
	var i, x=[], y=[];
	var d = JSON.parse(data);
  var minX, minY, maxX, maxY;
  var curveCount=0;
  var b = brd.objects;

	for(i=0;i<d.length;i++){
		  x[i] = d[i].x;
		  y[i] = d[i].y;
		}
    //Sweep the board to find curves, if there is none, just set the limits to those of the curve
  for (var obj in b){
    var element = obj;
    if ( b[element].elementClass == 4 ){
      curveCount++;
    }
  }

  minX=Array.min(x)
  maxX=Array.max(x)
  minY=Array.min(y)
  maxY=Array.max(y)

  if (curveCount>0) {
    bb = brd.getBoundingBox();
    if ( bb[0] > minX ) bb[0]=minX;
    if ( bb[2] < maxX ) bb[2]=maxX;
    if ( bb[3] > minY ) bb[3]=minY;
    if ( bb[1] < maxY ) bb[1]=maxY;
  } else {
    bb = [minX,maxY,maxX,minY];
  }

	brd.setBoundingBox(bb);
	var c = brd.create('curve',[x,y],{strokeColor:color[curveCount%color.length]});
	brd.update();
}
