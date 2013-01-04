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
        $(this.el).html(this.template());
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

window.QuizQuestionView = Backbone.View.extend({

    initialize: function () {},

    events: {
        'click #single-type button': 'handleSingleType',
        'click #multiple-type button': 'handleMultipleType',
        'keypress #integer-type': 'checkIntegerType',
        'keyup #integer-type': 'handleIntegerType',
        'click #matrix-type input': 'handleMatrixType',
    },

    handleSingleType: function (e) {
        var oldOptionSelected = this.model.get('optionSelected');
        var optionSelected = e.target.value;
        if (optionSelected == oldOptionSelected) {
            logs.add(new Log({
                'questionId': this.model.get('id'),
                'optionIndex': optionSelected,
                'timestamp': new Date().getTime(),
                'action': 1
            }));
            this.model.set('optionSelected', null);
            if (!this.model.get('optionUnSelectedTimeStamps')[optionSelected]) {
                this.model.get('optionUnSelectedTimeStamps')[optionSelected] = new Array();
            }
            (this.model.get('optionUnSelectedTimeStamps')[optionSelected])
                .push(new Date().getTime());
            $(e.target).removeClass('active');
            e.stopPropagation();
        } else {
            logs.add(new Log({
                'questionId': this.model.get('id'),
                'optionIndex': optionSelected,
                'timestamp': new Date().getTime(),
                'action': 0
            }));
            this.model.set('optionSelected', optionSelected);
            if (!this.model.get('optionSelectedTimeStamps')[optionSelected]) {
                this.model.get('optionSelectedTimeStamps')[optionSelected] = new Array();
            }
            (this.model.get('optionSelectedTimeStamps')[optionSelected])
                .push(new Date().getTime());
        }
    },

    handleMultipleType: function (e) {
        var optionSelectedArray = [];
        var optionSelected = this.model.get('optionSelected');
        if (optionSelected != null) {
            optionSelectedArray = (optionSelected).split(SEPARATOR); // (SEPARATOR.SEPARATOR);
        } else {
            // fill all the fields with null
            var len = ((this.model.get('options')).split(SEPARATOR)).length;
            for (var j = 0; j < len; j++) {
                optionSelectedArray[j] = null;
            }
        }
        var finalOptions = [];
        len = optionSelectedArray.length;
        for (var i = 0; i < len; i++) {
            if (optionSelectedArray[i] != null) {
                finalOptions[parseInt(optionSelectedArray[i])] = true;
            }
        }
        // get the class for selected button...if its active then it has
        // been clicked again.
        var currentClass = e.target.getAttribute('class');
        var value = parseInt(e.target.getAttribute('value'));
        if (currentClass.indexOf('active') != -1) {
            // unselect this
            finalOptions[value] = false;
            // optionSelectedArray[value] = "";
        } else {
            finalOptions[value] = true;
        }
        optionSelectedArray.length = 0;
        len = finalOptions.length;
        for (i = 0; i < len; i++) {
            if (finalOptions[i] == true) {
                optionSelectedArray.push(i);
            }
        }
        this.model.set('optionSelected', optionSelectedArray.join(SEPARATOR));
    },

    checkIntegerType: function (e) {
        // we need to use a plug-in
        // https://github.com/SamWM/jQuery-Plugins/blob/master/numeric/jquery.numeric.js
        // or http://www.texotela.co.uk/code/jquery/numeric/
        // other scripts are buggy
    },

    handleIntegerType: function (e) {
        this.model.set('optionSelected', $('#integer-type').val());
    },

    handleMatrixType: function (e) {
        var optionSelectedArray = [];
        var optionSelected = this.model.get('optionSelected');
        if (optionSelected != null) {
            optionSelectedArray = (optionSelected).split(SEPARATOR + SEPARATOR); // (SEPARATOR.SEPARATOR);
        } else {
            // fill all the fields with null
            var len = (((this.model.get('options')).split(SEPARATOR + SEPARATOR))[0]).split(SEPARATOR).length;
            for (var j = 0; j < len; j++) {
                optionSelectedArray[j] = null;
            }
        }
        // get all checks for this particular row and add to the
        // solution
        var checkboxSelected = (e.target).getAttribute('name');
        var index = parseInt((checkboxSelected.split('-'))[1]);
        // var checks = $('.myCheckbox').attr('checked','checked');
        var selectedChecks = $("." + checkboxSelected + ":checked");
        var optionAtIndex = [];
        var len = selectedChecks.length;
        for (var i = 0; i < len; i++) {
            optionAtIndex.push(selectedChecks[i].value);
        }
        optionSelectedArray[index] = optionAtIndex.join(SEPARATOR);
        this.model.set('optionSelected', optionSelectedArray.join(SEPARATOR + SEPARATOR));
    },

    render: function () {
        $('#question').html(this.template(this.model.toJSON()));
        this.renderOptions();
        $('#status').hide();
        $('#solution').hide();
        $('#video').hide();
        if (this.model.get('hasAttempted')) {
            this.renderInfo();
            $('#analytics').show();
            // disable buttons
        } else {
            logs.add(new Log({
                'questionId': this.model.get('id'),
                'timestamp': new Date().getTime(),
                'action': 2
            }));
            $('#analytics').hide();
        }
        // diable right click for this page
        $('.quizview').bind("contextmenu", function (e) {
            e.preventDefault();
        });
        var math = document.getElementById('quiz-view');
        MathJax.Hub.Queue(["Typeset", MathJax.Hub, math]);
        return this;
    },

    renderOptions: function () {
        var htmlOpt = [];
        var buttonOpt = [];
        var options = this.model.get('options');
        var optionSelected = this.model.get('optionSelected');
        switch (this.model.get('typeId')) {
            case "1":
                // single option
                htmlOpt.push('<div class="span10"><div class="option-box"><ol type="A">');
                buttonOpt.push('<div class="span2 btn-group" data-toggle="buttons-radio" id="single-type">');
                var optionsArray = options.split(SEPARATOR);
                var len = optionsArray.length;
                for (var i = 0; i < len; i++) {
                    htmlOpt.push('<li>' + optionsArray[i] + '</li>');
                    if (optionSelected != null && optionSelected == i) {
                        buttonOpt.push('<button type="button" name="option" value="' + i + '" class="btn btn-large btn-block active">' + String.fromCharCode(65 + i) + '</button>');
                    } else {
                        buttonOpt.push('<button type="button" name="option" value="' + i + '" class="btn btn-large btn-block">' + String.fromCharCode(65 + i) + '</button>');
                    }
                }
                htmlOpt.push('</ol></div></div>');
                buttonOpt.push('</div>');
                $('#options').html(htmlOpt.join(''));
                $('#options').append(buttonOpt.join(''));
                break;
            case "2":
                // multiple option
                htmlOpt.push('<div class="span10"><div class="option-box"><ol type="A">');
                buttonOpt.push('<div class="span2 btn-group" data-toggle="buttons-checkbox" id="multiple-type">');
                var optionsArray = options.split(SEPARATOR);
                var len = optionsArray.length;
                var optionSelectedArray = [];
                if (optionSelected != null) {
                    optionSelectedArray = optionSelected.split(SEPARATOR);
                }
                for (var i = 0; i < len; i++) {
                    htmlOpt.push('<li>' + optionsArray[i] + '</li>');
                    if (jQuery.inArray(i.toString(), optionSelectedArray) >= 0) {
                        buttonOpt.push('<button type="button" name="mult" value="' + i + '" class="btn btn-large btn-block active">' + String.fromCharCode(65 + i) + '</button>');
                    } else {
                        buttonOpt.push('<button type="button" name="mult" value="' + i + '" class="btn btn-large btn-block">' + String.fromCharCode(65 + i) + '</button>');
                    }
                }
                htmlOpt.push('</ol></div></div>');
                buttonOpt.push('</div>');
                $('#options').html(htmlOpt.join(''));
                $('#options').append(buttonOpt.join(''));
                break;
            case "3":
                // integer type
                htmlOpt.push('<input type="number" id="integer-type" value="' + optionSelected + '">');
                $('#options').html(htmlOpt);
                break;
            case "4":
                // matrix type
                var optionsArray = options.split(SEPARATOR + SEPARATOR);
                var leftList = optionsArray[0].split(SEPARATOR);
                var rightList = optionsArray[1].split(SEPARATOR);
                var lLen = leftList.length;
                var rLen = rightList.length;
                // create the left right table
                htmlOpt.push('<div class="span6">');
                htmlOpt.push('<table class="table"><tr><td>');
                htmlOpt.push('<ol type="1">');
                for (var i = 0; i < lLen; i++) {
                    htmlOpt.push('<li>' + leftList[i] + '</li>');
                }
                htmlOpt.push('</ol></td><td>');
                htmlOpt.push('<ol type="A">');
                for (var i = 0; i < rLen; i++) {
                    htmlOpt.push('<li>' + rightList[i] + '</li>');
                }
                htmlOpt.push('</ol></td></tr></table>');
                htmlOpt.push('</div>');

                // create the checkboxes table
                var optionSelectedArray = [];
                if (optionSelected != null) {
                    optionSelectedArray = optionSelected.split(SEPARATOR + SEPARATOR);
                }
                buttonOpt.push('<div class="span6">');
                buttonOpt.push('<table class="table" id="matrix-type">');
                // define the top row
                buttonOpt.push('<tr><td></td>');
                for (var j = 0; j < rLen; j++) {
                    buttonOpt.push('<td>' + String.fromCharCode(65 + j) + '</td>');
                }
                buttonOpt.push('</tr>');
                // create checkboxes
                for (i = 0; i < lLen; i++) {
                    buttonOpt.push('<tr><td>' + (i) + '</td>');
                    for (var j = 0; j < rLen; j++) {
                        if (optionSelectedArray[i] != null && optionSelectedArray[i].indexOf(j) != -1) {
                            buttonOpt.push('<td><input type="checkbox" name="multicheck-' + i + '" class="multicheck-' + i + '" value="' + j + '" checked></td>');
                        } else {
                            buttonOpt.push('<td><input type="checkbox" name="multicheck-' + i + '" class="multicheck-' + i + '" value="' + j + '"></td>');
                        }

                    }
                    buttonOpt.push('</tr>');
                }
                buttonOpt.push('</div>');
                $('#options').html(htmlOpt.join(''));
                $('#options').append(buttonOpt.join(''));
                break;
        }
    },

    renderInfo: function () {
        var html = [];
        $('#status').show();
        $('#options').hide();
        $('#video').show();
        html.push('<div class="row-fluid"><div class="span7">');
        html.push('<h3>YOU MARKED OPTION A - <span class="orange">100ml</span>');
        html.push('<img src="img/checkmark.png" width="33px"> <br> <span class="orange"> in 20 seconds</span>');
        html.push('</h3></div>');
        html.push('<div class="span5">');
        html.push('<div class="g-stats">');
        html.push('Difficulty : <span class="blue">Easy</span></div>');
        html.push('<div class="g-stats">');
        html.push('<div class="stat">');
        html.push(' Average Accuracy<br> <span class="blue">30%</span>');
        html.push('</div>');
        html.push('<div class="stat">Average Time<br> <span class="blue">30 Seconds</span>');
        html.push('</div></div>');
        html.push('<div class="g-stats">');
        html.push('<span class="val">JEE 2012, JEE 2013</span>');
        html.push('</div></div></div>');
        $('#status').html(html.join(''));
        $('#solution').show();
        $('#solutionText').html(this.model.get('explanation'));

        /*		'<span class="green bold">Correct Answer</span> : '
								+ this.model.get('correctAnswer'));
				$('#solution').append(
						'<br><div class="sol"><span class="green bold">Solution</span> : '
								+ this.model.get('explanation') + '</div>');
				$('#solution')
						.append(
								'<br><div class="stats"><span class="green bold">Average Correct</span>:'
										+ this.model.get('averageCorrect')
										+ '<span class="green bold"> Average Time</span> :'
										+ this.model.get('averageTimeCorrect')
										+ '<span class="badge badge-success">2012 CAT</span></div>');
				// code to add video here.
				*/
        $('#video').html('<video id="analysis_video" class="video-js vjs-default-skin" controls preload="none" width="640" height="264" data-setup="{}"><source src="videos/video1.mp4" type="video/mp4" /> </video>');

        $('#time').html(this.model.get('timeTaken'));
        $('#submit').hide();
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