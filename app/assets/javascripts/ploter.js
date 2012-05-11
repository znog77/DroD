$(function(){
  if (typeof data !='undefined'){
    brd = plotInit('bbox');
    g1 = plotLine(data);
    xax = xAxis(brd);
    yax = yAxis(brd);
  }
});

