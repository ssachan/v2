/**
 * The Quiz Model
 * @author ssachan 
 * 
 **/
window.Quiz = Backbone.Model.extend({

    urlRoot: Config.serverUrl+'quizzes/',
    initialize: function () {
    	
    	 if (!this.get('questionIdsArray')) {
             this.set({
            	 questionIdsArray: new Array()
             });
         }
         
    	 if (!this.get('selectedAnswersArray')) {
             this.set({
            	 selectedAnswersArray: new Array()
             });
         }
    	 
    	 if (!this.get('timePerQuestionArray')) {
             this.set({
            	 timePerQuestionArray: new Array()
             });
         }
    	 if(this.get('questionIds')!=null){
 			this.get('questionIdsArray').push.apply(this.get('questionIdsArray'), this.get('questionIds').split(SEPARATOR));
    	 }
    	 if(this.get('selectedAnswers')!=null){
 			this.get('selectedAnswersArray').push.apply(this.get('selectedAnswersArray'), JSON.parse(this.get('selectedAnswers')));
    	 }
    	 if(this.get('timePerQuestion')!=null){
    		this.get('timePerQuestionArray').push.apply(this.get('timePerQuestionArray'), JSON.parse(this.get('timePerQuestion')));
     	 }
    },

    defaults: {
        'hasAttempted' : false,
        'totalCorrect' : 0,
        'totalIncorrect' : 0,
        'timeTaken' : 0,  
        'selectedAnswers':null,
        'timePerQuestion':null	
    },
    
	/**
	 * Calculates the total correct incorrect and stores them in totalCorrect and totalIncorrect  
	 **/
	calculateScores : function(){
		if(!(this.get('hasAttempted'))){
			var qIds = this.getQuestionIds();
			var len = qIds.length;
			for(var i=0; i<len; i++ )
			{
				var question = quizQuestions.get(qIds[i]);
				if(question.isOptionSelectedCorrect()==true){
					this.set('totalCorrect', this.get('totalCorrect')+1);
				}else if (question.isOptionSelectedCorrect()==false){
					this.set('totalIncorrect', this.get('totalIncorrect')+1);
				}
				this.getSelectedAnswers().push(parseInt(question.get('optionSelected')));
				this.getTimeTakenPerQuestion().push(parseInt(question.get('timeTaken')));
			}
			this.set('hasAttempted',true);
		}
	},
	
	/**
	 * Get all question ids belonging to this quiz 
	 **/
	getQuestionIds : function (){
		return this.get('questionIdsArray') ;
	},

	/**
	 * Get all selected answers ids belonging to this quiz 
	 **/
	getSelectedAnswers : function (){
		return this.get('selectedAnswersArray');
	},
	
	/**
	 * Get all selected questions 
	 **/
	getTimeTakenPerQuestion : function(){
		return this.get('timePerQuestionArray');
	},
	
	submitResults : function(quiz) {
		//var questionIds = JSON.stringify(this.getQuestionIds()); // .join(SEPARATOR);
		var response = new Response({
			accountId : account.get('id'),
			quizId : this.get('id'),
			score : JSON.stringify([this.get('totalCorrect'),this.get('totalIncorrectCorrect')]),
			selectedAnswers : JSON.stringify(this.getSelectedAnswers()),
			timePerQuestion : JSON.stringify(this.getTimeTakenPerQuestion()),
		});
		response.save({
			success : function(data) {
				quizHistory.add(data);
			}
		});
	}	
});

window.QuizCollection = Backbone.Collection.extend({
    model: Quiz,
    url: Config.serverUrl+'quizzes/',
});

var quizLibrary = new QuizCollection();
var quizHistory = new QuizCollection();