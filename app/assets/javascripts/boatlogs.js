$(document).ready(function() {

	// Prevent loading this script on every page
	if(!EA.onRailsPage('boatlogs', ['edit', 'new'])) {
    return;
  };

  // Trigger select2 opening on focus
  // on first focus (bubbles up to document), open the menu
  $(document).on('focus', '.select2-selection.select2-selection--single', function (e) {
    $(this).closest(".select2-container").siblings('select:enabled').select2('open');
  });
  // steal focus during close - only capture once and stop propogation
  $('select.select2').on('select2:closing', function (e) {
    $(e.target).data("select2").$selection.one('focus focusin', function (e) {
      e.stopPropagation();
    });
  });

  // Implement dropdown with textbox for site
  $("#boatlog_site_id").select2();
  // Trigger validation on close (select2 does not trigger focusout)
  $("#boatlog_site_id").on("close", function (e) {  
    $(this).valid(); 
  });

	// // Create alert if time is too early or late
	// function alert24HourClock() {
 //    $("#boatlog_begin_time").on("focusout", function(){
 //      var $time = $(this).val();
 //      var b = ($time.split(":")[0]) + ($time.split(":")[1]);
 //      var $time2 = parseInt(b, 10);
 //      if ( $time2 <= "800" || $time2 >= "1800" ){
	//       alert("Why are you diving in the dark?");
 //      } else {  }
 //    });
 //  };
 //  // Trigger the alert
 //  alert24HourClock();

 //  // Add validation method to check format of time
 //  jQuery.validator.addMethod("timeformat", function(value, element) {
 //    return this.optional(element) || /^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$/.test(value);
 //  }, "Enter as HH:MM (24 hr clock)");

	// Create validation rules
	$(".new_boatlog, .edit_boatlog").validate( {
		ignore: [], // enable hidden field validation for select2
		// Trigger validation on focusout
  	onfocusout: function(element) {
        this.element(element);
    },

  	// List the rules
  	rules: {
			"boatlog[site_id]": { required: true },
			"boatlog[date_completed]": { required: true },
			//"boatlog[begin_time]": { required: true, timeformat: true },
			"boatlog[manager_id]": { required: true }
  	},

  	// List the error messages
  	messages: {
      "boatlog[site_id]": { required: "Required" },
      "boatlog[date_completed]": { required: "Required" },
      //"boatlog[begin_time]": { required: "Required" },
      "boatlog[manager_id]": { required: "Required" }
    }
  });

  // Format the datepicker
  $("#boatlog_date_completed").datepicker({
    format: 'yyyy-mm-dd',
    autoclose: true
    // We cannot prevent focusout event from firing when selecting a date.
    // The code below acts as a workaround. 
	  // On focus, ignore the validation.
	  // On hide, remove the ignored validation and validate.
  }).on("hide",function(){ 
      $(".new_boatlog, .edit_boatlog").data("validator").settings.ignore="";
      $(this).valid();
  }).on("focus",function(){
      $(".new_boatlog, .edit_boatlog").data("validator").settings.ignore="#boatlog_date_completed, :hidden";
  });

  // Fix calendar arrows disappearing
  $('.prev i').removeClass();
  $('.prev i').addClass("fa fa-chevron-left");

  $('.next i').removeClass();
  $('.next i').addClass("fa fa-chevron-right");

  // Survey must be unique (site, survey_type, replicate)
  surveyInformation = {}
  if ( typeof survey_info !== "undefined" ) {
    $.each(survey_info, function(a){
      // Need to extract the site from the boatlog
      var bl_id = survey_info[a].boatlog_id;
      var boatlog = boatlog_info.filter(function(e) {
        return e.id == bl_id;
      });
      var site = boatlog[0].site_id;
      // Add info to array
      surveyInformation[survey_info[a].id] = { "site": site, "type": survey_info[a].survey_type_id, "replicate": survey_info[a].rep };
    });
  };
  $.validator.addMethod(
    "uniqueReplicate", function(value, element) {
      // Check against form
      // type and replicate only

      // Check against database unless editing
      if(EA.onRailsPage('boatlogs', ['edit'])) {
        return true;
      };
      var site = $('#boatlog_site_id').val();
      var this_type = $(element).closest('li').find('.typeSelect').val();
      var filtered = Object.values(surveyInformation).filter(function(e) {
        return e.site === parseInt(site) && e.type === parseInt(this_type) && e.replicate === parseInt(value);
      });
      if ( filtered.length > 0) {
        return false; // FAIL validation if site/survey_type/replicate exists in database
      };
      
      return true; // PASS otherwise
    },
    "Duplicate survey"
  );

  // Implement dropdown with textbox for observer
  $(".observerSelect").select2();
  // Validate on closing event (focusout not triggered)
  $(".observerSelect").on("close", function (e) {  
    $(this).valid(); 
  });
  // Create dropdown for each nested field added
  $('#boatlog_surveys').on('cocoon:after-insert', function() {
    $(".observerSelect").last().select2(); // convert to select2
    $('.observerSelect').last().select2('open'); // focus and open dropdown
    $(".observerSelect").on("close", function (e) {  
      $(this).valid(); // validate on close
    });
  });

  // Hitting enter while in fish section adds new species
  $("#boatlog_surveys").bind("keypress", function(e){
    if (e.keyCode ==13){
      e.preventDefault();
      $(".addDiver").trigger("click");
    };
  });

	// Add validations for nested station fields
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
        uniqueReplicate: true,
        min: 1,
        max: 12
      });
    });
  };

  // Trigger validation for nested station fields
  validate_fields();
  // Trigger validation for added nested station fields
  $(document).delegate(".add_fields", "click", function(){ 
    validate_fields();
  });
});