$(document).ready(function() {

	// Prevent loading this script on every page
	if(!EA.onRailsPage('algae_heights', ['edit', 'new'])) {
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
  $("#algae_height_date_completed").datepicker({
    format: 'yyyy-mm-dd',
    autoclose: true
    // We cannot prevent focusout event from firing when selecting a date.
    // The code below acts as a workaround. 
    // On focus, ignore the validation.
    // On hide, remove the ignored validation and validate.
  }).on("hide",function(){ 
      $(".new_algae_height, .edit_algae_height").data("validator").settings.ignore="";
      $(this).valid();
  }).on("focus",function(){
      $(".new_algae_height, .edit_algae_height").data("validator").settings.ignore="#algae_height_date_completed, :hidden";
  });

  // Fix calendar arrows disappearing
  $('.prev i').removeClass();
  $('.prev i').addClass("fa fa-chevron-left");

  $('.next i').removeClass();
  $('.next i').addClass("fa fa-chevron-right");

	// Create validation rules
	$(".new_algae_height, .edit_algae_height").validate( {
		ignore: [], // enable hidden field validation for select2
		// Trigger validation on focusout
  	onfocusout: function(element) {
        this.element(element);
    },

  	// List the rules
  	rules: {
			"algae_height[manager_id]": { required: true },
      "algae_height[site_id]": { required: true },
      "algae_height[user_id]": { required: true },
			"algae_height[date_completed]": { required: true },
      "algae_height[rep]": { required: true,
        number: true,
        min: 1,
        max: 6 }
  	},

  	// List the error messages
  	messages: {
      "algae_height[manager_id]": { required: "Required" },
      "algae_height[site_id]": { required: "Required" },
      "algae_height[user_id]": { required: "Required" },
      "algae_height[date_completed]": { required: "Required" },
      "algae_height[rep]": { required: "Required",
        number: "Must be a number",
        min: "Must be between 1 and 6",
        max: "Must be between 1 and 6" }
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

  // Second Section (Algae)
  // Hitting enter while in algae section adds new algae
  $("#algaes").bind("keypress", function(e){
    if (e.keyCode ==13){
      e.preventDefault();
      $(".addAlgae").trigger("click");
    };
    $('.speciesSelect').last().focus();
  });

  // Implement dropdown with textbox for species
  $(".speciesSelect").select2();
  // Validate on closing event (focusout not triggered)
  $(".speciesSelect").on("close", function (e) {  
    $(this).valid(); 
  });

  
  // Add properties to nested fields when added
  $('#algaes').on('cocoon:after-insert', function() {
    $(".speciesSelect").last().select2(); // convert to select2
    $('.speciesSelect').last().select2('open'); // focus and open dropdown
    $(".speciesSelect").on("close", function (e) {  
      $(this).valid(); // validate on close
    });
  });
  
  // Add validations for all nested station fields
  function validate_fields() {
    $('[name*="height_cm"]').each(function(){
      $(this).rules('add', {
        required: true,
        number: true,
        min: 0
      });
    });
    $('[name*="algae_id"]').each(function(){
      $(this).rules('add', {
        required: true
      });
    });
  };

  // Trigger validation for nested algae fields
  validate_fields();

  // Add validation behavior to added nested fields
  $(document).delegate(".add_fields", "click", function(){ 
    // Trigger validation
    validate_fields();
  });
});