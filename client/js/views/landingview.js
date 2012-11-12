window.LandingView = Backbone.View.extend({
	
	initialize : function() {
		this.render();
	},

	render : function() {
		$(this.el).html(this.template());
		$(this.el).append((new SignUpView({model:account})).el);
		$(this.el).append((new LoginView({model:account})).el);

	}
});
