/**
 * The mysets views
 * 
 * @author ssachan
 * 
 */

window.MySetsView = Backbone.View.extend({
	
	initialize : function() {
	},
	
	render : function(){
		$(this.el).html(this.template());
	},
	
	onRender : function(){
		
	}
});

window.HistoryView = Backbone.View.extend({
    initialize: function () {
        this.render();
    },

    render: function () {
        var quizzes = this.collection.models;
        var len = quizzes.length;
        var i = 0;
        if (len == 0) {
            $("#history").append('You have not taken any tests. Please take a test to update your history');
        }
        while (i < len) {
            $("#history").append('<ul class="thumbnails"></ul>');
            for (var j = 0; j < 3 && i < len; j++) {
                $(".thumbnails:last").append(new QuizItemView({
                    model: quizzes[i]
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