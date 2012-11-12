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
    	this.model.signUp($('#inputEmail').val(), $('#inputPassword').val(),$('#inputFname').val(),$('#inputLname').val());
    }
});

window.ForgotPassView = Backbone.View.extend({

    initialize:function () {
        console.log('Initializing SignUp View');
        this.render();
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
    	this.model.signUp($('#inputEmail').val(), $('#inputPassword').val(),$('#inputFname').val(),$('#inputLname').val());
    }
});