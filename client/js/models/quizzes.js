/**
 * The Quiz Model
 * 
 * @author ssachan
 * 
 */
window.Quiz = Backbone.Model.extend({

	urlRoot : Config.serverUrl + 'quizzes/',
	initialize : function() {

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
					.get('questionIdsArray'), this.get('questionIds').split(
					SEPARATOR));
		}
		if (this.get('selectedAnswers') != null) {
			this.get('selectedAnswersArray').push.apply(this
					.get('selectedAnswersArray'), JSON.parse(this
					.get('selectedAnswers')));
			this.set('hasAttempted', true);
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
		if(this.get('l2Ids')!=null){
			var l2Ids = this.get('l2Ids').split(SEPARATOR);
			var len=l2Ids.length;
			if(len==1){
				var l2 = sectionL2.get(l2Ids[0]);
				this.set('topics',l2.get('displayName'));
				this.set('l1', (sectionL1.get(l2.get('l1Id'))).get('id'));
			}else{
				var topics=[];
				for(var i=0;i<len;i++){
					var l2 = sectionL2.get(l2Ids[i]);
					topics.push(l2.get('displayName'));
					this.set('l1', (sectionL1.get(l2.get('l1Id'))).get('id'));
				}
				this.set('topics',topics.join(','));
			}
		}else{
			this.set('l1', 2);
		}
	},

	defaults : {
		'hasAttempted' : false,
		'totalCorrect' : 0,
		'totalIncorrect' : 0,
		'timeTaken' : 0,
		'selectedAnswers' : null,
		'timePerQuestion' : null,
		'totalScore' : 0,
		'maxScore' : 0,
		'totalScore' : 0,
		'topics' :'',
		'l1':null,
		'fid':null
	},

	/**
	 * Calculates the total correct incorrect and stores them in totalCorrect
	 * and totalIncorrect
	 */
	calculateScores : function() {
		if (!(this.get('hasAttempted'))) {
			var qIds = this.getQuestionIds();
			var len = qIds.length;
			for ( var i = 0; i < len; i++) {
				var question = quizQuestions.get(qIds[i]);
				var score = question.getScore();
				if(score!=null){
					this.set('totalScore', this.get('totalScore')
						+ score);
				}
				var answer = question.get('optionSelected');
				if (question.isOptionSelectedCorrect(answer) == true) {
					this.set('totalCorrect', this.get('totalCorrect') + 1);
				} else if (question.isOptionSelectedCorrect(answer) == false) {
					this.set('totalIncorrect', this.get('totalIncorrect') + 1);
				}
				this.getSelectedAnswers().push(answer);
				this.getTimeTakenPerQuestion().push(question.get('timeTaken'));
			}
			this.set('hasAttempted', true);
		}
	},

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
	 * Data uploaded to results. TODO:video
	 * 
	 * @param quiz
	 */
	submitResults : function(quiz) {
		var score = [ parseInt(this.get('totalCorrect')),
		parseInt(this.get('totalIncorrect')),parseInt(this.get('totalScore')) ];
		
		var url = '../api/responses';
		console.log('Adding responses... ');
		$.ajax({
			url : url,
			type : 'POST',
			dataType : "json",
			data : {
				accountId : account.get('id'),
				streamId : streamId,
				quizId : this.get('id'),
				streamId : streamId,
				score : JSON.stringify(score),
				selectedAnswers : JSON.stringify(this.getSelectedAnswers()),
				timePerQuestion : JSON.stringify(this.getTimeTakenPerQuestion()),
			},
			success : function(data) {
				console.log('results submitted');
			},
			error : function(data) {
				// console.log([ "error: ", data ]);
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
