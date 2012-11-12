/**
 * The fac directory view
 * @author ssachan 
 * 
 **/
window.PackagesView = Backbone.View.extend({

    initialize: function () {
    	this.render();
    },

    render: function () {
        $(this.el).html(this.template());
    	var packages = this.collection.models;
        var len = packages.length;
        for (var i = 0; i < len; i++) {
            $('#package-list', this.el).append(new PackageItemView({model: packages[i]}).render().el);
        }
        return this;
    }
});

window.PackageItemView = Backbone.View.extend({
	el : '<tr>',

	initialize: function () {
	       this.render();
	},
	
	render : function() {
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	},

});
