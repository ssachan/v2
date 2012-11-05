/**
 * The SectionL1 Model
 * @author ssachan 
 * 
 **/
window.SectionL1 = Backbone.Model.extend({

    urlRoot: Config.serverUrl+'l1/',
    initialize: function () {}

});

window.SectionL1Collection = Backbone.Collection.extend({
    model: SectionL1,
    url: Config.serverUrl+'l1/'
});

/**
 * The SectionL2 Model
 * @author ssachan 
 * 
 **/
window.SectionL2 = Backbone.Model.extend({

    urlRoot: Config.serverUrl+'l2/',
    initialize: function () {}

});

window.SectionL2Collection = Backbone.Collection.extend({
    model: SectionL2,
    url: Config.serverUrl+'l2/'
});

/**
 * The SectionL3 Model
 * @author ssachan 
 * 
 **/
window.SectionL3 = Backbone.Model.extend({

    urlRoot: Config.serverUrl+'l3/',
    initialize: function () {}

});

window.SectionL3Collection = Backbone.Collection.extend({
    model: SectionL3,
    url: Config.serverUrl+'l3/'
});

var sectionL1 = new SectionL1Collection();

var sectionL2 = new SectionL2Collection();

var sectionL3 = new SectionL3Collection();