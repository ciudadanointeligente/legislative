$(document).ready(function(){
  // set up hover panels
  // although this can be done without JavaScript, we've attached these events
  // because it causes the hover to be triggered when the element is tapped on a touch device
  $('.hover').hover(function(){
    $(this).addClass('flip');
  },function(){
    $(this).removeClass('flip');
  });

  $('.tags-tooltip').tooltip({
    selector: "[data-toggle=tooltip]",
    container: "tags-tooltip"
  });



  var data = {
    labels : [
      "", "", "", "", "",
      "", "", "", "", "",
      "", "", "", "", "",
      "", "", "", "", "",
      "", "", "", "", "",
      "", "", "", "", "",
      "", "", "", "", "",
      "", "", "", "", "",
      "", "", "", "", "",
      "", "", "", "", "",
      "", ""
      ],
    datasets : [
      {
        fillColor : "rgba(220,220,220,0.5)",
        strokeColor : "rgba(220,220,220,1)",
        data : [2,0,0,0,1,
            0,1,0,0,0,
            0,1,2,0,0, 
            2,0,0,0,1,
            10,1,0,0,0,
            0,10,2,0,0,
            2,0,0,0,1,
            0,1,0,0,0,
            0,1,2,0,0, 
            2,0,0,0,1,
            5,1]
      }
      ]
  }

  var options = {
    scaleShowLabels : false,
    barStrokeWidth : 0,
    scaleShowGridLines : false,
    animation : false,
      scaleGridLineColor : "rgba(0,0,0,0)",
      pointDot : false
  }

  var ctx = document.getElementById("myChart").getContext("2d");
  var myNewChart = new Chart(ctx).Line(data, options);
});
 