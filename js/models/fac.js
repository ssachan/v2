/**
 * The faculty Model
 * 
 * @author ssachan
 * 
 */
window.Fac = Backbone.Model.extend({
	
	defaults : {
		dpUrl : DP_PATH + 'avatar.jpg',
		dpUrlL : DP_PATH + 'avatar.jpg',
	},
	
	urlRoot : Config.serverUrl + 'fac/',

	initialize : function() {
		if (this.get('id') != null) {
			this.set('dpUrl', DP_PATH + this.get('id') + '.jpg');
		}
		this.on('change:id', function(model) {
			if (model.get('id') != null && model.get('id')!='') {
				model.set('dpUrl', DP_PATH + model.get('id') + '.jpg');
				model.set('dpUrlL', DP_PATH + model.get('id') + '-l.jpg');
			}else{
				model.set('dpUrl', DP_PATH + 'avatar.jpg');
				model.set('dpUrlL', DP_PATH + 'avatar.jpg');
			}
		});
		
		if (this.get('l1Ids') != null) {
	        this.set('l1DisplayName', (sectionL1.get(this.get('l1Ids')))
	            .get('displayName'));
	    }
	},
	
    addReco: function () {
        var url = Config.serverUrl + 'addFacReco';
        var that = this;
        $.ajax({
        	//context:this,
            url: url,
            type: 'POST',
            dataType: "json",
            data: {
                accountId: account.get('id'),
                facId: this.get('id'),
            },
            success: function (data) {
                if (data.status) {
                	helper.processStatus(data);
                }
            },
            error: function (data) {
                console.log(data);
            },
        });
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