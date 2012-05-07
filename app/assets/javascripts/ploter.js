$(function(){
  if (data){
    brd = plotInit('bbox');
    g1 = plotLine(data);
    xax = xAxis(brd);
    yax = yAxis(brd);
  }
});

