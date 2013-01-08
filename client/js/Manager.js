var STATUS = {
	SUCCESS : 'success',
	FAIL : 'fail',
	ERROR : 'error'
};

/**
 * the generic loaders
 */
$(document).ajaxStart(function() {
	$('#content').hide();
	$('#loading').show();
}).ajaxStop(function() {
	$('#content').show();
	$('#loading').hide();
});

// Tell jQuery to watch for any 401 or 403 errors and handle them appropriately
$.ajaxSetup({
	statusCode : {
		401 : function() {
			// Redirec the to the login page.
			window.location = '#login';
		},
		403 : function() {
			// 403 -- Access denied
			window.location = '#denied';
		}
	}
});

/**
 * 
 * The Manager class
 * 
 * @author ssachan
 * 
 */
window.Manager = {

	getStreams : function() {

	},

	getL1ByStreamId : function(id) {
		return $.ajax({
			url : Config.serverUrl + 'l1ByStream/' + id,
			dataType : "json",
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					sectionL1.reset(data.data);
				} else { // If not, send them back to the home page
					helper.showError(data.data);
				}
			}
		});
	},

	getL2ByStreamId : function(id) {
		return $.ajax({
			url : Config.serverUrl + 'l2ByStream/' + id,
			dataType : "json",
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					sectionL2.reset(data.data);
				} else { // If not, send them back to the home page
					helper.showError(data.data);
				}
			}
		});
	},

	getL3ByStreamId : function(id) {
		return $.ajax({
			url : Config.serverUrl + 'l3ByStream/' + id,
			dataType : "json",
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					sectionL3.reset(data.data);
				} else { // If not, send them back to the home page
					helper.showError(data.data);
				}
			}
		});
	},

	getL1Performance : function() {
		var url = Config.serverUrl + 'l1Performance/';
		return $.ajax({
			url : url,
			dataType : "json",
			data : {
				accountId : account.get('id'),
				streamId : streamId
			},
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					scoreL1.reset(data.data);
				} else { // If not, send them back to the home page
					helper.showError(data.data);
				}
			}
		});
	},

	getL2Performance : function() {
		var url = Config.serverUrl + 'l2Performance/';
		return $.ajax({
			url : url,
			data : {
				accountId : account.get('id'),
				streamId : streamId
			},
			dataType : "json",
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					scoreL2.reset(data.data);
				} else { // If not, send them back to the home page
					helper.showError(data.data);
				}
			}
		});
	},

	getSubjectsByStreamId : function(id) {
		var dfd = [ this.getL1ByStreamId(id), this.getL2ByStreamId(id),
				this.getL3ByStreamId(id) ];
		$.when.apply(null, dfd).then(function(data) {
		});
	},

	loadOverallView : function() {
		activeView.switchMenu('overall');
		var overView = new OverView({
			model : account
		});
		activeView.switchView(overView);
	},

	getDashboardData : function() {
		var dfd = [];
		var that = this;
		if (sectionL1.length == 0 || sectionL2.length == 0) {
			dfd.push(this.getL1ByStreamId(streamId));
			dfd.push(this.getL2ByStreamId(streamId));
			dfd.push(this.getL3ByStreamId(streamId));
		}
		dfd.push(this.getL1Performance());
		dfd.push(this.getL2Performance());
		$.when.apply(null, dfd).then(function(data) {
			var dbView = new DashboardView({});
			app.showView('#content', dbView);
			dbView.onRender();
			that.loadOverallView();
		});
	},

	getQuizzesByStreamId : function(id) {
		var url = Config.serverUrl + 'quizzesByStreamId/' + id;
		return $.ajax({
			url : url,
			dataType : "json",
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					if (account.get('id') == null) {
						// just load the library
						quizLibrary.reset(data.data);
					} else {
						// set the hasAttempted flag to true.
						var len = data.data.length;
						for ( var i = 0; i < len; i++) {
							var quiz = new Quiz(data.data[i]);
							if ($.inArray(quiz.get('id'), account
									.get('quizzesAttemptedArray')) != -1) {
								quiz.set('hasAttempted', true);
							}
							quizLibrary.push(quiz);
						}
					}
				} else { // If not, send them back to the home page
					helper.showError(data.data);
				}
			}
		});
	},

	getHistoryById : function() {
		var url = Config.serverUrl + 'historyById/';
		return $.ajax({
			url : url,
			data : {
				accountId : account.get('id'),
				streamId : streamId
			},
			dataType : "json",
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					quizHistory.reset(data.data);
				} else { // If not, send them back to the home page
					helper.showError(data.data);
				}
			}
		});
	},

	getFacByStreamId : function(id) {
		var url = Config.serverUrl + 'facByStreamId/' + id;
		$.ajax({
			url : url,
			dataType : "json",
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					facDirectory.reset(data.data);
					var facDirectoryView = new FacDirectoryView({
						collection : facDirectory,
					});
					app.showView('#content', facDirectoryView);
					facDirectoryView.onRender();

				} else { // If not, send them back to the home page
					helper.showError(data.data);
				}
			}
		});
	},

	loadQuiz : function(quiz) {
		if (quizQuestions.length > 0) {
			var qView = new QuizView({
				model : quiz,
				index : 0,
			});
			app.showView('#content', qView);
			qView.startQuiz();
		}
	},

	loadPractice : function(quiz) {
		if (quizQuestions.length > 0) {
			var pView = new PracticeView({
				model : quiz,
				index : quiz.get('state') == null ? 0 : parseInt(quiz
						.get('state')),
			});
			app.showView('#content', pView);
			pView.startQuiz();
		}
	},

	getFacById : function(id) {
		var url = Config.serverUrl + 'fac/' + id;
		return $.ajax({
			url : url,
			dataType : "json",
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					console.log("faculty fetched: " + data);
					fac.set(data.data);
				} else { // If not, show error
					helper.showError(data.data);
				}
			}
		});
	},

	getQuizzesByFac : function(id) {
		var url = Config.serverUrl + 'quizzesByFac/' + id + '|' + streamId;
		return $.ajax({
			url : url,
			dataType : "json",
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					console.log("faculty fetched: " + data);
					facQuizzes.reset(data.data);// facDirectory.reset(data);
				} else { // If not, show error
					helper.showError(data.data);
				}
			}
		});
	},

	getRSquareData : function() {
		if (activeView instanceof DashboardView) {
			activeView.switchMenu('rsquare');
			$('#main-content', this.el).append('<div class="header"><h2>Results Square</h2></div><br>');
			var l1 = sectionL1.models;
			var len = l1.length;
			for ( var i = 0; i < len; i++) {
				var pView = new PerformanceView({
					model : l1[i]
				});
				$('#main-content', this.el).append(pView.render().el);
				pView.onRender();
			}
		}
	},

	/**
	 * fetch all the data for the faculty page
	 * 
	 * @param facId
	 */
	getFaculty : function(facId) {
		var dfd = [ this.getFacById(facId), this.getQuizzesByFac(facId) ];
		$.when.apply(null, dfd).then(function(data) {
			var facView = new FacView({
				model : fac,
				collection : facQuizzes,
			});
			app.showView('#content', facView);
			facView.renderQuizzes();
		});
	},

	getPackagesByStreamId : function(streamId) {
		var url = Config.serverUrl + 'packagesByStreamId/' + streamId;
		return $.ajax({
			url : url,
			dataType : "json",
			success : function(data) {
				console.log("questions fetched: " + data.length);
				packages.reset(data);
				new PackagesView({
					collection : packages,
					el : $('#content'),
				});
			}
		});
	},

	getAttemptedQuestions : function() {
		var url = Config.serverUrl + 'attemptedQuestions/';
		return $.ajax({
			url : url,
			data : {
				accountId : account.get('id'),
				streamId : streamId
			},
			dataType : "json",
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					console.log("review questions fetched: " + data);
					attemptedQuestions.reset(data.data);// facDirectory.reset(data);
				} else { // If not, show error
					helper.showError(data.data);
				}
			}
		});
	},

	processQuiz : function(quizId) {
		var url = Config.serverUrl + 'processQuiz/';
		return $.ajax({
			url : url,
			type : 'GET',
			dataType : "json",
			data : {
				quizId : quizId,
				accountId : account.get('id'),
				streamId : streamId
			},
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					quizQuestions.reset(data.data);
				} else { // If not, send them back to the home page
					helper.showError(data.data);
				}
			}
		});
	},

	getDataForMySets : function() {
		var dfd = [];
		if (sectionL1.length == 0 || sectionL2.length == 0) {
			dfd.push(this.getL1ByStreamId(streamId));
			dfd.push(this.getL2ByStreamId(streamId));
			dfd.push(this.getL3ByStreamId(streamId));
		}
		dfd.push(this.getHistoryById());
		$.when.apply(null, dfd).then(function(data) {
			if (activeView instanceof DashboardView) {
				activeView.switchMenu('myprepsets');
				var mySetsView = new MySetsView({
					collection : quizHistory
				});
				activeView.switchView(mySetsView);
			}
		});
	},

	purchasePackage : function(id) {
		var url = Config.serverUrl + 'package/';
		return $.ajax({
			url : url,
			type : "POST",
			data : {
				packageId : id
			}, // gotta strinigfy the entire hash
			dataType : "json",
			success : function(data) {
				console.log("packages fetched: " + data.length);
			}
		});
	},

	/**
	 * ensure all questions are loaded in the quizQuestions collection
	 * 
	 * @param quiz
	 * @returns
	 */
	getDataForQuizLibrary : function(streamId) {
		var dfd = [];
		if (sectionL1.length == 0 || sectionL2.length == 0) {
			// what if the data is already is being fetched???I think jquery
			// makes sure with promises that it is not fetched again
			dfd.push(this.getL1ByStreamId(streamId));
			dfd.push(this.getL2ByStreamId(streamId));
			dfd.push(this.getL3ByStreamId(streamId));
		}
		dfd.push(this.getQuizzesByStreamId(streamId));
		$.when.apply(null, dfd).then(function(data) {
			var quizLibraryView = new QuizLibraryView({
				collection : quizLibrary,
			});
			app.showView('#content', quizLibraryView);
			quizLibraryView.onRender();
		});
	},

	startQuiz : function(quiz) {
		var dfd = [];
		dfd.push(this.processQuiz(quiz.get('id')));
		$.when.apply(null, dfd).then(function(data) {
			if (quizQuestions.length > 0) {
				var instructionsView = new InstructionsView({
					model : quiz
				});
				app.showView('#content', instructionsView);
			}
		});
	},

	resumeQuiz : function(quiz) {
		var dfd = [];
		dfd.push(this.processQuiz(quiz.get('id')));
		$.when.apply(null, dfd).then(function(data) {
			if (quizQuestions.length > 0) {
				var resumeView = new ResumeView({
					model : quiz
				});
				app.showView('#content', resumeView);
			}
		});
	},

	showResults : function(quiz) {
		var dfd = [];
		dfd.push(this.processQuiz(quiz.get('id')));
		$.when.apply(null, dfd).then(function(data) {
			if (quizQuestions.length > 0) {
				var resultsView = new ResultsView({
					model : quiz
				});
				app.showView('#content', resultsView);
				resultsView.onRender();
			}
		});
	},

	getDataForQuiz : function(quizId) {
		var quiz = null;
		quizQuestions.reset();
		quiz = quizLibrary.get(quizId) == null ? quizHistory.get(quizId)
				: quizLibrary.get(quizId);
		if (quiz != null) {
			switch (quiz.get('status')) {
			case quiz.STATUS_NOTSTARTED:
				this.startQuiz(quiz);
				break;

			case quiz.STATUS_INPROGRESS:
				this.resumeQuiz(quiz);
				break;

			case quiz.STATUS_INTERRUPTED:
				this.startQuiz(quiz);
				break;

			case quiz.STATUS_COMPLETED:
				this.showResults(quiz);
				break;
			}
		}
	},

	getDataForReview : function() {
		var dfd = [];
		dfd.push(this.getAttemptedQuestions());
		$.when.apply(null, dfd).then(function(data) {
			if (activeView instanceof DashboardView) {
				activeView.switchMenu('review');
				var reviewView = new ReviewView({
					collection : attemptedQuestions
				});
				activeView.switchView(reviewView);
			}
		});
	},

	getFacContactPage : function() {
		var facContactView = new FacContactView();
		app.showView('#content', facContactView);
	},
};
