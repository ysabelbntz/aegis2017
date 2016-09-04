// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .

$(document).ready(function () {

	try {
		var menu = $('.sticky');
		var origOffsetY = menu.offset().top;	
	}
	catch(err) {

	}
	

	function scroll() {
	    if ($(window).scrollTop() >= origOffsetY) {
	        $('.sticky').addClass('navbar-fixed-top');
	    } else {
	        $('.sticky').removeClass('navbar-fixed-top');
	    }
	}

	$('#account_student_id').on('input', function() {
	    var value = $(this).val();
	    var length = value.toString().length;

	    if(length == 6) {
	      $.ajax({
	        method: 'GET',
	        url: '/students/search',
	        data: { id: value },
	        dataType: 'json',
	        success: function(student) {
	            // name = camelize(student.stu_full_name);
	            // crs = student.stu_course;  
	            // yr = student.stu_year;
	            // if (name!=null){
	            //   $('#student-name').text(name);  
	            //   $('#student-yrcrs').text(yr + " - " + crs);
	            // }
	            // else {
	            //   $('#student-name').text("Student not found.");
	            // }
	            
	            
	            // if ($('#student-name').text() != "Student not found.") {
	            //   $('#form button').click();
	            // }
	            $('#student-name').text(student[0].name);
	            $('#student-yrcrs').text(student[0].yr + " - " + student[0].course);
	            $('#student-school').text(student[0].school);

	            $('#account_name').val(student[0].name);
	            $('#account_yr').val(student[0].yr);
	            $('#account_course').val(student[0].course);
	            $('#account_school').val(student[0].school);
	          }
	      });
	            
	       
	    } else {
		    $('#student-name').text("Student not found.");
		    $('#student-yrcrs').text("");
		    $('#student-school').text("");

		    $('#account_name').val("");
	        $('#account_yr').val("");
	        $('#account_course').val("");
	        $('#account_school').val("");
	    }
	  }); 

  	document.onscroll = scroll;

});