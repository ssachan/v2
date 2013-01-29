/**
 * The Question Model
 * @author ssachan 
 * 
 **/
window.Question = Backbone.Model.extend({

    urlRoot: Config.serverUrl+'questions/',
    
    defaults: {
        'correctAnswer': null,
        'status': null, // null not attempted, true correct, false incorrect
        'timeTaken': null,
        'hasAttempted':false,
        'optionSelected':null,
        'isCorrect':null,
        'videoData' : null //am adding this to load video for each question
    },

    initialize: function () {
      var l3Id=this.get('l3Id');
        if (l3Id) {
        	var l3 = sectionL3.get(l3Id);
        	var l2Id = l3.get('l2Id');
            this.set('l2Id',l2Id);
        	var l2 = sectionL2.get(l2Id);
            this.set('l1Id',l2.get('l1Id'));
        }
        if (this.get('optionSelected')) {
        	this.set('isCorrect',this.isOptionSelectedCorrect(this.get('optionSelected')));
        }
    },
	
	getOption : function (index){
		var type = this.get('typeId');
		switch (type){
		case "1":
            var optionsArray = this.get('options').split(SEPARATOR);
            return optionsArray[index];
		}
	},
	//tanujb:TODO:remove this function.
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
	
	/**
     * returns true, false and null depending on whether the option selected was right, wrong or not selected at all. 
     **/
	setStatus : function (){
		var status = null; 
		var answer = this.get('correctAnswer');
		var optionSelected = this.get('optionSelected');
		if(optionSelected && optionSelected!=null){
			status = (optionSelected==answer)?true:false;
		}
		this.set('status',status);
	},
});

window.QuestionCollection = Backbone.Collection.extend({
    model: Question,
    url: Config.serverUrl+'questions/'
});

var quizQuestions = new QuestionCollection();
var attemptedQuestions = new QuestionCollection();
var question = new Question();
