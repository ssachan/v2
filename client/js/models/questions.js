/**
 * The Question Model
 * @author ssachan 
 * 
 **/
window.Question = Backbone.Model.extend({

    urlRoot: Config.serverUrl+'questions/',

    initialize: function () {
      /*  if (!this.get('openTimeStamps')) {
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
        }*/
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

	getResults : function()
	{
		var url = Config.serverUrl + 'questions/result-data/';
		return $.ajax({
			url : url,
			data : {
				accountId : account.get('id'),
				qid : this.get('id')
			},
			dataType : "json",
			success : function(data) {
				if(data.status == STATUS.SUCCESS ){
						this.set('timeTaken') = data.t;
						this.set('abilityScoreBefore') = data.a;
						this.set('delta') = data.d;
						this.set('optionSelected') = data.o;
				
				} else { // If not, send them back to the home page
					helper.showError(data.data);
				}
			}
		});
	},
	
    defaults: {
        'correctAnswer': null,
        'status': null,
        'timeTaken': null,
        'hasAttempted':false,
        'optionSelected':null,
        'isCorrect':null,
        'videoData' : null //am adding this to load video for each question
    }
});

window.QuestionCollection = Backbone.Collection.extend({
    model: Question,
    url: Config.serverUrl+'questions/'
});

var quizQuestions = new QuestionCollection();
var attemptedQuestions = new QuestionCollection();

