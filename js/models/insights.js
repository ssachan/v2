window.Insight = Backbone.Model.extend({

    urlRoot: Config.serverUrl+'streams/',

    initialize: function () {
    	
    },
});

window.InsightCollection = Backbone.Collection.extend({
    model: Insight,
    url: Config.serverUrl+'streams/',
});

var insights = new InsightCollection();
