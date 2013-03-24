window.Log = Backbone.Model.extend({

	urlRoot : ' ',

	
	initialize : function()) {
		this.set('t',new Date().getTime());
	},

	defaults : {
		t : null,
		e : null,
		q : null,
		o : null
	}

});

window.LogCollection = Backbone.Collection.extend({
	model : Log,

	eventids : {	
	OPTION_SELECT : 0,
	OPTION_DESELECT : 1,
	QUESTION_OPEN :3,
	QUESTION_CLOSE :4,
	QUESTION_MARK : 5,
	QUESTION_UNMARK: 6,
	QUESTION_SUBMIT: 7,
	TEST_SUBMIT: 8,
	TEST_PAUSE: 9,
	TEST_START: 10 },

	addEntry: function(eventname, questionid, optionid)
	{
		var obj = {
			e : this.eventids[eventname]
		};
		if(questionid)
			obj.q = questionid;
		if(optionid)
			obj.o = optionid
		this.add(new Log(obj));
	},

	comparator: function(logEntry)
	{
		return logEntry.get("t");
	}
});

var logs = new LogCollection();
