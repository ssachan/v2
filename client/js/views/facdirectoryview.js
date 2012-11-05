/**
 * The fac directory view
 * @author ssachan 
 * 
 **/
window.FacDirectoryView = Backbone.View.extend({

    initialize: function () {
    	this.render();
    },

    render: function () {
        $(this.el).html(this.template());
    	var facs = this.model.models;
        var len = facs.length;
        for (var i = 0; i < len; i++) {
            $('#fac-list', this.el).append(new FacItemView({model: facs[i]}).render().el);
        }
        return this;
    }
});

window.FacItemView = Backbone.View.extend({

	className: "media",

	initialize: function () {
	       this.render();
	},
	
	render : function() {
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	},

});
