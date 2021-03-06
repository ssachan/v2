window.LandingView = Backbone.View.extend({
	className : 'container landing',
	initialize : function() {
		this.render();
	},

	render : function() {
		$(this.el).html(this.template());
		return this;
		//$('#sign-up').append((new SignUpView({model:account})).el);
	}
});

window.LearnMoreView = Backbone.View.extend({
	className :'container learn',
	
	initialize : function() {
		this.active = this.options.menu;
	},
		
	changeMenu : function(id) {
		$('#' + this.active+'-div').hide();
		this.active = id;
		$('#' + this.active+'-div').show();
		$('#' + this.active+'-menu').addClass('active');
	},
	
	render : function() {
		$(this.el).html(this.template());
		return this;
	},
	
	onRender : function (){
		$('#pq-div').hide();
		$('#tests-div').hide();
		$('#faculty-div').hide();
		$('#feedback-div').hide();
		$('#choice-div').hide();
		$('#started-div').hide();
		this.changeMenu(this.active);
	}
	
});

