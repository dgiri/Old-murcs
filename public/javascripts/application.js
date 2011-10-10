// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


// jQuery ajax requests should land in format.js block.
//----------------------------------------------------------------------------
$.ajaxSetup({
    'beforeSend': function(xhr) {
        xhr.setRequestHeader("Accept", "");
        xhr.setRequestHeader("Accept", "text/javascript")
    }
});

// Global ajax activity indicators.
//----------------------------------------------------------------------------
$(document).ajaxStart(function(){
    $('#progress').animate({top: 0});
}).ajaxStop(function(){
    $('#progress').animate({top: '-30px'});
});

$(document).ajaxComplete(function(event,response,settings) {
    if(response.status == 401) {
        var newLocationObject = Util.parseJSON(response.responseText);
        window.location = newLocationObject.location;
    }
});

//--------------------------------------------------------------------------------------------------------------------//
$(function(){
	
	// It is used for tagging functionality
	$('form.story_form').livequery(function(){
		$('#story_tag_list').tagsInput({
		  'width':'auto'
		});
	});

    // Hide the notification panel on click.
    //----------------------------------------------------------------------------
    $('#notifications').click(function(){
        $(this).animate({
            "top" : "-60"
        })
    });

    // Equivalent of rails link_to_remote helper.
    //----------------------------------------------------------------------------
    $("a.remote, div.remote a").livequery('click', function() {
        var type = 'GET';
		var el = $(this);

        if(el.hasClass('update')) {
            type = 'PUT';
			Util.requestAjax(el.attr('href'), type);
        } else if(el.hasClass('delete')) {
            type = 'DELETE';
            ref = el.attr('rel');
            var confirmMsg = el.attr('rel').length ? el.attr('rel') : 'Are you sure to delete?';
			var titleMsg = el.attr('title').length ? el.attr('title') : 'Are you sure to delete?';
            jConfirm(confirmMsg, titleMsg, function(r) {
				if(r) {
					Util.requestAjax(el.attr('href'), type);
				}
			});
        } else if(el.hasClass('view_child_test_report')) {
            $(".row_selected").removeClass("row_selected");
            el.parent().parent().addClass("row_selected");
			Util.requestAjax(el.attr('href'), type);
        } else {
			Util.requestAjax(el.attr('href'), type);
		}

        return false;
    });

    // Equivalent of rails link_to_remote helper.
    // Only to send requests using http delete.
    //----------------------------------------------------------------------------
    $("a.remoteDelete").livequery('click', function() {
        $.ajax({
            url: $(this).attr('href'),
            dataType: "script",
            type: "DELETE",
            data: {'_' : String(new Date().getTime())}, // To fix 'Error occurred while parsing request parameters' while using Google Chrome
            beforeSend: function(xhr) {
                xhr.setRequestHeader("Accept", "text/javascript");
            }
        });
        return false;
    });

    // To validate forms client-side and submit through ajax.
    //----------------------------------------------------------------------------
    $('form').livequery(function(){
        $(this).validate({
            meta: "validate",
            submitHandler : function(form) {
                var f = $(form),
					msg = f.attr('rel'),
        			title = f.attr('title');
                if (f.hasClass('deactivatePost')) {
                    f.find("input[type='submit']").attr('disabled', true);
                }
                if (f.hasClass('remote')) {
					if (f.hasClass('confirm')){
						jConfirm(msg,title,function(r) {
		            		if(r) {
		                		f.ajaxSubmit({ dataType: 'script'});
		            		} else {
		                		return false;
		            		}
		        		});
					} else {
						f.ajaxSubmit({
	                        dataType: 'script'
	                    });	
					}					
                    
                } else if(f.hasClass('facebook_remote')) {
                    f.ajaxSubmit({
                        dataType: 'script',
                        beforeSubmit: showSpinner,
                        success: hideSpinner
                    });
                } else {
					if (f.hasClass('confirm')){
						jConfirm(msg,title,function(r) {
		            		if(r) {
		                		form.submit();
		            		} else {
		                		return false;
		            		}
		        		});
					} else {
						form.submit();
					}
                }
            },
            errorPlacement: function(error, element) {
                if (element.attr("id") == "date_of_birth" )
                    error.insertAfter($(".calendars-trigger")[0]);
                else
                    error.insertAfter(element);
            }

        });
    });
	
});




// Namespace for storing all utility functions
//----------------------------------------------------------------------------
if (typeof Util == 'undefined') {
    Util = {};
}

Util = {
	requestAjax : function(url, type) {
		$.ajax({
            url: url,
            type: type,
            dataType: "script",
            data: {'_' : String(new Date().getTime())}, // To fix 'Error occurred while parsing request parameters' while using Google Chrome
            beforeSend: function(xhr) {
                xhr.setRequestHeader("Accept", "text/javascript");
            }
        });
	},

    parseJSON : function(stringData) {        
        if(window.JSON == undefined) {            
            return eval('(' + stringData + ')');
        } else {            
            return JSON.parse(stringData);
        }
    },

    reloading_window_location : function(){
        var oldUrl = window.location.href;
        window.location = oldUrl.split("#")[0];        
    }
}



Message = function() {
    return {
        notice : function(text) {
            $('#message').html(text);

            this.showNotice();
            this.hideNotice();
        },

        error : function(text) {
            $('#message').html(text);

            this.showErrorNotice();
            this.hideNotice();
        },

        showNotice : function() {
            $('#notifications #notificationIcon').removeClass("errorNotificationIcon");
            $('#notifications #notificationIcon').addClass("notificationIcon");
            $('#notifications').animate({
                "top" : "0"
            });
        },

        showErrorNotice : function() {
            $('#notifications #notificationIcon').removeClass("notificationIcon");
            $('#notifications #notificationIcon').addClass("errorNotificationIcon");
            $('#notifications').animate({
                "top" : "0"
            });
        },

        hideNotice : function() {
            var msg = $('#message').html();

            if (msg.length > 0) {
                setTimeout(function() {
                    $('#notifications').animate({
                        "top" : "-60"
                    });
                }, 10000);
            }
        }
    };
}();

$(function(){
	//hover states on the static widgets
	$('.dialog_link').hover(
		function() { $(this).addClass('ui-state-default'); }, 
		function() { $(this).removeClass('ui-state-default'); }
	);
});



(function ($) {
    $.fn.styleTable = function (options) {
        var defaults = {
            css: 'styleTable'
        };
        options = $.extend(defaults, options);

        return this.each(function () {

            input = $(this);
            input.addClass(options.css);

            input.find("tr").live('mouseover mouseout', function (event) {
                if (event.type == 'mouseover') {
                    $(this).children("td").addClass("ui-state-hover");
                } else {
                    $(this).children("td").removeClass("ui-state-hover");
                }
            });

            input.find("th").addClass("ui-state-default");
            input.find("td").addClass("ui-widget-content");

            input.find("tr").each(function () {
                $(this).children("td:not(:first)").addClass("first");
                $(this).children("th:not(:first)").addClass("first");
            });
        });
    };
})(jQuery);