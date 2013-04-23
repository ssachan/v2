//cat accounts.js streams.js questions.js quizzes.js fac.js packages.js sections.js scores.js logs.js > models.js
window.Account = Backbone.Model.extend({

	defaults : {
		id : null,
		quizzesAttempted : null,
		paid : '0',
		dpUrl : DP_PATH + 'avatar.jpg'
	},

	urlRoot : ' ',

	initialize : function() {
		if (!this.get('quizzesAttemptedArray')) {
			this.set({
				quizzesAttemptedArray : new Array()
			});
		}

		this.on('change:quizzesAttempted', function(model) {
			model.get('quizzesAttemptedArray').length = 0;
			if (model.get('quizzesAttempted') != null
					&& model.get('quizzesAttemptedArray')) {
				model.get('quizzesAttemptedArray').push.apply(this
						.get('quizzesAttemptedArray'), JSON.parse(model
						.get('quizzesAttempted')));
			}
		});

		this.on('change:dp', function(model) {
			if (model.get('dp') == true) {
				model.set('dpUrl', DP_PATH + model.get('id') + '.jpg');
			} else {
				model.set('dpUrl', DP_PATH + 'avatar.jpg');
			}
		});

		// var that = this;
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
					helper.track("login",{"id":account.get('id'),'email':account.get('email'), 'name' : account.get('firstName')
				    });	
					window.location = '#';
				} else {
					helper.processStatus(data);
				}
			},
			error : function(data) {
				eval('var obj='+data.responseText);
				helper.processStatus(obj);
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
					// window.location.replace('#landing');
					if (user) {
						user.clear();
					}
					account.reset();
					account.get('quizzesAttemptedArray').length = 0;
					activeQuiz = null;
					var signUpView = new SignUpView({
						model : account
					});
					app.showView('#content', signUpView);
					signUpView.onRender();
				}
				helper.processStatus(data);
			},
			error : function(data) {
				eval('var obj='+data.responseText);
				helper.processStatus(obj);
			},
		});
	},

	invite : function(inputValues) {
		// Do a POST to /login and send the creds
		var url = Config.serverUrl + 'invite';
		console.log('invite up... ');
		$.ajax({
			url : url,
			type : 'POST',
			dataType : "json",
			data : inputValues,
			success : function(data) {
				helper.processStatus(data);
			},
			error : function(data) {
				eval('var obj='+data.responseText);
				helper.processStatus(obj);
			},
		});
	},

	fblogin : function(inputValues) {
		// Do a POST to /login and send the creds
		var url = Config.serverUrl + 'fblogin';
		console.log('fb up... ');
		$.ajax({
			url : url,
			type : 'POST',
			dataType : "json",
			data : inputValues,
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					account.set(data.data);
					helper.track("login",{"id":account.get('id'),'email':account.get('email'), 'name' : account.get('firstName')
				    });
				    window.location = '#';
				} else {
					helper.processStatus(data);
				}
			},
			error : function(data) {
				eval('var obj='+data.responseText);
				helper.processStatus(obj);
			},
		});
	},
	
	ccSignUp : function(inputValues) {
		// Do a POST to /login and send the creds
		var url = Config.serverUrl + 'ccsignup';
		console.log('signing up... ');
		$.ajax({
			url : url,
			type : 'POST',
			dataType : "json",
			data : inputValues,
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					account.set(data.data);
					helper.track("csup",{"id":account.get('id'),
				        "ccode": inputValues.ccode, 'email':account.get('email')
				    });
					window.location = '#';
				} else {
					helper.processStatus(data);
				}
			},
			error : function(data) {
				eval('var obj='+data.responseText);
				helper.processStatus(obj);
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
					helper.track("sup",{"id":account.get('id'),'email':account.get('email'), 'name' : account.get('firstName')
				    });
					window.location = '#';
				} else {
					helper.processStatus(data);
				}
			},
			error : function(data) {
				eval('var obj='+data.responseText);
				helper.processStatus(obj);
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
				helper.processStatus(data);
			},
			error : function(data) {
				eval('var obj='+data.responseText);
				helper.processStatus(obj);
			},
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
				newpassword : newpassword,
				accountId : this.get('id')
			},
			success : function(data) {
				helper.processStatus(data);
			},
			error : function(data) {
				eval('var obj='+data.responseText);
				helper.processStatus(obj);
			},
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

});

var account = new Account();
