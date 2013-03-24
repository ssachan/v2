/**
 * The header view
 * @author ssachan 
 * 
 **/

window.HeaderView = Backbone.View.extend({

	initialize : function() {
		_.bindAll(this, "render");
		this.model.bind('change', this.render);
		this.render();
	},
	
	render : function() {
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	},
	
});

window.FooterView = Backbone.View.extend({

	initialize : function() {
		this.render();
	},
	
	render : function() {
		$(this.el).html(this.template());
		return this;
	},

});window.LandingView = Backbone.View.extend({
	className : 'container landing',
	initialize : function() {
		this.render();
	},

	render : function() {
		$(this.el).html(this.template());
		return this;
		//$('#sign-up').append((new SignUpView({model:account})).el);
	}
});

window.LearnMoreView = Backbone.View.extend({
	className :'container learn',
	
	initialize : function() {
		this.active = this.options.menu;
	},
		
	changeMenu : function(id) {
		$('#' + this.active+'-div').hide();
		this.active = id;
		$('#' + this.active+'-div').show();
		$('#' + this.active+'-menu').addClass('active');
	},
	
	render : function() {
		$(this.el).html(this.template());
		return this;
	},
	
	onRender : function (){
		$('#pq-div').hide();
		$('#tests-div').hide();
		$('#faculty-div').hide();
		$('#feedback-div').hide();
		$('#choice-div').hide();
		$('#started-div').hide();
		this.changeMenu(this.active);
	}
	
});

/**
 * The dashboard view
 * 
 * @author ssachan
 * 
 */
window.DashboardView = Backbone.View.extend({
	className : 'container dashboard',
	initialize : function() {
		this.activeMenu = null;
		this.activeView = null;
	},

	switchView : function(view) {
		if (this.activeView != null)
			this.activeView.close();
		$('#main-content', this.el).html(view.render().el);
		view.onRender();
		this.activeView = view;
		return view;
	},

	switchMenu : function(menu) {
		if (this.activeMenu != null) {
			$('#' + this.activeMenu + '-nav').removeClass('active');
		}
		if (this.activeMenu != menu) {
			this.activeMenu = menu;
			$('#' + this.activeMenu + '-nav').addClass('active');
			$('#main-content').empty();
		}
	},

	render : function() {
		$(this.el).html(this.template());
		return this;
	},

	onRender : function() {
		//$('a').tooltip({placement:'bottom'});
	}

});

window.OverView = Backbone.View.extend({
	className : "overall",

	initialize : function() {
		_.bindAll(this, "render");
		this.model.bind('change', this.render);
		this.model.bind('change', this.onRender);
	},

	uploadImage : function() {
		var btnUpload = $('#upload');
		var status = $('#status');
		var that = this;
		new AjaxUpload(btnUpload, {
			action : Config.serverUrl + 'uploadImage',
			name : 'file',
			type : 'POST',
			onSubmit : function(file, ext) {
				if (!(ext && /^(jpg|png|jpeg|gif)$/.test(ext))) {
					// extension is not allowed
					status.text('Only JPG, PNG or GIF files are allowed');
					return false;
				}
				status.text('Uploading...');
			},
			onComplete : function(file, response) {
				// On completion clear the status
				status.text('');
				that.model.set('dp', true);
				$("#dp img").attr(
						"src",
						that.model.get('dpUrl') + "?timestamp="
								+ new Date().getTime());
				// $('#profile-pic').html('<img class="media-object"
				// src="<%=dp%>" height="100" width="130">');
				// Add uploaded file to list
			}
		});
	},

	render : function() {
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	},

	onRender : function() {
		//this.uploadImage();
		$('#result-square').empty();
		var l1 = sectionL1.models;
        var len = l1.length;
        for (var i = 0; i < len; i++) {
            var pView = new PerformanceView({
                model: l1[i]
            });
            $('#result-square').append(pView.render().el);
            pView.onRender();
        }		
	}
	
});

