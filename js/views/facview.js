/**
 * The fac profile view
 * 
 * @author ssachan
 * 
 */

window.FacView = Backbone.View.extend({
	
	className : "container fac-profile",
	
	initialize : function() {
		_.bindAll(this, "render");
		this.model.bind('change', this.render);
	},
	
	events : {
		'click #recommendFac' : 'recommendFac'
	},
	
	recommendFac : function (){
		this.model.addReco();
	},
	
	render : function() {
		if(account.get('id')){
			this.model.set('loggedIn',true);
			$(this.el).html(this.template(this.model.toJSON()));
		}else{
			this.model.set('loggedIn',false);
			$(this.el).html(this.template(this.model.toJSON()));
		}
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
        		quizzes[i].set('firstName',this.model.get('firstName'));
        		quizzes[i].set('lastName',this.model.get('lastName'));
        		quizzes[i].set('bioShort',this.model.get('bioShort'));
        		quizzes[i].set('education',this.model.get('education'));
        		$(".thumbnails:last").append(new QuizItemView({model: quizzes[i]}).render().el);
        		i++;
        	}
        }
	}
});
