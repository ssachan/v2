/**
 * The dashboard view
 * 
 * @author ssachan
 * 
 */
window.DashboardView = Backbone.View.extend({

    initialize: function () {
        this.infoView = new InfoView();
    },

    render: function () {
        $(this.el).html(this.template());
        return this;
    },

    onRender: function () {
        this.infoView.model = account;
        $('#info').html(this.infoView.render().el);
        $('#performance').empty();
        var l1 = sectionL1.models;
        var len = l1.length;
        for (var i = 0; i < len; i++) {
        	var pView = new PerformanceView({
                model: l1[i]
            });
        	$('#performance', this.el).append(pView.render().el);
        	pView.onRender();
        }
    }
});

window.InfoView = Backbone.View.extend({
    initialize: function () {},

    uploadImage: function () {
        var btnUpload = $('#upload');
        var status = $('#status');
        var that = this;
        new AjaxUpload(btnUpload, {
            action: Config.serverUrl + 'uploadImage',
            name: 'file',
            type: 'POST',
            onSubmit: function (file, ext) {
                if (!(ext && /^(jpg|png|jpeg|gif)$/.test(ext))) {
                    // extension is not allowed
                    status.text('Only JPG, PNG or GIF files are allowed');
                    return false;
                }
                status.text('Uploading...');
            },
            onComplete: function (file, response) {
                // On completion clear the status
                status.text('');
                that.model.set('dp', true);
                $("#dp img").attr(
                    "src",
                that.model.get('dpUrl') + "?timestamp=" + new Date().getTime());
                // $('#profile-pic').html('<img class="media-object"
                // src="<%=dp%>" height="100" width="130">');
                // Add uploaded file to list
            }
        });
    },

    render: function () {
        $(this.el).html(this.template(this.model.toJSON()));
        return this;
    },
    
    onRender : function(){
        this.uploadImage();
    }
});

window.PerformanceView = Backbone.View.extend({
    className: "subject",
    initialize: function () {
        this.render();
        this.activel2Id = '0';
        this.activel3Id = '0';
        this.stats = null;
    },

    events: {
        'click .l2 li': 'onL2Click',
        'click .l3 li': 'onL3Click',
    },
    
    onL2Click : function (e){
    	if(this.activel2Id != e.target.parentElement.getAttribute('id')){
            $('.l3',this.el).empty();
            $('.l3-stats',this.el).empty();
            this.activel3Id = '0';
    		$('#'+this.activel2Id+'-l2').removeClass('active');
        	this.activel2Id = (e.target.parentElement.getAttribute('id')).split('-')[0];

        	//this.activel2Id = e.target.getAttribute('id');
        	$('#'+this.activel2Id+'-l2').addClass('active');        
        	this.renderL3();
    	}
    },
    
    onL3Click : function (e){
    	if(this.activel3Id != e.target.parentElement.getAttribute('id')){
        	$('#'+this.activel3Id+'-l3').removeClass('active');
        	this.activel3Id = (e.target.parentElement.getAttribute('id')).split('-')[0];
        	$('#'+this.activel3Id+'-l3').addClass('active');
        	this.renderStats();
        }
    },

    render: function () {
        $(this.el).html(this.template(this.model.toJSON()));
        return this;
    },

    onRender: function () {
        var l2 = sectionL2.where({
            l1Id: this.model.get('id')
        });
        var len = l2.length;
        for (var i = 0; i < len;i++) {
        	$('.l2',this.el).append('<li id="' + l2[i].get('id') + '-l2"><a>' + l2[i].get('displayName') + '</a></li>');
        }
    },

    renderL3: function () {
    	$('.l3',this.el).empty();
        var l3 = sectionL3.where({
            l2Id: this.activel2Id
        });
        var len = l3.length;
        for (var i = 0; i < len;i++) {
            $('.l3',this.el).append(
                '<li id="' + l3[i].get('id') + '-l3"><a>' + l3[i].get('displayName') + '</a></li>');
        }
    },

    renderStats: function () {
        $('#l3-stats',this.el).html('Hard code these things for now');
    }

    /*
     * for(var j = 0 ; j < len2 ;j++){ l2Id =l2[j].get('id'); var
     * l2ScoreModel = scoreL2.get(l2Id); var l2Score =
     * (l2ScoreModel==null?'N/A':l2ScoreModel.get('score'));
     * $(this.el).append('<h5>'+l2[j].get('displayName')+'-'+l2Score+'</h5>'); }
     */
    /*
     * <div class="row-fluid"> <div class="span4"></div> <div
     * class="span4"></div> <div class="span4"></div> </div>
     */

});