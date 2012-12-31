window.Log = Backbone.Model.extend({

	urlRoot : ' ',
	
	OPTION_SELECTED : 0,
	OPTION_UNSELECT : 1,
	QUESTION_OPEN :3,
	QUESTION_CLOSE :4,
	
	initialize : function() {

	},

	defaults : {
		timestamp : null,
		action : null,
		questionId : null,
		optionIndex : null,
	}

});

window.LogCollection = Backbone.Collection.extend({
	model : Log,
});

var logs = new LogCollection();
