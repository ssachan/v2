/**
 * The fac directory view
 * 
 * @author ssachan
 * 
 */
window.FacDirectoryView = Backbone.View.extend({
	// className : "container fac-directory",

	initialize : function() {
		this.filtered = new QuizCollection();
		this.type = '0';
		this.l1 = '0';
		this.totalTests='0';
		this.rec = '0';
		this.render();
	},	

	events : {
		'change #f-l1' : 'l1Filter',
		'click #s-rec' : 'recSort',
		'click #s-rec1' : 'recSort1',
		'click #s-rec2' : 'recSort2',
		'click #s-tests' : 'testsSort',
		'click #s-tests1' : 'testsSort1',
		'click #s-tests2' : 'testsSort2',
	},
		
	l1Filter : function (e){
		this.l1 = $("#f-l1 option:selected").val();
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
	
	testsSort : function(e){
		this.totalTests = 0;
		this.onRender();
	},
	
	testsSort1 : function(e){
		this.totalTests = 1;
		this.onRender();
	},
	
	testsSort2: function(e){
		this.totalTests = 2;
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
		$("#fac-list").empty();
    	this.filtered.reset(this.collection.models);
    	if(this.l1!='0'){
    		var filteredArray = this.filtered.where({l1: this.l1});
			this.filtered.reset(filteredArray);
    	}
    	if(this.rec=='1'){
    		var sortedCollection = this.filtered.sortBy(function(fac){
    			  return parseInt(fac.get("rec"));
    			});
			this.filtered.reset(sortedCollection);
    	} else if(this.rec=='2'){
    		var sortedCollection = this.filtered.sortBy(function(fac){
    			  return -parseInt(fac.get("rec"));
    			});
			this.filtered.reset(sortedCollection);
    	}
    	if(this.totalTests=='1'){
    		var sortedCollection = this.filtered.sortBy(function(fac){
    			  return parseInt(fac.get("totalQuizzes"));
    			});
			this.filtered.reset(sortedCollection);
    	} else if(this.rec=='2'){
    		var sortedCollection = this.filtered.sortBy(function(fac){
    			  return -parseInt(fac.get("totalQuizzes"));
    			});
			this.filtered.reset(sortedCollection);
    	}
    	var facs = this.filtered.models;
        var len = facs.length;
    	for ( var i = 0; i < len; i++) {
			$('#fac-list', this.el).append(new FacItemView({
				model : facs[i]
			}).render().el);
		}
	}
});

window.FacItemView = Backbone.View.extend({
	tagName :'li',
	className : 'fac-item',
	initialize : function() {
		this.render();
	},

	render : function() {
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	},

});
