// created using 
//cat accounts.js streams.js questions.js quizzes.js fac.js packages.js sections.js scores.js logs.js > models.js
window.Account = Backbone.Model.extend({

	defaults : {
		id : null,
		quizzesAttempted : null,
		dpUrl : DP_PATH + 'avatar.jpg'
	},

	urlRoot : ' ',

	initialize : function() {
		if (!this.get('quizzesAttemptedArray')) {
			this.set({
				quizzesAttemptedArray : new Array()
			});
		}

		this.on('change:quizzesAttempted', function(model) {
			model.get('quizzesAttemptedArray').length = 0;
			if (model.get('quizzesAttempted') != null
					&& model.get('quizzesAttemptedArray')) {
				model.get('quizzesAttemptedArray').push.apply(this
						.get('quizzesAttemptedArray'), JSON.parse(model
						.get('quizzesAttempted')));
			}
		});

		this.on('change:dp', function(model) {
			if (model.get('dp') == true) {
				model.set('dpUrl', DP_PATH + model.get('id') + '.jpg');
			} else {
				model.set('dpUrl', DP_PATH + 'avatar.jpg');
			}
		});

		// var that = this;
		// Hook into jquery
		// The server must allow this through response headers
		/*
		 * $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
		 * options.xhrFields = { withCredentials : true }; // If we have a csrf
		 * token send it through with the next request if (typeof
		 * that.get('_csrf') !== 'undefined') {
		 * jqXHR.setRequestHeader('X-CSRF-Token', that.get('_csrf')); } });
		 */
	},

	fConnect : function() {
		user.login();
		// also send the details to the server
	},

	gConnect : function() {
		glogin();
	},

	login : function(email, password) {
		// Do a POST to /login and send the creds
		var url = Config.serverUrl + 'login';
		console.log('Loggin in... ');
		var formValues = {
			email : email,
			password : password,
			streamId : 1
		};
		$.ajax({
			url : url,
			type : 'POST',
			dataType : "json",
			data : formValues,
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					account.set(data.data);
					window.location = '#';
				} else {
					helper.processStatus(data);
				}
			},
			error : function(data) {
				helper.processStatus(data.responseText);
			}
		});
	},

	logout : function() {
		// delete the existing sesison and reset account
		var url = Config.serverUrl + 'logout';
		$.ajax({
			url : url,
			type : 'GET',
			dataType : "json",
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					console.log('log out');
					// window.location.replace('#landing');
					if (user) {
						user.clear();
					}
					account.reset();
					account.get('quizzesAttemptedArray').length = 0;
					activeQuiz = null;
					var signUpView = new SignUpView({
						model : account
					});
					app.showView('#content', signUpView);
					signUpView.onRender();
				}
				helper.processStatus(data);
			},
			error : function(data) {
				helper.processStatus(data.responseText);
			},
		});
	},

	invite : function(inputValues) {
		// Do a POST to /login and send the creds
		var url = Config.serverUrl + 'invite';
		console.log('invite up... ');
		$.ajax({
			url : url,
			type : 'POST',
			dataType : "json",
			data : inputValues,
			success : function(data) {
				helper.processStatus(data);
			},
			error : function(data) {
				helper.processStatus(data.responseText);
			},
		});
	},

	fblogin : function(inputValues) {
		// Do a POST to /login and send the creds
		var url = Config.serverUrl + 'fblogin';
		console.log('fb up... ');
		$.ajax({
			url : url,
			type : 'POST',
			dataType : "json",
			data : inputValues,
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					account.set(data.data);
					window.location = '#';
				} else {
					helper.processStatus(data);
				}
			},
			error : function(data) {
				helper.processStatus(data.responseText);
			},
		});
	},
	
	ccSignUp : function(inputValues) {
		// Do a POST to /login and send the creds
		var url = Config.serverUrl + 'ccsignup';
		console.log('signing up... ');
		$.ajax({
			url : url,
			type : 'POST',
			dataType : "json",
			data : inputValues,
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					account.set(data.data);
					helper.track("csup",{"id":account.get('id'),
				        "ccode": inputValues.ccode, 'email':account.get('email')
				    });
					window.location = '#';
				} else {
					helper.processStatus(data);
				}
			},
			error : function(data) {
				helper.processStatus(data.responseText);
			},
		});
	},
	
	signUp : function(inputValues) {
		// Do a POST to /login and send the creds
		var url = Config.serverUrl + 'signup';
		console.log('signing up... ');
		$.ajax({
			url : url,
			type : 'POST',
			dataType : "json",
			data : inputValues,
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					account.set(data.data);
					helper.track("sup",{"id":account.get('id'),'email':account.get('email')
				    });
					window.location = '#';
				} else {
					helper.processStatus(data);
				}
			},
			error : function(data) {
				helper.processStatus(data.responseText);
			},
		});
	},

	forgotPass : function(email) {
		var url = Config.serverUrl + 'forgotpass';
		console.log('forgot pass... ');
		var formValues = {
			email : email,
		};
		$.ajax({
			url : url,
			type : 'POST',
			dataType : "json",
			data : formValues,
			success : function(data) {
				helper.processStatus(data);
			},
			error : function(data) {
				helper.processStatus(data.responseText);
			},
		});
	},

	changePass : function(oldpassword, newpassword) {
		var url = Config.serverUrl + 'changepass';
		console.log('change pass... ');
		$.ajax({
			url : url,
			type : 'POST',
			dataType : "json",
			data : {
				oldpassword : oldpassword,
				newpassword : newpassword,
				accountId : this.get('id')
			},
			success : function(data) {
				helper.processStatus(data);
			},
			error : function(data) {
				helper.processStatus(data.responseText);
			},
		});
	},

	isAuth : function() {
		// isAuth is wrapped around our router
		// before we start any routers let us see if the user is authenticated
		url = Config.serverUrl + 'isAuth';
		$.ajax({
			url : url,
			type : 'GET',
			dataType : "json",
			success : function(data) {
				if (data.status == STATUS.SUCCESS) {
					account.set(data.data);
				}
				app = new AppRouter();
				Backbone.history.start();
			}
		});
	},

});

