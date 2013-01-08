/**
 * The fac directory view
 * 
 * @author ssachan
 * 
 */
window.ReviewView = Backbone.View.extend({
	// className : "container fac-directory",

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
		this.onRender();
	},

	tnessFilter : function (e){
		this.tness = $("#f-tness option:selected").val();
		this.onRender();
	},
	
	statusFilter : function (e){
		this.status = $("#f-status option:selected").val();
		this.onRender();
	},
	
	render : function() {
		$(this.el).html(this.template());
		this.onRender();
		/*var facs = this.collection.models;
		var len = facs.length;
		for ( var i = 0; i < len; i++) {
			$('#fac-list', this.el).append(new FacItemView({
				model : facs[i]
			}).render().el);
		}*/
		return this;
	},
	
	onRender : function (){
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
    	for ( var i = 0; i < len; i++) {
			$('#q-list', this.el).append(new QuestionItemView({
				model : questions[i]
			}).render().el);
		}
	}
});

window.QuestionItemView = Backbone.View.extend({
	tagName :'tr',
	initialize : function() {
		this.render();
	},

	render : function() {
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	},

});
