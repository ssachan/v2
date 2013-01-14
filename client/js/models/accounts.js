window.Account = Backbone.Model.extend({

	urlRoot : ' ',

	initialize : function() {
		if (!this.get('quizzesAttemptedArray')) {
			this.set({
				quizzesAttemptedArray : new Array()
			});
		}
		
		this.on('change:quizzesAttempted', function(model){
			if(model.get('quizzesAttempted')!=null && model.get('quizzesAttemptedArray')){
				model.get('quizzesAttemptedArray').push.apply(this.get('quizzesAttemptedArray'), JSON.parse(model.get('quizzesAttempted')));
			}
        });
		
		this.on('change:dp', function(model){
			if(model.get('dp')==true){
				model.set('dpUrl', DP_PATH+model.get('id')+'.jpg');
			}else{
				model.set('dpUrl', DP_PATH+'avatar.jpg');				
			}
        });
		
		//var that = this;
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
		var url = Config.serverUrl + 'login';
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
				if (data.status == STATUS.SUCCESS) {
					account.set(data.data);
					window.location = '#';
				} else {
					helper.showError(data.data);
				}
			}
		});
	},

	logout : function() {
		// delete the existing sesison and reset account
		var url = Config.serverUrl + 'logout';
		$.ajax({
			url : url,
			type : 'GET',
			dataType : "json",
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					console.log('log out');
					//window.location.replace('#landing');
					account.clear();
					user.clear();
					var signUpView = new SignUpView({
						model : account
					});
					app.showView('#content', signUpView);
					signUpView.onRender();
					helper.showError(data.data);
				} else {
					helper.showError(data.data);
				}
			},
			error : function(data) {
				console.log(data);
			},
		});
	},

	signUp : function(inputValues) {
		// Do a POST to /login and send the creds
		var url = Config.serverUrl + 'signup';
		console.log('signing up... ');
		$.ajax({
			url : url,
			type : 'POST',
			dataType : "json",
			data : inputValues,
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					account.set(data.data);
					window.location = '#';
				} else {
					helper.showError(data.data);
				}
			},
			error : function(data) {
				// console.log([ "error: ", data ]);
			},
		});
	},

	forgotPass : function(email) {
		var url = Config.serverUrl + 'forgotpass';
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
				if (data.status == STATUS.SUCCESS) {
					account.set(data.data);
				} else {
					helper.showError(data.data);
				}
			}
		});
	},

	changePass : function(oldpassword, newpassword) {
		var url = Config.serverUrl + 'changepass';
		console.log('change pass... ');
		$.ajax({
			url : url,
			type : 'POST',
			dataType : "json",
			data : {
				oldpassword : oldpassword,
				newpassword : newpassword
			},
			success : function(data) {

			}
		});
	},

	isAuth : function() {
		// isAuth is wrapped around our router
		// before we start any routers let us see if the user is authenticated
		url = Config.serverUrl + 'isAuth';
		$.ajax({
			url : url,
			type : 'GET',
			dataType : "json",
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					account.set(data.data);
				}
				app = new AppRouter();
				Backbone.history.start();
			}
		});
	},

	defaults : {
		id : null,
		quizzesAttempted : null,
		dpUrl : DP_PATH+'avatar.jpg'
	},


});

var account = new Account();
