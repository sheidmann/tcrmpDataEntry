$(document).on('ready page:load', function() {
  
	$("#boatlog_begin_time").timeEntry({show24Hours: true, minTime: "08:00", maxTime: "19:00" });

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

  /*$("#new_boatlog").validate( {
  	onfocusout: function(element) {
        this.element(element);
      },

  	rules: {
			"boatlog[begin_time]": { required: true }
  	}
  });*/
});