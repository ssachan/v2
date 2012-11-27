/*
 * THE GLOBALS
 */
var app = null;
var activeQuiz = null;

var activeStream = new Stream({
	id : '1',
	displayName : 'Engineering'
});
var streamId = activeStream.get('id');
var mView = new ModalView();

var timer = new Timer(1000, null, []); // we will have just one global timer
var activeMenu = null;

$(document).ready(function() {
	helper.loadTemplate(Config.viewsArray, function() {
		app = new AppRouter();
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
		Backbone.history.start();
	});
});

var AppRouter = Backbone.Router.extend({

	routes : {
		"" : "dashboard",
		"landing" : "landing",
		"login" : "login",
		"quizLibrary" : "quizLibrary",
		"facDirectory" : "facDirectory",
		"quizResults/:id" : "quizResults",
		"quiz/:id" : "startQuiz",
		"fac/:id" : "fac",
		"packages" : "packages",
		"forgotpass" : "forgotPass",
		"changepass" : "changePass"
	},

	initialize : function() {
		// fetch all the initial data here
		Manager.getSubjectsByStreamId(streamId);
		this.headerView = new HeaderView({
			el : $('header'),
			model : account
		});
	},

	landing : function() {
		new LandingView({
			el : $('#content')
		});
		$('#log-in').html((new LoginView({model:account})).el);
		$('#packages-menu').hide();
		$('#home-menu').hide();
		$('#'+activeMenu).removeClass('active');
		return;
	},

	dashboard : function() {
		// check if authenticated move to dashboard page, else move to landing page
		mView.close();
		if (account.get('id') != null) {
			Manager.getDashboardData();
			$('#packages-menu').show();
			$('#home-menu').show();
			this.changeMenu('home-menu');
		}else{
			account.isAuth();
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

	fac : function(id) {
		Manager.getFaculty(id);
	},

	/**
	 * TODO:at this point there are separate routes for start and results but
	 * later we might want to merge them to same route #quiz...it displays the
	 * results when the quiz is attempted else starts the quiz.
	 * 
	 * @param id
	 */
	startQuiz : function(id) {
		if (account.get('id') != null) {
			mView.close();
			Manager.getQuizDataForStart(id);
		} else {
			window.location.replace('#quizLibrary');
		}
	},

	quizResults : function(id) {
		// pick from history
		var quiz = quizHistory.get(id);
		if (quiz) {
			Manager.getQuizDataForResults(quiz);
		} else {
			alert('access denied');
		}
	},
	
	changePass: function() {
		console.log('changing pass');
		// load forgot password page
		var changePassView = new ChangePassView({model:account});
		this.showView(changePassView);
	},
	
	forgotPass : function() {
		console.log('forgot pass');
		// load forgot password page
		var forgotPassView = new ForgotPassView({model:account});
		this.showView(forgotPassView);
	},
	
	showView : function(view) {
		if (this.currentView)
			this.currentView.close();
		this.currentView = view;
		$('#content').html((this.currentView.render()).el);
	},
	
	changeMenu : function(newMenu){
		if (activeMenu!=null){
			$('#'+activeMenu).removeClass('active');
		}
		activeMenu = newMenu;
		$('#'+activeMenu).addClass('active');
		if (account.get('id') == null) {
			$('#log-in').show();
		}else{
			$('#log-in').hide();
		}
	}
});

Backbone.View.prototype.close = function() {
	this.remove();
	this.unbind();
};