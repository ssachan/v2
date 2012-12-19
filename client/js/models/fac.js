/**
 * The faculty Model
 * 
 * @author ssachan
 * 
 */
window.Fac = Backbone.Model.extend({
	urlRoot : Config.serverUrl + 'fac/',
	initialize : function() {
		if (this.get('id') != null) {
			this.set('dpUrl', FAC_PATH + this.get('id') + '.jpg');
		}
		this.on('change:id', function(model) {
			if (model.get('id') != null && model.get('id')=='') {
				model.set('dpUrl', FAC_PATH + model.get('id') + '.jpg');
			}
		});
	},

	defaults : {
		dpUrl : DP_PATH + 'avatar.jpg'
	}
});

window.FacCollection = Backbone.Collection.extend({
	model : Fac,
	url : Config.serverUrl + 'fac/',
});

var facDirectory = new FacCollection();
var facQuizzes = new QuizCollection();
var fac = new Fac();