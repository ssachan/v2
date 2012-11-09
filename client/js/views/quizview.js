/**
 * The quiz views
 * 
 * @author ssachan
 * 
 */

window.QuizView = Backbone.View.extend({

	initialize : function() {
		var context = this;
		this.index = this.options.index;
		this.questionView = null;
		this.question = null;
		this.questionIds = this.model.getQuestionIds();
		this.totalQuestions = this.questionIds.length;
		this.hasAttempted = this.model.get('hasAttempted');
		if(this.hasAttempted){
			this.setUp();
		}
		timer.setUpdateFunction(context.updateQuizTimer, [ context ]);
		this.currentView = '';
		this.render();
	},
	

	setUp : function(){
		this.answersSelected = this.model.getSelectedAnswers();
		this.getTimeTakenPerQuestion = this.model.getTimeTakenPerQuestion();
		for(var i=0;i<this.totalQuestions;i++){
			var question = quizQuestions.get(this.questionIds[i]);
			if(question.get('timeTaken')==null){
				question.set('timeTaken', this.answersSelected[i]);
				question.set('optionSelected',this.answersSelected[i]);
			}
		}
	},
	
	switchView : function(view){
		if(this.currentView==''){
			this.currentView = view;
			$('#'+this.currentView+'-div').show();
			return;
		}
		$('#'+this.currentView+'-div').hide();
		this.currentView = view;
		$('#'+this.currentView+'-div').show();
	},
	
	events : {
		'click #previous' : 'onPreviousClick',
		'click #next' : 'onNextClick',
		'click .qnolist' : 'onQNoClick',
		'click #submit' : 'submitQuiz',
		'click #analytics' : 'switchAnalytics'
	},

	switchAnalytics : function(){
		this.switchView('results');
	},
	
	startQuiz: function (){
		this.renderQuestion();
		if (!this.hasAttempted) {
			timer.reset();
			timer.start();
		}
		this.switchView('quiz');
	},
	
	submitQuiz : function() {
		timer.stop();
		this.model.set('timeTaken', timer.count);
		this.model.calculateScores();
		this.hasAttempted=true;
		this.model.submitResults();
		$('#results-div').hide();
		$('#quiz-div').show();
		this.renderResults();
	},
	
	updateQuizTimer : function(context) {
		$('#time').html(helper.formatTime(timer.count));
		var qtimer = context.question.get('timeTaken');
		qtimer++;
		context.question.set('timeTaken', qtimer);
		if (timer.count == context.model.get('allotedTime')) {
			alert('time up');
			this.submitQuiz();
		}
	},

	onPreviousClick : function() {
		if(!this.hasAttempted){
			this.question.get('closeTimeStamps').push(new Date().getTime());
		}
		this.index--;
		if (this.index < 0) {
			return;
		}
		this.renderQuestion();
		$('#previous').show();
		$('#next').show();
		if (this.index == 0) {
			$('#previous').hide();
		}else{
			$('#previous').show();
		}
	},

	onNextClick : function() {
		if(!this.hasAttempted){
			this.question.get('closeTimeStamps').push(new Date().getTime());
		}
		this.index++;
		if (this.index >= this.totalQuestions) {
			return;
		}
		this.renderQuestion();
		$('#previous').show();
		$('#next').show();
		if (this.index == (this.totalQuestions - 1)) {
			$('#next').hide();
		}else{
			$('#next').show();
		}
	},

	onQNoClick : function(e) {
		this.index = e.target.getAttribute('id'); // .split('-')[1];
		if(!this.hasAttempted){
			this.question.get('closeTimeStamps').push(new Date().getTime());
		}
		this.switchView('quiz');
		this.renderQuestion();
	},

	render : function() {
		$(this.el).html(this.template({
			'totalQuestions' : this.totalQuestions,
			'hasAttempted' :this.hasAttempted,
		}));
		$('#quiz-view').hide();
		$('#results-view').hide();
		return this;
	},
	
	
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
		this.questionView.model = this.question;
		this.questionView.hasAttempted = this.hasAttempted;
		this.questionView.render();
		$("#qnum").html((parseInt(this.index) + 1));
		$("#qtotal").html((this.totalQuestions));
		this.question.get('openTimeStamps').push(new Date().getTime());
		return null;
	},
	
	renderResults : function (){
		this.switchView('results');
		new QuizResultsView({
			model : this.model,
			el : $('#results-div')
		});
	}
});

