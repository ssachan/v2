window.ResultsView = Backbone.View.extend({

	initialize : function() {
		this.activeView=null;
	},
	
	events : {
		'click .resnav>li' : 'onNavClick',
	},

	render : function() {
		$(this.el).html(this.template());
		return this;
	},

	onRender : function() {
		// render all views
		var analysisView = new ResultAnalysisView({model:this.model});
		$('#analysis-div').html(analysisView.render().el);
		analysisView.onRender();
		var graphsView = new ResultGraphsView({model:this.model});
		$('#graphs-div').html(graphsView.render().el);
		graphsView.onRender();
		var solutionView = new SolutionsView({model:this.model, index : 0,});
		$('#solutions-div').html(solutionView.render().el);
		solutionView.renderQuestion();
		$('#analysis-div').hide();
		$('#graphs-div').hide();
		$('#solutions-div').hide();
		this.switchView('analysis');
	},
	
	onNavClick : function(e) {
		this.switchView(e.currentTarget.getAttribute('id'));
	},
	
	switchView : function(view){
		if(this.activeView!=null){
			$('#' + this.activeView).removeClass('active');
			$('#' + this.activeView + '-div').hide();
		}
		this.activeView = view;
		$('#' + this.activeView + '-div').show();
		$('#' + this.activeView).addClass('active');
	}
});

window.ResultAnalysisView = Backbone.View.extend({
	initialize : function() {
	},

	calculateVideoArray : function(options) {

		videoResults = array();
		
		_.each(options,function(item)
		{
			videoResultObject = {
				thumb_url : item.posterSrc,
				poster_url : item.posterSrc,
				sources : [ {
					src : item.videoSrc,
					type : "video/mp4",
					title : (item.title || ""),
					media : ''
				} ]
			};
			videoResults.push(videoResultObject);
		});
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
		var videoResults = this.calculateVideoArray(this.model.get('videoArray'));

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
		//this.setUpPlaylist(videoResults);
		return this;
	},
	
	onRender : function(){
		drawL3Chart('l3-graph');
	}
});


window.ResultGraphsView = Backbone.View.extend({
	initialize : function() {
		this.activeInsights = '';
	},

	events : {
		'click .insightItem>.btn' : 'onInsightClick',
	},
	
	switchView : function (view){
		$('#' + this.activeInsights + '-div').hide();
		this.activeInsights = view;
		$('#' + this.activeInsights + '-div').show();
	},
	
	onInsightClick : function(e) {
		this.switchView(e.target.getAttribute('id'));
	},

	render : function() {
		$(this.el).html(this.template());
		return this;
	},
	
	onRender : function(){
		drawTimeChart(this.model);
		drawDifficultyChart(this.model);
		$('#difficulty-div').hide();
		$('#history-div').hide();
		$('#strategy-div').hide();
		$("tspan:contains('Highcharts.com')").hide();
		this.switchView('timeTaken');
	}
});

window.SolutionsView = Backbone.View.extend({
	initialize : function() {
		this.index = this.options.index;
		this.questionView = null;
		this.question = null;
		this.questionIds = this.model.getQuestionIds();
		this.totalQuestions = this.questionIds.length;
		this.setUp();
	},

	setUp : function() {
		this.answersSelected = this.model.getSelectedAnswers();
		this.getTimeTakenPerQuestion = this.model.getTimeTakenPerQuestion();
		for ( var i = 0; i < this.totalQuestions; i++) {			
			var question = quizQuestions.get(this.questionIds[i]);
	        if (this.getTimeTakenPerQuestion[i] != null) {
	            // mark this question
	            question.set('timeTaken', this.getTimeTakenPerQuestion[i]);
	            question.set('optionSelected', this.answersSelected[i]);
	            question.set('hasAttempted', true);
	        }
		}
	},

	events : {
		'click #previous' : 'onPreviousClick',
		'click #next' : 'onNextClick',
		'click .qnolist' : 'onQNoClick',
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
		$('#'+this.index).removeClass('active');
        this.index = e.currentTarget.getAttribute('id');
        this.renderQuestion();
	},

	render : function() {
		$(this.el).html(this.template({
			'totalQuestions' : this.totalQuestions,
			'hasAttempted' : this.hasAttempted,
		}));
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
});