window.PerformanceView = Backbone.View.extend({
	className : "subject",
	initialize : function() {
		this.activel2Id = '0';
		this.activel3Id = '0';
		this.stats = null;
	},

	events : {
		'click .l1' : 'onL1Click',
		'click .l2 li' : 'onL2Click',
		'click .l3 li' : 'onL3Click',
	},
	
	onL1Click : function(e) {
		$('#' + this.activel2Id + '-l2').removeClass('active');
		this.activel2Id = '0';
		$('.l3', this.el).empty();
		$('.l3-stats', this.el).hide();
		this.activel3Id = '0';
		this.renderL1Stats();
	},
	
	onL2Click : function(e) {
		$('.l3', this.el).empty();
		$('.l3-stats', this.el).hide();
		this.activel3Id = '0';
		$('#' + this.activel2Id + '-l2').removeClass('active');
		this.activel2Id = (e.target.parentElement.getAttribute('lid'));

		// this.activel2Id = e.target.getAttribute('id');
		$('#' + this.activel2Id + '-l2').addClass('active');
		this.renderL3();
		this.renderL2Stats();
	},

	onL3Click : function(e) {
		if (this.activel3Id != e.target.parentElement.getAttribute('lid')) {
			$('#' + this.activel3Id + '-l3').removeClass('active');
			this.activel3Id = (e.target.parentElement.getAttribute('lid'));
			$('#' + this.activel3Id + '-l3').addClass('active');
			this.renderL3Stats();
		}
	},

	render : function() {
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	},

	onRender : function() {
		var l2 = sectionL2.where({
			l1Id : this.model.get('id')
		});
		var len = l2.length;
		for ( var i = 0; i < len; i++) {
			$('.l2', this.el).append('<li id="' + l2[i].get('id') + '-l2" lid="'+l2[i].get('id')+'"><a>'
							+ l2[i].get('displayName') + '</a></li>');
			var l2Score = scoreL2.get(l2[i].get('id'));
			if(l2Score!=null){
				var score = parseInt(l2Score.get('score'));
				if(score>80){
					$('#'+l2[i].get('id') + '-l2>a', this.el).addClass('bg-green');
				}else if(score>=30 && score<=80){
					$('#'+l2[i].get('id') + '-l2>a', this.el).addClass('bg-yellow');
				}else if(score<30 && score>0){
					$('#'+l2[i].get('id') + '-l2>a', this.el).addClass('bg-red');
				}else if(score==0){
					$('#'+l2[i].get('id') + '-l2>a', this.el).addClass('bg-grey');
				}
			}else{
				$('#'+l2[i].get('id') + '-l2>a', this.el).addClass('bg-grey');
			}
		}
		this.renderL1Stats();
	},
	
	renderStats : function (score){
		if(score!=null){
			$('.l3-stats #bar', this.el).html('<div class="bar bar-warning" style="width:'+parseInt(score.get('score'))+'%"></div>');
			$('.l3-stats #pts', this.el).html(parseInt(score.get('score')));
			$('.l3-stats #total', this.el).html(parseInt(score.get('numQuestions')));
			$('.l3-stats #correct', this.el).html(parseInt(score.get('numCorrect')));
			$('.l3-stats #incorrect', this.el).html(parseInt(score.get('numIncorrect')));
			$('.l3-stats #unattempted', this.el).html(parseInt(score.get('numUnattempted')));
			var scoreVal = parseInt(score.get('score'));
			if(scoreVal>80){
				$('.l3-stats #pts', this.el).html('Expert');
			}else if(scoreVal>=30 && scoreVal<=80){
				$('.l3-stats #pts', this.el).html('Getting There');
			}else if(scoreVal<30 && scoreVal>0){
				$('.l3-stats #pts', this.el).html('Struggling');
			}else if(scoreVal==0){
				$('.l3-stats #pts', this.el).html('Not Started');
			}
		}else{
			$('.l3-stats #bar', this.el).html('<div class="bar bar-warning" style="width:'+parseInt('0')+'%"></div>');
			$('.l3-stats #pts', this.el).html('Not Started');
			$('.l3-stats #total', this.el).html('0');
			$('.l3-stats #correct', this.el).html('0');
			$('.l3-stats #incorrect', this.el).html('0');
			$('.l3-stats #unattempted', this.el).html('0');
		}
		$('.l3-stats', this.el).show();
	},
	
	renderL1Stats : function (){
		var thisL1Score = scoreL1.get(this.model.get('id'));
		var l1Name = this.model.get('displayName');
		$('.l3-stats #topic', this.el).html(l1Name);
		this.renderStats(thisL1Score);
		$('#btns').show();
	},
	
	renderL2Stats : function (){
		var context = this;
		var thisL2Score = scoreL2.get(context.activel2Id);
		var l2Name = (sectionL2.get(context.activel2Id)).get('displayName');
		$('.l3-stats #topic', this.el).html(l2Name);
		this.renderStats(thisL2Score);
		$('#btns').show();
	},
	
	renderL3 : function() {
		$('.l3', this.el).empty();
		var l3 = sectionL3.where({
			l2Id : this.activel2Id
		});
		var len = l3.length;
		for ( var i = 0; i < len; i++) {
			$('.l3', this.el).append(
					'<li id="' + l3[i].get('id') + '-l3" lid="'+l3[i].get('id')+'"><a>'
							+ l3[i].get('displayName') + '</a></li>');
			var l3Score = scoreL3.get(l3[i].get('id'));
			if(l3Score!=null){
			var score = parseInt(l3Score.get('score'));
			if(score>80){
				$('#'+l3[i].get('id') + '-l3>a', this.el).addClass('bg-green');
			}else if(score>=30 && score<=80){
				$('#'+l3[i].get('id') + '-l3>a', this.el).addClass('bg-yellow');
			}else if(score<30 && score>0){
				$('#'+l3[i].get('id') + '-l3>a', this.el).addClass('bg-red');
			}else if(score==0){
				$('#'+l3[i].get('id') + '-l3>a', this.el).addClass('bg-grey');
			}
			}else{
				$('#'+l3[i].get('id') + '-l3>a', this.el).addClass('bg-grey');
			}
		}
	},

	renderL3Stats : function() {
		var context = this;
		var thisL3Score = scoreL3.get(context.activel3Id);
		var l3Name = (sectionL3.get(context.activel3Id)).get('displayName');
		$('.l3-stats #topic', this.el).html(l3Name);
		this.renderStats(thisL3Score);
		$('#btns').hide();
	},
	
});

window.ActivityView = Backbone.View.extend({
	className : "overall",

	initialize : function() {
	},
	
	render : function() {
		$(this.el).html(this.template());
		return this;
	},

	onRender : function() {
		if(account.get('quizzesAttemptedArray').length==0){
			$('#insight').html('Please take a test and come back to this section');
			return;
		}
		var quizzes = this.collection.models;
		var len = quizzes.length;
		$("#rec-quizzes").html('');
		for ( var i = 0; i <len; i++) {
			$(".thumbnails").append(new QuizItemView({
				model : quizzes[i], className:'span12'
			}).render().el);			
		}
		drawDonutChart('donut');
        $("tspan:contains('Highcharts.com')").hide();
	}
});
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
		var attemptedAs = e.currentTarget.getAttribute('id'); // $('input:radio[name=attemptedAs]:checked').val();
		this.model.set('attemptedAs', attemptedAs);
		this.model.updateAttemptedAs();
		// logs resetting
		logs.reset();
		logs.addEntry("TEST_START");
		helper.track('mode',{'id':attemptedAs,'accountId':account.get('id'),'email':account.get('email')});
	},

	render : function() {
		$(this.el).html(this.template({
			'totalQuestions' : this.model.get('questionIdsArray').length,
			'totalTime' : helper.formatTime(this.model.get('allotedTime')),
			'descriptionShort' : this.model.get('descriptionShort'),
		}));
		return this;
	},
});

window.ResumeView = Backbone.View.extend({

	initialize : function() {
		
	},

	events : {
		'click #resume-quiz' : 'resume',
	},

	resume : function() {
		// store the preference
		if (this.model.get('attemptedAs') == 1) {
			Manager.loadQuiz(this.model);
		} else {
			Manager.loadPractice(this.model);
		}
	},

	render : function() {
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	}
});

window.QuizView = Backbone.View.extend({
	className : 'container quizview',

	initialize : function() {
		var context = this;
		this.index = this.options.index;
		this.questionView = new QuizQuestionView();
		this.question = null;
		this.questionIds = this.model.get('questionIdsArray');
		this.totalQuestions = this.questionIds.length;
		timer.setUpdateFunction(context.updateQuizTimer, [ context ]);
		this.warning = true;
		window.onbeforeunload = function() {
		  if (context.warning) {
		    return '';
		  }
		};
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
		if (confirm('Are you sure you want to submit')) { 
			timer.stop();
			logs.addEntry("QUESTION_CLOSE", this.question.get('id'));
			logs.addEntry("TEST_SUBMIT");
			logs.sort();
			this.model.set('timeTaken', timer.count);
			this.model.set('state', this.totalQuestions);
			//this.model.set('status', this.model.STATUS_COMPLETED);
			this.model.submitQuiz();
		}
	},

	updateQuizTimer : function(context) {
		$('#time').html(helper.formatTime(parseInt(context.model.get('allotedTime')) -parseInt(timer.count * 1000)));
		var qtimer = context.question.get('timeTaken');
		qtimer++;
		context.question.set('timeTaken', qtimer);
		if (timer.count == context.model.get('allotedTime')) {
			alert('time up');
			this.submitQuiz();
		}
	},

	onPreviousClick : function() {
		logs.addEntry("QUESTION_CLOSE", this.question.get('id'));
		$('#' + this.index).removeClass('active');
		if (this.question.get('optionSelected')) {
			$('#' + this.index).addClass('attempted');
		} else {
			$('#' + this.index).removeClass('attempted');
		}
		this.index--;
		if (this.index < 0) {
			return;
		}
		this.renderQuestion();
	},

	onNextClick : function() {
		logs.addEntry("QUESTION_CLOSE", this.question.get('id'));
		$('#' + this.index).removeClass('active');
		if (this.question.get('optionSelected')) {
			$('#' + this.index).addClass('attempted');
		} else {
			$('#' + this.index).removeClass('attempted');
		}
		this.index++;
		if (this.index >= this.totalQuestions) {
			return;
		}
		this.renderQuestion();
	},

	onQNoClick : function(e) {
		logs.addEntry("QUESTION_CLOSE", this.question.get('id'));
		$('#' + this.index).removeClass('active');
		if (this.question.get('optionSelected')) {
			$('#' + this.index).addClass('attempted');
		} else {
			$('#' + this.index).removeClass('attempted');
		}
		this.index = e.currentTarget.getAttribute('id');
		this.renderQuestion();
	},

	render : function() {
		$(this.el).html(this.template({
			'totalQuestions' : this.totalQuestions,
		}));
		return this;
	},

	onRender : function() {
		$('#topic-head').html(this.model.get('l1DisplayName')+' : '+this.model.get('descriptionShort'));
	},
	
	/**
	 * TODO:video - just store the reference of the current video
	 */
	renderQuestion : function() {
		$('#' + this.index).addClass('active');
		this.question = quizQuestions.get(this.questionIds[this.index]);
		if (this.question.get('timeTaken') == null) {
			this.question.set('timeTaken', 0);
		}
		this.question.set('hasAttempted', false);
		this.questionView.model = this.question;
		$('#question').html(this.questionView.render().el);
		this.questionView.render();
		this.questionView.onRender();
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
	},
	
	close : function(){
		window.onbeforeunload = null;
		Backbone.View.prototype.close.call(this);
	}
});

