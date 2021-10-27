$(document).ready(function() {

	// Prevent loading this script on every page
	if(!EA.onRailsPage('fish_transects', ['edit', 'new'])) {
    return;
  };

  // First Section (Metadata)
  // Implement dropdown with textbox for site and observer
  $(".metaSelect").select2();
  //$("#fish_transect_user_id").select2();
  // Trigger validation on close (select2 does not trigger focusout)
  $(".metaSelect").on("close", function (e) {  
    $(this).valid(); 
  });

  // Format the datepicker
  $("#fish_transect_date_completed").datepicker({
    format: 'yyyy-mm-dd',
    autoclose: true
    // We cannot prevent focusout event from firing when selecting a date.
    // The code below acts as a workaround. 
    // On focus, ignore the validation.
    // On hide, remove the ignored validation and validate.
  }).on("hide",function(){ 
      $(".new_fish_transect, .edit_fish_transect").data("validator").settings.ignore="";
      $(this).valid();
  }).on("focus",function(){
      $(".new_fish_transect, .edit_fish_transect").data("validator").settings.ignore="#fish_transect_date_completed, :hidden";
  });

	// Create alert if time is too early or late
	function alert24HourClock() {
    $("#fish_transect_begin_time").on("focusout", function(){
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

  // Create alert if length is less than a full transect
  function alert25Meters() {
    $("#fish_transect_completed_m").on("focusout", function(){
      var $m = $(this).val();
      if ( $m < 25 ){
        alert("Are you sure you did less than a full transect (25 m)?");
      } else {  }
    });
  };
  // Trigger the alert
  alert25Meters();

  // Add validation method to check format of time
  jQuery.validator.addMethod("timeformat", function(value, element) {
    return this.optional(element) || /^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$/.test(value);
  }, "Enter as HH:MM (24 hr clock)");

	// Create validation rules
	$(".new_fish_transect, .edit_fish_transect").validate( {
		ignore: [], // enable hidden field validation for select2
		// Trigger validation on focusout
  	onfocusout: function(element) {
        this.element(element);
    },

  	// List the rules
  	rules: {
			"fish_transect[manager_id]": { required: true },
      "fish_transect[site_id]": { required: true },
      "fish_transect[user_id]": { required: true },
			"fish_transect[date_completed]": { required: true },
			"fish_transect[begin_time]": { required: true, timeformat: true },
      "fish_transect[oc_cc]": { required: true },
      "fish_transect[rep]": { required: true,
        number: true,
        min: 1,
        max: 9 },
      "fish_transect[completed_m]": { required: true,
        number: true,
        min: 1,
        max: 25 }
			
  	},

  	// List the error messages
  	messages: {
      "fish_transect[manager_id]": { required: "Required" },
      "fish_transect[site_id]": { required: "Required" },
      "fish_transect[user_id]": { required: "Required" },
      "fish_transect[date_completed]": { required: "Required" },
      "fish_transect[begin_time]": { required: "Required" },
      "fish_transect[oc_cc]": { required: "Required" },
      "fish_transect[rep]": { required: "Required",
        number: "Must be a number",
        min: "Must be between 1 and 9",
        max: "Must be between 1 and 9" },
      "fish_transect[completed_m]": { 
        required: "Required",
        number: "Must be a number",
        min: "Must be between 1 and 25",
        max: "Must be between 1 and 25" }
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

  // Second Section (Diadema)
  // Hitting enter while in diadema section adds new diadema
  $("#diademas").bind("keypress", function(e){
    if (e.keyCode ==13){
      e.preventDefault();
      $(".addDiadema").trigger("click");
    };
    $('.testSizeField').last().focus();
  });

  
  // Third Section (Fish)
  // Implement dropdown with textbox for species
  $(".speciesSelect").select2();
  // Validate on closing event (focusout not triggered)
  $(".speciesSelect").on("close", function (e) {  
    $(this).valid(); 
  });

  // Write function to check species total
  // This function and alert works, but it was changed to a validation (below)
  // Will need to be modified in the future to validate total number
  // function sum_species(fish_row) {
  //   var size_bin_nums = new Array();
    
  //   $(fish_row).find('.sizeBinField').each(function(){
  //     if ( $(this).val() != 0 ){
  //       size_bin_nums.push( $(this).val() );
  //     };
  //   });

  //   var total = 0;
  //   $.each(size_bin_nums,function() {
  //     total += parseFloat( this );
  //   });
  //   return total;
  // };

  // // Check species total before adding more fields
  // $("#fishes").on('cocoon:before-insert', function (e) {
  //   // Alert if fish row with all zeroes
  //   $(".fishRow").each(function(){
  //     if (sum_species($(this)) == 0){
  //       alert("You must have a value in one of the size bins");
  //     };
  //   });
  // });

  // Must be at least one fish per species
  $.validator.addMethod(
    "atLeastOneObserved", function(value, element) {
      var item = $(element).closest('li');
      var sizes = [];
      var sizeIsNaN = [];
      var numFound = false;
      item.find('.sizeBinField').each(function(){
        var size = parseFloat($(this).val());
        sizes.push(size);
        sizeIsNaN.push(Number.isNaN(size)); // if size is NaN (blank), is true
      });
      if(!(sizeIsNaN.every(Boolean))){ // if one is false (not blank), it's a number
        numFound = true;
      }; 
      
      return numFound;
    },
    "There must be a value in one of the size bins"
  );
  
  // Add properties to nested fields when added
  $('#fishes').on('cocoon:after-insert', function() {
    $(".speciesSelect").last().select2(); // convert to select2
    $('.speciesSelect').last().select2('open'); // focus and open dropdown
    $(".speciesSelect").on("close", function (e) {  
      $(this).valid(); // validate on close
    });
    // Set properties for size bins on change
    $(".sizeBinField").on('change', function (e) {
      // Highlight changed fields
      $(this).addClass('bg-success');
      // Validate the fish
      $(this).parent().parent().find('[name*="fish_id"]').valid();
    });
  });
  // Set properties for size bins on change
  $(".sizeBinField").on('change', function (e) {
    // Highlight changed fields
    $(this).addClass('bg-success');
    // Validate the fish
    $(this).parent().parent().find('[name*="fish_id"]').valid();
  });

  // Hitting enter while in fish section adds new species
  $("#fishes").bind("keypress", function(e){
    if (e.keyCode ==13){
      e.preventDefault();
      $(".addFish").trigger("click");
    };
  });

  // Second and third section (all nested fields)
  // Add validations for all nested station fields
  function validate_fields() {
    $('[name*="test_size_cm"]').each(function(){
      $(this).rules('add', {
        required: true
      });
    });
    $('[name*="fish_id"]').each(function(){
      $(this).rules('add', {
        required: true,
        atLeastOneObserved: true
      });
    });
    $('.sizeBinField').each(function(){
      $(this).rules('add', {
        number: true
      });
    });
  };

  // Trigger validation for nested diadema and fish fields
  validate_fields();

  // Add validation behavior to added nested fields
  $(document).delegate(".add_fields", "click", function(){ 
    // Trigger validation
    validate_fields();
    alertSpeciesSizes();
  });

  // Validate fish sizes using alerts
  speciesInformation = {}
  if ( typeof fish_info !== "undefined" ) {
    $.each(fish_info, function(a){
      speciesInformation[fish_info[a].id] = { "max_num": fish_info[a].max_num, "min_size": fish_info[a].min_size, "max_size": fish_info[a].max_size };
    });
  }

  function alertSpeciesSizes() {
    $('.sizeBinField').on('change', function(){
      var $species = $(this).parent().find('.speciesSelect').select2('val');
      // Check abundance
      var item = $(this).closest('li');
      var sizes = [];
      var sum_sizes = 0
      item.find('.sizeBinField').each(function(){
        var size = parseInt($(this).val());
        if(!isNaN(size)){
          sizes.push(size);
        }
        sum_sizes = sizes.reduce((a, b) => a + b, 0)
      });
      if ( sum_sizes > speciesInformation[$species].max_num) {
        alert("Over max number");
      }; 
      // Check minimum and maximum sizes
      var sizebin = $(this).attr('id');
      var smallest = speciesInformation[$species].min_size
      var biggest = speciesInformation[$species].max_size
      
      if ( sizebin == "size0to5" && smallest > 5 ) {alert("Under min size")};
      if ( sizebin == "size6to10" && smallest > 10 ) {alert("Under min size")};
      if ( sizebin == "size6to10" && biggest < 6 ) {alert("Over max size")};
      if ( sizebin == "size11to20" && smallest > 20 ) {alert("Under min size")};
      if ( sizebin == "size11to20" && biggest < 11 ) {alert("Over max size")};
      if ( sizebin == "size21to30" && smallest > 30 ) {alert("Under min size")};
      if ( sizebin == "size21to30" && biggest < 21 ) {alert("Over max size")};
      if ( sizebin == "size31to40" && smallest > 40 ) {alert("Under min size")};
      if ( sizebin == "size31to40" && biggest < 31 ) {alert("Over max size")};
      if ( sizebin == "size41to50" && smallest > 50 ) {alert("Under min size")};
      if ( sizebin == "size41to50" && biggest < 41 ) {alert("Over max size")};
      if ( sizebin == "size51to60" && smallest > 60 ) {alert("Under min size")};
      if ( sizebin == "size51to60" && biggest < 51 ) {alert("Over max size")};
      if ( sizebin == "size61to70" && smallest > 70 ) {alert("Under min size")};
      if ( sizebin == "size61to70" && biggest < 61 ) {alert("Over max size")};
      if ( sizebin == "size71to80" && smallest > 80 ) {alert("Under min size")};
      if ( sizebin == "size71to80" && biggest < 71 ) {alert("Over max size")};
      if ( sizebin == "size81to90" && smallest > 90 ) {alert("Under min size")};
      if ( sizebin == "size81to90" && biggest < 81 ) {alert("Over max size")};
      if ( sizebin == "size91to100" && smallest > 100 ) {alert("Under min size")};
      if ( sizebin == "size91to100" && biggest < 91 ) {alert("Over max size")};
      if ( sizebin == "size101to110" && biggest < 101 ) {alert("Over max size")};
      if ( sizebin == "size111to120" && biggest < 111 ) {alert("Over max size")};
      if ( sizebin == "size121to130" && biggest < 121 ) {alert("Over max size")};
      if ( sizebin == "size131to140" && biggest < 131 ) {alert("Over max size")};
      if ( sizebin == "size141to150" && biggest < 141 ) {alert("Over max size")};
      if ( sizebin == "sizegt150" && biggest < 151 ) {alert("Over max size")};
    });
  };
  
  alertSpeciesSizes();
});