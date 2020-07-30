$(document).ready(function() {
  
	// $("#boatlog_begin_time").timeEntry({show24Hours: true, minTime: "06:00", maxTime: "20:00" });

	function alert24HourClock() {
    $("#boatlog_begin_time").on("focusout", function(){
      var $time = $(this).val();
      var b = ($time.split(":")[0]) + ($time.split(":")[1]);
      var $time2 = parseInt(b, 10);
      if ( $time2 <= "800" || $time2 >= "1800" ){
	      alert("Why are you diving in the dark?");
      } else {  }
    });
  };

  alert24HourClock();

  jQuery.validator.addMethod("timeformat", function(value, element) {
    return this.optional(element) || /^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$/.test(value);
  }, "Enter as HH:MM (24 hr clock)");

	$("#new_boatlog").validate( {
		debug:true,
  	onfocusout: function(element) {
        this.element(element);
    },

  	rules: {
			"boatlog[site_id]": { required: true },
			"boatlog[date_completed]": { required: true },
			"boatlog[begin_time]": { required: true, timeformat: true },
			"boatlog[manager_id]": { required: true }
  	},

  	messages: {
      "boatlog[site_id]": { required: "Required" },
      "boatlog[date_completed]": { required: "Required" },
      "boatlog[begin_time]": { required: "Required" },
      "boatlog[manager_id]": { required: "Required" }
    }
  });

  function validate_fields() {
      $('[name*="user_id"]').each(function(){
        $(this).rules('add', {
          required: true
        });
      });
      $('[name*="survey_type_id"]').each(function(){
        $(this).rules('add', {
          required: true
        });
      });
      $('[name*="rep"]').each(function(){
        $(this).rules('add', {
          required: true,
          number: true,
          min: 1,
          max: 12
        });
      });
    };

    validate_fields();
    $(document).delegate(".add_fields", "click", function(){ 
      validate_fields();
    });
});