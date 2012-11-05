window.Stream = Backbone.Model.extend({

    urlRoot: Config.serverUrl+'streams/',

    initialize: function () {
    	
    },
});

window.StreamCollection = Backbone.Collection.extend({
    model: Stream,
    url: Config.serverUrl+'streams/',
});

var streams = new StreamCollection();
