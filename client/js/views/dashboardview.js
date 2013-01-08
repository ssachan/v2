/**
 * The dashboard view
 * 
 * @author ssachan
 * 
 */
window.DashboardView = Backbone.View.extend({

	initialize : function() {
		this.activeMenu = null;
		this.activeView = null;
		this.overView = new OverView();
		this.myPrepSetsView = new MySetsView();
		this.review = new ReviewView();
		this.performanceView = new PerformanceView();
	},

	switchView : function(view) {
		if (this.activeView != null)
			this.activeView.close();
		$('#main-content', this.el).html(view.render().el);
		view.onRender();
		this.activeView = view;
		return view;
	},

	switchMenu : function(menu) {
		if (this.activeMenu != null) {
			$('#' + this.activeMenu + '-nav').removeClass('active');
		}
		if (this.activeMenu != menu) {
			this.activeMenu = menu;
			$('#' + this.activeMenu + '-nav').addClass('active');
			$('#main-content').empty();
		}
	},

	render : function() {
		$(this.el).html(this.template());
		return this;
	},

	onRender : function() {

	},

	renderOverall : function() {
	},

	renderPerformance : function() {
		this.switchMenu('performance');
		var l1 = sectionL1.models;
		var len = l1.length;
		for ( var i = 0; i < len; i++) {
			var pView = new PerformanceView({
				model : l1[i]
			});
			$('#main-content', this.el).append(pView.render().el);
			pView.onRender();
		}
	},

	renderActivity : function() {
		this.switchMenu('activity');

	},

	renderMyPrepSets : function(collection) {
		this.switchMenu('myprepsets');
		this.myPrepSetsView.collection = collection;
		$('#main-content', this.el).html(this.myPrepSetsView.render().el);
		this.myPrepSetsView.onRender();
	},

	renderReview : function(collection) {
		this.switchMenu('review');
		this.review.collection = collection;
		$('#main-content', this.el).html(this.review.render().el);
		this.review.onRender();
	},

	renderMyPackages : function() {
		this.switchMenu('mypackages');

	},

});

window.OverView = Backbone.View.extend({
	className : "overall",

	initialize : function() {
	},

	uploadImage : function() {
		var btnUpload = $('#upload');
		var status = $('#status');
		var that = this;
		new AjaxUpload(btnUpload, {
			action : Config.serverUrl + 'uploadImage',
			name : 'file',
			type : 'POST',
			onSubmit : function(file, ext) {
				if (!(ext && /^(jpg|png|jpeg|gif)$/.test(ext))) {
					// extension is not allowed
					status.text('Only JPG, PNG or GIF files are allowed');
					return false;
				}
				status.text('Uploading...');
			},
			onComplete : function(file, response) {
				// On completion clear the status
				status.text('');
				that.model.set('dp', true);
				$("#dp img").attr(
						"src",
						that.model.get('dpUrl') + "?timestamp="
								+ new Date().getTime());
				// $('#profile-pic').html('<img class="media-object"
				// src="<%=dp%>" height="100" width="130">');
				// Add uploaded file to list
			}
		});
	},

	render : function() {
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	},

	onRender : function() {
		// this.uploadImage();
	}
});

window.PerformanceView = Backbone.View.extend({
	className : "subject",
	initialize : function() {
		this.activel2Id = '0';
		this.activel3Id = '0';
		this.stats = null;
	},

	events : {
		'click .l2 li' : 'onL2Click',
		'click .l3 li' : 'onL3Click',
	},

	onL2Click : function(e) {
		if (this.activel2Id != e.target.parentElement.getAttribute('id')) {
			$('.l3', this.el).empty();
			$('.l3-stats', this.el).empty();
			this.activel3Id = '0';
			$('#' + this.activel2Id + '-l2').removeClass('active');
			this.activel2Id = (e.target.parentElement.getAttribute('id'))
					.split('-')[0];

			// this.activel2Id = e.target.getAttribute('id');
			$('#' + this.activel2Id + '-l2').addClass('active');
			this.renderL3();
		}
	},

	onL3Click : function(e) {
		if (this.activel3Id != e.target.parentElement.getAttribute('id')) {
			$('#' + this.activel3Id + '-l3').removeClass('active');
			this.activel3Id = (e.target.parentElement.getAttribute('id'))
					.split('-')[0];
			$('#' + this.activel3Id + '-l3').addClass('active');
			this.renderStats();
		}
	},

	render : function() {
		$(this.el).html(this.template(this.model.toJSON()));
		return this;
	},

	onRender : function() {
		var l2 = sectionL2.where({
			l1Id : this.model.get('id')
		});
		var len = l2.length;
		for ( var i = 0; i < len; i++) {
			$('.l2', this.el).append(
					'<li id="' + l2[i].get('id') + '-l2"><a>'
							+ l2[i].get('displayName') + '</a></li>');
		}
	},

	renderL3 : function() {
		$('.l3', this.el).empty();
		var l3 = sectionL3.where({
			l2Id : this.activel2Id
		});
		var len = l3.length;
		for ( var i = 0; i < len; i++) {
			$('.l3', this.el).append(
					'<li id="' + l3[i].get('id') + '-l3"><a>'
							+ l3[i].get('displayName') + '</a></li>');
		}
	},

	renderStats : function() {
		$('#l3-stats', this.el).html('Hard code these things for now');
	}
});

/*
 * window.InfoView = Backbone.View.extend({ initialize : function() { },
 * 
 * uploadImage : function() { var btnUpload = $('#upload'); var status =
 * $('#status'); var that = this; new AjaxUpload(btnUpload, { action :
 * Config.serverUrl + 'uploadImage', name : 'file', type : 'POST', onSubmit :
 * function(file, ext) { if (!(ext && /^(jpg|png|jpeg|gif)$/.test(ext))) { //
 * extension is not allowed status.text('Only JPG, PNG or GIF files are
 * allowed'); return false; } status.text('Uploading...'); }, onComplete :
 * function(file, response) { // On completion clear the status status.text('');
 * that.model.set('dp', true); $("#dp img").attr( "src", that.model.get('dpUrl') +
 * "?timestamp=" + new Date().getTime()); // $('#profile-pic').html('<img
 * class="media-object" // src="<%=dp%>" height="100" width="130">'); // Add
 * uploaded file to list } }); },
 * 
 * render : function() { $(this.el).html(this.template(this.model.toJSON()));
 * return this; },
 * 
 * onRender : function() { this.uploadImage(); } });
 */