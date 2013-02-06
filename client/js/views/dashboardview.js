/**
 * The dashboard view
 * 
 * @author ssachan
 * 
 */
window.DashboardView = Backbone.View.extend({
	className : 'container dashboard',
	initialize : function() {
		this.activeMenu = null;
		this.activeView = null;
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
		//$('a').tooltip({placement:'bottom'});
	}

});

window.OverView = Backbone.View.extend({
	className : "overall",

	initialize : function() {
		_.bindAll(this, "render");
		this.model.bind('change', this.render);
		this.model.bind('change', this.onRender);
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
		//this.uploadImage();
		$('#result-square').empty();
		var l1 = sectionL1.models;
        var len = l1.length;
        for (var i = 0; i < len; i++) {
            var pView = new PerformanceView({
                model: l1[i]
            });
            $('#result-square').append(pView.render().el);
            pView.onRender();
        }		
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
		'click .l1' : 'onL1Click',
		'click .l2 li' : 'onL2Click',
		'click .l3 li' : 'onL3Click',
	},
	
	onL1Click : function(e) {
		$('#' + this.activel2Id + '-l2').removeClass('active');
		this.activel2Id = '0';
		$('.l3', this.el).empty();
		$('.l3-stats', this.el).hide();
		this.activel3Id = '0';
		this.renderL1Stats();
	},
	
	onL2Click : function(e) {
		$('.l3', this.el).empty();
		$('.l3-stats', this.el).hide();
		this.activel3Id = '0';
		$('#' + this.activel2Id + '-l2').removeClass('active');
		this.activel2Id = (e.target.parentElement.getAttribute('lid'));

		// this.activel2Id = e.target.getAttribute('id');
		$('#' + this.activel2Id + '-l2').addClass('active');
		this.renderL3();
		this.renderL2Stats();
	},

	onL3Click : function(e) {
		if (this.activel3Id != e.target.parentElement.getAttribute('lid')) {
			$('#' + this.activel3Id + '-l3').removeClass('active');
			this.activel3Id = (e.target.parentElement.getAttribute('lid'));
			$('#' + this.activel3Id + '-l3').addClass('active');
			this.renderL3Stats();
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
			$('.l2', this.el).append('<li id="' + l2[i].get('id') + '-l2" lid="'+l2[i].get('id')+'"><a>'
							+ l2[i].get('displayName') + '</a></li>');
			var l2Score = scoreL2.get(l2[i].get('id'));
			if(l2Score!=null){
				var score = parseInt(l2Score.get('score'));
				if(score>80){
					$('#'+l2[i].get('id') + '-l2>a', this.el).addClass('bg-green');
				}else if(score>40 && score<=80){
					$('#'+l2[i].get('id') + '-l2>a', this.el).addClass('bg-yellow');
				}else if(score<=40 && score>0){
					$('#'+l2[i].get('id') + '-l2>a', this.el).addClass('bg-red');
				}else if(score==0){
					$('#'+l2[i].get('id') + '-l2>a', this.el).addClass('bg-grey');
				}
			}else{
				$('#'+l2[i].get('id') + '-l2>a', this.el).addClass('bg-grey');
			}
		}
		this.renderL1Stats();
	},
	
	renderStats : function (score){
		if(score!=null){
			$('.l3-stats #bar', this.el).html('<div class="bar bar-warning" style="width:'+parseInt(score.get('score'))+'%"></div>');
			$('.l3-stats #pts', this.el).html(parseInt(score.get('score')));
			$('.l3-stats #total', this.el).html(parseInt(score.get('numQuestions')));
			$('.l3-stats #correct', this.el).html(parseInt(score.get('numCorrect')));
			$('.l3-stats #incorrect', this.el).html(parseInt(score.get('numIncorrect')));
			$('.l3-stats #unattempted', this.el).html(parseInt(score.get('numUnattempted')));
		}else{
			$('.l3-stats #bar', this.el).html('<div class="bar bar-warning" style="width:'+parseInt('0')+'%"></div>');
			$('.l3-stats #pts', this.el).html('0');
			$('.l3-stats #total', this.el).html('0');
			$('.l3-stats #correct', this.el).html('0');
			$('.l3-stats #incorrect', this.el).html('0');
			$('.l3-stats #unattempted', this.el).html('0');
		}
		$('.l3-stats', this.el).show();
	},
	
	renderL1Stats : function (){
		var thisL1Score = scoreL1.get(this.model.get('id'));
		var l1Name = this.model.get('displayName');
		$('.l3-stats #topic', this.el).html(l1Name);
		this.renderStats(thisL1Score);
	},
	
	renderL2Stats : function (){
		var context = this;
		var thisL2Score = scoreL2.get(context.activel2Id);
		var l2Name = (sectionL2.get(context.activel2Id)).get('displayName');
		$('.l3-stats #topic', this.el).html(l2Name);
		this.renderStats(thisL2Score);
	},
	
	renderL3 : function() {
		$('.l3', this.el).empty();
		var l3 = sectionL3.where({
			l2Id : this.activel2Id
		});
		var len = l3.length;
		for ( var i = 0; i < len; i++) {
			$('.l3', this.el).append(
					'<li id="' + l3[i].get('id') + '-l3" lid="'+l3[i].get('id')+'"><a>'
							+ l3[i].get('displayName') + '</a></li>');
			var l3Score = scoreL3.get(l3[i].get('id'));
			if(l3Score!=null){
			var score = parseInt(l3Score.get('score'));
			if(score>80){
				$('#'+l3[i].get('id') + '-l3>a', this.el).addClass('bg-green');
			}else if(score>40 && score<=80){
				$('#'+l3[i].get('id') + '-l3>a', this.el).addClass('bg-yellow');
			}else if(score<=40 && score>0){
				$('#'+l3[i].get('id') + '-l3>a', this.el).addClass('bg-red');
			}else if(score==0){
				$('#'+l3[i].get('id') + '-l3>a', this.el).addClass('bg-grey');
			}
			}else{
				$('#'+l3[i].get('id') + '-l3>a', this.el).addClass('bg-grey');
			}
		}
	},

	renderL3Stats : function() {
		var context = this;
		var thisL3Score = scoreL3.get(context.activel3Id);
		var l3Name = (sectionL3.get(context.activel3Id)).get('displayName');
		$('.l3-stats #topic', this.el).html(l3Name);
		this.renderStats(thisL3Score);
	},
	
});

window.ActivityView = Backbone.View.extend({
	className : "overall",

	initialize : function() {
	},
	
	render : function() {
		$(this.el).html(this.template());
		return this;
	},

	onRender : function() {
		if(account.get('quizzesAttemptedArray').length==0){
			$('#insight').html('Looks like you have not taken any tests. Take one and return to this section');
		}
		 drawDonutChart('donut');
         $("tspan:contains('Highcharts.com')").hide();
	}
});
