/**
 * The fac directory view
 * 
 * @author ssachan
 * 
 */
window.FacDirectoryView = Backbone.View.extend({
	className : "container fac-dir",

	initialize : function() {
		this.filtered = new FacCollection();
		this.letters = '';
		this.type = '0';
		this.l1 = '0';
		this.totalTests='0';
		this.rec = '0';
	},	

	events : {
		'keyup #s-name' : 'nameSearch',
		'change #f-l1' : 'l1Filter',
		'click #s-rec' : 'recSort',
		'click #s-tests' : 'testsSort',
	},
	
	nameSearch : function (){
		this.letters = $('#s-name').val();
		this.renderFacItems();
	},
	
	l1Filter : function (e){
		this.l1 = $("#f-l1 option:selected").val();
		this.renderFacItems();
	},

	
	recSort : function(e){
		this.rec = (this.rec=='1')?0:1;
		this.renderFacItems();
	},
	
	testsSort : function(e){
		this.totalTests = (this.totalTests=='1')?0:1;
		this.renderFacItems();
	},
		
	render : function() {
		$(this.el).html(this.template());
		return this;
	},
	
	onRender : function() {
		$('.selectpicker').selectpicker({
			btnStyle : 'btn-small'
		});
		this.renderFacItems();
	},

	renderFacItems : function (){
		$("#fac-list").empty();
    	this.filtered.reset(this.collection.models);
    	if(this.letters!=''){
    		var pattern = new RegExp(this.letters,'gi');
    		var res = this.filtered.filter(function(data) {
    		  	if(pattern.test(data.get('firstName')) || pattern.test(data.get('lastName'))){
    		  		return true;
    		  	}
    		});
    		this.filtered.reset(res);
    	}
    	
    	if(this.l1!='0'){
    		var filteredArray = this.filtered.where({l1Ids: this.l1});
			this.filtered.reset(filteredArray);
    	}
    	if(this.rec=='1'){
    		var sortedCollection = this.filtered.sortBy(function(fac){
    			  return -parseInt(fac.get("rec"));
    			});
			this.filtered.reset(sortedCollection);
    	} 
    	if(this.totalTests=='1'){
    		var sortedCollection = this.filtered.sortBy(function(fac){
    			  return -parseInt(fac.get("totalQuizzes"));
    			});
			this.filtered.reset(sortedCollection);
    	} 
    	var facs = this.filtered.models;
        var len = facs.length;
		if (len == 0) {
			$('#fac-list', this.el).html('<h3>No faculty found. Try again...</h3>');
			return;
		}
		$('#fac-list', this.el).html('');
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