window.QuizQuestionView = Backbone.View
		.extend({

			initialize : function() {
			},

			events : {
				'click div.btn-group button' : 'onOptionSelection'
			},

			onOptionSelection : function(e) {
				var oldOptionSelected = this.model.get('optionSelected');
				var optionSelected = e.target.value;
				if (optionSelected == oldOptionSelected) {
					this.model.set('optionSelected', null);
					if (!this.model.get('optionUnSelectedTimeStamps')[optionSelected]) {
						this.model.get('optionUnSelectedTimeStamps')[optionSelected] = new Array();
					}
					(this.model.get('optionUnSelectedTimeStamps')[optionSelected])
							.push(new Date().getTime());
				} else {
					this.model.set('optionSelected', optionSelected);
					if (!this.model.get('optionSelectedTimeStamps')[optionSelected]) {
						this.model.get('optionSelectedTimeStamps')[optionSelected] = new Array();
					}
					(this.model.get('optionSelectedTimeStamps')[optionSelected])
							.push(new Date().getTime());
				}
			},
			render : function() {
				$('#question').html(this.template(this.model.toJSON()));
				$('#solution').hide();
				if (this.hasAttempted) {
					this.renderInfo();
				}
				return this;
			},

			renderInfo : function() {
				$('#solution').show();
				$('#solution').html(
						'<span class="green bold">Correct Answer</span> : '
								+ this.model.get('correctAnswer'));
				$('#solution').append(
						'<br><div class="sol"><span class="green bold">Solution</span> : '
								+ this.model.get('explanation') + '</div>');
				$('#solution')
						.append(
								'<br><div class="stats"><span class="green bold">Average Correct</span>:'+ this.model.get('averageCorrect')+'<span class="green bold"> Average Time</span> :'+ this.model.get('averageTimeCorrect')+'<span class="badge badge-success">2012 CAT</span></div>');
				//code to add video here.
				
				/*
					<video id="analysis_video" class="video-js vjs-default-skin" controls preload="none" width="640" height="264" poster="<%= this.model.get('videoData').poster %>" data-setup="{}">
                			<source src="<%= this.model.get('videoData').src %>" type='video/mp4' />
            			</video>
				*/


				$('#time').html(this.model.get('timeTaken'));
				$('#submit').hide();
			}

		});

window.QuizResultsView = Backbone.View.extend({
	initialize : function() {
		this.activeInsights = 'time';
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


	calculateVideoArray : function(options){

		var videoResults = Array(
			 {
			 	
				thumb_url : 'img/video1.jpg',
				poster_url : 'img/video1.jpg',
				sources : [{
					src : 'videos/video1.mp4',
					type : "video/mp4",
					title : 'analysisVideo',
					media : ''
				}]
			},
			{
			 	
				thumb_url : 'img/video2.jpg',
				poster_url : 'img/video2.jpg',
				sources : [{
					src : 'videos/video2.mp4',
					type : "video/mp4",
					title : 'q1',
					media : ''
					}]
			},
			 {
			 	
				thumb_url : 'img/video1.jpg',
				poster_url : 'img/video1.jpg',
				sources : [{
									src : 'videos/video1.mp4',
									type : "video/mp4",
									title : 'q2',
									media : ''
							}]
			}			
		);


		

		//a video object has el,src,poster

		//this is an implementation to select one of 6 possible videos.
		//if we're not editing those 6 videos, I will need a series of clips and
		//add a handler to the _V_("video-analysis").addEvent("ended",handler)
		//will have to add an indicator to let people know video remaining.

		//Currently assuming we have those, let's get down to the dirty work

		//I need to know marks. 

		return videoResults;

	},

	setUpPlaylist : function(videoResults){

		var videoOptions = {"playlist": videoResults}
		var myPlayer = _V_("video_analysis",videoOptions);
		
		myPlayer.addEvent("ended",function(){myPlayer.playlist.next()}); //enables autoplay of next
		

	},

	render : function() {
		// var questionIds = this.model.getQuestionIds();
		var score = this.model.get('totalScore');
		var length = quizQuestions.length;
		var correct = this.model.get('totalCorrect');
		var incorrect = this.model.get('totalIncorrect');
		var unattempted = parseInt(length)
				- (parseInt(correct) + parseInt(incorrect));
		var accuracyInsights = insights.accuracyInsights(this.model);
		var difficultyInsights = insights.difficultyLevelInsights(this.model);
		var strategicInsights = insights.strategicInsights(this.model);
		var historyInsights = 'they come here';
		
		//video array containing all data for all questions and analysis
		var videoResults = this.calculateVideoArray();
		
		$(this.el).html(this.template({
			'id' : this.model.get('id'),
			'totalQuestions' : length,
			'score':score,
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
		$("tspan:contains('Highcharts.com')").hide();
		return this;
	}
});
