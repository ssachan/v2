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
		timer.setUpdateFunction(context.updateQuizTimer, [ context ]);
	},
	
	events : {
		'click #previous' : 'onPreviousClick',
		'click #next' : 'onNextClick',
		'click .qnolist' : 'onQNoClick',
		'click #submit' : 'submitQuiz'
	},

	startQuiz: function (){
		this.render();
		if (this.hasAttempted) {
			timer.reset();
			timer.start();
		}
	},
	
	updateQuizTimer : function(context) {
		$('#time').html(helper.formatTime(timer.count));
		var qtimer = context.question.get('timeTaken');
		qtimer++;
		context.question.set('timeTaken', qtimer);
		if (timer.count == context.model.get('allotedTime')) {
			timer.stop();
			alert('time up');
			app.stopQuiz(context.model.get('allotedTime'));
		}
	},

	onPreviousClick : function() {
		this.question.get('closeTimeStamps').push(new Date().getTime());
		this.index--;
		if (this.index < 0) {
			return;
		}
		this.renderQuestion();
		$('#previous').show();
		$('#next').show();
		if (this.index == 0) {
			$('#previous').hide();
		}
	},

	onNextClick : function() {
		this.question.get('closeTimeStamps').push(new Date().getTime());
		this.index++;
		if (this.index >= this.totalQuestions) {
			return;
		}
		this.renderQuestion();
		$('#previous').show();
		$('#next').show();
		if (this.index == (this.totalQuestions - 1)) {
			$('#next').hide();
		}
	},

	onQNoClick : function(e) {
		this.index = e.target.getAttribute('id'); // .split('-')[1];
		this.question.get('closeTimeStamps').push(new Date().getTime());
		this.renderQuestion();
	},

	render : function() {
		$(this.el).html(this.template({
			'totalQuestions' : this.totalQuestions
		}));
		this.renderQuestion();
		return this;
	},

	submitQuiz : function() {
		timer.stop();
		app.stopQuiz(timer.count);
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
		if (this.hasAttempted && this.answersSelected.length > 0) {
			this.question.set('timeTaken', this.answersSelected[this.index]);
			this.question.set('optionSelected',
					this.answersSelected[this.index]);
		}
		this.questionView.render();
		$("#qnum").html((parseInt(this.index) + 1));
		$("#qtotal").html((this.totalQuestions));
		this.question.get('openTimeStamps').push(new Date().getTime());
		return null;
	},
	
	renderResults : function (){
		new QuizResultsView({
			model : this.model,
			el : $('#content')
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
								+ this.model.get('correctOption'));
				$('#solution').append(
						'<br><div class="sol"><span class="green bold">Solution</span> : '
								+ this.model.get('explanation') + '</div>');
				$('#solution')
						.append(
								'<br><div class="stats"><span class="green bold">Average Accuracy</span> : 50 % <span class="green bold"> Average Time</span> : 1 min <span class="green bold">Top 20% Time</span> : 30 sec <span class="badge badge-success">2012 CAT</span></div>');
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
		'click .insightItem' : 'onInsightClick'
	},

	onInsightClick : function(e) {
		$('#' + this.activeInsights).parent().removeClass('active');
		$('#' + this.activeInsights + '-div').hide();
		this.activeInsights = e.target.getAttribute('id');
		$('#' + this.activeInsights + '-div').show();
		$('#' + this.activeInsights).parent().addClass('active');
	},

	render : function() {
		// var questionIds = this.model.getQuestionIds();
		var length = quizQuestions.length;
		var correct = this.model.get('totalCorrect');
		var incorrect = this.model.get('totalIncorrect');
		var unattempted = parseInt(length)
				- (parseInt(correct) + parseInt(incorrect));
		var accuracyInsights = insights.accuracyInsights(this.model);
		var difficultyInsights = insights.difficultyLevelInsights(this.model);
		var strategicInsights = insights.strategicInsights(this.model);
		var historyInsights = 'they come here';
		$(this.el).html(this.template({
			'totalQuestions' : length,
			'correct' : correct,
			'incorrect' : incorrect,
			'unattempted' : unattempted,
			'totalTime' : helper.formatTime(this.model.get('allotedTime')),
			'timeTaken' : helper.formatTime(this.model.get('timeTaken')),
			'avgTime' : '1 min 30 secs',
			'accuracyInsights' : accuracyInsights,
			'strategicInsights' : strategicInsights,
			'historyInsights' : historyInsights,
			'difficultyInsights' : difficultyInsights
		}));
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
