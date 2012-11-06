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
			this.set('hasAttempted',true);
    	 }
    	 if(this.get('timePerQuestion')!=null){
    		this.get('timePerQuestionArray').push.apply(this.get('timePerQuestionArray'), JSON.parse(this.get('timePerQuestion')));
     	 }
    	 if(this.get('score')!=null){
    		 var score = JSON.parse(this.get('score'));
    		 this.set('totalCorrect',score[0]);
    		 this.set('totalIncorrect',score[1]);
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
				var answer = question.get('optionSelected');
				if(question.isOptionSelectedCorrect(answer)==true){
					this.set('totalCorrect', this.get('totalCorrect')+1);
				}else if (question.isOptionSelectedCorrect(answer)==false){
					this.set('totalIncorrect', this.get('totalIncorrect')+1);
				}
				this.getSelectedAnswers().push(answer);
				this.getTimeTakenPerQuestion().push(question.get('timeTaken'));
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
		var score = [parseInt(this.get('totalCorrect')),parseInt(this.get('totalIncorrect'))];
		var response = new Response({
			accountId : id,
			quizId : this.get('id'),
			score : JSON.stringify(score),
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