/**
 * The dashboard view
 * 
 * @author ssachan
 * 
 */

window.DashboardView = Backbone.View.extend({

	initialize : function() {
		_.bindAll(this, 'render');
		this.collection.on("change", this.render);
		this.options.collection2.on("change", this.render);
		this.render();
	},

	render : function() {
		$(this.el).html(this.template());
		new InfoView({
			el : '#info',
			model : account
		});
		var l1Scores = this.collection;
		var l2Scores = this.options.collection2;
		// loop through the sectionL1 collection and print the scores
		// corresponding to those id
		var l1 = sectionL1.models;
		var len = l1.length;
		for ( var i = 0; i < len; i++) {
			// l1Id = l1[i].get('id');
			// var l1ScoreModel = l1Scores.get(l1Id);
			// var l1Score =
			// (l1ScoreModel==null?'N/A':l1ScoreModel.get('score'));
			var pView = new PerformanceView({
				model : l1[i],
				el : '#performance'
			});
			// $('#performance').append(pView.el);
			// $('#performance').append('<h4>'+l1[i].get('displayName')+'-(
			// '+l2Score+' )</h4>');
			// get the L2s for this L1
			// var l2 = sectionL2.where({l1Id:l1Id});
			// var len2 = l2.length;
			// loop through L2s and get the scores for each of these l2s

		}
		new HistoryView({
			el : '#history',
			collection : quizHistory
		});
	}
});

window.InfoView = Backbone.View.extend({
	initialize : function() {
		this.render();
	},

	render : function() {
		$(this.el).html(this.template(this.model.toJSON()));
	},

});

window.PerformanceView = Backbone.View
		.extend({
			initialize : function() {
				this.render();
			},

			render : function() {
				var l1Id = this.model.get('id');
				var l1ScoreModel = scoreL1.get(l1Id);
				var l1Score = (l1ScoreModel == null ? 'N/A' : l1ScoreModel
						.get('score'));
				var information = {
					'displayName' : this.model.get('displayName'),
					'l1Score' : l1Score,
					'accuracy' : 4,
				};
				$(this.el).append(this.template(information));
				var l2 = sectionL2.where({
					l1Id : l1Id
				});
				var len = l2.length;
				for ( var i = 0; i < len;) {
					var l2ScoreModel = scoreL2.get(l2[i].get('id'));
					var l2Score = (l2ScoreModel == null ? 'N/A' : l2ScoreModel.get('score')+'/10');
					for ( var j = 0; j < 3 && i < len; j++) {
						if (j == 0) {
							$('.l2-performance:last').append(
									'<div class="row-fluid l2row"></div>');
						}
						$('.l2row:last').append(
								'<div class="span4">'
										+ l2[i].get('displayName') +'<span style="margin-left:10px">'+l2Score+'</span></div>');
						i++;
					}
				}
				/*
				 * for(var j = 0 ; j < len2 ;j++){ l2Id =l2[j].get('id'); var
				 * l2ScoreModel = scoreL2.get(l2Id); var l2Score =
				 * (l2ScoreModel==null?'N/A':l2ScoreModel.get('score'));
				 * $(this.el).append('<h5>'+l2[j].get('displayName')+'-'+l2Score+'</h5>'); }
				 */
				/*
				 * <div class="row-fluid"> <div class="span4"></div> <div
				 * class="span4"></div> <div class="span4"></div> </div>
				 */
			},
		});

window.HistoryView = Backbone.View.extend({
	initialize : function() {
		this.render();
	},

	render : function() {
		var quizzes = this.collection.models;
        var len = quizzes.length;
        var i = 0;
        if(len==0){
        	$("#history").append('You have not taken any tests. Please take a test to update your history');
        }
        while(i<len){
        	$("#history").append('<ul class="thumbnails"></ul>');
        	for (var j = 0; j < 3&&i<len; j++) {
        		$(".thumbnails:last").append(new QuizItemView({model: quizzes[i]}).render().el);
        		i++;        		
        	}
        }
        
		/*var quizHistory = this.collection.models;
		var len = quizHistory.length;
		for ( var i = 0; i < len; i++) {
			$(this.el).append(
					'<a href=#quizResults/' + quizHistory[i].get('id')
							+ '>quiz' + quizHistory[i].get('id') + '|</a>');
		}*/
	}
});
