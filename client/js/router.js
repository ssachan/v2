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

var activeView = null;

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
		"signup" : "signUp",
		"library" : "library",
		"facs" : "facs",
		"quiz/:id" : "quiz",
		"fac/:id" : "fac",
		"packages" : "packages",
		"forgotpass" : "forgotPass",
		"changepass" : "changePass",
		"facContact" : "facContact",
		"review" : "review",
		"myprepsets" : "myprepsets",
		"rsquare" : "rsquare",
		"activity" : "activity",
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
		return;
	},

	dashboard : function() {
		// check if authenticated move to dashboard page, else move to landing
		// page
		if(account.get('id')!=null){
			Manager.getDashboardData();
			$('#signup-menu>a').html('Log Out');
			$('#myprepset-menu').show();
		}else{
			window.location = '#landing';
			$('#signup-menu>a').html('Sign Up');
			$('#myprepset-menu').hide();
		}
	},

	library : function() {
		this.changeMenu('lib-menu');
		Manager.getDataForQuizLibrary(streamId);
	},

	facs : function() {
		this.changeMenu('fac-menu');
		// if streamId is set
		if (streamId) {
			Manager.getFacByStreamId(streamId);
		} else {
			// get a generic faculty list
			alert('generic list of fac');
		}
	},
	
	rsquare : function (){
		Manager.getRSquareData();
	},
	
	activity : function(){
		Manager.getDataforActivity();
	},
	
	packages : function() {
		this.changeMenu('packages-menu');
		Manager.getPackagesByStreamId(streamId);
	},

	review : function() {
		Manager.getDataForReview();
	},
	
	myprepsets : function (){
		Manager.getDataForMySets();
	},
	
	fac : function(id) {
		Manager.getFaculty(id);
	},

	facContact : function() {
		Manager.getFacContactPage();
	},
	
	quiz : function(id) {
		if (account.get('id') != null) {
			mView.close();
			Manager.getDataForQuiz(id);
		} else {
			window.location = '#quizLibrary';
		}
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
		this.showView('#content',forgotPassView);
	},

	signUp : function() {
		mView.close();
		this.changeMenu('signup-menu');
		$('#signup-menu>a').html('Sign Up');
		$('#myprepset-menu').hide();
		if (account.get('id') != null) {
			account.logout();
		}else{
			var signUpView = new SignUpView({
				model : account
			});
			app.showView('#content', signUpView);
			signUpView.onRender();
		} 
	},

	showView : function(selector, view) {
		if (activeView)
			activeView.close();
		$(selector).html(view.render().el);
		activeView = view;
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
		} else {
			$('#sign-up').html('<a href="#signUp">Log Out</a>');
		}
	}
});

Backbone.View.prototype.close = function() {
	this.remove();
	this.unbind();
};