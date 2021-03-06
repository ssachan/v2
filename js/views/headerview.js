/**
 * The header view
 cat headerview.js landingview.js dashboardview.js quizview.js questionview.js quizlibraryview.js facdirectoryview.js modalview.js signupview.js packagesview.js facview.js faccontactview.js reviewview.js resultsview.js mysetsview.js > views.js
 * @author ssachan 
 * 
 **/

window.HeaderView = Backbone.View.extend({

	initialize : function() {
		_.bindAll(this, "render");
		this.model.bind('change', this.render);
		this.render();
	},
	
	render : function() {
		$(this.el).html(this.template(this.model.toJSON()));
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