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

var account = new Account({
	id : '1',
	firstName : 'Shikhar',
	lastName : 'Sachan',
	streamId : '1',
	quizzesAttempted : '1|:2|:3'
});

var id = account.get('id')+'|'+activeStream.get('id');

var timer = new Timer(1000, null, []); // we will have just one global timer
										// object shared across quizzes and
										// practice

$(document).ready(function() {
	helper.loadTemplate(Config.viewsArray, function() {
		app = new AppRouter();
		Backbone.history.start();
	});
});

var AppRouter = Backbone.Router.extend({

	routes : {
		"":"dashboard",
		"quizLibrary" : "quizLibrary",
		"facDirectory" : "facDirectory",
		"quizResults/:id" : "quizResults",
		"quizDetails/:id/p:qno" : "quizDetails",
		"quiz/:id" : "startQuiz",
		"fac/:id":"fac",
	},

	initialize : function() {
		//fetch all the initial data here
		Manager.getSubjectsByStreamId(streamId);
		this.headerView = new HeaderView({
			el : $('header')
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
		Manager.getDashboardData();
	},

	quizLibrary : function() {
		Manager.getQuizzesByStreamId(streamId);
	},
	
	facDirectory : function() {
		//if streamId is set
		if(streamId){
			Manager.getFacByStreamId(streamId);
		}else{
			// get a generic faculty list
			alert('generic list of fac');
		}
	},
	
	fac : function(id){
		Manager.getFaculty(id,streamId);
	},
	
	startQuiz : function(id) {
		activeQuiz = quizLibrary.get(id); // active quiz initialized for the first time
		Manager.getQuizDataForStart(activeQuiz);
	},
	
	quizResults : function(id) {
			// pick from history
		var quiz = quizHistory.get(id);
		if(quiz){
			Manager.getQuizDataForResults(quiz);
		}else{
			alert('access denied');
		}
	},
	

});