var account = new Account();
window.Stream = Backbone.Model.extend({

    urlRoot: Config.serverUrl+'streams/',

    initialize: function () {
    	
    },
});

window.StreamCollection = Backbone.Collection.extend({
    model: Stream,
    url: Config.serverUrl+'streams/',
});

var streams = new StreamCollection();
/**
 * The Question Model
 * @author ssachan 
 * 
 **/
window.Question = Backbone.Model.extend({

    urlRoot: Config.serverUrl+'questions/',
    
    defaults: {
        'correctAnswer': null,
        'status': null, // null not attempted, true correct, false incorrect
        'timeTaken': null,
        'hasAttempted':false,
        'optionSelected':null,
        'isCorrect':null,
        'videoData' : null, //am adding this to load video for each question
        'typeString':''
    },
        
    initialize: function () {
      var l3Id=this.get('l3Id');
        if (l3Id) {
        	var l3 = sectionL3.get(l3Id);
        	var l2Id = l3.get('l2Id');
            this.set('l2Id',l2Id);
        	var l2 = sectionL2.get(l2Id);
            this.set('l1Id',l2.get('l1Id'));
        }
        if (this.get('optionSelected')) {
        	this.set('isCorrect',this.isOptionSelectedCorrect(this.get('optionSelected')));
        }
        if(this.get('typeId')){
        	var type = this.get('typeId');
        	switch(type){
        		case "1":
        			this.set('typeString','');
        			break;
        		case "2":
        			this.set('typeString','Multiple Choice');
        			break;
        		case "3":
        			this.set('typeString','Integer Type');
        			break;
        		case "4":
        			this.set('typeString','Matrix Type');
        			break;
        	}
        }
    },
	
	getOption : function (index){
		var type = this.get('typeId');
		switch (type){
		case "1":
            var optionsArray = this.get('options').split(SEPARATOR);
            return optionsArray[index];
		}
	},
	//tanujb:TODO:remove this function.
	getScore : function(){
		var type = this.get('typeId');
		switch(type){
		case "1":
			// the single option correct
			if(this.isOptionSelectedCorrect(this.get('optionSelected'))==true){
				// got it correct
				return parseInt(this.get('correctScore'));
			}else if(this.isOptionSelectedCorrect(this.get('optionSelected'))==false){
				// got it incorrect
				return parseInt('-'+this.get('incorrectScore'));
			}else{
				return null;
			}
			break;
		case "2":
			// the multiple option correct
			if(this.isOptionSelectedCorrect(this.get('optionSelected'))==true){
				// got it correct
				return parseInt(this.get('correctScore'));
			}else if(this.isOptionSelectedCorrect(this.get('optionSelected'))==false){
				// got it incorrect check for individual options
				return parseInt('-'+this.get('incorrectScore'));
			}else{
				return null;
			}

			break;
		case "3":
			// integer type
			if(this.isOptionSelectedCorrect(this.get('optionSelected'))==true){
				// got it correct
				return parseInt(this.get('correctScore'));
			}else if(this.isOptionSelectedCorrect(this.get('optionSelected'))==false){
				// got it incorrect
				return parseInt('-'+this.get('incorrectScore'));
			}else{
				return null;
			}

			break;
		case "4":
			// matrix type
			if(this.isOptionSelectedCorrect(this.get('optionSelected'))==true){
				// got it correct
				return parseInt(this.get('correctScore'));
			}else if(this.isOptionSelectedCorrect(this.get('optionSelected'))==false){
				// got it incorrect check for individual options
				var totalScore = 0;
				var optionScore = parseInt(this.get('optionScore'));
				if(optionScore!=0){
					// we have option scores
					var correctAnswersArray = (this.get('correctAnswer')).split(SEPARATOR+SEPARATOR);
					var selectedOptionsArray = (this.get('optionSelected')).split(SEPARATOR+SEPARATOR);
					var len = correctAnswersArray.length;
					for (var i = 0; i< len; i++){
						if(selectedOptionsArray[i]!=null && selectedOptionsArray[i]==correctAnswersArray[i]){
							// u got the option correct
							totalScore = totalScore + optionScore;
						}
					}
				}
				return totalScore;
			}else{
				return null;
			}
			break;
		}
	},
	
    /**
     * returns true, false and null depending on whether the option selected was right, wrong or not selected at all. 
     **/
	isOptionSelectedCorrect : function (selectedOption){
		var isCorrect = null; 
		var answer = this.get('correctAnswer');
		if(selectedOption && selectedOption!=null){
			isCorrect = (selectedOption==answer)?true:false;
		}
		return isCorrect; 
	},
	
	/**
     * returns true, false and null depending on whether the option selected was right, wrong or not selected at all. 
     **/
	setStatus : function (){
		var status = null; 
		var answer = this.get('correctAnswer');
		var optionSelected = this.get('optionSelected');
		if(optionSelected && optionSelected!=null){
			status = (optionSelected==answer)?true:false;
		}
		this.set('status',status);
	},
});

