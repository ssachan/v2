/**
 * The fac directory view
 * 
 * @author ssachan
 * 
 */
window.FacDirectoryView = Backbone.View.extend({
	// className : "container fac-directory",

	initialize : function() {
		this.type = '0';
		this.l1 = '0';
		this.tness = '0';
		this.rec = '0';
		this.render();
	},	

	render : function() {
		$(this.el).html(this.template());
		var facs = this.model.models;
		var len = facs.length;
		for ( var i = 0; i < len; i++) {
			$('#fac-list', this.el).append(new FacItemView({
				model : facs[i]
			}).render().el);
		}
		return this;
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
