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
		var l1Scores = this.collection;
		var l2Scores = this.options.collection2;
		// loop through the sectionL1 collection and print the scores
		// corresponding to those id
		var l1 = sectionL1.models;
		var len = l1.length;
		for(var i=0; i< len; i++){
			l1Id = l1[i].get('id');
			var l1ScoreModel = l1Scores.get(l1Id);
			var l2Score = (l1ScoreModel==null?'N/A':l1ScoreModel.get('score'));
			$('#performance').append('<h4>'+l1[i].get('displayName')+'-( '+l2Score+' )</h4>');
			// get the L2s for this L1
			var l2 = sectionL2.where({l1Id:l1Id});
			var len2 = l2.length;
			// loop through L2s and get the scores for each of these l2s
			for(var j = 0 ; j < len2 ;j++){
				l2Id =l2[j].get('id'); 
				var l2ScoreModel = l2Scores.get(l2Id);
				var l2Score = (l2ScoreModel==null?'N/A':l2ScoreModel.get('score'));
				$('#performance').append('<h5>'+l2[j].get('displayName')+'-'+l2Score+'</h5>');
			}
		}
		new HistoryView({el:'#history', collection:quizHistory});
	}
});

window.PerformanceView = Backbone.View.extend({
	initialize : function() {
		this.render();
	},

	render : function() {
		$(this.el).html(this.template());
	}
});

window.HistoryView = Backbone.View.extend({
	initialize : function() {
		this.render();
	},

	render : function() {
		var quizHistory = this.collection.models;
		var len = quizHistory.length;
		for(var i=0;i<len;i++){
			$(this.el).append('<a href=#quizResults/'+quizHistory[i].get('id')+'>quiz</a>' );
		}
	}
});
