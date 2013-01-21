window.SignUpView = Backbone.View.extend({

    initialize:function () {
    },

    render:function () {
        $(this.el).html(this.template());
        return this;
    },
    
    onRender : function(){
    	$('#login-box').append(new LoginBox({model:this.model}).render().el);
    	$('#signup-box').append(new SignUpBox({model:this.model}).render().el);
    }
});

window.LoginBox = Backbone.View.extend({

    initialize:function () {
        console.log('Initializing Login View');
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
        this.model.set('type', 2);
		user.login();
		//also send the details to the server
	},

	gConnect : function() {
        this.model.set('type', 3);
		glogin();
	},
	
    login:function (event) {
        event.preventDefault(); // Don't let this button submit the form
    	this.model.login($('#email-lg').val(), $('#pass-lg').val());
    	//event.preventDefault(); // Don't let this button submit the form
       //$('.alert-error').hide(); // Hide any errors on a new submit        
    },
    
});

window.SignUpBox = Backbone.View.extend({

    initialize:function () {
        console.log('Initializing SignUp View');
    },

    events: {
        "click #signupButton": "signup",
    },

    render:function () {
        $(this.el).html(this.template());
        return this;
    },

    signup:function (event) {
        event.preventDefault(); // Don't let this button submit the form
    	var formValues = {
    			email : $('#email-su').val(),
    			password :  $('#pass-su').val(),
    			firstName : $('#fname-su').val(),
    			lastName : 'dummy',
    			type : 1,
    			streamId : streamId,
    		};
        this.model.signUp(formValues);
        this.model.set('type', 1);

        /*
         //Test type 2 auth
         var formValues = {
        	bio: "find my scribbling here - http://greypad.thinkpluto.com/",
            email: "shikhar.sachan@gmail.com",
            first_name: "Shikhar",
            gender: "male",
            id: "675467514",
            last_name: "Sachan",
            link: "https://www.facebook.com/shikhar.sachan",
            locale: "en_US",
            name: "Shikhar Sachan",
            pictures: Object,
            quotes: "you loose 100 % of the shots you don't take ...",
            timezone: 5.5,
            updated_time: "2012-08-18T16:31:31+0000",
            username: "shikhar.sachan",
            type : 2,
			streamId : streamId,
        };
        this.model.signUp(formValues);
        */
    },

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
	className : 'container forgotpass',
	
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