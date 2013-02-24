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
    }
});

window.QuizCollection = Backbone.Collection.extend({
    model: Quiz,
    url: Config.serverUrl + 'quizzes/',
});

var quizLibrary = new QuizCollection();
var quizHistory = new QuizCollection();
var quizRecommendation = new QuizCollection();