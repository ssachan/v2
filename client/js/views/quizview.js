/**
 * The quiz views
 * 
 * @author ssachan
 * 
 */
window.InstructionsView = Backbone.View.extend({
	className : 'container instructions',
	
	initialize : function() {
	},

	events : {
		'click .start-quiz' : 'startQuiz',
	},

	startQuiz : function(e) {
		// store the preference
		var attemptedAs = e.currentTarget.getAttribute('id'); //$('input:radio[name=attemptedAs]:checked').val();
		this.model.set('attemptedAs', attemptedAs);
		this.model.updateAttemptedAs();
		//logs resetting
		logs.reset();
		logs.addEntry("TEST_START");
	},

	render : function() {
		$(this.el).html(this.template(
				{
					'totalQuestions' : this.model.get('questionIdsArray').length,
					'totalTime' : helper.formatTime(this.model.get('totalTime')),
					'descriptionShort' : this.model.get('descriptionShort'),
				}));
		return this;
	},
});

window.ResumeView = Backbone.View.extend({

    initialize: function () {},

    events: {
        'click #resume-quiz': 'resume',
    },

    resume: function () {
        // store the preference
        if(this.model.get('attemptedAs')==1){
            Manager.loadQuiz(this.model);
        }else{
            Manager.loadPractice(this.model);           
        }
    },

    render: function () {
        $(this.el).html(this.template(this.model.toJSON()));
        return this;
    }
});

window.QuizView = Backbone.View.extend({

	initialize : function() {
		var context = this;
		this.index = this.options.index;
		this.questionView = null;
		this.question = null;
		this.questionIds = this.model.getQuestionIds();
		this.totalQuestions = this.questionIds.length;
		timer.setUpdateFunction(context.updateQuizTimer, [ context ]);
	},

	events : {
		'click #previous' : 'onPreviousClick',
		'click #next' : 'onNextClick',
		'click .qnolist' : 'onQNoClick',
		'click #submit' : 'submitQuiz',
	},

	startQuiz : function() {
		this.renderQuestion();
		timer.reset();
		timer.start();
	},

	submitQuiz : function() {
		timer.stop();
		logs.addEntry("QUESTION_CLOSE",this.question.get('id'));
		logs.addEntry("TEST_SUBMIT");
		logs.sort();

		this.model.set('timeTaken', timer.count);
		this.model.calculateScores();
		this.model.set('state', this.totalQuestions);
        this.model.set('status', 1);        
		this.model.submitResults();

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
		this.question.get('closeTimeStamps').push(new Date().getTime());

		logs.addEntry("QUESTION_CLOSE",this.question.get('id'));

		this.index--;
		if (this.index < 0) {
			return;
		}
		this.renderQuestion();
	},

	onNextClick : function() {
		//this.question.get('closeTimeStamps').push(new Date().getTime());
		logs.addEntry("QUESTION_CLOSE",this.question.get('id'));

		this.index++;
		if (this.index >= this.totalQuestions) {
			return;
		}
		this.renderQuestion();
	},

	onQNoClick : function(e) {
		logs.addEntry("QUESTION_CLOSE",this.question.get('id'));
		this.index = e.target.parentElement.getAttribute('id'); // .split('-')[1];
		this.renderQuestion();
	},

	render : function() {
		$(this.el).html(this.template({
			'totalQuestions' : this.totalQuestions,
		}));
		return this;
	},

	/**
	 * TODO:video - just store the reference of the current video
	 */
	renderQuestion : function() {
        $('#'+this.index).addClass('active');
		this.question = quizQuestions.get(this.questionIds[this.index]);

		if (this.question.get('timeTaken') == null) {
			this.question.set('timeTaken', 0);
		}
		if (this.questionView == null) {
			this.questionView = new QuizQuestionView({
				el : $('#question'),
			});
		}
		this.question.set('hasAttempted', false);
		this.questionView.model = this.question;
		this.questionView.render();
		$("#qnum").html((parseInt(this.index) + 1));
		$("#qtotal").html((this.totalQuestions));
		this.question.get('openTimeStamps').push(new Date().getTime());
		$('#previous').show();
		$('#next').show();
		if (this.index == 0) {
			$('#previous').hide();
		} else if (this.index == (this.totalQuestions - 1)) {
			$('#next').hide();
		}
		return null;
	}
});

window.PracticeView = Backbone.View.extend({

    initialize: function () {
        var context = this;
        this.index = this.options.index;
        this.questionView = null;
        this.question = null;
        this.questionIds = this.model.getQuestionIds();
        this.totalQuestions = this.questionIds.length;
        this.setUp();
        timer.setUpdateFunction(context.updateQuizTimer, [context]);
    },

    setUp: function () {
        this.answersSelected = this.model.getSelectedAnswers();
        this.getTimeTakenPerQuestion = this.model.getTimeTakenPerQuestion();
        for (var i = 0; i <= this.index; i++) {
            var question = quizQuestions.get(this.questionIds[i]);
            if (this.getTimeTakenPerQuestion[i] != null) {
                // mark this question
                question.set('timeTaken', this.getTimeTakenPerQuestion[i]);
                question.set('optionSelected', this.answersSelected[i]);
                question.set('hasAttempted', true);
            }
        }
    },

    events: {
        'click #previous': 'onPreviousClick',
        'click #next': 'onNextClick',
        // 'click .qnolist' : 'onQNoClick',
        'click #submit': 'submitQuestion',
        'click #pause': 'pauseQuiz'
    },

    startQuiz: function () {
        timer.reset();
        this.renderQuestion();
    },

    submitQuiz: function () {
        this.model.calculateScores();
        this.model.submitResults();
    },

    submitQuestion: function () {
        this.question.set('hasAttempted', true);
        timer.stop();
        timer.reset();
        $('#previous').show();
        $('#next').show();
        if (this.index == 0) {
            $('#previous').hide();
        } 
        this.model.set('state', this.index);
        this.model.calculateScores();
        this.model.submitResults();
        this.renderQuestion();
    },

    pauseQuiz: function () {
        window.location = '#';
    },

    updateQuizTimer: function (context) {
        $('#time').html(helper.formatTime(timer.count));
        var qtimer = context.question.get('timeTaken');
        qtimer++;
        context.question.set('timeTaken', qtimer);
    },

    onPreviousClick: function () {
        this.index--;
        if (this.index < 0) {
            return;
        }
        this.renderQuestion();
    },

    onNextClick: function () {
        this.index++;
        if (this.index == this.totalQuestions) {
            // show results
            Manager.showResults(this.model);
            return;
        }
        this.renderQuestion();
        
    },

    onQNoClick: function (e) {
        this.index = e.target.getAttribute('id');
        this.renderQuestion();
    },

    render: function () {
        $(this.el).html(this.template({
            'totalQuestions': this.totalQuestions,
        }));
        return this;
    },

    /**
     * TODO:video - just store the reference of the current video
     */
    renderQuestion: function () {
        this.question = quizQuestions.get(this.questionIds[this.index]);
        if (this.question.get('timeTaken') == null) {
            this.question.set('timeTaken', 0);
        }
        if (this.questionView == null) {
            this.questionView = new QuizQuestionView({
                el: $('#question')
            });
        }
        this.questionView.model = this.question;
        this.questionView.render();
        if (this.question.get('hasAttempted') == false) {
            timer.start();
            $('#previous').hide();
            $('#next').hide();
            $('#submit').show();
            $('#pause').hide();
        } else {
            $('#pause').show();
        }
        $("#qnum").html((parseInt(this.index) + 1));
        $("#qtotal").html((this.totalQuestions));
        return null;
    }
});