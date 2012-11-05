/**
 * The ScoreL1 model
 * @author ssachan 
 * 
 **/
window.ScoreL1 = Backbone.Model.extend({

    urlRoot: Config.serverUrl+'l1/',
    initialize: function () {}

});

window.ScoreL1Collection = Backbone.Collection.extend({
    model: ScoreL1,
    url: Config.serverUrl+'l1/'
});

/**
 * The ScoreL2 model
 * @author ssachan 
 * 
 **/
window.ScoreL2 = Backbone.Model.extend({

    urlRoot: Config.serverUrl+'l2/',
    initialize: function () {}

});

window.ScoreL2Collection = Backbone.Collection.extend({
    model: ScoreL2,
    url: Config.serverUrl+'l2/'
});

var scoreL1 = new ScoreL1Collection();

var scoreL2 = new ScoreL2Collection();