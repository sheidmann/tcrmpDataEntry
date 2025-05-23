$(document).ready(function() {

	// Prevent loading this script on every page
	if(!EA.onRailsPage('fish_transects', ['edit', 'new'])) {
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

  // Fix calendar arrows disappearing
  $('.prev i').removeClass();
  $('.prev i').addClass("fa fa-chevron-left");

  $('.next i').removeClass();
  $('.next i').addClass("fa fa-chevron-right");

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
  // Species must not already exist in the form
  $.validator.addMethod(
    "notDuplicated", function(value, element) {
        var species_list = [];
        $('.speciesSelect').each(function(){
          var species = $(this).val().toString();
          species_list.push(species);
        });
        // Remove the blanks that were added
        species_list = species_list.filter(Boolean);
        // Take the just-selected species out of the list
        var this_index = species_list.indexOf(value);
        if (this_index > -1) {
          species_list.splice(this_index, 1)
        }
        // Test for duplicates
        if (species_list.includes(value)) {
          return false; // FAIL validation if duplicated
        }
      return true; // PASS validation otherwise
    },
    "This species has already been entered"
  );
  // Numbers must be integers (no decimals)
  $.validator.addMethod(
    "isInteger", function(value, element) {
      if(value.toString()==""){
        return true; // PASS validation if empty box
      }
      return /^[1-9][0-9]*$/.test(value.toString()) // otherwise check if integer with regex
    },
    "Must be an integer"
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
    // Remove highlight if field is blank
    if ($(this).val().toString() == "") {
      $(this).removeClass("bg-success");
    };
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
        required: true,
        number: true
      });
    });
    $('[name*="fish_id"]').each(function(){
      $(this).rules('add', {
        required: true,
        notDuplicated: true,
        atLeastOneObserved: true
      });
    });
    $('.sizeBinField').each(function(){
      $(this).rules('add', {
        number: true,
        isInteger: true
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
      //prevent from firing twice because javascript is weird
      if(this.value==this.oldvalue){return}; // checks for an actual change
      this.oldvalue=this.value; // makes sure we are using the new value
      // prevent from firing when an offending number is removed
      var num = parseInt($(this).val());
      if (isNaN(num)){return};

      // extract species
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
        sum_sizes = sizes.reduce(function(a, b) { return a + b; }, 0)
      });
      if ( sum_sizes > speciesInformation[$species].max_num) {
        alert("Over max number");
      }; 
      
      // Check minimum and maximum sizes
      var sizebin = $(this).attr('id');
      var smallest = speciesInformation[$species].min_size
      var biggest = speciesInformation[$species].max_size

      var u = 0;
      u += ( sizebin == "size0to5" && smallest > 5 )? 1 : 0;
      u += ( sizebin == "size6to10" && smallest > 10 )? 1 : 0;
      u += ( sizebin == "size11to20" && smallest > 20 )? 1 : 0;
      u += ( sizebin == "size21to30" && smallest > 30 )? 1 : 0;
      u += ( sizebin == "size31to40" && smallest > 40 )? 1 : 0;
      u += ( sizebin == "size41to50" && smallest > 50 )? 1 : 0;
      u += ( sizebin == "size51to60" && smallest > 60 )? 1 : 0;
      u += ( sizebin == "size61to70" && smallest > 70 )? 1 : 0;
      u += ( sizebin == "size71to80" && smallest > 80 )? 1 : 0;
      u += ( sizebin == "size81to90" && smallest > 90 )? 1 : 0;
      u += ( sizebin == "size91to100" && smallest > 100 )? 1 : 0;

      if( u > 0 ) {
          alert("Under min size");
      };
      var o = 0;
      o += ( sizebin == "size6to10" && biggest < 6 )? 1 : 0;
      o += ( sizebin == "size11to20" && biggest < 11 )? 1 : 0;
      o += ( sizebin == "size21to30" && biggest < 21 )? 1 : 0;
      o += ( sizebin == "size31to40" && biggest < 31 )? 1 : 0;
      o += ( sizebin == "size41to50" && biggest < 41 )? 1 : 0;
      o += ( sizebin == "size51to60" && biggest < 51 )? 1 : 0;
      o += ( sizebin == "size61to70" && biggest < 61 )? 1 : 0;
      o += ( sizebin == "size71to80" && biggest < 71 )? 1 : 0;
      o += ( sizebin == "size81to90" && biggest < 81 )? 1 : 0;
      o += ( sizebin == "size91to100" && biggest < 91 )? 1 : 0;
      o += ( sizebin == "size101to110" && biggest < 101 )? 1 : 0;
      o += ( sizebin == "size111to120" && biggest < 111 )? 1 : 0;
      o += ( sizebin == "size121to130" && biggest < 121 )? 1 : 0;
      o += ( sizebin == "size131to140" && biggest < 131 )? 1 : 0;
      o += ( sizebin == "size141to150" && biggest < 141 )? 1 : 0;
      o += ( sizebin == "sizegt150" && biggest < 151 )? 1 : 0;

      if( o > 0 ) {
          alert("Over max size");
      };
    });

    // Alert to large Diadema
    $('.testSizeField').on('change', function(){
      //prevent from firing twice because javascript is weird
      if(this.value==this.oldvalue){return};
      this.oldvalue=this.value;

      if($(this).val() > 13){
        alert("Over max size");
      }
    });
  };
  
  alertSpeciesSizes();
});