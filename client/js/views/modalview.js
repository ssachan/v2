/**
 * The modal view
 * 
 * @author ssachan
 * 
 */

window.ModalView = Backbone.View.extend({
	
	initialize : function() {
	},

	events : {
		'click .close' : 'close',
		'click #start-quiz' : 'startQuiz'	
	},

	render : function() {
		this.$el.html(this.template(this.model.toJSON()));
		return this;
	},

	show : function() {
		$(document.body).append(this.render().el);
        $('#modal').modal({backdrop:false});
	},

	close : function() {
		$('#modal').modal('hide');
		this.remove();
	},
	
	startQuiz : function(){
		this.close();
		app.startQuiz(this.model.get('id'));
	}

});
