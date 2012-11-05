/**
 * The faculty Model
 * @author ssachan 
 * 
 **/
window.Fac = Backbone.Model.extend({
	urlRoot: Config.serverUrl+'fac/',
	initialize: function () {},
});

window.FacCollection = Backbone.Collection.extend({
    model: Fac,
    url: Config.serverUrl+'fac/',
});

var facDirectory = new FacCollection();
