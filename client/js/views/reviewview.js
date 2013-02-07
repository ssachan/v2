/**
 * The fac directory view
 * 
 * @author ssachan
 * 
 */
window.ReviewView = Backbone.View.extend({

	initialize : function() {
		this.filtered = new FacCollection();
		this.l1 = '0';
		this.l2 = '0';
		this.l3 = '0';
		this.tness = '0';
		this.status = '0';
	},	

	events : {
		'change #f-tness' : 'tnessFilter',
		'change #f-status' : 'statusFilter',
		'change #f-l1' : 'l1Filter',
	},
	
	l1Filter : function (e){
		this.l1 = $("#f-l1 option:selected").val();
		this.renderQuestionItems();
	},

	tnessFilter : function (e){
		this.tness = $("#f-tness option:selected").val();
		this.renderQuestionItems();
	},
	
	statusFilter : function (e){
		this.status = $("#f-status option:selected").val();
		this.renderQuestionItems();
	},
	
	render : function() {
		$(this.el).html(this.template());
		return this;
	},
	
	onRender : function (){
		$('.selectpicker').selectpicker();
		this.renderQuestionItems();
	},
	
	renderQuestionItems : function (){
		$("#q-list").empty();
    	this.filtered.reset(this.collection.models);
    	if(this.l1!='0'){
    		var filteredArray = this.filtered.where({l1Id: this.l1});
			this.filtered.reset(filteredArray);
    	}
    	if(this.tness!='0'){
    		var filteredArray = this.filtered.where({difficulty: this.tness});
			this.filtered.reset(filteredArray);
    	}
    	
    	if(this.status=='1'){
    		var filteredArray = this.filtered.where({isCorrect: true});
			this.filtered.reset(filteredArray);
    	} else if(this.status=='2'){
    		var filteredArray = this.filtered.where({isCorrect: false});
			this.filtered.reset(filteredArray);	
    	}
    	
    	var questions = this.filtered.models;
        var len = questions.length;
		if (len == 0) {
			$('#q-list', this.el).html('<h3>No questions found. Try again...</h3>');
			return;
		}
		$('#q-list', this.el).html('');
    	for ( var i = 0; i < len; i++) {
			$('#q-list', this.el).append(new QuestionItemView({
				model : questions[i]
			}).render().el);
		}
        var math = document.getElementById('q-list');
        MathJax.Hub.Queue(["Typeset", MathJax.Hub, math]);
	}
});

window.QuestionItemView = Backbone.View.extend({
	tagName :'tr',
	initialize : function() {
	},

	render : function() {
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	},

});

window.ReviewQuestionView = Backbone.View.extend({
	className :'container reviewq',
	initialize : function() {
		this.qView = new QuizQuestionView();
	},

	render : function() {
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	},
	
	onRender : function(){
		this.qView.model = this.model;
		$('#r-question').html(this.qView.render().el);
		this.qView.onRender();
	}
});
