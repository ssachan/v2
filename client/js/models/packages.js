/**
 * The Package Model
 * @author ssachan 
 * 
 **/
window.Package = Backbone.Model.extend({
		
    defaults: {
    },

    urlRoot: Config.serverUrl+'packages/',

    initialize: function () {
    	
    },
    
    purchase: function () {
        var url = Config.serverUrl + 'purchase';
        $.ajax({
            url: url,
            type: "POST",
            data: {
                packageId: this.get('id'),
                accountId : account.get('id'),
                streamId : streamId
            },
            dataType: "json",
            success: function (data) {
                if (data.status == STATUS.SUCCESS) {
                	account.set('quizzesRemaining',data.data);
                    data.data = 'Added package. Your account now has '+data.data+' tests.';
                	helper.processStatus(data);
                }
            }
        });
    },
});

window.PackageCollection = Backbone.Collection.extend({
    model: Package,
    url: Config.serverUrl+'packages/'
});

var packages = new PackageCollection();
