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
				new QuizLibraryView({
					model : quizLibrary,
					el : '#content'
				});
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

	/**
	 * @param id
	 * @returns
	 */
	getQuestion : function(id) {
		var url = Config.serverUrl + 'questions/' + id;
		return $.ajax({
			url : url,
			dataType : "json",
			success : function(data) {
				console.log("questions fetched: " + data.length);
				quizQuestions.add(data);
			}
		});
	},

	/**
	 * ensure all questions are loaded in the quizQuestions collection
	 * 
	 * @param quiz
	 * @returns
	 */
	getQuizDataForStart : function(quiz) {
		var qIds = quiz.getQuestionIds();
		var len = qIds.length;
		var dfd = [];
		/**
		 * make this call more efficient. Pass all ids at one go and fetch the
		 * questions using an IN clause
		 */
		for ( var i = 0; i < len; i++) {
			if (quizQuestions.get(qIds[i]) == null) {
				dfd.push(this.getQuestion(qIds[i]));
			}
		}
		$.when.apply(null, dfd).then(function(data) {
			new QuizView({
				model : quiz,
				index : 0,
				el : $('#content'),
				timer : timer
			});
		});
	},

	/**
	 * ensure all data is present before quiz results are loaded.
	 * 
	 * @param id
	 * @returns
	 */
	getQuizDataForResults : function(quiz) {
		var qIds = quiz.getQuestionIds();
		var len = qIds.length;
		var dfd = [];
		/**
		 * make this call more efficient. Pass all ids at one go and fetch the
		 * questions using an IN clause
		 */
		for ( var i = 0; i < len; i++) {
			if (quizQuestions.get(qIds[i]) == null) {
				dfd.push(this.getQuestion(qIds[i]));
			}
		}
		$.when.apply(null, dfd).then(function(data) {
			new QuizResultsView({
				model : quiz,
				el : $('#content')
			});
		});
	},

};
