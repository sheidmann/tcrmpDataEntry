$(document).ready(function() {

	// Prevent loading this script on every page
	if(!EA.onRailsPage('e_surveys', ['edit', 'new'])) {
    return;
  };

  // Stop enter from submitting form
  $(document).bind("keypress", function(e){
    if (e.keyCode ==13){
      e.preventDefault();
    };
  });

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
  // Implement dropdown with textbox for observer
  $(".metaSelect").select2();
  // Trigger validation on close (select2 does not trigger focusout)
  $(".metaSelect").on("close", function (e) {  
    $(this).valid(); 
  });

  // Format the datepicker
  $("#e_survey_date_completed").datepicker({
    format: 'yyyy-mm-dd',
    autoclose: true
    // We cannot prevent focusout event from firing when selecting a date.
    // The code below acts as a workaround. 
    // On focus, ignore the validation.
    // On hide, remove the ignored validation and validate.
  }).on("hide",function(){ 
      $(".new_e_survey, .edit_e_survey").data("validator").settings.ignore="";
      $(this).valid();
  }).on("focus",function(){
      $(".new_e_survey, .edit_e_survey").data("validator").settings.ignore="#e_survey_date_completed, :hidden";
  });

  // Fix calendar arrows disappearing
  $('.prev i').removeClass();
  $('.prev i').addClass("fa fa-chevron-left");

  $('.next i').removeClass();
  $('.next i').addClass("fa fa-chevron-right");

  // Create alert if time is too early or late
  function alert24HourClock() {
    $("#e_survey_begin_time").on("focusout", function(){
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
  jQuery.validator.addMethod("timeformat", function(value, element) {
    return this.optional(element) || /^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$/.test(value);
  }, "Enter as HH:MM (24 hr clock)");

  // Create validation rules
  $(".new_e_survey, .edit_e_survey").validate( {
    ignore: [], // enable hidden field validation for select2
    // Trigger validation on focusout
    onfocusout: function(element) {
        this.element(element);
    },

    // List the rules
    rules: {
      "e_survey[fid]": { required: true,
      number: true,
      isInteger: true,
      min: 1000,
      max: 2000 },
      "e_survey[user_id]": { required: true },
      "e_survey[team]": { required: true },
      "e_survey[role]": { required: true },
      "e_survey[date_completed]": { required: true },
      "e_survey[begin_time]": { required: true, timeformat: true }
    },

    // List the error messages
    messages: {
      "e_survey[fid]": { required: "Required",
        number: "Must be a number",
        isInteger: "Must be an integer",
        min: "Must be between 1000 and 2000",
        max: "Must be between 1000 and 2000" },
      "e_survey[user_id]": { required: "Required" },
      "e_survey[team]": { required: "Required" },
      "e_survey[role]": { required: "Required" },
      "e_survey[date_completed]": { required: "Required" },
      "e_survey[begin_time]": { required: "Required" }
    },

    // Set error positions
    errorPlacement: function (error, element) {
      // Select2 dropdowns will put error on new line
      if (element.hasClass("metaSelect, speciesSelect")){
        error.insertAfter($(element).parent().parent().parent('div'));
      } else {
        // default for rest is immediately after
        error.insertAfter($(element));
      }
    }
  });

  // Implement dropdown with textbox for species
  $(".speciesSelect").select2();
  // Validate on closing event (focusout not triggered)
  $(".speciesSelect").on("close", function (e) {  
    $(this).valid(); 
  });

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
  // Max depth must be greater than min depth
  $.validator.addMethod(
    "moreThanMin", function(value, element) {
      var item = $(element).closest('.row');
      var min = 0;
      item.find('.depthField').each(function(){
        var thisdepth = $(this).attr('id');
        var depthval = parseFloat($(this).val());
        if(thisdepth == "minDepth") {min += depthval};
      });
      if(value != "" && !isNaN(min)){
        // If max depth is greater than or equal to min depth, pass validation (return true)
        return min <= value;
      } else { return true } // default is to pass validation
    },
    "Max depth cannot be less than min depth"
  );


  // Add properties to nested fields when added
  $('#plots, #plotCorals').on('cocoon:after-insert', function() {
    $(".speciesSelect").last().select2(); // convert to select2
    $(".speciesSelect").on("close", function (e) {  
      $(this).valid(); // validate on close
    });
    $('.firstbox').last().focus(); // focus on first box of new coral or plot
  });

  // Add validations for all nested station fields
  function validate_fields() {
    //Plot fields
    $('.plotplot').each(function(){
      $(this).rules('add', {
        required: true,
        number: true,
        isInteger: true,
        min: 1,
        max: 2
      });
    });
    $('[name*="habitat"]').each(function(){
      $(this).rules('add', {
        required: true
      });
    });
    $('[name*="hardbottom"]').each(function(){
      $(this).rules('add', {
        //required: true,
        number: true,
        isInteger: true,
        min: 1,
        max: 100
      });
    });
    $('[name*="coral_cover"]').each(function(){
      $(this).rules('add', {
        //required: true,
        number: true,
        isInteger: true,
        min: 0,
        max: 100
      });
    });
    $('[name*="max_relief_cm"]').each(function(){
      $(this).rules('add', {
        //required: true,
        number: true,
        isInteger: true,
        min: 1,
        max: 500
      });
    });
    $('[name*="min_depth"]').each(function(){
      $(this).rules('add', {
        //required: true,
        number: true,
        isInteger: true,
        min: 0,
        max: 50
      });
    });
    $('[name*="max_depth"]').each(function(){
      $(this).rules('add', {
        //required: true,
        number: true,
        isInteger: true,
        moreThanMin: true,
        min: 0,
        max: 50
      });
    });

    // Coral fields
    $('[name*="quadrant"]').each(function(){
      $(this).rules('add', {
        required: true,
        number: true,
        isInteger: true,
        min:1,
        max:4
      });
    });
    $('[name*="coral_code_id"]').each(function(){
      $(this).rules('add', {
        required: true
      });
    });
    $('[name*="max_diam"]').each(function(){
      $(this).rules('add', {
        required: true,
        number: true,
        min: 1
      });
    });
    $('[name*="old_mortality"]').each(function(){
      $(this).rules('add', {
        number: true,
        min: 0,
        max: 99
      });
    });
    $('[name*="new_mortality"]').each(function(){
      $(this).rules('add', {
        number: true,
        min: 0,
        max: 99
      });
    });

    //ESA fields
    $('.esaField').each(function(){
      $(this).rules('add', {
        number: true,
        min: 0,
        max: 1
      });
    });
  };

  // Trigger validation for nested coral fields
  validate_fields();

  // Add validation behavior to added nested fields
  $(document).delegate(".add_fields", "click", function(){ 
    // Trigger validation
    validate_fields();
    alertDepth30();
    alertSpeciesSizes();
    alertMort100();
  });

  // Validate coral sizes using alerts
  speciesInformation = {}
  if ( typeof coral_info !== "undefined" ) {
    $.each(coral_info, function(a){
      speciesInformation[coral_info[a].id] = { "max_diam": coral_info[a].max_diam, "max_height": coral_info[a].max_height };
    });
  }

  function alertSpeciesSizes() {
    $('.diamField').on('change', function(){
      var $species = $(this).parent().find('.speciesSelect').select2('val');
      // Check maximum diameter
      var size = parseFloat($(this).val());
      var maxDiam = speciesInformation[$species].max_diam
      if(!isNaN(size) && maxDiam != null){
        if ( size > maxDiam ) {alert("Over max length")};
      }
    });
  };

  alertSpeciesSizes();

  // Sum of mortality fields cannot be >100
  function alertMort100() {
    $('.pcMortField').on('change', function(){
      var item = $(this).closest('.row');
      var percents = [];
      var sum_percent = 0
      console.log(sum_percent);
      item.find('.pcMortField').each(function(){
        var percent = parseInt($(this).val());
        console.log(percent);
        if(!isNaN(percent)){
          percents.push(percent);
        }
        sum_percent = percents.reduce(function(a, b) { return a + b; }, 0)
        console.log(sum_percent);
      });
      if ( sum_percent > 100) {
        alert("Mortality percents cannot sum to >100");
      }; 
    });
  };

  alertMort100();

  // Depth rarely deeper than 30
  function alertDepth30() {
    $('.depthField').on('focusout', function(){
      var depth = $(this).val();
      if ( depth > 30) {
        alert("Are you sure you went deeper than 30 ft?");
      }; 
    });
  };

  alertDepth30();
});