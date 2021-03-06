/**
Quiz Library Views
**/
window.QuizLibraryView = Backbone.View.extend({
	className : "container quiz-library",

	initialize : function() {
		this.filtered = new QuizCollection();
		this.type = '0';
		this.l1 = '0';
		this.tness = '0';
		this.rec = '0';
	},

	events : {
		'change #f-type' : 'typeFilter',
		'change #f-l1' : 'l1Filter',
		'change #f-tness' : 'tnessFilter',
		'click #s-rec' : 'recSort',
	},

	typeFilter : function(e) {
		this.type = $("#f-type option:selected").val();
		this.renderQuizItems();
	},

	l1Filter : function(e) {
		this.l1 = $("#f-l1 option:selected").val();
		this.renderQuizItems();
	},

	tnessFilter : function(e) {
		this.tness = $("#f-tness option:selected").val();
		this.renderQuizItems();
	},

	recSort : function(e) {
		this.rec = (this.rec == '1') ? 0 : 1;
		this.renderQuizItems();
	},

	render : function() {
		$(this.el).html(this.template());
		return this;
	},

	onRender : function() {
		$('.selectpicker').selectpicker();
		this.renderQuizItems();
	},

	renderQuizItems : function() {
		$("#pCarousel").empty();
		$("#cCarousel").empty();
		$("#mCarousel").empty();
		this.filtered.reset(this.collection.models);
		if (this.l1 != '0') {
			var filteredArray = this.filtered.where({
				l1 : this.l1
			});
			this.filtered.reset(filteredArray);
		}
		if (this.tness != '0') {
			var filteredArray = this.filtered.where({
				difficulty : this.tness
			});
			this.filtered.reset(filteredArray);
		}
		if (this.rec == '1') {
			var sortedCollection = this.filtered.sortBy(function(quiz) {
				return -parseInt(quiz.get("rec"));
			});
			this.filtered.reset(sortedCollection);
		}
		var subject = ["#mCarousel","#pCarousel","#cCarousel"];
		for(var k = 0; k<3; k++)
		{
			this.filtered.reset(this.collection.models);
			var filteredArray = this.filtered.where({
					l1 : k+1+''
			});
			this.filtered.reset(filteredArray);
			
			var quizzes = this.filtered.models;
			var len = quizzes.length;
			if (len == 0) {
				$(subject[k]).html('<h3>No quizzes found. Try again...</h3>');
				return;
			}

			var i = 0;
			var firstchild = true;
			while (i < len) {
				//if(firstchild)
				//{
				//	$(subject[k]).append('<div class="item active"><ul class="thumbnails lol"></ul></div>');
				//	firstchild=false;
				//}
				//else
					$(subject[k]).append('<div class="item"><ul class="thumbnails lol"></ul></div>');

				for ( var j = 0; j < 3 && i < len; j++) {
					$(".lol:last").append(
					new QuizItemView({
						model : quizzes[i]
					}).render().el);
					i++;
				}
				$('.lol').removeClass('lol');
			}
			$(subject[k]+">div:first").addClass("active");
		}
		$('.carousel').carousel({interval:null});
	}
});

window.QuizItemView = Backbone.View.extend({

	tagName : "li",

	className : "span4",

	initialize : function() {
		this.render();
	},

	events : {
		'click .box' : 'onQuizItemClick',
	},

	onQuizItemClick : function() {
		if (this.model.get('hasAttempted') == true || this.model.get('available')=='3') {
			return;
		}
		if (this.model.get('status') == this.model.STATUS_NOTSTARTED) {
			mView.model = this.model;
			mView.show();
		} else {
			window.location = '#quiz/' + this.model.get('id');
		}
	},

	render : function() {
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	}
});
