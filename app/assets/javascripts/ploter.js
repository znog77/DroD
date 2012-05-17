function DownloadJSON2CSV(objArray)
  {
    var array = typeof objArray != 'object' ? JSON.parse(objArray) : objArray;
    var str = '';

    for (var i = 0; i < array.length; i++) {
        var line = '';
        for (var index in array[i]) {
            if(line != '') line += ','

            line += array[i][index];
        }

        str += line + '\r\n';
    }

    if (navigator.appName != 'Microsoft Internet Explorer')
    {
        window.open('data:text/csv;charset=utf-8,' + escape(str));
    }
    else
    {
        var popup = window.open('','csv','');
        popup.document.body.innerHTML = '<pre>' + str + '</pre>';
    }
}

$(function(){
  if (typeof data !='undefined'){
    brd = plotInit('bbox');
    g1 = plotLine(data);
    g2 = plotXY(data);
    xax = xAxis(brd);
    yax = yAxis(brd);
  }
 $('#download').click(function(){
   DownloadJSON2CSV(data);
                     });
});
