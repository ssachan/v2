/**
 * The mysets views
 * 
 * @author ssachan
 * 
 */

window.MySetsView = Backbone.View.extend({
	className : "container mysets",
	
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
        	var totalQuestions = quiz.get('questionIdsArray').length;
    		// quiz was available in history, check if its complete or
    		// incomplete
    		if (parseInt(quiz.get('state'))==totalQuestions) {
    			// completed quiz, get the results
    			history.push(quiz);
    		} else {
    			if (quiz.get('attemptedAs') == '1') {
    				//start the quiz all over again
    				interruped.push(quiz);
    			}else if(quiz.get('attemptedAs')=='2'){
    				//open practice view
    				paused.push(quiz);
    			}
    		}
        }
        
        len = history.length;
        var i = 0;
        if (len == 0) {
            $("#history").append('You have not taken any tests. Please take a test to update your history');
        }
        while (i < len) {
            $('#history').append('<ul class="thumbnails"></ul>');
            for (var j = 0; j < 3 && i < len; j++) {
                $('.thumbnails:last','#history').append(new QuizItemView({
                    model: quizzes[i]
                }).render().el);
                i++;
            }
        }
        len = paused.length;
        var i = 0;
        if (len == 0) {
            $("#paused").append('You have not taken any tests. Please take a test to update your history');
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
            $("#interruped").append('You have not taken any tests. Please take a test to update your history');
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

        /*
         * var quizHistory = this.collection.models; var len =
         * quizHistory.length; for ( var i = 0; i < len; i++) {
         * $(this.el).append( '<a href=#quizResults/' +
         * quizHistory[i].get('id') + '>quiz' + quizHistory[i].get('id') + '|</a>'); }
         */
    }
});