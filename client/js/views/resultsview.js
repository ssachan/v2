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
		solutionView.onRender();
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
		$('#' + this.activeView + '-div').slideDown();
		$('#' + this.activeView).addClass('active');
	}
});

window.ResultAnalysisView = Backbone.View.extend({
	initialize : function() {
	},

	calculateVideoArray : function(options) {

		var videoResults = [];
		
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

		var firstVideo = videoResults[0];

		var videoOptions = {
			"techOrder": ["flash"],
			"poster" : firstVideo.thumb_url,
			"playlist" : videoResults
		};

		console.log(videoOptions);
		var myPlayer = _V_("results_video", videoOptions);

		myPlayer.src(firstVideo.sources);

		myPlayer.addEvent("ended", function() {

			myPlayer.playlist.next();

		}); // enables autoplay of next

	},

	render : function() {
		// var questionIds = this.model.getQuestionIds();
		var score = this.model.get('score');
		var length = quizQuestions.length;
		var correct = this.model.get('numCorrect');
		var incorrect = this.model.get('numIncorrect');
		var unattempted = parseInt(length)
				- (parseInt(correct) + parseInt(incorrect));
		var accuracyInsights = '';// insights.accuracyInsights(this.model);
		var difficultyInsights = '';// insights.difficultyLevelInsights(this.model);
		var strategicInsights = ''; //insights.strategicInsights(this.model);
		var historyInsights = '';

		// video array containing all data for all questions and analysis
		$(this.el).html(this.template({
			'id' : this.model.get('id'),
			'totalQuestions' : length,
			'score' : score,
			'correct' : correct,
			'incorrect' : incorrect,
			'unattempted' : unattempted,
			'maxScore' : this.model.get('maxScore'),
			'totalTime' : helper.formatTime(this.model.get('allotedTime')),
			'timeTaken' : helper.formatTime(this.model.get('timeTaken')),
			'avgTime' : '1 min 30 secs',
			'accuracyInsights' : accuracyInsights,
			'strategicInsights' : strategicInsights,
			'historyInsights' : historyInsights,
			'difficultyInsights' : difficultyInsights
		}));
		
		return this;
	},
	
	onRender : function(){
		$("#video").html('<video id="results_video" class="video-js moo-css" controls preload="none" width="640" height="264" data-setup="{}"></video>');
		var videoResults = this.calculateVideoArray(this.model.get('videoArray'));
		this.setUpPlaylist(videoResults);
		var l3GraphData = this.model.get('l3GraphData');
		if(l3GraphData){
			var html=[];
			var len = l3GraphData.length;
			for(var i=0; i< len; i++){
				var l3Data = l3GraphData[i];
				
				html.push('<div class="grey-box"><div class="row-fluid"><div class="span8">');
				html.push('<h3><span class="blue">'+(sectionL3.get(l3Data.lId)).get('displayName')+'</span><i class="icon-stop"></i><span style="font-h3  orange">'+l3Data.delta+'</span> </h3><hr>');
				html.push('<div class="progress outline">');
				if(parseInt(l3Data.delta)>0){
				html.push('<div class="bar bar-warning" style="width:'+parseInt(l3Data.scoreBefore)+'%"></div>');
				html.push('<div class="bar bar-success" style="width:'+parseInt(l3Data.delta)+'%"></div>');
				}else{
					var val = parseInt(l3Data.scoreBefore)+parseInt(l3Data.delta);
					html.push('<div class="bar bar-warning" style="width:'+val+'%"></div>');
					html.push('<div class="bar bar-danger" style="width:'+(-parseInt(l3Data.delta))+'%"></div>');
				}
				html.push('</div></div>');
				html.push('<div class="span4">');
				html.push('<div class="stats">');
				html.push('<ul class="unstyled">');
				html.push('<li><i class="icon-signal"></i>'+l3Data.numQ+' Questions</li>');
				html.push('<li><i class="icon-th-list"></i>'+l3Data.numCorrect+' Correct</li>');
				html.push('<li><i class="icon-th-list"></i>'+l3Data.numIncorrect+' Incorrect</li>');
				html.push('</ul></div></div></div></div>');
			}
			$('#topic-wise').html(html.join(' '));
		}
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
	className : 'container quizview',
	
	initialize : function() {
		this.index = this.options.index;
		this.questionView = new QuizQuestionView();
		this.question = null;
		this.questionIds = this.model.get('questionIdsArray');
		this.totalQuestions = this.questionIds.length;
		this.setUp();
	},

	setUp : function() {
		this.answersSelected = this.model.get('selectedAnswersArray');
        this.getTimeTakenPerQuestion = this.model.get('timePerQuestionArray');
		for ( var i = 0; i < this.totalQuestions; i++) {			
			var question = quizQuestions.get(this.questionIds[i]);
	        if (this.getTimeTakenPerQuestion[i] != null) {
	            // mark this question
	            question.set('timeTaken', this.getTimeTakenPerQuestion[i]);
	            question.set('optionSelected', this.answersSelected[i]);
                question.setStatus();
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

	onRender : function (){
		var len = this.questionIds.length;
		for(var i=0;i<len;i++){
			var question = quizQuestions.get(this.questionIds[i]);
			switch(question.get('status')){
				case true:
					$('#'+i).addClass('right');
					break;
				case false:
					$('#'+i).addClass('wrong');
					break;
				default : 
					$('#'+i).addClass('unattempted');
					break;
			}
		}
    },
	
	/**
	 * TODO:video - just store the reference of the current video
	 */
	renderQuestion : function() {
		this.question = quizQuestions.get(this.questionIds[this.index]);
		if (this.question.get('timeTaken') == null) {
			this.question.set('timeTaken', 0);
		}
		this.questionView.model = this.question;
		$('#question').html(this.questionView.render().el);
		this.questionView.onRender();
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
