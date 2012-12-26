/**
 * The header view
 * @author ssachan 
 * 
 **/

window.HeaderView = Backbone.View.extend({

	initialize : function() {
		this.render();
	},
	
	render : function() {
		$(this.el).html(this.template());
		return this;
	},

});

window.FooterView = Backbone.View.extend({

	initialize : function() {
		this.render();
	},
	
	render : function() {
		$(this.el).html(this.template());
		return this;
	},

});