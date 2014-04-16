// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
		$( "#writing_writing_date" ).datepicker({
		dateFormat: "yy/mm/dd",
		numberOfMonths: 2,
		showButtonPanel: true,
		showOn: "button",
		buttonText: "Εμφάνιση ημερολογίου",
		},
		$.datepicker.regional["el"]);
	});
