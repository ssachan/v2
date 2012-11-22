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
		var answer = this.get('correctAnswer');
		if(selectedOption && selectedOption!=null){
			isCorrect = (selectedOption==answer)?true:false;
		}
		return isCorrect; 
	},
    
	getScore : function(){
		var type = this.get('typeId');
		switch(type){
		case "1":
			// the single option correct
			if(this.isOptionSelectedCorrect(this.get('optionSelected'))==true){
				// got it correct
				return parseInt(this.get('correctScore'));
			}else if(this.isOptionSelectedCorrect(this.get('optionSelected'))==false){
				// got it incorrect
				return parseInt('-'+this.get('incorrectScore'));
			}else{
				return null;
			}
			break;
		case "2":
			// the multiple option correct
			if(this.isOptionSelectedCorrect(this.get('optionSelected'))==true){
				// got it correct
				return parseInt(this.get('correctScore'));
			}else if(this.isOptionSelectedCorrect(this.get('optionSelected'))==false){
				// got it incorrect check for individual options
				return parseInt('-'+this.get('incorrectScore'));
			}else{
				return null;
			}

			break;
		case "3":
			// integer type
			if(this.isOptionSelectedCorrect(this.get('optionSelected'))==true){
				// got it correct
				return parseInt(this.get('correctScore'));
			}else if(this.isOptionSelectedCorrect(this.get('optionSelected'))==false){
				// got it incorrect
				return parseInt('-'+this.get('incorrectScore'));
			}else{
				return null;
			}

			break;
		case "4":
			// matrix type
			if(this.isOptionSelectedCorrect(this.get('optionSelected'))==true){
				// got it correct
				return parseInt(this.get('correctScore'));
			}else if(this.isOptionSelectedCorrect(this.get('optionSelected'))==false){
				// got it incorrect check for individual options
				var totalScore = 0;
				var optionScore = parseInt(this.get('optionScore'));
				if(optionScore!=0){
					// we have option scores
					var correctAnswersArray = (this.get('correctAnswer')).split(SEPARATOR+SEPARATOR);
					var selectedOptionsArray = (this.get('optionSelected')).split(SEPARATOR+SEPARATOR);
					var len = correctAnswersArray.length;
					for (var i = 0; i< len; i++){
						if(selectedOptionsArray[i]!=null && selectedOptionsArray[i]==correctAnswersArray[i]){
							// u got the option correct
							totalScore = totalScore + optionScore;
						}
					}
				}
				return totalScore;
			}else{
				return null;
			}
			break;
		}
		
	},
	
    defaults: {
        'correctAnswer': null,
        'status': null,
        'timeTaken': null,
        'attemptedInPractice':false,
        'optionSelected':null,
        'videoData' : null //am adding this to load video for each question
    }
});

window.QuestionCollection = Backbone.Collection.extend({
    model: Question,
    url: Config.serverUrl+'questions/'
});

var quizQuestions = new QuestionCollection();
