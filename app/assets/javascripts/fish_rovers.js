$(document).ready(function() {

	// Prevent loading this script on every page
	if(!EA.onRailsPage('fish_rovers', ['edit', 'new'])) {
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
  $("#fish_rover_date_completed").datepicker({
    format: 'yyyy-mm-dd',
    autoclose: true
    // We cannot prevent focusout event from firing when selecting a date.
    // The code below acts as a workaround. 
    // On focus, ignore the validation.
    // On hide, remove the ignored validation and validate.
  }).on("hide",function(){ 
      $(".new_fish_rover, .edit_fish_rover").data("validator").settings.ignore="";
      $(this).valid();
  }).on("focus",function(){
      $(".new_fish_rover, .edit_fish_rover").data("validator").settings.ignore="#fish_rover_date_completed, :hidden";
  });

  // Fix calendar arrows disappearing
  $('.prev i').removeClass();
  $('.prev i').addClass("fa fa-chevron-left");

  $('.next i').removeClass();
  $('.next i').addClass("fa fa-chevron-right");

	// Create alert if time is too early or late
	function alert24HourClock() {
    $("#fish_rover_begin_time").on("focusout", function(){
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
	$(".new_fish_rover, .edit_fish_rover").validate( {
		ignore: [], // enable hidden field validation for select2
		// Trigger validation on focusout
  	onfocusout: function(element) {
        this.element(element);
    },

  	// List the rules
  	rules: {
			"fish_rover[manager_id]": { required: true },
      "fish_rover[site_id]": { required: true },
      "fish_rover[user_id]": { required: true },
			"fish_rover[date_completed]": { required: true },
			"fish_rover[begin_time]": { required: true, timeformat: true },
      "fish_rover[oc_cc]": { required: true },
      "fish_rover[rep]": { required: true,
        number: true,
        min: 1,
        max: 4 }
  	},

  	// List the error messages
  	messages: {
      "fish_rover[manager_id]": { required: "Required" },
      "fish_rover[site_id]": { required: "Required" },
      "fish_rover[user_id]": { required: "Required" },
      "fish_rover[date_completed]": { required: "Required" },
      "fish_rover[begin_time]": { required: "Required" },
      "fish_rover[oc_cc]": { required: "Required" },
      "fish_rover[rep]": { required: "Required",
        number: "Must be a number",
        min: "Must be between 1 and 3",
        max: "Must be between 1 and 3" }
    }
  });

  // Second Section (Fish)
  // Implement dropdown with textbox for species
  $(".speciesSelect").select2();
  // Validate on closing event (focusout not triggered)
  $(".speciesSelect").on("close", function (e) {  
    $(this).valid(); 
  });

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
    // Validate fish on abundance change
    $(".abundField").on('change', function (e) {
      $(this).parent().parent().find('[name*="fish_id"]').valid();
    });
  });
  // Validate fish on abundance change
  $(".abundField").on('change', function (e) {
    $(this).parent().parent().find('[name*="fish_id"]').valid();
  });

  // Hitting enter while in fish section adds new species
  $("#fishes").bind("keypress", function(e){
    if (e.keyCode ==13){
      e.preventDefault();
      $(".addFish").trigger("click");
    };
  });

  // Add validations for nested fish fields
  function validate_fields() {
    $('[name*="fish_id"]').each(function(){
      $(this).rules('add', {
        required: true,
        notDuplicated: true
      });
    });
    $('.abundField').each(function(){
      $(this).rules('add', {
        required: true,
        number: true,
        isInteger: true,
        min: 1,
        max: 5
      });
    });
  };

  // Trigger validation for nested fish fields
  validate_fields();

  // Add validation behavior to added nested fields
  $(document).delegate(".add_fields", "click", function(){ 
    // Trigger validation
    validate_fields();
    alertAbundance();
  });

  // Validate fish abundance using alerts
  speciesInformation = {}
  if ( typeof fish_info !== "undefined" ) {
    $.each(fish_info, function(a){
      speciesInformation[fish_info[a].id] = { "max_num": fish_info[a].max_num, "min_size": fish_info[a].min_size, "max_size": fish_info[a].max_size };
    });
  }

  function alertAbundance() {
    $('.abundField').on('change', function(){
      //prevent from firing twice because javascript is weird
      if(this.value==this.oldvalue){return};
      this.oldvalue=this.value;

      // extract species and corresponding info
      var item = $(this).closest('li');
      var $species = item.find('.speciesSelect').select2('val');
      var most = speciesInformation[$species].max_num

      // compare entered value to the max num
      var num = parseInt($(this).val());
      var a = 0;
      a += ( num >= 2 && most < 2 )? 1 : 0;
      a += ( num >= 3 && most < 10 )? 1 : 0;
      a += ( num >= 4 && most < 100 )? 1 : 0;
      a += ( num >= 5 && most < 1000 )? 1 : 0;

      if( a > 0 ) {
          alert("Over max number");
      };
    });
  };

  alertAbundance();
});