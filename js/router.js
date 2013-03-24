/**
 * THE GLOBALS
 */
var app = null;
var activeStream = new Stream({
	id : '1',
	displayName : 'Engineering'
});

/**
 * Since streamId and accountId are very frequently used, move them out for
 * faster access
 */
var streamId = activeStream.get('id');
var accountId = account.get('id');
var activeMenu = null;
var mView = new ModalView();
var timer = new Timer(1000, null, []); // we will have just one global timer
var activeQuiz = null;
var activeView = null;

$(document).ready(function() {
	helper.loadTemplate(Config.viewsArray, function() {
		(function(d) {
			var js, id = 'facebook-jssdk';
			if (d.getElementById(id)) {
				return;
			}
			js = d.createElement('script');
			js.id = id;
			js.async = true;
			js.src = "//connect.facebook.net/en_US/all.js";
			d.getElementsByTagName('head')[0].appendChild(js);
		}(document));
		account.isAuth();
	});
});

var AppRouter = Backbone.Router.extend({

	routes : {
		"" : "dashboard",
		"landing" : "landing",
		"learn/:id":"learn",
		"signup" : "signUp",
		"library" : "library",
		"facs" : "facs",
		"quiz/:id" : "quiz",
		"question/:id" : "question",		
		"fac/:id" : "fac",
		"packages" : "packages",
		"forgotpass" : "forgotPass",
		"changepass" : "changePass",
		"facContact" : "facContact",
		"review" : "review",
		"myprepsets" : "myprepsets",
		"rsquare" : "rsquare",
		"activity" : "activity",
	},

	initialize : function() {
		window._gaq = window._gaq || [];  
		window._gaq.push(['_setAccount', 'UA-38361771-1']);  
		window._gaq.push(['_setDomainName', 'prepsquare.com']);  
		this.bind('all', this._trackPageview);  
		// fetch all the initial data here
		Manager.getSubjectsByStreamId(streamId);
		this.headerView = new HeaderView({
			el : $('#header'),
			model : account
		});
		this.footerView = new FooterView({
			el : $('#footer'),
		});
		if(account.get('id')!=null){
			Manager.getDashboardData();
			helper.loadScript('js/lib/jwplayer/jwplayer.js');
			helper.loadScript('js/lib/highcharts.js');
			helper.loadScript('js/lib/highcharts-more.js');
			helper.loadScript('js/lib/exporting.js');
		}
	},

	landing : function() {
		var lView = new LandingView({});
		this.showView('#content',lView);
		return;
	},

	dashboard : function() {
		this.changeMenu('dashboard-menu');
		// check if authenticated move to dashboard page, else move to landing
		// page
		if(account.get('id')!=null){
			Manager.getDashboardData();
			helper.loadScript('js/lib/jwplayer/jwplayer.js');
			helper.loadScript('js/lib/highcharts.js');
			helper.loadScript('js/lib/highcharts-more.js');
			helper.loadScript('js/lib/exporting.js');
		}else{
			window.location = '#landing';
		}
	},

	library : function() {
		this.changeMenu('lib-menu');
		Manager.getDataForQuizLibrary(streamId);
	},

	facs : function() {
		this.changeMenu('fac-menu');
		// if streamId is set
		if (streamId) {
			Manager.getFacByStreamId(streamId);
		} else {
			// get a generic faculty list
			alert('generic list of fac');
		}
	},
	
	rsquare : function (){
		Manager.getRSquareData();
	},
	
	activity : function(){
		Manager.getDataforActivity();
	},
	
	packages : function() {
		this.changeMenu('packages-menu');
		Manager.getPackagesByStreamId(streamId);
	},

	review : function() {
		Manager.getDataForReview();
	},
	
	myprepsets : function (){
		Manager.getDataForMySets();
	},
	
	fac : function(id) {
		Manager.getFaculty(id);
	},

	facContact : function() {
		Manager.getFacContactPage();
	},
	
	quiz : function(id) {
		if (account.get('id') != null) {
			Manager.getDataForQuiz(id);			
		} else {
			window.location = '#quizLibrary';
		}
	},
	
	question : function (id){
		//helper.loadScript('js/lib/jwplayer/jwplayer.js');
		Manager.getDataForQuestion(id);
	},
	
	changePass : function() {
		console.log('changing pass');
		// load forgot password page
		var changePassView = new ChangePassView({
			model : account
		});
		this.showView('#content',changePassView);
	},

	forgotPass : function() {
		console.log('forgot pass');
		// load forgot password page
		var forgotPassView = new ForgotPassView({
			model : account
		});
		this.showView('#content',forgotPassView);
	},
	
	learn : function(id) {
		this.changeMenu('hiw-menu');
		var learnMoreView = new LearnMoreView({
			menu : id
		});
		app.showView('#content', learnMoreView);
		learnMoreView.onRender();
	},
	
	signUp : function() {
		this.changeMenu('dash-menu');
		if (account.get('id') != null) {
			account.logout();
		}else{
			var signUpView = new SignUpView({
				model : account
			});
			app.showView('#content', signUpView);
			signUpView.onRender();
		} 
	},
	
	showView : function(selector, view) {
		$('.alert').hide();
		mView.close();
		if(view instanceof QuizView || view instanceof PracticeView ){
			$('#test-header').show();
			$('#menu-header').hide();
			$('#footer').hide();
		}else{
			$('#test-header').hide();
			$('#menu-header').show();
			$('#footer').show();
		}
		if (activeView)
			activeView.close();
		$(selector).html(view.render().el);
        $(window).scrollTop(0);
		activeView = view;
		return view;
	},

	changeMenu : function(newMenu) {
		if (activeMenu != null) {
			$('#' + activeMenu).removeClass('active');
		}
		activeMenu = newMenu;
		$('#' + activeMenu).addClass('active');
	},
	
	_trackPageview: function() {
		var url;  
		url = Backbone.history.getFragment();  
	    window._gaq.push(['_trackPageview', "/" + url]);  
	}
});

Backbone.View.prototype.close = function() {
	this.remove();
	this.unbind();
};

Backbone.Model.prototype.reset = function (options) {
	  this.set(this.defaults);
};