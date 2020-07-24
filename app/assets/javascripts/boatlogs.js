$(document).on('ready page:load', function() {
  
  function alert24HourClock() {
    $(".boatlog_time").on("focusout", function(){
      var $time = $(this).val();
      var b = ($time.split(":")[0]) + ($time.split(":")[1]);
      var $time2 = parseInt(b, 10);
      if ( $time2 >= "800" && $time2 <= "1900" ){
      
      } else { alert("Why are you diving in the dark?"); }
    });
  };

  alert24HourClock();
});