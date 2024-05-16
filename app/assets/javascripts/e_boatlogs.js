$(document).ready(function() {

	// Prevent loading this script on every page
	if(!EA.onRailsPage('e_boatlogs', ['edit', 'new'])) {
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

  // First Section (Metadata)
  // Format the datepicker
  $("#e_boatlog_date_completed").datepicker({
    format: 'yyyy-mm-dd',
    autoclose: true
    // We cannot prevent focusout event from firing when selecting a date.
    // The code below acts as a workaround. 
	  // On focus, ignore the validation.
	  // On hide, remove the ignored validation and validate.
  }).on("hide",function(){ 
      $(".new_e_boatlog, .edit_e_boatlog").data("validator").settings.ignore="";
      $(this).valid();
  }).on("focus",function(){
      $(".new_e_boatlog, .edit_e_boatlog").data("validator").settings.ignore="#e_boatlog_date_completed, :hidden";
  });

  // Fix calendar arrows disappearing
  $('.prev i').removeClass();
  $('.prev i').addClass("fa fa-chevron-left");

  $('.next i').removeClass();
  $('.next i').addClass("fa fa-chevron-right");

  // Create alert if time is too early or late
  function alert24HourClock() {
    $("#e_boatlog_time_in, #e_boatlog_time_out").on("focusout", function(){
      var $time = $(this).val();
      var b = ($time.split(":")[0]) + ($time.split(":")[1]);
      var $time2 = parseInt(b, 10);
      if ( $time2 <= "800" || $time2 >= "1800" ){
        alert("Why are you diving in the dark?");
      } else {  }
    });
  };
  // Trigger the alert
  alert24HourClock();

  // Add validation method to check format of time
  jQuery.validator.addMethod(
    "timeformat", function(value, element) {
      return this.optional(element) || /^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$/.test(value);
    }, 
    "Enter as HH:MM (24 hr clock)"
  );
  // Out time cannot be before in time
  $.validator.addMethod(
    "laterThanIn", function(value, element) {
      var item = $(element).closest('.row');
      var inTime = 0;
      var outTime = 0;
      item.find('.timeField').each(function(){
        var thistime = $(this).attr('id');
        var $time = $(this).val();
        var b = ($time.split(":")[0]) + ($time.split(":")[1]);
        var $time2 = parseInt(b, 10);
        if(thistime == "timeIn") {inTime += $time2};
        if(thistime == "timeOut") {outTime += $time2};
      });
      // If time in is less than time out, pass validation (return true)
      return inTime < outTime;
    },
    "Time out cannot be before time in"
  );
  // Some numbers must be integers (no decimals)
  $.validator.addMethod(
    "isInteger", function(value, element) {
      if(value.toString()==""){
        return true; // PASS validation if empty box
      }
      return /^[1-9][0-9]*$/.test(value.toString()) // otherwise check if integer with regex
    },
    "Must be an integer"
  );

  // Create validation rules
  $(".new_e_boatlog, .edit_e_boatlog").validate( {
    ignore: [], // enable hidden field validation for select2
    // Trigger validation on focusout
    onfocusout: function(element) {
        this.element(element);
    },

    // List the rules
    rules: {
      "e_boatlog[fid]": { required: true,
      number: true,
      isInteger: true,
      min: 1000,
      max: 2000 },
      "e_boatlog[date_completed]": { required: true },
      "e_boatlog[captain]": { required: true },
      "e_boatlog[dod]": { required: true,
      number: true,
      isInteger: true,
      min: 1,
      max: 14 },
      "e_boatlog[latitude]": { required: true,
      number: true },
      "e_boatlog[longitude]": { required: true,
      number: true },
      "e_boatlog[time_in]": { required: true, timeformat: true },
      "e_boatlog[time_out]": { required: true, timeformat: true, laterThanIn: true },
      "e_boatlog[depth_ft]": { required: true, 
      isInteger: true,
      min:1,
      max:50 }
    },

    // List the error messages
    messages: {
      "e_boatlog[fid]": { required: "Required",
        number: "Must be a number",
        isInteger: "Must be an integer",
        min: "Must be between 1000 and 2000",
        max: "Must be between 1000 and 2000" },
      "e_boatlog[date_completed]": { required: "Required" },
      "e_boatlog[captain]": { required: "Required" },
      "e_boatlog[dod]": { required: "Required",
        number: "Must be a number",
        isInteger: "Must be an integer",
        min: "Must be between 1 and 14",
        max: "Must be between 1 and 14" },
      "e_boatlog[latitude]": { required: "Required",
        number: "Must be a number" },
      "e_boatlog[longitude]": { required: "Required",
        number: "Must be a number" },
      "e_boatlog[time_in]": { required: "Required" },
      "e_boatlog[time_out]": { required: "Required" },
      "e_boatlog[depth_ft]": { required: "Required",
        number: "Must be a number",
        isInteger: "Must be an integer",
        min: "Must be between 1 and 50",
        max: "Must be between 1 and 50" }
    },

    // Set error positions
    errorPlacement: function (error, element) {
      // Select2 dropdowns will put error on new line
      if (element.hasClass("observerSelect")){
        error.insertAfter($(element).parent().parent().parent('div'));
      } else {
        // default for rest is immediately after
        error.insertAfter($(element));
      }
    }
  });


  // Second section (Diver Data)
  // Implement dropdown with textbox for observer
  $(".observerSelect").select2();
  // Validate on closing event (focusout not triggered)
  $(".observerSelect").on("close", function (e) {  
    $(this).valid(); 
  });
  // Create dropdown for each nested field added
  $('#boatlog_teams').on('cocoon:after-insert', function() {
    $(".observerSelect").last().select2(); // convert to select2
    $(".observerSelect").on("close", function (e) {  
      $(this).valid(); // validate on close
    });
    $('.teamteam').last().focus(); // focus on first box of new diver
  });

  // Hitting enter while in diver section adds new diver
  $("#boatlog_teams").bind("keypress", function(e){
    if (e.keyCode ==13){
      e.preventDefault();
      $(".addDiver").trigger("click");
    };
  });

  // Add validations for nested diver fields
  function validate_fields() {
    $('.teamteam').each(function(){
      $(this).rules('add', {
        required: true,
        number: true,
        isInteger: true,
        min: 1,
        max: 2
      });
    });
    $('[name*="user_id"]').each(function(){
      $(this).rules('add', {
        required: true
      });
    });
    $('[name*="role"]').each(function(){
      $(this).rules('add', {
        required: true
      });
    });
  };

  // Trigger validation for nested coral fields
  validate_fields();

  // Add validation behavior to added nested fields
  $(document).delegate(".add_fields", "click", function(){ 
    // Trigger validation
    validate_fields();
  });

  // Depth rarely deeper than 30
  function alertDepth33() {
    $('.depthField').on('focusout', function(){
      var depth = $(this).val();
      if ( depth > 33) {
        alert("Are you sure you went deeper than 33 ft?");
      }; 
    });
  };

  alertDepth33();
});