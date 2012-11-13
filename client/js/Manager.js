 // Tell jQuery to watch for any 401 or 403 errors and handle them appropriately
$.ajaxSetup({
    statusCode: {
        401: function(){
            // Redirec the to the login page.
            window.location.replace('#login');
         
        },
        403: function() {
            // 403 -- Access denied
            window.location.replace('#denied');
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
				sectionL1.reset(data);
			}
		});
	},

	getL2ByStreamId : function(id) {
		return $.ajax({
			url : Config.serverUrl + 'l2ByStream/' + id,
			dataType : "json",
			success : function(data) {
				sectionL2.reset(data);
			}
		});
	},

	getL3ByStreamId : function(id) {
		return $.ajax({
			url : Config.serverUrl + 'l3ByStream/' + id,
			dataType : "json",
			success : function(data) {
				sectionL3.reset(data);
			}
		});
	},

	getL1Performance : function() {
		var url = Config.serverUrl + 'l1Performance/' + id;
		return $.ajax({
			url : url,
			dataType : "json",
			success : function(data) {
				console.log("L1performance fetched: " + data.length);
				scoreL1.reset(data);
			}
		});
	},

	getL2Performance : function() {
		var url = Config.serverUrl + 'l2Performance/' + id;
		return $.ajax({
			url : url,
			dataType : "json",
			success : function(data) {
				console.log("L2performance fetched: " + data.length);
				scoreL2.reset(data);
			}
		});
	},

	getHistoryById : function() {
		var url = Config.serverUrl + 'historyById/' + id;
		return $.ajax({
			url : url,
			dataType : "json",
			success : function(data) {
				console.log("history fetched: " + data.length);
				quizHistory.reset(data);
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
		dfd.push(this.getHistoryById());
		$.when.apply(null, dfd).then(function(data) {
			new DashboardView({
				collection : scoreL1,
				collection2 : scoreL2,
				el : '#content'
			});
		});
	},

	getQuizzesByStreamId : function(id) {
		var url = Config.serverUrl + 'quizzesByStreamId/' + id;
		$.ajax({
			url : url,
			dataType : "json",
			success : function(data) {
				console.log("quizzes fetched: " + data.length);
				quizLibrary.reset(data);
				var quizLibraryView = new QuizLibraryView({
					model : quizLibrary,
					//el : '#content'
				});
				app.showView(quizLibraryView);
			}
		});
	},

	getFacByStreamId : function(id) {
		var url = Config.serverUrl + 'facByStreamId/' + id;
		$.ajax({
			url : url,
			dataType : "json",
			success : function(data) {
				console.log("faculty fetched: " + data.length);
				facDirectory.reset(data);
				new FacDirectoryView({
					model : facDirectory,
					el : '#content'
				});
			}
		});
	},

	getFacById : function(id) {
		var url = Config.serverUrl + 'fac/' + id;
		return $.ajax({
			url : url,
			dataType : "json",
			success : function(data) {
				console.log("faculty fetched: " + data.length);
				var faculty = new fac(data);//facDirectory.reset(data);
				new FacView({
					model : faculty,
					el : '#content'
				});
			}
		});
	},
	
	getQuizzesByFac : function(id) {
		var url = Config.serverUrl + 'quizzesByFac/' + id+'|'+streamId;
		return $.ajax({
			url : url,
			dataType : "json",
			success : function(data) {
				console.log("faculty fetched: " + data.length);
			}
		});
	},
	
	getFaculty : function(facId, streamId){
		this.getFacById();
	},
	
	getQuestions : function(qids){
		var url = Config.serverUrl + 'questions/';
		return $.ajax({
			url : url,
			dataType : "json",
			type : 'GET',
			data : {qids : qids},
			success : function(data) {
				console.log("questions fetched: " + data.length);
				quizQuestions.add(data);
			}
		});
	},
	
	getPackagesByStreamId : function(streamId){
		var url = Config.serverUrl + 'packagesByStreamId/'+streamId;
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
	
	processQuiz : function (quizId){
		var url = Config.serverUrl + 'processQuiz/';
		return $.ajax({
			url : url,
			type : 'GET',
			dataType : "json",
			data : {quizId : quizId, accountId : account.get('id')},
			success : function(data) {
				if (data.error) { // If there is an error, show the error
					// messages
					alert(data.error.text);
				} else { // If not, send them back to the home page
					quizQuestions.reset(data);
				}
			}
		});
	},
	
	purchasePackage : function(id){
		var url = Config.serverUrl + 'package/';
		return $.ajax({
			url : url,
			type: "POST",
			data: {packageId: id}, // gotta strinigfy the entire hash
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
	getQuizDataForStart : function(quizId) {
		activeQuiz = quizLibrary.get(quizId); // active quiz initialized for the first time
		var dfd = [];
		dfd.push(this.processQuiz(quizId));
		$.when.apply(null, dfd).then(function(data) {
			var quizView = new QuizView({
				model : activeQuiz,
				index : 0,
				//el : $('#content')
			});
			app.showView(quizView);
			quizView.startQuiz();
		});
	},

	/**
	 * ensure all data is present before quiz results are loaded.
	 * 
	 * @param id
	 * @returns
	 */
	getQuizDataForResults : function(quiz) {
		var dfd = [];
		dfd.push(this.getQuestions(quiz.get('questionIds')));
		$.when.apply(null, dfd).then(function(data) {
			var quizView = new QuizView({
				model : quiz,
				index : 0,
			});
			app.showView(quizView);
			quizView.renderResults();
		});
	},
	
	resetResults : function (){
		var url = Config.serverUrl + 'resetResults/';
		return $.ajax({
			url : url,
			dataType : "json",
			success : function(data) {
				alert("Results Reset");
			}
		});
	},
	
	resetAccounts : function (){
		var url = Config.serverUrl + 'resetAccounts/';
		return $.ajax({
			url : url,
			dataType : "json",
			success : function(data) {
				alert("All accounts Deleted Reset");
			}
		});
	}
	

};