window.PracticeView = Backbone.View.extend({
	className : 'container quizview',
	initialize : function() {
		var context = this;
		this.index = this.options.index;
		this.questionView = new QuizQuestionView();
		this.question = null;
		this.questionIds = this.model.get('questionIdsArray');
		this.totalQuestions = this.questionIds.length;
		this.setUp();
		timer.setUpdateFunction(context.updateQuizTimer, [ context ]);
		this.warning = true;
		window.onbeforeunload = function() {
		  if (context.warning) {
		    return '';
		  }
		};
	},

	setUp : function() {
		// tanujb:TODO: What is this code supposed to do?
		this.answersSelected = this.model.get('selectedAnswersArray');
		this.getTimeTakenPerQuestion = this.model.get('timePerQuestionArray');
		for ( var i = 0; i <= this.index; i++) {
			var question = quizQuestions.get(this.questionIds[i]);
			if (this.getTimeTakenPerQuestion[i] != null) {
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
//		'click .qnolist' : 'onQNoClick',
		'click #submit' : 'submitQuestion',
		'click #pause' : 'pauseQuiz'
	},

	startQuiz : function() {
		timer.reset();
		this.renderQuestion();
	},
	
	onQNoClick : function(e) {
		
		this.index--;
		if (this.index < 0) {
			return;
		}
		this.renderQuestion();
		/*logs.addEntry("QUESTION_CLOSE", this.question.get('id'));
		$('#' + this.index).removeClass('active');
		if (this.question.get('optionSelected')) {
			$('#' + this.index).addClass('attempted');
		} else {
			$('#' + this.index).removeClass('attempted');
		}
		this.index = e.currentTarget.getAttribute('id');
		this.renderQuestion();
		*/
	},

	submitQuestion : function() {
		timer.stop();
		this.question.set('timeTaken', (timer.count * 1000));
		timer.reset();
		this.question.set('hasAttempted', true);
		this.question.setStatus();
		switch (this.question.get('status')) {
		case true:
			$('#' + this.index).addClass('right');
			break;
		case false:
			$('#' + this.index).addClass('wrong');
			break;
		default:
			$('#' + this.index).addClass('unattempted');
			break;
		}
		logs.addEntry("QUESTION_CLOSE", this.question.get('id'));
		$('#previous').show();
		$('#next').show();
		if (this.index == 0) {
			$('#previous').hide();
		}
		this.model.set('state', this.index);
		// this.model.calculateScores();
		this.model.submitPracticeQuestion();
		this.renderQuestion();
	},

	pauseQuiz : function() {
		window.location = '#';
	},

	updateQuizTimer : function(context) {
		$('#time').html(helper.formatTime((timer.count * 1000)));
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
		if (this.index == this.totalQuestions) {
			logs.reset();
			// show results
			this.model.set('state', this.index);
			this.model.set('status', this.model.STATUS_COMPLETED);
			this.model.submitPracticeResults();
			return;
		}
		this.renderQuestion();

	},

	render : function() {
		$(this.el).html(this.template({
			'totalQuestions' : this.totalQuestions,
		}));
		return this;
	},

	onRender : function() {
		/*for ( var i = 0; i <= this.index; i++) {
			var question = quizQuestions.get(this.questionIds[i]);
			if (this.getTimeTakenPerQuestion[i] != null) {
				switch (question.get('status')) {
				case true:
					$('#' + i).addClass('right');
					break;
				case false:
					$('#' + i).addClass('wrong');
					break;
				default:
					$('#' + i).addClass('unattempted');
					break;
				}
			}
		}*/
		$('#side-nav').hide();
		$('#topic-head').html(this.model.get('l1DisplayName')+' : '+this.model.get('descriptionShort'));
	},

	/**
	 * TODO:video - just store the reference of the current video
	 */
	renderQuestion : function() {
		this.questionView.close();
		this.question = quizQuestions.get(this.questionIds[this.index]);
		if (this.question.get('timeTaken') == null) {
			this.question.set('timeTaken', 0);
		}
		this.questionView.model = this.question;
		$('#question').html(this.questionView.render().el);
		this.questionView.onRender();
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
	},
	
	close : function(){
		window.onbeforeunload = null;
		Backbone.View.prototype.close.call(this);
	}
});/**
 * The quiz views
 * 
 * @author ssachan
 * 
 */
window.QuizQuestionView = Backbone.View.extend({

    initialize: function () {},

    events: {
        'click #single-type button': 'handleSingleType',
        'click #multiple-type button': 'handleMultipleType',
        'keypress #integer-type': 'checkIntegerType',
        'change #integer-type': 'handleIntegerType',
        'click #matrix-type input': 'handleMatrixType',
    },

    handleSingleType: function (e) {
        var oldOptionSelected = this.model.get('optionSelected');
        var optionSelected = e.target.value;
        if (optionSelected === oldOptionSelected) {
            logs.addEntry("OPTION_DESELECT", this.model.get('id'),
            oldOptionSelected);
            this.model.set('optionSelected', null);
            $(e.target).removeClass('active');
            e.stopPropagation();
        } else {
            if (oldOptionSelected !== null) logs.addEntry("OPTION_DESELECT", this.model.get('id'),
            oldOptionSelected);
            logs.addEntry("OPTION_SELECT", this.model.get('id'),
            optionSelected);
            this.model.set('optionSelected', optionSelected);
        }
    },

    handleMultipleType: function (e) {
        var optionSelectedArray = [];
        var optionSelected = this.model.get('optionSelected');
        var optionLength = ((this.model.get('options'))
            .split(SEPARATOR)).length;
        if (optionSelected != null) {
            var temp = (optionSelected).split(SEPARATOR); // (SEPARATOR.SEPARATOR);
            for (var j = 0; j < optionLength; j++) {
                optionSelectedArray[j] = (temp.indexOf(''+j) != -1) ? 1 : 0;
            }
        } else {
            // fill all the fields with null
            for (var j = 0; j < optionLength; j++) {
                optionSelectedArray[j] = 0;
            }
        }
        // get the class for selected button...if its active then it has
        // been clicked again.
        var currentClass = e.target.getAttribute('class');
        var value = parseInt(e.target.getAttribute('value'));
        if (currentClass.indexOf('active') != -1) {
            // unselect this
            logs.addEntry("OPTION_DESELECT", this.model.get('id'),
            value);
            optionSelectedArray[value] = 0;
            // optionSelectedArray[value] = "";
        } else {
            logs.addEntry("OPTION_SELECT", this.model.get('id'), value);
            optionSelectedArray[value] = 1;
        }
        var temp = [];
        for (var i = 0; i < optionLength; i++) {
            if (optionSelectedArray[i]) {
                temp.push(i);
            }
        }
        optionSelected = temp.join(SEPARATOR);
        this.model.set('optionSelected', optionSelected);
    },

    checkIntegerType: function (e) {
        // we need to use a plug-in
        // https://github.com/SamWM/jQuery-Plugins/blob/master/numeric/jquery.numeric.js
        // or http://www.texotela.co.uk/code/jquery/numeric/
        // other scripts are buggy
    },

    handleIntegerType: function (e) {
        this.model.set('optionSelected', $('#integer-type').val());
        logs.addEntry("OPTION_SELECT", this.model.get('id'), this.model.get('optionSelected'));
    },

    handleMatrixType: function (e) {
        // tanujb:TODO:add logs
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
    	$(this.el).html(this.template(this.model.toJSON()));
    	this.delegateEvents();
        return this;
    },
    
    onRender : function (){
    	 this.renderOptions();
         $('#qtype').html(this.model.get('typeString'));
         $('#status').hide();
         $('#solution').hide();
         $('#q-video').hide();
         if (this.model.get('hasAttempted')) {
             this.renderInfo();
             $('#analytics').show();
             $('#hq').html('Solution');
         } else {
             logs.addEntry("QUESTION_OPEN", this.model.get('id'));
             $('#analytics').hide();
             $('#hq').html('Question');
         }
         // diable right click for this page
         $('.quizview').bind("contextmenu", function (e) {
             e.preventDefault();
         });
         var math = document.getElementById('quiz-view');
         MathJax.Hub.Queue(["Typeset", MathJax.Hub, math]);
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
        // tanujb:TODO:add retrieval of data
        var html = [];
        $('#single-type').hide();
        $('#multiple-type').hide();
        $('#integer-type').hide();
        $('#matrix-type').hide();

        $('#status').show();
        $('#options').show();
        $('#q-video').show();
        
        switch (this.model.get('typeId')) {
        case "1":
        	var status = this.model.get('status');
            if (status == null) {
            	html.push('<a class="pull-left" ><img class="media-object" src="img/cross.png"></a>');
                html.push('<div class="media-body">');
                html.push('<h3>YOU SELECTED NONE</h3>');
                html.push('<h3>CORRECT OPTION ' + String.fromCharCode(65 + parseInt(this.model.get('correctAnswer'))) + '</h3>');
                html.push('</div>');
            } else {
                if (status == true) {
                    html.push('<img class="media-object pull-left" src="img/tick.png">');
                    html.push('<div class="media-body">');
                    html.push('<h3>YOU MARKED OPTION ' + String.fromCharCode(65 + parseInt(this.model.get('optionSelected'))) + '</h3>');
                    html.push('</div>');
                } else if(status==false) {
                    html.push('<img class="media-object pull-left" src="img/cross.png">');
                    html.push('<div class="media-body">');
                    html.push('<h3>YOU MARKED OPTION ' + String.fromCharCode(65 + parseInt(this.model.get('optionSelected'))) + '</h3>');
                    html.push('<h3>CORRECT OPTION ' + String.fromCharCode(65 + parseInt(this.model.get('correctAnswer'))) + '</h3>');
                    html.push('</div>');
                }
            }
        	break;
        case "2":
        	var status = this.model.get('status');
        	var correctAnswerArray = (this.model.get('correctAnswer')).split(SEPARATOR);
        	var optionSelectedArray = null;
        	if(this.model.get('optionSelected')!=null){
        		optionSelectedArray = (this.model.get('optionSelected')).split(SEPARATOR);
        	}
            if (status == null) {
            	html.push('<a class="pull-left" ><img class="media-object" src="img/cross.png"></a>');
                html.push('<div class="media-body">');
                html.push('<h3>YOU SELECTED NONE</h3>');
                html.push('<h3>CORRECT OPTION ');
                for(var i = 0; i<correctAnswerArray.length;i++){
                	html.push(String.fromCharCode(65 + parseInt(correctAnswerArray[i]))+',');
                }
                html.push('</h3></div>');
            } else {
                if (status == true) {
                    html.push('<img class="media-object pull-left" src="img/tick.png">');
                    html.push('<div class="media-body">');
                    html.push('<h3>YOU MARKED OPTION ');
                    for(var i = 0; i<correctAnswerArray.length;i++){
                    	html.push(String.fromCharCode(65 + parseInt(correctAnswerArray[i]))+',');
                    }
                    html.push('</h3></div>');
                } else if(status==false) {
                    html.push('<img class="media-object pull-left" src="img/cross.png">');
                    html.push('<div class="media-body">');
                    html.push('<h3>YOU MARKED OPTION ');
                    var dummy = [];
                    for(var i = 0; i<optionSelectedArray.length;i++){
                        dummy.push(String.fromCharCode(65 + parseInt(optionSelectedArray[i])));
                    }
                    html.push(dummy.join(','));
                    html.push('</h3>');
                    html.push('<h3>CORRECT OPTION ');
                    var dummy = [];
                    for(var i = 0; i<correctAnswerArray.length;i++){
                    	dummy.push(String.fromCharCode(65 + parseInt(correctAnswerArray[i])));
                    	//html.push(String.fromCharCode(65 + parseInt(correctAnswerArray[i]))+',');
                    }
                    html.push(dummy.join(','));
                    html.push('</h3></div>');
                }
            }
        	break;
        case "3":
        	var status = this.model.get('status');
            if (status == null) {
            	html.push('<a class="pull-left" ><img class="media-object" src="img/cross.png"></a>');
                html.push('<div class="media-body">');
                html.push('<h3>YOU ANSWERED NONE</h3>');
                html.push('<h3>CORRECT ANSWER ' + this.model.get('correctAnswer') + '</h3>');
                html.push('</div>');
            } else {
                if (status == true) {
                    html.push('<img class="media-object pull-left" src="img/tick.png">');
                    html.push('<div class="media-body">');
                    html.push('<h3>YOU ANSWERED ' + this.model.get('optionSelected') + '</h3>');
                    html.push('</div>');
                } else if(status==false) {
                    html.push('<img class="media-object pull-left" src="img/cross.png">');
                    html.push('<div class="media-body">');
                    html.push('<h3>YOU ANSWERED ' + this.model.get('optionSelected') + '</h3>');
                    html.push('<h3>CORRECT ANSWER ' + this.model.get('correctAnswer') + '</h3>');
                    html.push('</div>');
                }
            }
        	break;
        case "4":
        	 // matrix type
        	var htmlOpt = [];
            var options = this.model.get('options');
            if(this.model.get('optionSelected')!=null){
        		optionSelectedArray = (this.model.get('optionSelected')).split(SEPARATOR + SEPARATOR);
        	}
            if(this.model.get('correctAnswer')!=null){
            	correctAnswerArray = (this.model.get('correctAnswer')).split(SEPARATOR + SEPARATOR);
        	}
        	var status = this.model.get('status');
            if (status == null) {
                html.push('<h3>YOU ANSWERED NONE</h3>');
            } else {
                if (status == true) {
                    html.push('<h3>YOU ANSWERED CORRECTLY</h3>');
                } else if(status==false) {
                    html.push('<h3>YOU ANSWERED INCORRECTLY</h3>');
                }
            }
            var optionsArray = options.split(SEPARATOR + SEPARATOR);
            var leftList = optionsArray[0].split(SEPARATOR);
            var rightList = optionsArray[1].split(SEPARATOR);
            var lLen = leftList.length;
            var rLen = rightList.length;
            // create the left right table
            html.push('<div class="span12">');
            html.push('<table class="table">');
            html.push('<tr><th>Option</th><th>Selected</th><th>Correct</th><th></th></tr>');
            //html.push('<ol type="1">');
            for (var i = 0; i < lLen; i++) {
                html.push('<tr><td>' + leftList[i]+'</td>');
                if (status != null){
                	var selectedOptArray = optionSelectedArray[i].split(SEPARATOR);
                	var len = selectedOptArray.length;
                	var dummy = [];
                	for(var j = 0; j< len; j++){
                		dummy.push(String.fromCharCode(65 + parseInt(selectedOptArray[j])));
                	}
                	html.push('<td>' + dummy.join(',') + '</td>');                
                }else{
                	html.push('<td>None</td>');
                }
                var correctOptArray = correctAnswerArray[i].split(SEPARATOR);
                var len = correctOptArray.length;
                var dummy = [];
                for(var j = 0; j< len; j++){
                	dummy.push(String.fromCharCode(65 + parseInt(correctOptArray[j])));
                }
                html.push('<td>'+dummy.join(',')+'</td>');
                if(optionSelectedArray[i]==correctAnswerArray[i]){
                	html.push('<td><img class="media-object pull-left" src="img/tick.png" style="margin:0px;width: 20px;"></td>');
                }else{
                	html.push('<td><img class="media-object pull-left" src="img/cross.png" style="margin:0px;width: 20px;"></td>');
                }
                html.push('</tr>');
            }
            html.push('</table>');
            html.push('</div>');
            break;        	
        }
        $('#stathead').html(html.join(' '));
        $('#diff').html(this.model.get('difficulty'));
        $('#avgAcc').html(this.model.get('averageCorrect'));
        $('#avgTime').html(helper.formatTime(this.model.get('timeTaken')));
        $('#tags').html(this.model.get('tagIds'));
        $('#solutionText').html(this.model.get('explanation'));
        $('#solution').show(); 
        jwplayer("analysis-video-"+this.model.get('id')).setup({ //::video::QuizQuestion 
                        file: this.model.get('videoSrc'),
                        image: this.model.get('posterSrc'),
                        startparam: "start",
                        height : 360,
                        width: 640,
                        autostart : true,
                        fallback : false,
                        primary: "flash" //,
                        	
                        /*playlist: [{
                            title: "",
                            description: "",
                            image: "",
                            sources : [{file: "", label: "360p"}]
                        }],*/
                        //skin : "",
                        /*listbar: {
                                    position: 'bottom',
                                    size: 180
                                 },*/
                    });
        $('#time').html(helper.formatTime(this.model.get('timeTaken')));
        $('#submit').hide();
    }
});/**
 * The quiz library view
 * 
 * @author ssachan
 * 
 */
window.QuizLibraryView = Backbone.View.extend({
	className : "container quiz-library",

	initialize : function() {
		this.filtered = new QuizCollection();
		this.type = '0';
		this.l1 = '0';
		this.tness = '0';
		this.rec = '0';
	},

	events : {
		'change #f-type' : 'typeFilter',
		'change #f-l1' : 'l1Filter',
		'change #f-tness' : 'tnessFilter',
		'click #s-rec' : 'recSort',
	},

	typeFilter : function(e) {
		this.type = $("#f-type option:selected").val();
		this.renderQuizItems();
	},

	l1Filter : function(e) {
		this.l1 = $("#f-l1 option:selected").val();
		this.renderQuizItems();
	},

	tnessFilter : function(e) {
		this.tness = $("#f-tness option:selected").val();
		this.renderQuizItems();
	},

	recSort : function(e) {
		this.rec = (this.rec == '1') ? 0 : 1;
		this.renderQuizItems();
	},

	render : function() {
		$(this.el).html(this.template());
		return this;
	},

	onRender : function() {
		$('.selectpicker').selectpicker();
		this.renderQuizItems();
	},

	renderQuizItems : function() {
		$("#pCarousel").empty();
		$("#cCarousel").empty();
		$("#mCarousel").empty();
		this.filtered.reset(this.collection.models);
		if (this.l1 != '0') {
			var filteredArray = this.filtered.where({
				l1 : this.l1
			});
			this.filtered.reset(filteredArray);
		}
		if (this.tness != '0') {
			var filteredArray = this.filtered.where({
				difficulty : this.tness
			});
			this.filtered.reset(filteredArray);
		}
		if (this.rec == '1') {
			var sortedCollection = this.filtered.sortBy(function(quiz) {
				return -parseInt(quiz.get("rec"));
			});
			this.filtered.reset(sortedCollection);
		}
		var subject = ["#mCarousel","#pCarousel","#cCarousel"];
		for(var k = 0; k<3; k++)
		{
			this.filtered.reset(this.collection.models);
			var filteredArray = this.filtered.where({
					l1 : k+1+''
			});
			this.filtered.reset(filteredArray);
			
			var quizzes = this.filtered.models;
			var len = quizzes.length;
			if (len == 0) {
				$(subject[k]).html('<h3>No quizzes found. Try again...</h3>');
				return;
			}

			var i = 0;
			while (i < len) {
				$(subject[k]).append('<div class="item"><ul class="thumbnails lol"></ul></div>');
				for ( var j = 0; j < 3 && i < len; j++) {
					$(".lol:last").append("<li> "+subject[k] + " "+ i +"</li>");
					/*new QuizItemView({
						model : quizzes[i]
					}).render().el*/
					i++;
				}
				$('.lol').removeClass('lol');
			}
		}
	}
});

window.QuizItemView = Backbone.View.extend({

	tagName : "li",

	className : "span3",

	initialize : function() {
		this.render();
	},

	events : {
		'click .box' : 'onQuizItemClick',
	},

	onQuizItemClick : function() {
		if(this.model.get('available') == '2'){
			return;
		}
		if (this.model.get('hasAttempted') == true) {
			return;
			// alert('quiz purchased. Access it from My PrepSets space');
			// window.location = '#quiz/' + this.model.get('id');
		} else if (this.model.get('status') == this.model.STATUS_NOTSTARTED) {
			mView.model = this.model;
			mView.show();
		} else {
			window.location = '#quiz/' + this.model.get('id');
		}
	},

	render : function() {
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	},
});
/**
 * The fac directory view
 * 
 * @author ssachan
 * 
 */
window.FacDirectoryView = Backbone.View.extend({
	className : "container fac-dir",

	initialize : function() {
		this.filtered = new FacCollection();
		this.letters = '';
		this.type = '0';
		this.l1 = '0';
		this.totalTests='0';
		this.rec = '0';
	},	

	events : {
		'keyup #s-name' : 'nameSearch',
		'change #f-l1' : 'l1Filter',
		'click #s-rec' : 'recSort',
		'click #s-tests' : 'testsSort',
	},
	
	nameSearch : function (){
		this.letters = $('#s-name').val();
		this.renderFacItems();
	},
	
	l1Filter : function (e){
		this.l1 = $("#f-l1 option:selected").val();
		this.renderFacItems();
	},

	
	recSort : function(e){
		this.rec = (this.rec=='1')?0:1;
		this.renderFacItems();
	},
	
	testsSort : function(e){
		this.totalTests = (this.totalTests=='1')?0:1;
		this.renderFacItems();
	},
		
	render : function() {
		$(this.el).html(this.template());
		return this;
	},
	
	onRender : function() {
		$('.selectpicker').selectpicker({
			btnStyle : 'btn-small'
		});
		this.renderFacItems();
	},

	renderFacItems : function (){
		$("#fac-list").empty();
    	this.filtered.reset(this.collection.models);
    	if(this.letters!=''){
    		var pattern = new RegExp(this.letters,'gi');
    		var res = this.filtered.filter(function(data) {
    		  	if(pattern.test(data.get('firstName')) || pattern.test(data.get('lastName'))){
    		  		return true;
    		  	}
    		});
    		this.filtered.reset(res);
    	}
    	
    	if(this.l1!='0'){
    		var filteredArray = this.filtered.where({l1Ids: this.l1});
			this.filtered.reset(filteredArray);
    	}
    	if(this.rec=='1'){
    		var sortedCollection = this.filtered.sortBy(function(fac){
    			  return -parseInt(fac.get("rec"));
    			});
			this.filtered.reset(sortedCollection);
    	} 
    	if(this.totalTests=='1'){
    		var sortedCollection = this.filtered.sortBy(function(fac){
    			  return -parseInt(fac.get("totalQuizzes"));
    			});
			this.filtered.reset(sortedCollection);
    	} 
    	var facs = this.filtered.models;
        var len = facs.length;
		if (len == 0) {
			$('#fac-list', this.el).html('<h3>No faculty found. Try again...</h3>');
			return;
		}
		$('#fac-list', this.el).html('');
    	for ( var i = 0; i < len; i++) {
			$('#fac-list', this.el).append(new FacItemView({
				model : facs[i]
			}).render().el);
		}
	}
});

window.FacItemView = Backbone.View.extend({
	tagName :'li',
	className : 'fac-item box',
	initialize : function() {
		this.render();
	},

	render : function() {
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	},

});
/**
 * The modal view
 * 
 * @author ssachan
 * 
 */

window.ModalView = Backbone.View.extend({
	
	initialize : function() {
		this.state = false;
	},

	events : {
		//'click .close' : 'close',
		'hidden #modal' : 'close'
	},

	render : function() {
		this.$el.html(this.template(this.model.toJSON()));
		return this;
	},

	show : function() {
		this.state = true;
		$(document.body).append(this.render().el);
		//myPlayer = _V_("intro-vid-"+this.model.get('id'), { "techOrder": ["flash"]});
		//::video:ModalView
         jwplayer("intro-vid-"+this.model.get('id')).setup({
                        file: "videos/s"+this.model.get('id')+"introvid1.mp4",
                        image: "img/introvid.png",
                        startparam: "start",
                        height : 270,
                        width : 520,
                        autostart : true,
                        fallback : false,
                        primary: "flash"
                        /*playlist: [{
                        	title: "",
                        	description: "",
                        	image: "",
							sources : [{file: "", label: "360p"}]
                        }],*/
                        /*listbar: {
							        position: 'bottom',
							        size: 180
							     },*/
                    });
		if(account.get('id')!=null){
			// check if credits exist
			if(parseInt(account.get('quizzesRemaining'))>0){
				$('#take-btn').append('<a href="#quiz/'+this.model.get('id')+'" class="btn blue-btn">START TEST</a>');
			}else{
				$('#take-btn').append('<a href="#packages" class="btn blue-btn">You need to purchase a package to take this quiz.CLICK</a>');
			}
		}else{
			$('#take-btn').append('<a href="#signup" class="btn blue-btn">Log-In/Sign-Up to take Test</a>');
		}
        $('#modal').modal({backdrop:true});
	},

	close : function() {
		if(this.state != true){
			return;
		}
		$('#modal').modal('hide');
		this.state =false;
		//::video::
		jwplayer("intro-vid-"+this.model.get('id')).onReady(function(){jwplayer("intro-vid-"+this.model.get('id')).remove();});
		this.remove();
	},
});
window.SignUpView = Backbone.View.extend({

    initialize:function () {
    },

    render:function () {
        $(this.el).html(this.template());
        return this;
    },
    
    onRender : function(){
    	$('#login-box').append(new LoginBox({model:this.model}).render().el);
    	$('#signup-box').append(new SignUpBox({model:this.model}).render().el);
    }
});

window.LoginBox = Backbone.View.extend({

    initialize:function () {
        console.log('Initializing Login View');
    },

    events: {
        'click #loginButton': 'login',
        'click #flogin' : 'fConnect',
    	'click #glogin' : 'gConnect',
    },

    render:function () {
        $(this.el).html(this.template());
        return this;
    },
    
    fConnect : function() {
        this.model.set('type', 2);
		user.login();
	},

	gConnect : function() {
        this.model.set('type', 3);
		glogin();
	},
	
    login:function (event) {
        event.preventDefault(); // Don't let this button submit the form
    	this.model.login($('#email-lg').val(), $('#pass-lg').val());
    	//event.preventDefault(); // Don't let this button submit the form
       //$('.alert-error').hide(); // Hide any errors on a new submit        
    },
    
    
    
});

window.SignUpBox = Backbone.View.extend({

    initialize:function () {
        console.log('Initializing SignUp View');
    },

    events: {
        "click #signupButton": "signup",
        "click #inviteButton": "invite",
    },

    render:function () {
        $(this.el).html(this.template());
        return this;
    },
    
    ccSignUp:function (event) {
        event.preventDefault(); // Don't let this button submit the form
    	var formValues = {
    			email : $('#email-su').val(),
    			password :  $('#pass-su').val(),
    			cPassword :  $('#passcon-su').val(),
    			firstName : $('#fname-su').val(),
    			lastName : 'dummy',
    			ccode : $('#ccode').val(),
    			streamId : streamId,
    		};
        this.model.ccSignUp(formValues);
    },
    
    signup:function (event) {
        event.preventDefault(); // Don't let this button submit the form
    	var formValues = {
    			email : $('#email-su').val(),
    			password :  $('#pass-su').val(),
    			cPassword :  $('#passcon-su').val(),
    			firstName : $('#fname-su').val(),
    			lastName : 'dummy',
    			streamId : streamId,
    		};
        this.model.signUp(formValues);
        //this.model.set('type', 1);
        /*
         //Test type 2 auth
         var formValues = {
        	bio: "find my scribbling here - http://greypad.thinkpluto.com/",
            email: "shikhar.sachan@gmail.com",
            first_name: "Shikhar",
            gender: "male",
            id: "675467514",
            last_name: "Sachan",
            link: "https://www.facebook.com/shikhar.sachan",
            locale: "en_US",
            name: "Shikhar Sachan",
            pictures: Object,
            quotes: "you loose 100 % of the shots you don't take ...",
            timezone: 5.5,
            updated_time: "2012-08-18T16:31:31+0000",
            username: "shikhar.sachan",
            type : 2,
			streamId : streamId,
        };
        this.model.signUp(formValues);
        */
    },
    
    invite:function (event) {
        event.preventDefault(); // Don't let this button submit the form
    	var formValues = {
    			email : $('#email-su').val(),
    			firstName : $('#fname-su').val(),
    			lastName : 'dummy',
    			streamId : streamId,
    		};
        this.model.invite(formValues);
    }

});

window.ForgotPassView = Backbone.View.extend({

    initialize:function () {
        console.log('initializing forgot pass view');
    },

    events: {
        "click #forgotPassButton": "forgotPass"
    },

    render:function () {
        $(this.el).html(this.template());
        return this;
    },

    forgotPass:function (event) {
        event.preventDefault(); // Don't let this button submit the form
    	this.model.forgotPass($('#forgotPassEmail').val());
    }
});

window.ChangePassView = Backbone.View.extend({
	className : 'container forgotpass',
	
    initialize:function () {
        console.log('initializing change pass view');
    },

    events: {
        "click #changePassButton": "changePass"
    },

    render:function () {
        $(this.el).html(this.template());
        return this;
    },

    changePass:function (event) {
        event.preventDefault(); // Don't let this button submit the form
    	this.model.changePass($('#currPassword').val(), $('#newPassword').val());
    }
});/**
 * The fac directory view
 * @author ssachan 
 * 
 **/
window.PackagesView = Backbone.View.extend({
	
	className : "container packages",

    initialize: function () {
    	this.render();
    },

    render: function () {
        $(this.el).html(this.template());
        return this;
    },
    
    onRender : function (){
     	var packages = this.collection.models;
        var len = packages.length;
		var i = 0;
		while (i < len) {
			$("#package-list").append('<ul class="thumbnails"></ul>');
			for ( var j = 0; j < 3 && i < len; j++) {
				$(".thumbnails:last").append(new PackageItemView({
					model : packages[i]
				}).render().el);
				i++;
			}
		}
    }
});

window.PackageItemView = Backbone.View.extend({
	tagName : "li",
	
	className : "span4",
	
	initialize: function () {
	},
	
	events : {
		'click #purchase' : 'purchase',
	},
	
	purchase : function(){
		this.model.purchase();
	},
	
	render : function() {
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	},

});
/**
 * The fac profile view
 * 
 * @author ssachan
 * 
 */

window.FacView = Backbone.View.extend({
	
	className : "container fac-profile",
	
	initialize : function() {
		_.bindAll(this, "render");
		this.model.bind('change', this.render);
	},
	
	events : {
		'click #recommendFac' : 'recommendFac'
	},
	
	recommendFac : function (){
		this.model.addReco();
	},
	
	render : function() {
		if(account.get('id')){
			this.model.set('loggedIn',true);
			$(this.el).html(this.template(this.model.toJSON()));
		}else{
			this.model.set('loggedIn',false);
			$(this.el).html(this.template(this.model.toJSON()));
		}
		return this;
	},
	
	renderQuizzes : function(){
		var quizzes = this.collection.models;
        var len = quizzes.length;
        var i = 0;
        while(i<len){
        	$("#quizzes").append('<ul class="thumbnails"></ul>');
        	for (var j = 0; j < 4&&i<len; j++) {
        		quizzes[i].set('fid',this.model.get('id'));
        		quizzes[i].set('fdpURL',this.model.get('dpUrl'));
        		quizzes[i].set('firstName',this.model.get('firstName'));
        		quizzes[i].set('lastName',this.model.get('lastName'));
        		quizzes[i].set('bioShort',this.model.get('bioShort'));
        		quizzes[i].set('education',this.model.get('education'));
        		$(".thumbnails:last").append(new QuizItemView({model: quizzes[i]}).render().el);
        		i++;
        	}
        }
	},
});window.FacContactView = Backbone.View.extend({

    initialize:function () {
        console.log('Initializing faculty contact View');
        this.render();
    },

    events: {
        'click #contactButton': 'submitContactForm',
    },

    render:function () {
        $(this.el).html(this.template());
        return this;
    },

    submitContactForm:function (event) {
    	var formValues = {
    			email : $('#email').val(),
    			firstName : $('#fname').val(),
    			lastName : $('#lname').val(),
    			phoneNumber : $('#phone').val(),
    			about : $('#about').val(),
			};
        event.preventDefault(); // Don't let this button submit the form
		var url = Config.serverUrl + 'facContact/';
        return $.ajax({
			url : url,
			type : 'POST',
			dataType : "json",
			data : formValues,
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					
				} else { // If not, send them back to the home page
					helper.showError(data.data);
				}
			}
		});
    }
});
/**
 * The fac directory view
 * 
 * @author ssachan
 * 
 */
