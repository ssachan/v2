/**
 * The fac profile view
 * 
 * @author ssachan
 * 
 */

window.FacView = Backbone.View.extend({
	
	className : "container fac-profile",
	
	initialize : function() {
		this.render();
	},

	render : function() { 
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	},
	
	renderQuizzes : function(){
		var quizzes = this.collection.models;
        var len = quizzes.length;
        var i = 0;
        while(i<len){
        	$("#quizzes").append('<ul class="thumbnails"></ul>');
        	for (var j = 0; j < 4&&i<len; j++) {
        		quizzes[i].set('fid',this.model.get('id'));
        		quizzes[i].set('fdpURL',this.model.get('dpUrl'));
        		quizzes[i].set('firstname',this.model.get('firstName'));
        		quizzes[i].set('lastname',this.model.get('lastName'));
        		quizzes[i].set('bioShort',this.model.get('bioShort'));
        		$(".thumbnails:last").append(new QuizItemView({model: quizzes[i]}).render().el);
        		i++;
        	}
        }
	}
});

/**
 * Not being used now. will be deleted
 */
window.FacQuizView = Backbone.View.extend({

	tagName: "li",

	className: "span4",

	initialize: function () {
	       this.render();
	},
	
	render : function() {
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	},

});
