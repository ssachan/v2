window.LoginView = Backbone.View.extend({

    initialize:function () {
        console.log('Initializing Login View');
        this.render();
    },

    events: {
        'click #loginButton': 'login',
        'click #flogin' : 'fConnect',
    	'click #glogin' : 'gConnect',
    },

    render:function () {
        $(this.el).html(this.template());
        return this;
    },

	fConnect : function() {
		user.login();
		//also send the details to the server
	},

	gConnect : function() {
		glogin();
	},
	
    login:function (event) {
        event.preventDefault(); // Don't let this button submit the form
    	this.model.login($('#linputEmail').val(), $('#linputPassword').val());
    	
        event.preventDefault(); // Don't let this button submit the form
        $('.alert-error').hide(); // Hide any errors on a new submit
        
    }
});

window.SignUpView = Backbone.View.extend({

    initialize:function () {
        console.log('Initializing SignUp View');
        this.render();
    },

    events: {
        "click #signupButton": "signup"
    },

    render:function () {
        $(this.el).html(this.template());
        return this;
    },

    signup:function (event) {
        event.preventDefault(); // Don't let this button submit the form
    	var formValues = {
    			email : $('#inputEmail').val(),
    			password :  $('#inputPassword').val(),
    			firstName : $('#inputFname').val(),
    			lastName : $('#inputLname').val(),
    			type : 1,
    			streamId : streamId,
    		};
        this.model.signUp(formValues);
    }
});

window.ForgotPassView = Backbone.View.extend({

    initialize:function () {
        console.log('initializing forgot pass view');
    },

    events: {
        "click #forgotPassButton": "forgotPass"
    },

    render:function () {
        $(this.el).html(this.template());
        return this;
    },

    forgotPass:function (event) {
        event.preventDefault(); // Don't let this button submit the form
    	this.model.forgotPass($('#forgotPassEmail').val());
    }
});

window.ChangePassView = Backbone.View.extend({

    initialize:function () {
        console.log('initializing change pass view');
    },

    events: {
        "click #changePassButton": "changePass"
    },

    render:function () {
        $(this.el).html(this.template());
        return this;
    },

    changePass:function (event) {
        event.preventDefault(); // Don't let this button submit the form
    	this.model.changePass($('#currPassword').val(), $('#newPassword').val());
    }
});