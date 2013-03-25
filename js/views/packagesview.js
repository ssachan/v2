/**
 * The fac directory view
 * @author ssachan 
 * 
 **/
window.PackagesView = Backbone.View.extend({
	
	className : "container packages",

    initialize: function () {
    	this.render();
    },

    render: function () {
        $(this.el).html(this.template());
        return this;
    },
    
    onRender : function (){
     	var packages = this.collection.models;
        var len = packages.length;
		var i = 0;
		while (i < len) {
			$("#package-list").append('<div class="row-fluid"></div>');
			for ( var j = 0; j < 3 && i < len; j++) {
				$(".row-fluid:last").append(new PackageItemView({
					model : packages[i]
				}).render().el);
				i++;
			}
		}
    }
});

window.PackageItemView = Backbone.View.extend({
	tagName : "div",
	
	className : "span3 item recommended",
	
	initialize: function () {
	},
	
	events : {
		'click #purchase' : 'purchase',
	},
	
	purchase : function(){
		this.model.purchase();
	},
	
	render : function() {
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	},

});
