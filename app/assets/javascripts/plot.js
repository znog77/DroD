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

  if (curveCount>0) {
    bb = brd.getBoundingBox();
    if ( bb[0] > x.min() ) bb[0]=x.min();
    if ( bb[2] < x.max() ) bb[2]=x.max();
    if ( bb[3] > y.min() ) bb[3]=y.min();
    if ( bb[1] < y.max() ) bb[1]=y.max();
  } else {
    bb = [x.min(),y.max(),x.max(),y.min()]
  }

	brd.setBoundingBox(bb);
	var c = brd.create('curve',[x,y],{strokeColor:color[curveCount%color.length]});
	brd.update();
}
