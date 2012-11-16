window.LandingView = Backbone.View.extend({
	
	initialize : function() {
		this.render();
	},

	render : function() {
		$(this.el).html(this.template());
		$('#sign-up').append((new SignUpView({model:account})).el);
	}
});
