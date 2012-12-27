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
			this.set('dpUrl', DP_PATH + this.get('id') + '.jpg');
		}
		this.on('change:id', function(model) {
			if (model.get('id') != null && model.get('id')!='') {
				model.set('dpUrl', DP_PATH + model.get('id') + '.jpg');
			}else{
				model.set('dpUrl', DP_PATH + 'avatar.jpg');
			}
		});
	},
	
	defaults : {
		dpUrl : DP_PATH + 'avatar.jpg',
	}
});

window.FacCollection = Backbone.Collection.extend({
	model : Fac,
	url : Config.serverUrl + 'fac/',
	search : function(letters){
		if(letters == "") return this;
 
		var pattern = new RegExp(letters,'gi');
		return _(this.filter(function(data) {
		  	return pattern.test(data.get('firstName'));
			
		}));
	},
});

var facDirectory = new FacCollection();
var facQuizzes = new QuizCollection();
var fac = new Fac();