window.ReviewView = Backbone.View.extend({

	initialize : function() {
		this.filtered = new FacCollection();
		this.l1 = '0';
		this.l2 = '0';
		this.l3 = '0';
		this.tness = '0';
		this.status = '0';
	},	

	events : {
		'change #f-tness' : 'tnessFilter',
		'change #f-status' : 'statusFilter',
		'change #f-l1' : 'l1Filter',
	},
	
	l1Filter : function (e){
		this.l1 = $("#f-l1 option:selected").val();
		this.renderQuestionItems();
	},

	tnessFilter : function (e){
		this.tness = $("#f-tness option:selected").val();
		this.renderQuestionItems();
	},
	
	statusFilter : function (e){
		this.status = $("#f-status option:selected").val();
		this.renderQuestionItems();
	},
	
	render : function() {
		$(this.el).html(this.template());
		return this;
	},
	
	onRender : function (){
		$('.selectpicker').selectpicker();
		this.renderQuestionItems();
	},
	
	renderQuestionItems : function (){
		$("#q-list").empty();
    	this.filtered.reset(this.collection.models);
    	if(this.l1!='0'){
    		var filteredArray = this.filtered.where({l1Id: this.l1});
			this.filtered.reset(filteredArray);
    	}
    	if(this.tness!='0'){
    		var filteredArray = this.filtered.where({difficulty: this.tness});
			this.filtered.reset(filteredArray);
    	}
    	
    	if(this.status=='1'){
    		var filteredArray = this.filtered.where({isCorrect: true});
			this.filtered.reset(filteredArray);
    	} else if(this.status=='2'){
    		var filteredArray = this.filtered.where({isCorrect: false});
			this.filtered.reset(filteredArray);	
    	}
    	
    	var questions = this.filtered.models;
        var len = questions.length;
		if (len == 0) {
			$('#q-list', this.el).html('<h3>No questions found. Try again...</h3>');
			return;
		}
		$('#q-list', this.el).html('');
    	for ( var i = 0; i < len; i++) {
			$('#q-list', this.el).append(new QuestionItemView({
				model : questions[i]
			}).render().el);
		}
        var math = document.getElementById('q-list');
        MathJax.Hub.Queue(["Typeset", MathJax.Hub, math]);
	}
});

