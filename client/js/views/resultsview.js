window.ResultsView = Backbone.View.extend({

	initialize : function() {
		this.index = this.options.index;
		this.questionView = null;
		this.question = null;
		this.questionIds = this.model.getQuestionIds();
		this.totalQuestions = this.questionIds.length;
		this.setUp();
		this.currentView = '';
	},

	setUp : function() {
		this.answersSelected = this.model.getSelectedAnswers();
		this.getTimeTakenPerQuestion = this.model.getTimeTakenPerQuestion();
		for ( var i = 0; i < this.totalQuestions; i++) {
			var question = quizQuestions.get(this.questionIds[i]);
			if (question.get('timeTaken') == null) {
				question.set('timeTaken', this.answersSelected[i]);
				question.set('optionSelected', this.answersSelected[i]);
			}
		}
	},

	/**
	 * TODO:video - check if the view variable is results or quiz. Have another
	 * reference to the results page video.
	 */
	switchView : function(view) {
		if (this.currentView == '') {
			this.currentView = view;
			$('#' + this.currentView + '-div').show();
			return;
		}
		$('#' + this.currentView + '-div').hide();
		this.currentView = view;
		$('#' + this.currentView + '-div').show();
	},

	events : {
		'click #previous' : 'onPreviousClick',
		'click #next' : 'onNextClick',
		'click .qnolist' : 'onQNoClick',
		'click #analytics' : 'switchAnalytics'
	},

	switchAnalytics : function() {
		this.switchView('results');
	},

	onPreviousClick : function() {
		this.index--;
		if (this.index < 0) {
			return;
		}
		this.renderQuestion();
	},

	onNextClick : function() {
		this.index++;
		if (this.index >= this.totalQuestions) {
			return;
		}
		this.renderQuestion();
	},

	onQNoClick : function(e) {
		this.index = e.target.getAttribute('id'); // .split('-')[1];
		this.switchView('quiz');
		this.renderQuestion();
	},

	render : function() {
		$(this.el).html(this.template({
			'totalQuestions' : this.totalQuestions,
			'hasAttempted' : this.hasAttempted,
		}));
		$('#quiz-view').hide();
		$('#results-view').hide();
		return this;
	},

	/**
	 * TODO:video - just store the reference of the current video
	 */
	renderQuestion : function() {
		this.question = quizQuestions.get(this.questionIds[this.index]);
		if (this.question.get('timeTaken') == null) {
			this.question.set('timeTaken', 0);
		}
		if (this.questionView == null) {
			this.questionView = new QuizQuestionView({
				el : $('#question'),
			});
		}
		this.question.set('hasAttempted',true);
		this.questionView.model = this.question;
		this.questionView.render();
		$("#qnum").html((parseInt(this.index) + 1));
		$("#qtotal").html((this.totalQuestions));
		$('#previous').show();
		$('#next').show();
		if (this.index == 0) {
			$('#previous').hide();
		} else if(this.index == (this.totalQuestions - 1)){
			$('#next').hide();
		}
		return null;
	},

	renderResults : function() {
		this.switchView('results');
		new QuizResultsView({
			model : this.model,
			el : $('#results-div')
		});
	}
});


window.QuizResultsView = Backbone.View.extend({
	initialize : function() {
		this.activeInsights = 'timeTaken';
		this.render();
	},

	events : {
		'click .insightItem' : 'onInsightClick',
	},

	onInsightClick : function(e) {
		$('#' + this.activeInsights).parent().removeClass('active');
		$('#' + this.activeInsights + '-div').hide();
		this.activeInsights = e.target.getAttribute('id');
		$('#' + this.activeInsights + '-div').show();
		$('#' + this.activeInsights).parent().addClass('active');
	},

	calculateVideoArray : function(options) {

		var videoResults = Array({

			thumb_url : 'img/video1.jpg',
			poster_url : 'img/video1.jpg',
			sources : [ {
				src : 'videos/video1.mp4',
				type : "video/mp4",
				title : 'analysisVideo',
				media : ''
			} ]
		}, {

			thumb_url : 'img/video2.jpg',
			poster_url : 'img/video2.jpg',
			sources : [ {
				src : 'videos/video2.mp4',
				type : "video/mp4",
				title : 'q1',
				media : ''
			} ]
		}, {

			thumb_url : 'img/video3.jpg',
			poster_url : 'img/video3.jpg',
			sources : [ {
				src : 'videos/video3.mp4',
				type : "video/mp4",
				title : 'q2',
				media : ''
			} ]
		}, {

			thumb_url : 'img/video4.jpg',
			poster_url : 'img/video4.jpg',
			sources : [ {
				src : 'videos/video3.mp4',
				type : "video/mp4",
				title : 'q2',
				media : ''
			} ]
		}, {

			thumb_url : 'img/video4.jpg',
			poster_url : 'img/video4.jpg',
			sources : [ {
				src : 'videos/video4.mp4',
				type : "video/mp4",
				title : 'q2',
				media : ''
			} ]
		});

		// a video object has el,src,poster

		// this is an implementation to select one of 6 possible videos.
		// if we're not editing those 6 videos, I will need a series of clips
		// and
		// add a handler to the _V_("video-analysis").addEvent("ended",handler)
		// will have to add an indicator to let people know video remaining.

		// Currently assuming we have those, let's get down to the dirty work

		// I need to know marks.

		return videoResults;

	},

	setUpPlaylist : function(videoResults) {

		var videoOptions = {
			"playlist" : videoResults
		}
		var myPlayer = _V_("video_analysis", videoOptions);

		myPlayer.addEvent("ended", function() {

			myPlayer.playlist.next()

		}); // enables autoplay of next

	},

	render : function() {
		// var questionIds = this.model.getQuestionIds();
		var score = this.model.get('totalScore');
		var length = quizQuestions.length;
		var correct = this.model.get('totalCorrect');
		var incorrect = this.model.get('totalIncorrect');
		var unattempted = parseInt(length)
				- (parseInt(correct) + parseInt(incorrect));
		var accuracyInsights = '';// insights.accuracyInsights(this.model);
		var difficultyInsights = '';// insights.difficultyLevelInsights(this.model);
		var strategicInsights = insights.strategicInsights(this.model);
		var historyInsights = '';

		// video array containing all data for all questions and analysis
		var videoResults = this.calculateVideoArray();

		$(this.el).html(this.template({
			'id' : this.model.get('id'),
			'totalQuestions' : length,
			'score' : score,
			'correct' : correct,
			'incorrect' : incorrect,
			'unattempted' : unattempted,
			'totalTime' : helper.formatTime(this.model.get('allotedTime')),
			'timeTaken' : helper.formatTime(this.model.get('timeTaken')),
			'avgTime' : '1 min 30 secs',
			'accuracyInsights' : accuracyInsights,
			'strategicInsights' : strategicInsights,
			'historyInsights' : historyInsights,
			'difficultyInsights' : difficultyInsights,
			'videoResults' : videoResults
		}));

		this.setUpPlaylist(videoResults);

		drawTimeChart(this.model);
		drawDifficultyChart(this.model);
		drawHistoryChart(this.model);
		// drawStratChart(this.model);
		$('#difficulty-div').hide();
		$('#history-div').hide();
		$('#strategy-div').hide();
		$('#' + this.activeInsights).parent().addClass('active');
		$("tspan:contains('Highcharts.com')").hide();
		return this;
	}
});
