window.Account = Backbone.Model.extend({

	urlRoot : ' ',

	initialize : function() {
		var that = this;
		// Hook into jquery
		// The server must allow this through response headers
		/*
		 * $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
		 * options.xhrFields = { withCredentials : true }; // If we have a csrf
		 * token send it through with the next request if (typeof
		 * that.get('_csrf') !== 'undefined') {
		 * jqXHR.setRequestHeader('X-CSRF-Token', that.get('_csrf')); } });
		 */
	},

	fConnect : function() {
		user.login();
		// also send the details to the server
	},

	gConnect : function() {
		glogin();
	},

	login : function(email, password) {
		// Do a POST to /login and send the creds
		var url = '../api/login';
		console.log('Loggin in... ');
		var formValues = {
			email : email,
			password : password,
			streamId : 1
		};
		$.ajax({
			url : url,
			type : 'POST',
			dataType : "json",
			data : formValues,
			success : function(data) {
				console.log([ "Login request details: ", data ]);
				if (data.error) { // If there is an error, show the error
					// messages
					alert(data.error.text);
				} else { // If not, send them back to the home page
					account.set(data);
					account.set('type',1);
					id=account.get('id')+'|'+activeStream.get('id');
					window.location.replace('#dashboard');
				}
			}
		});
	},

	logout : function() {
		// Do a DELETE to /session and clear the clientside data
		var that = this;

		/*
		 * this.destroy({ success : function(model, resp) { model.clear(); //
		 * Set auth to false to trigger a change:auth event // The server also
		 * returns a new csrf token so that // the user can relogin without
		 * refreshing the page that.set({ auth : false, _csrf : resp._csrf });
		 *  } });
		 */
	},

	getAuth : function(callback) {
		// getAuth is wrapped around our router
		// before we start any routers let us see if the user is valid
		this.fetch({
			success : callback
		});
	},

	signUp : function(email, password, firstName, lastName) {
		// Do a POST to /login and send the creds
		var url = '../api/signup';
		console.log('Loggin in... ');
		var formValues = {
			email : email,
			password : password,
			firstName : firstName,
			lastName : lastName,
			streamId : 1,
		};
		$.ajax({
			url : url,
			type : 'POST',
			dataType : "json",
			data : formValues,
			success : function(data) {
				console.log([ "signup request details: ", data ]);
				if (data.error) { // If there is an error, show the error
					// messages
					alert(data.error.text);
				} else { // If not, send them back to the home page
					account.set(data);
					account.set('type',1);
					id=account.get('id')+'|'+activeStream.get('id');
					window.location.replace('#dashboard');
					
				}
			}
		});
	},
	
	forgotPass : function(email){
		var url = '../api/forgotpass';
		console.log('Loggin in... ');
		var formValues = {
			email : email,
		};
		$.ajax({
			url : url,
			type : 'POST',
			dataType : "json",
			data : formValues,
			success : function(data) {
				console.log([ "signup request details: ", data ]);
				if (data.error) { // If there is an error, show the error
					// messages
					alert(data.error.text);
				} else { // If not, send them back to the home page
					account.set(data);
					account.set('type',1);
					id=account.get('id')+'|'+activeStream.get('id');
					window.location.replace('#dashboard');
					
				}
			}
		});
	},
	
	defaults : {
		id : null,
	}

});

var account = new Account({});
