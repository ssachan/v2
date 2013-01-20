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

    initialize: function () {
        var context = this;
        this.index = this.options.index;
        this.questionView = null;
        this.question = null;
        this.questionIds = this.model.get('questionIdsArray');
        this.totalQuestions = this.questionIds.length;
        timer.setUpdateFunction(context.updateQuizTimer, [context]);
    },

    events: {
        'click #previous': 'onPreviousClick',
        'click #next': 'onNextClick',
        'click .qnolist': 'onQNoClick',
        'click #submit': 'submitQuiz',
    },

    startQuiz: function () {
        this.renderQuestion();
        timer.reset();
        timer.start();
    },

    submitQuiz: function () {
        timer.stop();
    	logs.addEntry("QUESTION_CLOSE",this.question.get('id'));
		logs.addEntry("TEST_SUBMIT");
		logs.sort();
        this.model.set('timeTaken', timer.count);
        this.model.set('state', this.totalQuestions);
        this.model.set('status', this.model.STATUS_COMPLETED);
        this.model.submitQuiz();
    },

    updateQuizTimer: function (context) {
        $('#time').html(helper.formatTime((timer.count*1000)));
        var qtimer = context.question.get('timeTaken');
        qtimer++;
        context.question.set('timeTaken', qtimer);
        if (timer.count == context.model.get('allotedTime')) {
            alert('time up');
            this.submitQuiz();
        }
    },

    onPreviousClick: function () {
		logs.addEntry("QUESTION_CLOSE",this.question.get('id'));
    	$('#'+this.index).removeClass('active');
        if(this.question.get('optionSelected')){
        	$('#'+this.index).addClass('attempted');
        }else{
        	$('#'+this.index).removeClass('attempted');        	
        }
    	this.index--;
        if (this.index < 0) {
            return;
        }
        this.renderQuestion();
    },

    onNextClick: function () {
		logs.addEntry("QUESTION_CLOSE",this.question.get('id'));
    	$('#'+this.index).removeClass('active');
    	if(this.question.get('optionSelected')){
        	$('#'+this.index).addClass('attempted');
        }else{
        	$('#'+this.index).removeClass('attempted');        	
        }
        this.index++;
        if (this.index >= this.totalQuestions) {
            return;
        }
        this.renderQuestion();
    },

    onQNoClick: function (e) {
		logs.addEntry("QUESTION_CLOSE",this.question.get('id'));
    	$('#'+this.index).removeClass('active');
    	if(this.question.get('optionSelected')){
        	$('#'+this.index).addClass('attempted');
        }else{
        	$('#'+this.index).removeClass('attempted');        	
        }
        this.index = e.currentTarget.getAttribute('id');
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
    	$('#'+this.index).addClass('active');
        this.question = quizQuestions.get(this.questionIds[this.index]);
        if (this.question.get('timeTaken') == null) {
            this.question.set('timeTaken', 0);
        }
        if (this.questionView == null) {
            this.questionView = new QuizQuestionView({
                el: $('#question'),
            });
        }
        this.question.set('hasAttempted', false);
        this.questionView.model = this.question;
        this.questionView.render();
        $("#qnum").html((parseInt(this.index) + 1));
        $("#qtotal").html((this.totalQuestions));
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
        this.questionIds = this.model.get('questionIdsArray');
        this.totalQuestions = this.questionIds.length;
        this.setUp();
        timer.setUpdateFunction(context.updateQuizTimer, [context]);
    },

    setUp: function () {
        // tanujb:TODO: What is this code supposed to do?
        this.answersSelected = this.model.get('selectedAnswersArray');
        this.getTimeTakenPerQuestion = this.model.get('timePerQuestionArray');
        for (var i = 0; i <= this.index; i++) {
            var question = quizQuestions.get(this.questionIds[i]);
            if (this.getTimeTakenPerQuestion[i] != null) {
                // mark this question
                question.set('timeTaken', this.getTimeTakenPerQuestion[i]);
                question.set('optionSelected', this.answersSelected[i]);
                question.setStatus();
                question.set('hasAttempted', true);
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

    submitQuestion: function () {
        timer.stop();        
    	this.question.set('timeTaken',(timer.count*1000));
        timer.reset();
    	this.question.set('hasAttempted', true);
        this.question.setStatus();
        switch(this.question.get('status')){
		case true:
			$('#'+this.index).addClass('right');
			break;
		case false:
			$('#'+this.index).addClass('wrong');
			break;
		default : 
			$('#'+this.index).addClass('unattempted');
		break;
        }
        logs.addEntry("QUESTION_CLOSE",this.question.get('id'));
        $('#previous').show();
        $('#next').show();
        if (this.index == 0) {
            $('#previous').hide();
        } 
        this.model.set('state', this.index);
        //this.model.calculateScores();
        this.model.submitPractice();
        this.renderQuestion();
    },

    pauseQuiz: function () {
		window.location = '#';
    },

    updateQuizTimer: function (context) {
        $('#time').html(helper.formatTime((timer.count*1000)));
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
            logs.reset();
            logs.addEntry("QUESTION_OPEN", this.question.get('id'));
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