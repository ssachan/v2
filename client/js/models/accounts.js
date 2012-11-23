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
				if (data.error) { // If there is an error, show the error
					// messages
					alert(data.error.text);
				} else { // If not, send them back to the home page
					account.set(data);
					account.set('type', 1);
					id = account.get('id') + '|' + activeStream.get('id');
					window.location.replace('#');
				}
			}
		});
	},

	logout : function() {
		//delete the existing sesison and reset account
		var url = '../api/logout';
		$.ajax({
			url : url,
			type : 'GET',
			dataType : "json",
			success : function(data) {
				console.log('log out');
				if (data.error) { // If there is an error, show the error
					// messages
					console.log(data.error.text);
				} else { // If not, send them back to the home page
					window.location.replace('#landing');
					account.clear();
				}
			},
			error : function(data) {
				console.log(data);
			},
		});
	},

	getAuth : function(callback) {
		// getAuth is wrapped around our router
		// before we start any routers let us see if the user is valid
		this.fetch({
			success : callback
		});
	},

	signUp : function(inputValues) {
		// Do a POST to /login and send the creds
		var url = '../api/signup';
		console.log('Loggin in... ');
		/*var formValues = {
			email : email,
			password : password,
			firstName : firstName,
			lastName : lastName,
			streamId : 1,
		};
		*/
		$.ajax({
			url : url,
			type : 'POST',
			dataType : "json",
			data : inputValues,
			success : function(data) {
				console.log([ "signup request details: ", data ]);
				if (data.error) { // If there is an error, show the error
					// messages
					console.log(data.error.text);
				} else { // If not, send them back to the home page
					account.set(data);
					account.set('type', 1);
					id = account.get('id') + '|' + activeStream.get('id');
					window.location.replace('#');
				}
			},
			error : function(data) {
				// console.log([ "error: ", data ]);
			},
		});
	},

	forgotPass : function(email) {
		var url = '../api/forgotpass';
		console.log('forgot pass... ');
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
					console.log(data.error.text);
				} else { // If not, send them back to the home page
					account.set(data);
					account.set('type', 1);
					id = account.get('id') + '|' + activeStream.get('id');
					window.location.replace('#');
				}
			}
		});
	},

	changePass : function(oldpassword, newpassword){
		var url = '../api/changepass';
		console.log('change pass... ');
		$.ajax({
			url : url,
			type : 'POST',
			dataType : "json",
			data : {oldpassword : oldpassword, newpassword: newpassword},
			success : function(data) {
				console.log([ "signup request details: ", data ]);
				if (data.error) { // If there is an error, show the error
					// messages
					console.log(data.error.text);
				} else { // If not, send them back to the home page
					account.set(data);
					account.set('type', 1);
					id = account.get('id') + '|' + activeStream.get('id');
					window.location.replace('#');
				}
			}
		});
	},
	
	isAuth : function() {
		// getAuth is wrapped around our router
		// before we start any routers let us see if the user is valid
		url = '../api/isAuth';
		$.ajax({
			url : url,
			type : 'GET',
			dataType : "json",
			success : function(data) {
				if (data == false) { // If there is an error, show the
					// error
					// messages
					window.location.replace('#landing');
				} else { // If not, send them back to the home page
					account.set(data);
					account.set('type', 1);
					id = account.get('id') + '|' + activeStream.get('id');
					app.dashboard();	
				}
			}
		});
	},

	defaults : {
		id : null,
	}

});

var account = new Account({});
