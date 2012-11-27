/**
 * The quiz library view
 * @author ssachan 
 * 
 **/
window.QuizLibraryView = Backbone.View.extend({
	className : "container quiz-library",
	
	initialize: function () {
    },

    render: function () {
        $(this.el).html(this.template());
        return this;
    },
    
    renderQuizItems : function(){
    	var quizzes = this.model.models;
        var len = quizzes.length;
        var i = 0;
        while(i<len){
        	$("#quizzes").append('<ul class="thumbnails"></ul>');
        	for (var j = 0; j < 3&&i<len; j++) {
        		$(".thumbnails:last").append(new QuizItemView({model: quizzes[i]}).render().el);
        		i++;
        	}
        }
    }
});

window.QuizItemView = Backbone.View.extend({

	tagName: "li",

	className: "span4",

	initialize: function () {
	       this.render();
	},
	
	events : {
		'click .box' : 'onQuizItemClick',
	},
	
	onQuizItemClick : function(){
		if(this.model.get('hasAttempted')==true){
			window.location.replace('#quizResults/' + this.model.get('id')+ '');
		}else{
			mView.model = this.model;//var view = new ModalView({ model: this.model });
			mView.show();
		}
	},
	
	render : function() {
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	},

});
