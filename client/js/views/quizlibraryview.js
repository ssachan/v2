/**
 * The quiz library view
 * @author ssachan 
 * 
 **/
window.QuizLibraryView = Backbone.View.extend({

    initialize: function () {
    	this.render();
    },

    render: function () {
        $(this.el).html(this.template());
    	var quizzes = this.model.models;
        var len = quizzes.length;
        var i = 0;
        while(i<len){
        	$('#quizzes').append('<ul class="thumbnails"></ul>');
        	for (var j = 0; j < 4&&i<len; j++) {
        		$('.thumbnails:last').append(new QuizItemView({model: quizzes[i]}).render().el);
        		i++;
        	}
        }
        return this;
    }
});

window.QuizItemView = Backbone.View.extend({

	tagName: "li",

	className: "span2",

	initialize: function () {
	       this.render();
	},
	
	events : {
		'click .box' : 'onQuizItemClick',
	},
	
	onQuizItemClick : function(){
		mView.model = this.model;//var view = new ModalView({ model: this.model });
        mView.show();
	},
	
	render : function() {
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	},

});
