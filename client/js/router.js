/*
 * THE GLOBALS
 */
var app = null;
var activeStream = new Stream({
	id : '1',
	displayName : 'Engineering'
});

/**
 * Since streamId and accountId are very frequently used, move them out for
 * faster access
 */
var streamId = activeStream.get('id');
var accountId = account.get('id');
var activeMenu = null;
var mView = new ModalView();
var timer = new Timer(1000, null, []); // we will have just one global timer

$(document).ready(function() {
	helper.loadTemplate(Config.viewsArray, function() {
		(function(d) {
			var js, id = 'facebook-jssdk';
			if (d.getElementById(id)) {
				return;
			}
			js = d.createElement('script');
			js.id = id;
			js.async = true;
			js.src = "//connect.facebook.net/en_US/all.js";
			d.getElementsByTagName('head')[0].appendChild(js);
		}(document));
		account.isAuth();
	});
});

var AppRouter = Backbone.Router.extend({

	routes : {
		"" : "dashboard",
		"landing" : "landing",
		"signUp" : "signUp",
		"quizLibrary" : "quizLibrary",
		"facDirectory" : "facDirectory",
		"quizResults/:id" : "quizResults",
		"quiz/:id" : "startQuiz",
		"fac/:id" : "fac",
		"packages" : "packages",
		"forgotpass" : "forgotPass",
		"changepass" : "changePass",
		"facContact" : "facContact",
		"review" : "review",
	},

	initialize : function() {
		// fetch all the initial data here
		Manager.getSubjectsByStreamId(streamId);
		this.headerView = new HeaderView({
			el : $('header'),
			model : account
		});
		this.footerView = new FooterView({
			el : $('footer'),
		});

	},

	landing : function() {
		new LandingView({
			el : $('#content')
		});
		$('#packages-menu').hide();
		$('#home-menu').hide();
		$('#' + activeMenu).removeClass('active');
		return;
	},

	dashboard : function() {
		// check if authenticated move to dashboard page, else move to landing
		// page
		if (account.get('id') != null) {
			Manager.getDashboardData();
			$('#packages-menu').show();
			$('#home-menu').show();
			this.changeMenu('home-menu');
		} else {
			window.location = '#landing';
		}
	},

	quizLibrary : function() {
		Manager.getDataForQuizLibrary(streamId);
		this.changeMenu('quiz-menu');
	},

	packages : function() {
		Manager.getPackagesByStreamId(streamId);
		this.changeMenu('packages-menu');
	},

	facDirectory : function() {
		// if streamId is set
		if (streamId) {
			Manager.getFacByStreamId(streamId);
		} else {
			// get a generic faculty list
			alert('generic list of fac');
		}
		this.changeMenu('fac-menu');
	},
	
	review : function() {
		Manager.getDataForReview();
		this.changeMenu('review-menu');
	},
	
	fac : function(id) {
		Manager.getFaculty(id);
	},

	facContact : function() {
		Manager.getFacContactPage();
	},

	/** 
	 * @param id
	 */
	startQuiz : function(id) {
		if (account.get('id') != null) {
			mView.close();
			Manager.getQuizDataForStart(id);
		} else {
			window.location = '#quizLibrary';
		}
	},

	quizResults : function(id) {
		// pick from history
		Manager.getQuizDataForResults(id);
	},

	changePass : function() {
		console.log('changing pass');
		// load forgot password page
		var changePassView = new ChangePassView({
			model : account
		});
		this.showView(changePassView);
	},

	forgotPass : function() {
		console.log('forgot pass');
		// load forgot password page
		var forgotPassView = new ForgotPassView({
			model : account
		});
		this.showView(forgotPassView);
	},
	
	signUp : function (){
		if(account.get('id')!=null){
			account.logout();
			$('#sign-up').html('<a href="#signUp">Log Out</a>');
		}
		var signUpView = new SignUpView({
			model : account
		});
		this.showView('#content', signUpView);
		signUpView.onRender();
	},
	
	showView : function(selector, view) {
		if (this.activeView)
			this.activeView.close();
		$(selector).html(view.render().el);
		this.activeView = view;
		return view;
	},
	
	changeMenu : function(newMenu) {
		if (activeMenu != null) {
			$('#' + activeMenu).removeClass('active');
		}
		activeMenu = newMenu;
		$('#' + activeMenu).addClass('active');
		if (account.get('id') == null) {
			$('#sign-up').html('<a href="#signUp">Sign-Up</a>');
			//$('#log-in').show();
		} else {
			$('#sign-up').html('<a href="#signUp">Log Out</a>');
		}
	}
});

Backbone.View.prototype.close = function() {
	this.remove();
	this.unbind();
};