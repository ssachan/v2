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
		if (this.hasAttempted) {
			this.setUp();
		}
		timer.setUpdateFunction(context.updateQuizTimer, [ context ]);
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
		'click #submit' : 'submitQuiz',
		'click #analytics' : 'switchAnalytics'
	},

	switchAnalytics : function() {
		this.switchView('results');
	},

	startQuiz : function() {
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
		this.hasAttempted = true;
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
		if (!this.hasAttempted) {
			this.question.get('closeTimeStamps').push(new Date().getTime());
		}
		this.index--;
		if (this.index < 0) {
			return;
		}
		this.renderQuestion();
	},

	onNextClick : function() {
		if (!this.hasAttempted) {
			this.question.get('closeTimeStamps').push(new Date().getTime());
		}
		this.index++;
		if (this.index >= this.totalQuestions) {
			return;
		}
		this.renderQuestion();
	},

	onQNoClick : function(e) {
		this.index = e.target.getAttribute('id'); // .split('-')[1];
		if (!this.hasAttempted) {
			this.question.get('closeTimeStamps').push(new Date().getTime());
		}
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
		this.questionView.model = this.question;
		this.questionView.hasAttempted = this.hasAttempted;
		this.questionView.render();
		$("#qnum").html((parseInt(this.index) + 1));
		$("#qtotal").html((this.totalQuestions));
		this.question.get('openTimeStamps').push(new Date().getTime());
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

window.QuizQuestionView = Backbone.View
		.extend({

			initialize : function() {
			},

			events : {
				'click #single-type button' : 'handleSingleType',
				'click #multiple-type button': 'handleMultipleType',
				'keypress #integer-type' : 'checkIntegerType',
				'keyup #integer-type' : 'handleIntegerType',
				'click #matrix-type input' : 'handleMatrixType',				
			},
		
			handleSingleType : function(e) {
				var oldOptionSelected = this.model.get('optionSelected');
				var optionSelected = e.target.value;
				if (optionSelected == oldOptionSelected) {
					this.model.set('optionSelected', null);
					if (!this.model.get('optionUnSelectedTimeStamps')[optionSelected]) {
						this.model.get('optionUnSelectedTimeStamps')[optionSelected] = new Array();
					}
					(this.model.get('optionUnSelectedTimeStamps')[optionSelected])
							.push(new Date().getTime());
					$(e.target).removeClass('active');
	                e.stopPropagation();
				} else {
					this.model.set('optionSelected', optionSelected);
					if (!this.model.get('optionSelectedTimeStamps')[optionSelected]) {
						this.model.get('optionSelectedTimeStamps')[optionSelected] = new Array();
					}
					(this.model.get('optionSelectedTimeStamps')[optionSelected])
							.push(new Date().getTime());
				}
			},

			handleMultipleType : function(e) {
				var optionSelectedArray = [];
				var optionSelected = this.model.get('optionSelected');
				if (optionSelected != null) {
					optionSelectedArray = (optionSelected).split(SEPARATOR);//(SEPARATOR.SEPARATOR);
				}else{
					// fill all the fields with null
					var len = ((this.model.get('options')).split(SEPARATOR)).length;
					for (var j =0 ; j<len; j++){
						optionSelectedArray[j] = null;
					}
				}
				var finalOptions = [];
				len = optionSelectedArray.length;
				for(var i=0;i<len;i++){
					if(optionSelectedArray[i]!=null){
						finalOptions[parseInt(optionSelectedArray[i])]=true;
					}
				}
				// get the class for selected button...if its active then it has been clicked again. 
				var currentClass = e.target.getAttribute('class');
				var value = parseInt(e.target.getAttribute('value'));
				if(currentClass.indexOf('active')!=-1){
					// unselect this 
					finalOptions[value] = false;					
					//optionSelectedArray[value] = "";
				}else {
					finalOptions[value] = true;					
				}
				optionSelectedArray.length=0;
				len = finalOptions.length;
				for(i=0;i<len;i++){
					if(finalOptions[i]==true){
						optionSelectedArray.push(i);
					}
				}
				this.model.set('optionSelected',optionSelectedArray.join(SEPARATOR));				
			},
			
			checkIntegerType : function (e){
				// we need to use a plug-in
				// https://github.com/SamWM/jQuery-Plugins/blob/master/numeric/jquery.numeric.js
				// or http://www.texotela.co.uk/code/jquery/numeric/
				// other scripts are buggy
			},
			
			handleIntegerType : function(e) {
				this.model.set('optionSelected', $('#integer-type').val());
			},

			handleMatrixType : function(e) {
				var optionSelectedArray = [];
				var optionSelected = this.model.get('optionSelected');
				if (optionSelected != null) {
					optionSelectedArray = (optionSelected).split(SEPARATOR+SEPARATOR);//(SEPARATOR.SEPARATOR);
				}else{
					// fill all the fields with null
					var len = (((this.model.get('options')).split(SEPARATOR+SEPARATOR))[0]).split(SEPARATOR).length;
					for (var j =0 ; j<len; j++){
						optionSelectedArray[j] = null;
					}
				}
				// get all checks for this particular row and add to the solution
				var checkboxSelected = (e.target).getAttribute('name');
				var index = parseInt((checkboxSelected.split('-'))[1]);
				// var checks = $('.myCheckbox').attr('checked','checked');
				var selectedChecks = $("."+checkboxSelected+":checked");
				var optionAtIndex = [];
				var len = selectedChecks.length;
				for(var i = 0 ; i < len; i++){
					optionAtIndex.push(selectedChecks[i].value);
				}
				optionSelectedArray[index] = optionAtIndex.join(SEPARATOR);
				this.model.set('optionSelected',optionSelectedArray.join(SEPARATOR+SEPARATOR));
			},

			render : function() {
				$('#question').html(this.template(this.model.toJSON()));
				this.renderOptions();
				$('#solution').hide();
				if (this.hasAttempted) {
					this.renderInfo();
					$('#analytics').show();
				}else{
					$('#analytics').hide();
				}
				//diable right click for this page
				$('.quizview').bind("contextmenu", function(e) {
	                e.preventDefault();
	            });
				return this;
			},

			renderOptions : function() {
				var htmlOpt = [];
				var buttonOpt = [];
				var options = this.model.get('options');
				var optionSelected = this.model.get('optionSelected');
				switch (this.model.get('typeId')) {
				case "1":
					// single option
					htmlOpt
							.push('<div class="span10"><div class="option-box"><ol type="A">');
					buttonOpt
							.push('<div class="span2 btn-group" data-toggle="buttons-radio" id="single-type">');
					var optionsArray = options.split(SEPARATOR);
					var len = optionsArray.length;
					for ( var i = 0; i < len; i++) {
						htmlOpt.push('<li>' + optionsArray[i] + '</li>');
						if (optionSelected != null && optionSelected == i) {
							buttonOpt
									.push('<button type="button" name="option" value="'
											+ i
											+ '" class="btn btn-large btn-block active">'
											+ String.fromCharCode(65 + i)
											+ '</button>');
						} else {
							buttonOpt
									.push('<button type="button" name="option" value="'
											+ i
											+ '" class="btn btn-large btn-block">'
											+ String.fromCharCode(65 + i)
											+ '</button>');
						}
					}
					htmlOpt.push('</ol></div></div>');
					buttonOpt.push('</div>');
					$('#options').html(htmlOpt.join(''));
					$('#options').append(buttonOpt.join(''));
					break;
				case "2":
					// multiple option
					htmlOpt
							.push('<div class="span10"><div class="option-box"><ol type="A">');
					buttonOpt
							.push('<div class="span2 btn-group" data-toggle="buttons-checkbox" id="multiple-type">');
					var optionsArray = options.split(SEPARATOR);
					var len = optionsArray.length;
					var optionSelectedArray = [];
					if (optionSelected != null) {
						optionSelectedArray = optionSelected.split(SEPARATOR);
					}
					for ( var i = 0; i < len; i++) {
						htmlOpt.push('<li>' + optionsArray[i] + '</li>');
						if (jQuery.inArray(i.toString(), optionSelectedArray) >= 0) {
							buttonOpt
									.push('<button type="button" name="mult" value="'
											+ i
											+ '" class="btn btn-large btn-block active">'
											+ String.fromCharCode(65 + i)
											+ '</button>');
						} else {
							buttonOpt
									.push('<button type="button" name="mult" value="'
											+ i
											+ '" class="btn btn-large btn-block">'
											+ String.fromCharCode(65 + i)
											+ '</button>');
						}
					}
					htmlOpt.push('</ol></div></div>');
					buttonOpt.push('</div>');
					$('#options').html(htmlOpt.join(''));
					$('#options').append(buttonOpt.join(''));
					break;
				case "3":
					// integer type
					htmlOpt
							.push('<input type="number" id="integer-type" value="'
									+ optionSelected + '">');
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
					for ( var i = 0; i < lLen; i++) {
						htmlOpt.push('<li>' + leftList[i] + '</li>');
					}
					htmlOpt.push('</ol></td><td>');
					htmlOpt.push('<ol type="A">');
					for ( var i = 0; i < rLen; i++) {
						htmlOpt.push('<li>' + rightList[i] + '</li>');
					}
					htmlOpt.push('</ol></td></tr></table>');
					htmlOpt.push('</div>');
						
					// create the checkboxes table
					var optionSelectedArray = [];
					if (optionSelected != null) {
						optionSelectedArray = optionSelected.split(SEPARATOR+SEPARATOR);
					}
					buttonOpt.push('<div class="span6">');
					buttonOpt.push('<table class="table" id="matrix-type">');
					// define the top row
					buttonOpt.push('<tr><td></td>');
					for ( var j = 0; j < rLen; j++) {
						buttonOpt.push('<td>'+ String.fromCharCode(65 + j)+ '</td>');
					}
					buttonOpt.push('</tr>');
					//create checkboxes
					for (i = 0; i < lLen; i++) {
						buttonOpt.push('<tr><td>' + (i) + '</td>');
						for ( var j = 0; j < rLen; j++) {
							if(optionSelectedArray[i]!=null && optionSelectedArray[i].indexOf(j)!=-1){
								buttonOpt
								.push('<td><input type="checkbox" name="multicheck-'
										+ i
										+ '" class="multicheck-'
										+ i
										+ '" value="'+j+'" checked></td>');
							}else{
								buttonOpt
								.push('<td><input type="checkbox" name="multicheck-'
										+ i
										+ '" class="multicheck-'
										+ i
										+ '" value="'+j+'"></td>');
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
								'<br><div class="stats"><span class="green bold">Average Correct</span>:'
										+ this.model.get('averageCorrect')
										+ '<span class="green bold"> Average Time</span> :'
										+ this.model.get('averageTimeCorrect')
										+ '<span class="badge badge-success">2012 CAT</span></div>');
				// code to add video here.

				/*
				 * <video id="analysis_video" class="video-js vjs-default-skin"
				 * controls preload="none" width="640" height="264" poster="<%=
				 * this.model.get('videoData').poster %>" data-setup="{}">
				 * <source src="<%= this.model.get('videoData').src %>"
				 * type='video/mp4' /> </video>
				 */

				$('#time').html(this.model.get('timeTaken'));
				$('#submit').hide();
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
