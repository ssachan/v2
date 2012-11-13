/*
 * THE GLOBALS
 */
var app = null;
var activeQuiz = null;
var currentQuizQuestion = null;

var activeStream = new Stream({
	id : '1',
	displayName : 'Engineering'
});
var streamId = activeStream.get('id');
var mView = new ModalView();

var id = null;// account.get('id')+'|'+activeStream.get('id');

var timer = new Timer(1000, null, []); // we will have just one global timer
// object shared across quizzes and
// practice

$(document).ready(function() {
	helper.loadTemplate(Config.viewsArray, function() {
		app = new AppRouter();
		/*
		 * (function (d) { var js, id = 'facebook-jssdk'; if
		 * (d.getElementById(id)) { return; } js = d.createElement('script');
		 * js.id = id; js.async = true; js.src =
		 * "//connect.facebook.net/en_US/all.js";
		 * d.getElementsByTagName('head')[0].appendChild(js); }(document));
		 */
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
		"forgotPass" : "forgotPass"
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
		// if authenticated, move to dashboard, else display the login page
		new LandingView({
			el : $('#content')
		});
		return;
	},

	dashboard : function() {
		// check if authenticated move to dashboard page, else move to landing
		// page
		if (account.get('id') != null) {
			Manager.getDashboardData();
		} else {
			account.isAuth();
		}
	},

	quizLibrary : function() {
		Manager.getQuizzesByStreamId(streamId);
	},

	packages : function() {
		Manager.getPackagesByStreamId(streamId);
	},

	facDirectory : function() {
		// if streamId is set
		if (streamId) {
			Manager.getFacByStreamId(streamId);
		} else {
			// get a generic faculty list
			alert('generic list of fac');
		}
	},

	fac : function(id) {
		Manager.getFaculty(id, streamId);
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
			window.location.replace('#');
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

	forgotPass : function() {
		console.log('forgot pass');
		// load forgot password page
	},

	showView : function(view) {
		if (this.currentView)
			this.currentView.close();
		this.currentView = view;
		$('#content').html((this.currentView.render()).el);
	},

});

Backbone.View.prototype.close = function() {
	this.remove();
	this.unbind();
};