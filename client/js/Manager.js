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

	getDashboardData : function() {
		var dfd = [];
		// ensure that by this time you have all the global data available
		if (sectionL1.length == 0 || sectionL2.length == 0) {
			// what if the data is already is being fetched???I think jquery
			// makes sure with promises that it is not fetched again
			dfd.push(this.getL1ByStreamId(streamId));
			dfd.push(this.getL2ByStreamId(streamId));
			dfd.push(this.getL3ByStreamId(streamId));
		}
		dfd.push(this.getL1Performance());
		dfd.push(this.getL2Performance());
		// dfd.push(this.getHistoryById());
		$.when.apply(null, dfd).then(function(data) {
			var dbView = new DashboardView({});
			app.showView('#content', dbView);
			dbView.onRender();
			/*
			 * new DashboardView({ collection : scoreL1, collection2 : scoreL2,
			 * //el : '#content' });
			 */
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
					new FacDirectoryView({
						collection : facDirectory,
						el : '#content'
					});
				} else { // If not, send them back to the home page
					helper.showError(data.data);
				}
			}
		});
	},

	getFacById : function(id) {
		var url = Config.serverUrl + 'fac/' + id;
		return $.ajax({
			url : url,
			dataType : "json",
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					console.log("faculty fetched: " + data);
					fac.set(data.data);// facDirectory.reset(data);
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
		// ensure that by this time you have all the global data available
		if (sectionL1.length == 0 || sectionL2.length == 0) {
			// what if the data is already is being fetched???I think jquery
			// makes sure with promises that it is not fetched again
			dfd.push(this.getL1ByStreamId(streamId));
			dfd.push(this.getL2ByStreamId(streamId));
			dfd.push(this.getL3ByStreamId(streamId));
		}
		dfd.push(this.getHistoryById());
		$.when.apply(null, dfd).then(function(data) {
			var mySetsView = new MySetsView({
				collection : quizHistory
			});
			app.showView('#content', mySetsView);
			mySetsView.onRender();
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
	
	startQuiz : function(quiz){
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
	
	resumeQuiz : function(quiz){
		var dfd = [];
		dfd.push(this.processQuiz(quiz.get('id')));
		$.when.apply(null, dfd).then(function(data) {
			if (quizQuestions.length > 0) {
				var pView = new PracticeView({
					model : quiz,
					index : quiz.get('state')==null?0:parseInt(quiz.get('state')),
				});
				app.showView('#content', pView);
				pView.startQuiz();
			}
		});
	},
	
	showResults : function(quiz){
		var dfd = [];
		dfd.push(this.processQuiz(quiz.get('id')));
		$.when.apply(null, dfd).then(function(data) {
			if (quizQuestions.length > 0) {
				var resultsView = new ResultsView({
					model : quiz,
					index : 0,
				});
				app.showView('#content', resultsView);
				resultsView.renderResults();
			}
		});
	},
	
	getDataForQuiz : function(quizId) {
		var quiz = null;
		quizQuestions.reset();
		// check if the quiz exists in the local datastructures
		// quiz library
		quiz = quizLibrary.get(quizId);
		if (quiz != null) {
			// just a casual check if its already taken
			if ($.inArray(quiz.get('id'), account.get('quizzesAttemptedArray')) == -1) {
				// new quiz thats being taken right now
				this.startQuiz(quiz);
				return;
			}
		}
		// check in hostory
		quiz = quizHistory.get(quizId);
		if (quiz != null) {
			var totalQuestions = quiz.get('questionIdsArray').length;
			// quiz was available in history, check if its complete or
			// incomplete
			if (parseInt(quiz.get('state'))==totalQuestions) {
				// completed quiz, get the results
				this.showResults(quiz);
			} else {
				if (quiz.get('attemptedAs') == '1') {
					//start the quiz all over again
					this.startQuiz(quiz);	
				}else if(quiz.get('attemptedAs')=='2'){
					//open practice view
					this.resumeQuiz(quiz);
				}
			}
			return;
		}
		if(quiz==null){
			alert('Direct access not allowed.');
		}
	},

	getDataForReview : function() {
		var dfd = [];
		dfd.push(this.getAttemptedQuestions());
		$.when.apply(null, dfd).then(function(data) {
			var reviewView = new ReviewView({
				collection : attemptedQuestions,
			});
			app.showView('#content', reviewView);
			reviewView.onRender();
		});
	},

	getFacContactPage : function() {
		var facContactView = new FacContactView();
		app.showView('#content', facContactView);
	},
};
