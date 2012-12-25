/**
 * The quiz library view
 * @author ssachan 
 * 
 **/
window.QuizLibraryView = Backbone.View.extend({
	className : "container quiz-library",
	
	initialize: function () {
		this.filtered = new QuizCollection();
		this.type = '0';
		this.l1 = '0';
		this.tness = '0';
		this.rec = '0';
    },
    
	events : {
		'change #f-type' : 'typeFilter',
		'change #f-l1' : 'l1Filter',
		'change #f-tness' : 'tnessFilter',
		'click #s-rec' : 'recSort',
		'click #s-rec1' : 'recSort1',
		'click #s-rec2' : 'recSort2',
	},
	
	typeFilter : function (e){
		this.type = $("#f-type option:selected").val();
		this.onRender();
	},
	
	l1Filter : function (e){
		this.l1 = $("#f-l1 option:selected").val();
		this.onRender();
	},
	
	tnessFilter : function (e){
		this.tness = $("#f-tness option:selected").val();
		this.onRender();
	},
	
	recSort : function(e){
		this.rec = 0;
		this.onRender();
	},
	
	recSort1 : function(e){
		this.rec = 1;
		this.onRender();
	},
	
	recSort2 : function(e){
		this.rec = 2;
		this.onRender();
	},
	
	render: function () {
        $(this.el).html(this.template());
        return this;
    },
    
    onRender :function(){
    	$("#quizzes").empty();
    	this.filtered.reset(this.collection.models);
    	if(this.type!='0'){
    		var filteredArray = this.filtered.where({typeId: this.type});
			this.filtered.reset(filteredArray);
    	}
    	if(this.l1!='0'){
    		var filteredArray = this.filtered.where({l1: this.l1});
			this.filtered.reset(filteredArray);
    	}
    	if(this.tness!='0'){
    		var filteredArray = this.filtered.where({difficulty: this.tness});
			this.filtered.reset(filteredArray);
    	}
    	if(this.rec=='1'){
    		var sortedCollection = this.filtered.sortBy(function(quiz){
    			  return parseInt(quiz.get("rec"));
    			});
			this.filtered.reset(sortedCollection);
    	} else if(this.rec=='2'){
    		var sortedCollection = this.filtered.sortBy(function(quiz){
    			  return -parseInt(quiz.get("rec"));
    			});
			this.filtered.reset(sortedCollection);
    	}
    	var quizzes = this.filtered.models;
        var len = quizzes.length;
        var i = 0;
        while(i<len){
        	$("#quizzes").append('<ul class="thumbnails"></ul>');
        	for (var j = 0; j < 3&&i<len; j++) {
        		$(".thumbnails:last").append(new QuizItemView({model: quizzes[i]}).render().el);
        		i++;
        	}
        }
    },
    
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
			window.location = '#quizResults/' + this.model.get('id')+ '';
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
