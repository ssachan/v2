window.FacContactView = Backbone.View.extend({

    initialize:function () {
        console.log('Initializing faculty contact View');
        this.render();
    },

    events: {
        'click #contactButton': 'submitContactForm',
    },

    render:function () {
        $(this.el).html(this.template());
        return this;
    },

    submitContactForm:function (event) {
    	var formValues = {
    			email : $('#email').val(),
    			firstName : $('#fname').val(),
    			lastName : $('#lname').val(),
    			phoneNumber : $('#phone').val(),
    			about : $('#about').val(),
			};
        event.preventDefault(); // Don't let this button submit the form
		var url = Config.serverUrl + 'facContact/';
        return $.ajax({
			url : url,
			type : 'POST',
			dataType : "json",
			data : formValues,
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					
				} else { // If not, send them back to the home page
					helper.showError(data.data);
				}
			}
		});
    }
});