window.QuestionCollection = Backbone.Collection.extend({
    model: Question,
    url: Config.serverUrl+'questions/'
});

var quizQuestions = new QuestionCollection();
var attemptedQuestions = new QuestionCollection();
var question = new Question();
/**
 * The Quiz Model
 * 
 * @author ssachan
 * 
 */
window.Quiz = Backbone.Model.extend({
	
    defaults: {
        'hasAttempted': false,
        'numCorrect': 0,
        'numIncorrect': 0,
        'numTotal': 0,
        'selectedAnswers': null,
        'timePerQuestion': null,
        'statusPerQuestion': null,
        'descriptionShort': null,
        'maxScore': 0,
        'score': 0,
        'timeTaken': 0,
        'topics': '',
        'l1': null,
        'fid': null,
        'firstName': null,
        'lastName': null,
        'attemptedAs': null,
        'logo': null,
        'fdpURL': DP_PATH + 'avatar.jpg',
        'state': null,
        'startTime': null,
        'reason':null
    },
    
    urlRoot: Config.serverUrl + 'quizzes/',
    // tanujb:TODO: this model is a mess, needs cleanup badly.
    STATUS_NOTSTARTED: 0, // when the quiz is fresh from the library
    STATUS_COMPLETED: 1, // when the quiz is completed
    STATUS_INPROGRESS: 2, // when the attemptedAs is set and the quiz is in progress
    STATUS_INTERRUPTED: 3, // when the attemptedAs is not set

    initialize: function () {
        if (!this.get('questionIdsArray')) {
            this.set({
                questionIdsArray: new Array()
            });
        }
        if (!this.get('selectedAnswersArray')) {
            this.set({
                selectedAnswersArray: new Array()
            });
        }
        if (!this.get('timePerQuestionArray')) {
            this.set({
                timePerQuestionArray: new Array()
            });
        }
        if (this.get('questionIds') != null) {
            this.get('questionIdsArray').push.apply(this.get('questionIdsArray'), this.get('questionIds')
                .split(SEPARATOR));
        }
        if (this.get('selectedAnswers') != null) {
            this.get('selectedAnswersArray').push.apply(this.get('selectedAnswersArray'), JSON.parse(this.get('selectedAnswers')));
        }
        if (this.get('timePerQuestion') != null) {
            this.get('timePerQuestionArray').push.apply(this.get('timePerQuestionArray'), JSON.parse(this.get('timePerQuestion')));
            //sum the time to get timeTaken
            this.setTimeTaken();
        }
        if (this.get('statusPerQuestion') != null) {
            this.get('statusPerQuestionArray').push.apply(this.get('statusPerQuestionArray'), JSON.parse(this.get('statusPerQuestion')));
        }
        if (this.get('score') != null) {
            /*var score = JSON.parse(this.get('score'));
            this.set('totalCorrect', score[0]);
            this.set('totalIncorrect', score[1]);
            this.set('totalScore', score[2]);
            */
        }
        if (this.get('fid') != null) {
            this.set('fdpURL', DP_PATH + this.get('fid') + '.jpg');
        }
        if (this.get('l2Ids') != null) {
            var l2Ids = this.get('l2Ids').split(SEPARATOR);
            var len = l2Ids.length;
            if (len == 1) {
                var l2 = sectionL2.get(l2Ids[0]);
                this.set('topics', l2.get('displayName'));
                this.set('l1', (sectionL1.get(l2.get('l1Id')))
                    .get('id'));
            } else {
                var topics = [];
                for (var i = 0; i < len; i++) {
                    var l2 = sectionL2.get(l2Ids[i]);
                    topics.push(l2.get('displayName'));
                    this.set('l1', (sectionL1.get(l2.get('l1Id')))
                        .get('id'));
                }
                this.set('topics', topics.join(','));
            }
        }

        if (this.get('l1') != null) {
            this.set('l1DisplayName', (sectionL1.get(this.get('l1')))
                .get('displayName'));
            this.set('logo', 'img/l1-' + this.get('l1') + '.png');
        }
        if (this.get('startTime') != null) {
        	this.setStatus();
        } else {
            this.set('status', this.STATUS_NOTSTARTED);
        }
        //onChange functions 
        this.on('change:questionIds', function (model) {
            if (model.get('questionIds') != null && model.get('questionIdsArray')) {
                model.get('questionIdsArray').push.apply(this.get('questionIdsArray'), (model.get('questionIds')).split(SEPARATOR));
                model.setTimeTaken();
            }
        });

        this.on('change:selectedAnswers', function (model) {
            if (model.get('selectedAnswers') != null && model.get('selectedAnswersArray')) {
                model.get('selectedAnswersArray').push.apply(this.get('selectedAnswersArray'), JSON.parse(model.get('selectedAnswers')));
            }
        });

        this.on('change:timePerQuestion', function (model) {
            if (model.get('timePerQuestion') != null && model.get('timePerQuestionArray')) {
                model.get('timePerQuestionArray').push.apply(this.get('timePerQuestionArray'), JSON.parse(model.get('timePerQuestion')));
                model.setTimeTaken();
            }
        });

        this.on('change:startTime', function (model) {
            model.setStatus();
        });
        this.on('change:attemptedAs', function (model) {
            model.setStatus();
        });
        this.on('change:state', function (model) {
            model.setStatus();
        });
        
        if(this.get('difficulty')){
        	var diff = this.get('difficulty');
        	switch(diff){
        		case "1":
        			this.set('difficultyString','Easy');
        			break;
        		case "2":
        			this.set('difficultyString','Medium');
        			break;
        		case "3":
        			this.set('difficultyString','Hard');
        			break;
        	}
        }
    },

    setTimeTaken: function () {
        //sum the time to get timeTaken
        var timeTaken = 0;
        var len = this.get('timePerQuestionArray').length;
        for (var k = 0; k < len; k++) {
            v = parseInt(this.get('timePerQuestionArray')[k]);
            if (!isNaN(v)) timeTaken += v;
        }
        this.set('timeTaken', timeTaken);
    },

    setStatus: function () {
            // quiz was downloaded
            if (this.get('attemptedAs') == null) {
                // attemptedAs was not set
                this.set('status', this.STATUS_INTERRUPTED);
            } else {
                if (this.get('state') == null) {
                    this.set('status', this.STATUS_INPROGRESS);
                } else if (this.get('state') == this.get('questionIdsArray').length) {
                    this.set('status', this.STATUS_COMPLETED);
                } else {
                    this.set('status', this.STATUS_INPROGRESS);
                }
            }
    },

    updateAttemptedAs: function () {
        // Do a POST
        var url = Config.serverUrl + 'attemptedAs/';
        var that = this;
        $.ajax({
            url: url,
            type: 'POST',
            dataType: "json",
            data: {
                accountId: account.get('id'),
                quizId: this.get('id'),
                attemptedAs: this.get('attemptedAs')
            },
            success: function (data) {
                if (data.status == STATUS.SUCCESS) {
                    if (data.data == 1) {
                        // start the quiz
                        Manager.loadQuiz(that);
                    } else {
                        Manager.loadPractice(that);
                    }
                } else {
                    helper.showError(data.data);
                }
            }
        });
    },

    /**
     * Data uploaded to results.
     * 
     * @param quiz
     */
    submitPracticeQuestion: function () {
        var url = Config.serverUrl + 'submitPractice';
        var that = this;
        $.ajax({
            url: url,
            type: 'POST',
            dataType: "json",
            data: {
                accountId: account.get('id'),
                quizId: this.get('id'),
                streamId: streamId,
                state: this.get('state'),
                logs: logs.toJSON(),
                isLast: 0
            },
            success: function (data) {
                // tanujb:TODO :what does this code do?
                //I need to forward the data coming from here to ResultsView
                if (data.status == STATUS.SUCCESS) {

                } else {
					helper.processStatus(data);
                }
            },
            error: function (data) {
                console.log(data);
            },
        });
    },

    /**
     * Data uploaded to results.
     * 
     * @param quiz
     */
    submitPracticeResults: function () {
        var url = Config.serverUrl + 'submitPractice';
        var that = this;
        $.ajax({
            url: url,
            type: 'POST',
            dataType: "json",
            data: {
                accountId: account.get('id'),
                quizId: this.get('id'),
                streamId: streamId,
                state: this.get('state'),
                logs: logs.toJSON(),
                isLast: 1
            },
            success: function (data) {
                // tanujb:TODO :what does this code do?
                //I need to forward the data coming from here to ResultsView
                if (data.status == STATUS.SUCCESS) {
                    that.set(data.data);
                    that.set('status', that.STATUS_COMPLETED);
                    app.quiz(that.get('id'));
                } else {
					helper.processStatus(data);
                }
            },
            error: function (data) {
                console.log(data);
            },
        });
    },

    /**
     * Data uploaded to results.
     * 
     * @param quiz
     */
    submitQuiz: function () {
        var url = Config.serverUrl + 'submitQuiz';
        var that = this;
        $.ajax({
        	//context:this,
            url: url,
            type: 'POST',
            dataType: "json",
            data: {
                accountId: account.get('id'),
                quizId: this.get('id'),
                streamId: streamId,
                state: this.get('state'),
                logs: logs.toJSON()
            },
            success: function (data) {
                // tanujb:TODO :what does this code do?
                //I need to forward the data coming from here to ResultsView
                if (data.status == STATUS.SUCCESS) {
                    that.set(data.data);
                    that.set('status', that.STATUS_COMPLETED);
                    app.quiz(that.get('id'));
                } else {
					helper.processStatus(data);
                }
            },
            error: function (data) {
                console.log(data);
            },
        });
    },
    
    /**
     * addQuizReco
     * 
     * @param quiz
     */
    addReco: function () {
        var url = Config.serverUrl + 'addQuizReco';
        var that = this;
        $.ajax({
        	//context:this,
            url: url,
            type: 'POST',
            dataType: "json",
            data: {
                accountId: account.get('id'),
                quizId: this.get('id'),
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

window.QuizCollection = Backbone.Collection.extend({
    model: Quiz,
    url: Config.serverUrl + 'quizzes/',
});

var quizLibrary = new QuizCollection();
var quizHistory = new QuizCollection();
var quizReco = new QuizCollection();/**
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
                	if(data.status == STATUS.SUCCESS){
                		that.set('rec',parseInt(that.get('rec'))+1);
                	}
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
var fac = new Fac();/**
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
/**
 * The SectionL1 Model
 * @author ssachan 
 * 
 **/
window.SectionL1 = Backbone.Model.extend({

    urlRoot: Config.serverUrl+'l1/',
    initialize: function () {}

});

window.SectionL1Collection = Backbone.Collection.extend({
    model: SectionL1,
    url: Config.serverUrl+'l1/'
});

/**
 * The SectionL2 Model
 * @author ssachan 
 * 
 **/
window.SectionL2 = Backbone.Model.extend({

    urlRoot: Config.serverUrl+'l2/',
    initialize: function () {}

});

window.SectionL2Collection = Backbone.Collection.extend({
    model: SectionL2,
    url: Config.serverUrl+'l2/'
});

/**
 * The SectionL3 Model
 * @author ssachan 
 * 
 **/
window.SectionL3 = Backbone.Model.extend({

    urlRoot: Config.serverUrl+'l3/',
    initialize: function () {}

});

window.SectionL3Collection = Backbone.Collection.extend({
    model: SectionL3,
    url: Config.serverUrl+'l3/'
});

var sectionL1 = new SectionL1Collection();

var sectionL2 = new SectionL2Collection();

var sectionL3 = new SectionL3Collection();/**
 * The ScoreL1 model
 * @author ssachan 
 * 
 **/
window.ScoreL1 = Backbone.Model.extend({

    urlRoot: Config.serverUrl+'l1/',
    initialize: function () {}

});

window.ScoreL1Collection = Backbone.Collection.extend({
    model: ScoreL1,
    url: Config.serverUrl+'l1/'
});

/**
 * The ScoreL2 model
 * @author ssachan 
 * 
 **/
window.ScoreL2 = Backbone.Model.extend({

    urlRoot: Config.serverUrl+'l2/',
    initialize: function () {}

});

window.ScoreL2Collection = Backbone.Collection.extend({
    model: ScoreL2,
    url: Config.serverUrl+'l2/'
});

window.ScoreL3 = Backbone.Model.extend({

    urlRoot: Config.serverUrl+'l3/',
    initialize: function () {}

});

window.ScoreL3Collection = Backbone.Collection.extend({
    model: ScoreL3,
    url: Config.serverUrl+'l3/'
});

var scoreL1 = new ScoreL1Collection();

var scoreL2 = new ScoreL2Collection();

var scoreL3 = new ScoreL3Collection();window.Log = Backbone.Model.extend({

	urlRoot : ' ',

	
	initialize : function(attr, eid, questionid, optionid) {
		this.set('t',new Date().getTime());
		this.set('e',eid);
		this.set('q',questionid);
		this.set('o',optionid);
	},

	defaults : {
		t : null,
		e : null,
		q : null,
		o : null
	}

});

window.LogCollection = Backbone.Collection.extend({
	model : Log,

	eventids : {	
	OPTION_SELECT : 0,
	OPTION_DESELECT : 1,
	QUESTION_OPEN :3,
	QUESTION_CLOSE :4,
	QUESTION_MARK : 5,
	QUESTION_UNMARK: 6,
	QUESTION_SUBMIT: 7,
	TEST_SUBMIT: 8,
	TEST_PAUSE: 9,
	TEST_START: 10 },

	addEntry: function(eventname, questionid, optionid)
	{
		this.add(new Log("",this.eventids[eventname],questionid,optionid));
	},

	comparator: function(logEntry)
	{
		return logEntry.get("t");
	}
});

var logs = new LogCollection();
