/**
 * The Question Model
 * @author ssachan 
 * 
 **/
window.Question = Backbone.Model.extend({

    urlRoot: Config.serverUrl+'questions/',

    initialize: function () {
        if (!this.get('openTimeStamps')) {
            this.set({
                openTimeStamps: new Array()
            });
        }
        if (!this.get('closeTimeStamps')) {
            this.set({
                closeTimeStamps: new Array()
            });
        }
        if (!this.get('optionSelectedTimeStamps')) {
            this.set({
            	optionSelectedTimeStamps: new Array()
            });
        }
        if (!this.get('optionUnSelectedTimeStamps')) {
            this.set({
            	optionUnSelectedTimeStamps: new Array()
            });
        }
    },
	
    /**
     * returns true, false and null depending on whether the option selected was right, wrong or not selected at all. 
     **/
	isOptionSelectedCorrect : function (selectedOption){
		var isCorrect = null; 
		if(selectedOption && selectedOption!=null){
 	      isCorrect = (selectedOption==this.get('correctAnswer'))?true:false;
		}
		return isCorrect; 
	},
    
    defaults: {
        'correctAnswer': null,
        'status': null,
        'timeTaken': null,
        'attemptedInPractice':false,
        'optionSelected':null,
    }
});

window.QuestionCollection = Backbone.Collection.extend({
    model: Question,
    url: Config.serverUrl+'questions/'
});

var quizQuestions = new QuestionCollection();