window.QuestionItemView = Backbone.View.extend({
	tagName :'tr',
	initialize : function() {
	},

	render : function() {
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	},

});

window.ReviewQuestionView = Backbone.View.extend({
	className :'container reviewq',
	initialize : function() {
		this.qView = new QuizQuestionView();
	},

	render : function() {
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	},
	
	onRender : function(){
		this.qView.model = this.model;
		$('#r-question').html(this.qView.render().el);
		this.qView.onRender();
	}
});
window.ResultsView = Backbone.View.extend({

	initialize : function() {
		this.activeView=null;
	},
	
	events : {
		'click .resnav>li' : 'onNavClick',
		'click #recommendQuiz' : 'recommendQuiz'
	},
	
	recommendQuiz : function (){
		this.model.addReco();
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

	calculateVideoArray : function(options) { //::video::

		var videoResults = [];
		
		_.each(options,function(item)
		{
			videoResultObject = 
			{
	        	title: (item.title || ""),
	        	description: (item.desc || ""),
	        	image: item.posterSrc,
				sources : [{file: item.videoSrc, label: "360p"}]
	        }

			videoResults.push(videoResultObject);
		});
		return videoResults;
	},

	setUpPlaylist : function(videoResults) { //::video::

		//::video::Playlist
		jwplayer("results_video").setup({
                        startparam: "start",
                        height : (640+210),
                        width: 360,
                        autostart : true,
                        fallback : false,
                        primary: "flash",
                        playlist: videoResults,
                        //skin : "",
                        listbar: {
							        position: 'right',
							        size: 210
							     }
                    });

/*
		myPlayer.addEvent("ended", function() {

			myPlayer.playlist.next();

		}); // enables autoplay of next
*/
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
		$("#video").html('<video id="results_video" class="video-js atlantis" controls preload="none" width="640" height="264" data-setup="{}"></video>');
		//::video::
		var videoResults = this.calculateVideoArray(this.model.get('videoArray'));
		this.setUpPlaylist(videoResults);
		var l3GraphData = this.model.get('l3GraphData');
		if(l3GraphData){
			var html=[];
			var len = l3GraphData.length;
			for(var i=0; i< len; i++){
				var l3Data = l3GraphData[i];
				
				html.push('<div class="grey-box"><div class="row-fluid"><div class="span8">');
				html.push('<h3><span class="blue">'+(sectionL3.get(l3Data.lId)).get('displayName')+'</span><span style="orange"> : '+(parseInt(l3Data.scoreBefore)+parseInt(l3Data.delta))+'</span>');
				if(parseInt(l3Data.delta)>0){
					html.push('<span style="float:right"> +'+parseInt(l3Data.delta)+'</span>');
				}else{
					html.push('<span style="float:right"> +'+parseInt(l3Data.delta)+'</span>');
				}
				html.push('</h3><hr>');
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
/**
 * The mysets views
 * 
 * @author ssachan
 * 
 */

window.MySetsView = Backbone.View.extend({
	
	initialize : function() {
		this.historyView = new HistoryView({collection:this.collection});
	},
	
	render : function(){
		$(this.el).html(this.template());
		return this;
	},
	
	onRender : function(){
		this.historyView.render();
	}
});

window.HistoryView = Backbone.View.extend({
    initialize: function () {
    },

    render: function () {
        var quizzes = this.collection.models;
        var paused =[];
        var history = [];
        var interruped = [];
        var len = quizzes.length;
        for (var i=0;i<len;i++){
        	var quiz = quizzes[i];
        	switch (quiz.get('status')) {
			case quiz.STATUS_COMPLETED:
				history.push(quiz);
				break;

			case quiz.STATUS_INPROGRESS:
				paused.push(quiz);
				break;

			case quiz.STATUS_INTERRUPTED:
				interruped.push(quiz);
				break;
			}
        }
       
        len = paused.length;
        var i = 0;
        if (len == 0) {
            $("#paused").append('You dont have any paused tests.');
        }
        while (i < len) {
            $('#paused').append('<ul class="thumbnails"></ul>');
            for (var j = 0; j < 3 && i < len; j++) {
                $('.thumbnails:last','#paused').append(new QuizItemView({
                    model: paused[i]
                }).render().el);
                i++;
            }
        }
        len = interruped.length;
        i = 0;
        if (len == 0) {
            //$("#interruped").append('You dont have any interrupted tests');
        }
        while (i < len) {
            $('#interruped').append('<ul class="thumbnails"></ul>');
            for (var j = 0; j < 3 && i < len; j++) {
                $('.thumbnails:last','#interruped').append(new QuizItemView({
                    model: interruped[i]
                }).render().el);
                i++;
            }
        }
        len = history.length;
        i = 0;
        if (len == 0) {
            $("#history").append('You have not taken any tests. Please take a test to update your history');
        }
        while (i < len) {
            $('#history').append('<ul class="thumbnails"></ul>');
            for (var j = 0; j < 3 && i < len; j++) {
                $('.thumbnails:last','#history').append(new QuizItemView({
                    model: history[i]
                }).render().el);
                i++;
            }
        }
    }
});