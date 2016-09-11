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
//= require moment 
//= require fullcalendar


$('.registrations.new').ready(function () {
	var terms_read = false;
	var terms_accepted = false;
	$('#new-account-submit').attr("disabled", "disabled");
	$('#new-account-submit').addClass('disable-button');

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
	            if (student[0].name == "Account already created.") {
	            	$('#student-name').text(student[0].name);	
	            	$('#new-account-submit').attr("disabled", "disabled");
					$('#new-account-submit').addClass('disable-button');
	            }
	            else {
		            $('#student-name').text(student[0].name);
		            $('#student-yrcrs').text(student[0].yr + " - " + student[0].course);
		            $('#student-school').text(student[0].school);

		            $('#account_name').val(student[0].name);
		            $('#account_yr').val(student[0].yr);
		            $('#account_course').val(student[0].course);
		            $('#account_school').val(student[0].school);

		   //          $('input[type=submit]').attr("disabled", "false");
					// $('input[type=submit]').removeClass('disable-button');
	        	}
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
	        $('#new-account-submit').attr("disabled", "disabled");
			$('#new-account-submit').addClass('disable-button');
	    }
	  }); 

	$('#terms-read').click(function() {
	    var $this = $(this);
  
	    if ($this.is(':checked')) {
	    	terms_read = true;
	    } else {
	    	terms_read = false;
	    }
	    activateSubmit();
	});

	$('#terms-accept').click(function() {
	    var $this = $(this);
  
	    if ($this.is(':checked')) {
	    	terms_accepted = true;
	    } else {
	    	terms_accepted = false;
	    }
	    activateSubmit();
	});

	function activateSubmit() {
		console.log("test_");
		if ((terms_accepted) && (terms_read) && ($('#student-name').text() != "Student not found." || $('#student-name').text() != "Account already created.")) {
			$('#new-account-submit').removeAttr("disabled");
			$('#new-account-submit').removeClass('disable-button');
		}
		else {
			$('#new-account-submit').attr("disabled", "disabled");
			$('#new-account-submit').addClass('disable-button');
		}
	}
});

$(document).ready(function () {

	$('#calendar').fullCalendar({
		events: '/events.json',
		eventRender: function(event, element) {
		    $(element).tooltip({title: event.title});             
		}
	});

	try {
		var menu = $('.sticky');
		var origOffsetY = menu.offset().top;	
	}
	catch(err) {

	}

	//https://jsfiddle.net/cse_tushar/Dxtyu/141/
	$('a[href^="#"]').on('click', function (x) {
        x.preventDefault();
        $(document).off("scroll");
        
        $('a').each(function () {
            $(this).parent().removeClass('active');
        })
        $(this).parent().addClass('active');
      
        var target = this.hash,
            menu = target;
        $target = $(target);
        $('html, body').stop().animate({
            'scrollTop': $target.offset().top-100
        }, 500, 'swing', function () {
            window.location.hash = target-500;
            $(document).on("scroll", onScroll);
        });
    });
	

	function scroll() {
	    if ($(window).scrollTop() >= origOffsetY) {
	        $('.sticky').addClass('navbar-fixed-top');
	        $('#announcements').css("padding-top","70px");
	    } else {
	        $('.sticky').removeClass('navbar-fixed-top');
	        $('#announcements').css("padding-top","0px");
	    }

	    var scrollPos = $(document).scrollTop();
	    $('nav a').each(function () {
	        var currLink = $(this);
	        var refElement = $(currLink.attr("href"));
	        if (refElement.position().top <= scrollPos && refElement.position().top + refElement.height() > scrollPos) {
	            // $('#menu-center ul li a').removeClass("active");
	            currLink.parent().addClass("active");
	        }
	        else{
	            currLink.parent().removeClass("active");
	        }
	    });
	}


  	document.onscroll = scroll;

});