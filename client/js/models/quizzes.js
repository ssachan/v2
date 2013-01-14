/**
 * The Quiz Model
 * 
 * @author ssachan
 * 
 */
window.Quiz = Backbone.Model
		.extend({
			urlRoot : Config.serverUrl + 'quizzes/',

			STATUS_NOTSTARTED : 0, // when the quiz is fresh from the library
			STATUS_COMPLETED : 1, // when the quiz is completed
			STATUS_INPROGRESS : 2, // when the attemptedAs is set and the quiz
			// is in progress
			STATUS_INTERRUPTED : 3,// when the attemptedAs is not set

			initialize : function() {
				this.set('status', this.STATUS_NOTSTARTED);

				if (!this.get('questionIdsArray')) {
					this.set({
						questionIdsArray : new Array()
					});
				}
				if (!this.get('selectedAnswersArray')) {
					this.set({
						selectedAnswersArray : new Array()
					});
				}
				if (!this.get('timePerQuestionArray')) {
					this.set({
						timePerQuestionArray : new Array()
					});
				}
				if (this.get('questionIds') != null) {
					this.get('questionIdsArray').push.apply(this
							.get('questionIdsArray'), this.get('questionIds')
							.split(SEPARATOR));
				}
				if (this.get('selectedAnswers') != null) {
					this.get('selectedAnswersArray').push.apply(this
							.get('selectedAnswersArray'), JSON.parse(this
							.get('selectedAnswers')));
				}
				if (this.get('timePerQuestion') != null) {
					this.get('timePerQuestionArray').push.apply(this
							.get('timePerQuestionArray'), JSON.parse(this
							.get('timePerQuestion')));
				}
				if (this.get('score') != null) {
					var score = JSON.parse(this.get('score'));
					this.set('totalCorrect', score[0]);
					this.set('totalIncorrect', score[1]);
					this.set('totalScore', score[2]);
				}
				if (this.get('fid') != null) {
					this.set('fdpURL', DP_PATH + this.get('fid') + '.jpg');
				}
				if (this.get('l2Ids') != null) {
					var l2Ids = this.get('l2Ids').split(SEPARATOR);
					var len = l2Ids.length;
					if (len == 1) {
						var l2 = sectionL2.get(l2Ids[0]);
						this.set('topics', l2.get('displayName'));
						this.set('l1', (sectionL1.get(l2.get('l1Id')))
								.get('id'));
					} else {
						var topics = [];
						for ( var i = 0; i < len; i++) {
							var l2 = sectionL2.get(l2Ids[i]);
							topics.push(l2.get('displayName'));
							this.set('l1', (sectionL1.get(l2.get('l1Id')))
									.get('id'));
						}
						this.set('topics', topics.join(','));
					}
				} else {
					this.set('l1', 2);
				}
				this.set('l1DisplayName', (sectionL1.get(this.get('l1')))
						.get('displayName'));
				this.set('logo', 'img/l1-' + this.get('l1') + '.png');
				if (this.get('startTime') != null) {
					// quiz was downloaded
					if (this.get('attemptedAs') == null) {
						// attemptedAs was not set
						this.set('status', this.STATUS_INTERRUPTED);
					} else {
						if (this.get('state') == null) {
							this.set('status', this.STATUS_INPROGRESS);
						} else if (this.get('state') == this
								.get('questionIdsArray').length) {
							this.set('status', this.STATUS_COMPLETED);
						} else {
							this.set('status', this.STATUS_INPROGRESS);
						}
					}
				}
			},

			defaults : {
				'hasAttempted' : false,
				'totalCorrect' : 0,
				'totalIncorrect' : 0,
				'selectedAnswers' : null,
				'timePerQuestion' : null,
				'descriptionShort' : null,
				'totalScore' : 0,
				'maxScore' : 0,
				'totalScore' : 0,
				'topics' : '',
				'l1' : null,
				'fid' : null,
				'firstName' : null,
				'lastName' : null,
				'attemptedAs' : null,
				'logo' : null,
				'fdpURL' : DP_PATH + 'avatar.jpg',
				'state' : null,
				'startTime' : null
			},

			updateAttemptedAs : function() {
				// Do a POST
				var url = Config.serverUrl + 'attemptedAs/';
				var that = this;
				$.ajax({
					url : url,
					type : 'POST',
					dataType : "json",
					data : {
						accountId : account.get('id'),
						quizId : this.get('id'),
						attemptedAs : this.get('attemptedAs')
					},
					success : function(data) {
						if (data.status == STATUS.SUCCESS) {
							if (data.data == 1) {
								// start the quiz
								Manager.loadQuiz(that);
							} else {
								Manager.loadPractice(that);
							}
						} else {
							helper.showError(data.data);
						}
					}
				});
			},

			/**
			 * Calculates the total correct incorrect and stores them in
			 * totalCorrect and totalIncorrect
			 */
			 /*
			calculateScores : function() {
				var qIds = this.getQuestionIds();
				var len = qIds.length;
				for ( var i = 0; i < len; i++) {
					var question = quizQuestions.get(qIds[i]);
					var score = question.getScore();
					if (score != null) {
						this.set('totalScore', this.get('totalScore') + score);
					}
					var answer = question.get('optionSelected');
					if (question.isOptionSelectedCorrect(answer) == true) {
						this.set('totalCorrect', this.get('totalCorrect') + 1);
					} else if (question.isOptionSelectedCorrect(answer) == false) {
						this.set('totalIncorrect',
								this.get('totalIncorrect') + 1);
					}
					this.get('selectedAnswersArray')[i] = answer;
					this.get('timePerQuestionArray')[i] = question
							.get('timeTaken');
				}
			}, */

			/**
			 * Get all question ids belonging to this quiz
			 */
			getQuestionIds : function() {
				return this.get('questionIdsArray');
			},

			/**
			 * Get all selected answers ids belonging to this quiz
			 */
			getSelectedAnswers : function() {
				return this.get('selectedAnswersArray');
			},

			/**
			 * Get all selected questions
			 */
			getTimeTakenPerQuestion : function() {
				return this.get('timePerQuestionArray');
			},

			/**
			 * Data uploaded to results.
			 * 
			 * @param quiz
			 */
			submitResults : function() {
				

				var url = Config.serverUrl + 'results';
				console.log('Adding responses... ');
				var that = this;
				$.ajax({
					url : url,
					type : 'POST',
					dataType : "json",
					data : {
						accountId : account.get('id'),
						streamId : streamId,
						quizId : this.get('id'),
						streamId : streamId,
						state : this.get('state'),
						logs : logs.toJSON()
					},
					success : function(data) {
						if (data.status == STATUS.SUCCESS) {
							quizHistory.unshift(that);
							account.get('quizzesAttemptedArray').unshift(
									that.get('id'));
							if (that.get('status') == that.STATUS_COMPLETED) {
										app.quiz(that.get('id'));
							} else {
								// continue the quiz
							}
						} else {
							helper.showError(data.data);
						}
					},
					error : function(data) {
						console.log(data);
					},
				});
			}
		});

window.QuizCollection = Backbone.Collection.extend({
	model : Quiz,
	url : Config.serverUrl + 'quizzes/',
});

var quizLibrary = new QuizCollection();
var quizHistory = new QuizCollection();
