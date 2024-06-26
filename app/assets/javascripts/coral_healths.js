$(document).ready(function() {

	// Prevent loading this script on every page
	if(!EA.onRailsPage('coral_healths', ['edit', 'new'])) {
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
  // Implement dropdown with textbox for site and observer
  $(".metaSelect").select2();
  //$("#fish_transect_user_id").select2();
  // Trigger validation on close (select2 does not trigger focusout)
  $(".metaSelect").on("close", function (e) {  
    $(this).valid(); 
  });

  // Format the datepicker
  $("#coral_health_date_completed").datepicker({
    format: 'yyyy-mm-dd',
    autoclose: true
    // We cannot prevent focusout event from firing when selecting a date.
    // The code below acts as a workaround. 
    // On focus, ignore the validation.
    // On hide, remove the ignored validation and validate.
  }).on("hide",function(){ 
      $(".new_coral_health, .edit_coral_health").data("validator").settings.ignore="";
      $(this).valid();
  }).on("focus",function(){
      $(".new_coral_health, .edit_coral_health").data("validator").settings.ignore="#coral_health_date_completed, :hidden";
  });

  // Fix calendar arrows disappearing
  $('.prev i').removeClass();
  $('.prev i').addClass("fa fa-chevron-left");

  $('.next i').removeClass();
  $('.next i').addClass("fa fa-chevron-right");

	// Create validation rules
	$(".new_coral_health, .edit_coral_health").validate( {
		ignore: [], // enable hidden field validation for select2
		// Trigger validation on focusout
  	onfocusout: function(element) {
        this.element(element);
    },

  	// List the rules
  	rules: {
			"coral_health[manager_id]": { required: true },
      "coral_health[site_id]": { required: true },
      "coral_health[user_id]": { required: true },
			"coral_health[date_completed]": { required: true },
      "coral_health[rep]": { required: true,
        number: true,
        min: 1,
        max: 6 },
      "coral_health[method]": { required: true }
  	},

  	// List the error messages
  	messages: {
      "coral_health[manager_id]": { required: "Required" },
      "coral_health[site_id]": { required: "Required" },
      "coral_health[user_id]": { required: "Required" },
      "coral_health[date_completed]": { required: "Required" },
      "coral_health[rep]": { required: "Required",
        number: "Must be a number",
        min: "Must be between 1 and 6",
        max: "Must be between 1 and 6" },
      "coral_health[method]": { required: "Required" },
    },

    // Set error positions
    errorPlacement: function (error, element) {
      // Select2 dropdowns will put error on new line
      if (element.hasClass("speciesSelect")){
        error.insertAfter($(element).parent().parent().parent('div'));
      } else {
        // default for rest is immediately after
        error.insertAfter($(element));
      }
    }
  });

  // Second Section (Coral)
  // Hitting enter while in coral section adds new coral
  // $("#corals:not(#interactions)").bind("keypress", function(e){
  //   if (e.keyCode ==13){
  //     e.preventDefault();
  //     $(".addCoral").trigger("click");
  //   };
  //   $('.speciesSelect').last().focus();
  // });
  // Hitting enter while in interaction section adds new interaction
  // $("#interactions").bind("keypress", function(e){
  //   if (e.keyCode ==13){
  //     e.preventDefault();
  //     $(this).closest(".addInteraction").trigger("click");
  //   };
  //   $('.speciesSelect').last().focus();
  // });

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
  // Width cannot be larger than length
  $.validator.addMethod(
    "lessThanLength", function(value, element) {
      var item = $(element).closest('li');
      var length = 0;
      item.find('.dimField').each(function(){
        var thisdim = $(this).attr('id');
        var dimval = parseFloat($(this).val());
        if(thisdim == "lengthField") {length += dimval};
      });
      // If length is greater than or equal to width, pass validation (return true)
      return length >= value;
    },
    "Width cannot be greater than length"
  );
  

  
  // Add properties to nested fields when added
  $('#corals, #interactions').on('cocoon:after-insert', function() {
    $(".speciesSelect").last().select2(); // convert to select2
    $('.speciesSelect').last().select2('open'); // focus and open dropdown
    $(".speciesSelect").on("close", function (e) {  
      $(this).valid(); // validate on close
    });
  });
  
  // Add validations for all nested station fields
  function validate_fields() {
    $('[name*="length_cm"]').each(function(){
      $(this).rules('add', {
        required: true,
        number: true,
        min: 0
      });
    });
    $('[name*="width_cm"]').each(function(){
      $(this).rules('add', {
        required: true,
        number: true,
        min: 0,
        lessThanLength: true
      });
    });
    $('[name*="height_cm"]').each(function(){
      $(this).rules('add', {
        required: true,
        number: true,
        min: 0
      });
    });
    $('[name*="bl_sp"]').each(function(){
      $(this).rules('add', {
        number: true,
        min: 0,
        max: 100
      });
    });
    $('[name*="bl_p"]').each(function(){
      $(this).rules('add', {
        number: true,
        min: 0,
        max: 100
      });
    });
    $('[name*="bl_vp"]').each(function(){
      $(this).rules('add', {
        number: true,
        min: 0,
        max: 100
      });
    });
    $('[name*="bl_bl"]').each(function(){
      $(this).rules('add', {
        number: true,
        min: 0,
        max: 100
      });
    });
    $('[name*="old_mortality"]').each(function(){
      $(this).rules('add', {
        number: true,
        min: 0,
        max: 100
      });
    });
    $('[name*="new_mortality"]').each(function(){
      $(this).rules('add', {
        number: true,
        min: 0,
        max: 100
      });
    });
    // $('[name*="disease"]').each(function(){
    //   $(this).rules('add', {
    //     number: true,
    //     min: 0,
    //     max: 100
    //   });
    // });
    $('[name*="coral_code_id"]').each(function(){
      $(this).rules('add', {
        required: true
      });
    });
    $('[name*="value"]').each(function(){
      $(this).rules('add', {
        required: true,
        isInteger: true,
        min: 0,
        max: 100
      });
    });
  };

  // Trigger validation for nested coral fields
  validate_fields();

  // Add validation behavior to added nested fields
  $(document).delegate(".add_fields", "click", function(){ 
    // Trigger validation
    validate_fields();
    alertSpeciesSizes();
    alertHealth100();
  });

  // Validate coral sizes using alerts
  speciesInformation = {}
  if ( typeof coral_info !== "undefined" ) {
    $.each(coral_info, function(a){
      speciesInformation[coral_info[a].id] = { "max_diam": coral_info[a].max_diam, "max_height": coral_info[a].max_height };
    });
  }

  function alertSpeciesSizes() {
    $('.dimField').on('change', function(){
      var $species = $(this).parent().find('.speciesSelect').select2('val');
      // Check maximum diameter and height
      var dimtype = $(this).attr('id');
      var size = parseFloat($(this).val());
      var maxDiam = speciesInformation[$species].max_diam
      var maxHeight = speciesInformation[$species].max_height
      if(!isNaN(size) && maxDiam != null){
        if ( dimtype == "lengthField" && size > maxDiam ) {alert("Over max length")};
      }
      if(!isNaN(size) && maxHeight != null){
        if ( dimtype == "heightField" && size > maxHeight ) {alert("Over max height")};
      }
    });
  };

  alertSpeciesSizes();

  // Sum of bleaching and disease fields cannot be >100
  function alertHealth100() {
    // This does not include mortality for now.
    $('.healthField').on('change', function(){
      var item = $(this).closest('li');
      var percents = [];
      var sum_percent = 0
      item.find('.healthField').each(function(){
        var percent = parseInt($(this).val());
        if(!isNaN(percent)){
          percents.push(percent);
        }
        sum_percent = percents.reduce(function(a, b) { return a + b; }, 0)
      });
      if ( sum_percent > 100) {
        alert("Health percents cannot sum to >100");
      }; 
    });
    /*// Width cannot be larger than length
    // We actually want this to be a hard rather than soft alert
    $('.dimField').on('change', function(){
      var item = $(this).closest('li');
      var length = 0;
      var width = 0;
      item.find('.dimField').each(function(){
        var thisdim = $(this).attr('id');
        //console.log(thisdim);
        var dimval = parseInt($(this).val());
        //console.log(dimval);
        if(thisdim == "lengthField") {length += dimval};
        if(thisdim == "widthField") {width += dimval};
      });
      if ( length < width ) {
        alert("Width cannot be greater than length");
      }; 
    });*/
  };

  alertHealth100();
});