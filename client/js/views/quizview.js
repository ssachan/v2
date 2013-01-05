/**
 * The quiz views
 * 
 * @author ssachan
 * 
 */
window.InstructionsView = Backbone.View.extend({

    initialize: function () {},

    events: {
        'click #start-quiz': 'startQuiz',
    },

    startQuiz: function () {
        // store the preference
        var attemptedAs = $('input:radio[name=attemptedAs]:checked').val();
        this.model.set('attemptedAs', attemptedAs);
        this.model.updateAttemptedAs();
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
        this.questionIds = this.model.getQuestionIds();
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
        this.model.set('timeTaken', timer.count);
        this.model.calculateScores();
        this.model.set('state', this.totalQuestions);
        this.model.submitResults();
    },

    updateQuizTimer: function (context) {
        $('#time').html(helper.formatTime(timer.count));
        var qtimer = context.question.get('timeTaken');
        qtimer++;
        context.question.set('timeTaken', qtimer);
        if (timer.count == context.model.get('allotedTime')) {
            alert('time up');
            this.submitQuiz();
        }
    },

    onPreviousClick: function () {
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
        this.currentView = '';
    },

    setUp: function () {
        this.answersSelected = this.model.getSelectedAnswers();
        this.getTimeTakenPerQuestion = this.model.getTimeTakenPerQuestion();
        for (var i = 0; i <= this.index; i++) {
            var question = quizQuestions.get(this.questionIds[i]);
            if (question.get('timeTaken') == null && this.answersSelected[i] != null) {
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
        this.question.get('closeTimeStamps').push(new Date().getTime());
        this.question.set('hasAttempted', true);
        timer.stop();
        timer.reset();
        $('#previous').show();
        $('#next').show();
        if (this.index == 0) {
            $('#previous').hide();
        } else if (this.index == (this.totalQuestions - 1)) {
            $('#next').hide();
        }
        this.renderQuestion();
    },

    pauseQuiz: function () {
        this.model.set('timeTaken', timer.count);
        this.model.calculateScores();
        this.model.set('state', this.index);
        this.model.submitResults();
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
        if (this.index >= this.totalQuestions) {
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
        $('#quiz-view').hide();
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