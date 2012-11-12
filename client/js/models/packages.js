/**
 * The Package Model
 * @author ssachan 
 * 
 **/
window.Package = Backbone.Model.extend({

    urlRoot: Config.serverUrl+'packages/',

    initialize: function () {
       
    },
	
    defaults: {
    },
});

window.PackageCollection = Backbone.Collection.extend({
    model: Package,
    url: Config.serverUrl+'packages/'
});

var packages = new PackageCollection();
