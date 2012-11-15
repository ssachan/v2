/**
 * The fac profile view
 * 
 * @author ssachan
 * 
 */

window.FacView = Backbone.View.extend({
	
	className : "container facpro",
	
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
        	for (var j = 0; j < 3&&i<len; j++) {
        		$(".thumbnails:last").append(new FacQuizView({model: quizzes[i]}).render().el);
        		i++;
        	}
        }
        /*while(i<len){
        	//$("#quizzes").append('<ul class="thumbnails span10"></ul>');
        	for (var j = 0; j < 3&&i<len; j++) {
        		$(".thumbnails:last").append(new FacQuizView({model: quizzes[i]}).render().el);
        		i++;
        	}
        }*/
	}
});


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
