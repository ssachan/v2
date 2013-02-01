var STATUS = {
    SUCCESS: 'success',
    FAIL: 'fail',
    ERROR: 'error'
};

/**
 * the generic loaders
 */
$(document).ajaxStart(function () {
    $('body').css({
        opacity: 0.5
    });
    // $('#content').hide();
    $('#loading').show();
}).ajaxStop(function () {
    $('body').css({
        opacity: 1
    });
    // $('#content').show();
    $('#loading').hide();
});

// Tell jQuery to watch for any 401 or 403 errors and handle them appropriately
$.ajaxSetup({
    statusCode: {
        401: function () {
            // Redirec the to the login page.
            window.location = '#login';
        },
        403: function () {
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

    getStreams: function () {

    },

    getTopics: function (level, id) {
        return $.ajax({
            url: Config.serverUrl + 'topics/' + level + '/' + id,
            dataType: "json",
            success: function (data) {
                if (data.status == STATUS.SUCCESS) {
                    switch (level) {
                        case "l1":
                            sectionL1.reset(data.data);
                            break;
                        case "l2":
                            sectionL2.reset(data.data);
                            break;
                        case "l3":
                            sectionL3.reset(data.data);
                            break;
                    }
                } else { // If not, send them back to the home page
                    helper.showError(data.data);
                }
            }
        });
    },

    getPQ: function () {
        var url = Config.serverUrl + 'pq/' + account.get('id');
        return $.ajax({
            url: url,
            dataType: "json",
            success: function (data) {
                if (data.status == STATUS.SUCCESS) {
                    account.set('ascore', data.data);
                } else { // If not, send them back to the home page
                    helper.showError(data.data);
                }
            }
        });
    },

    getScores: function (level) {
        var url = Config.serverUrl + 'scores/' + level;
        return $.ajax({
            url: url,
            data: {
                accountId: account.get('id'),
                streamId: streamId
            },
            dataType: "json",
            success: function (data) {
                if (data.status == STATUS.SUCCESS) {
                    switch (level) {
                        case "l1":
                            scoreL1.reset(data.data);
                            break;
                        case "l2":
                            scoreL2.reset(data.data);
                            var totalQuestions = 0;
                            // calculate totalQuestions attempted
                        	for(var i = 0; i< scoreL2.length; i++){
                        		totalQuestions=+ parseInt(scoreL2.models[i].get('numQuestions'));
                        	}
                        	account.set('totalQ',totalQuestions);
                            break;
                        case "l3":
                            scoreL3.reset(data.data);
                            break;
                    }
                } else { // If not, send them back to the home page
                    helper.showError(data.data);
                }
            }
        });
    },

    getSubjectsByStreamId: function (id) {
        var dfd = [this.getTopics("l1", id), this.getTopics("l2", id),
        this.getTopics("l3", id)];
        var pakka = new jQuery.Deferred();
        $.when.apply(null, dfd).then(function (data) {
            pakka.resolve("Subjects Fetched");
        });
        return pakka.promise();
    },

    loadOverallView: function () {
        activeView.switchMenu('overall');
        var overView = new OverView({
            model: account
        });
        activeView.switchView(overView);
    },

    getDashboardData: function () {
        var dfd = [];
        var that = this;
        if (sectionL1.length == 0 || sectionL2.length == 0) {
            dfd.push(this.getSubjectsByStreamId(streamId));
        }
        dfd.push(this.getPQ());
        dfd.push(this.getScores("l1"));
        dfd.push(this.getScores("l2"));
        dfd.push(this.getScores("l3"));
        return $.when.apply(null, dfd).then(function (data) {
            var dbView = new DashboardView({});
            app.showView('#content', dbView);
            dbView.onRender();
            that.loadOverallView();
        });
    },

    getQuizzesByStreamId: function (id) {
        var url = Config.serverUrl + 'quizzesByStreamId/' + id;
        return $.ajax({
            url: url,
            dataType: "json",
            success: function (data) {
                if (data.status == STATUS.SUCCESS) {
                    if (account.get('id') == null) {
                        // just load the library
                        quizLibrary.reset(data.data);
                    } else {
                        // set the hasAttempted flag to true.
                        quizLibrary.reset();
                        var len = data.data.length;
                        for (var i = 0; i < len; i++) {
                            var quiz = new Quiz(data.data[i]);
                            if ($.inArray(quiz.get('id'), account.get('quizzesAttemptedArray')) != -1) {
                                quiz.set('hasAttempted', true);
                            }
                            quizLibrary.push(quiz);
                        }
                    }
                    var quizLibraryView = new QuizLibraryView({
                        collection: quizLibrary,
                    });
                    app.showView('#content', quizLibraryView);
                    quizLibraryView.onRender();
                } else { // If not, send them back to the home page
                    helper.showError(data.data);
                }
            }
        });
    },

    getHistoryById: function () {
        var url = Config.serverUrl + 'historyById/';
        return $.ajax({
            url: url,
            data: {
                accountId: account.get('id'),
                streamId: streamId
            },
            dataType: "json",
            success: function (data) {
                if (data.status == STATUS.SUCCESS) {
                    quizHistory.reset(data.data);
                } else { // If not, send them back to the home page
                    helper.showError(data.data);
                }
            }
        });
    },

    getFacByStreamId: function (id) {
        var url = Config.serverUrl + 'facByStreamId/' + id;
        $.ajax({
            url: url,
            dataType: "json",
            success: function (data) {
                if (data.status == STATUS.SUCCESS) {
                    facDirectory.reset(data.data);
                    var facDirectoryView = new FacDirectoryView({
                        collection: facDirectory,
                    });
                    app.showView('#content', facDirectoryView);
                    facDirectoryView.onRender();
                } else { // If not, send them back to the home page
                    helper.showError(data.data);
                }
            }
        });
    },
    
    getQuestion : function (qId){
    	var url = Config.serverUrl + 'question/' + qId;
        $.ajax({
            url: url,
            dataType: "json",
            data: {
                accountId: account.get('id'),
                streamId: streamId
            },
            success: function (data) {
                if (data.status == STATUS.SUCCESS) {
                	question.set(data.data);
                	question.set('hasAttempted',true);
                	var qView = new QuizQuestionView({
                        model: question,
                    });
                    app.showView('#content', qView);
                    qView.onRender();
                } else { // If not, send them back to the home page
                    helper.showError(data.data);
                }
            }
        });	
    },
    
    showInstructions: function (quiz) {
        if (quizQuestions.length > 0) {
            var instructionsView = new InstructionsView({
                model: quiz
            });
            app.showView('#content', instructionsView);
        }
    },

    showResume: function (quiz) {
        if (quizQuestions.length > 0) {
            var resumeView = new ResumeView({
                model: quiz
            });
            app.showView('#content', resumeView);
        }
    },

    showResults: function (quiz) {
        if (quizQuestions.length > 0) {
            var resultsView = new ResultsView({
                model: quiz
            });
            app.showView('#content', resultsView);
            resultsView.onRender();
        }
    },

    loadQuiz: function (quiz) {
        // ensure that the questions belong to this quiz and load the view
        if (quizQuestions.length > 0) {
            var qView = new QuizView({
                model: quiz,
                index: 0,
            });
            app.showView('#content', qView);
            qView.startQuiz();
        }
    },

    loadPractice: function (quiz) {
        // ensure that the questions belong to this quiz and load the view
        if (quizQuestions.length > 0) {
            var pView = new PracticeView({
                model: quiz,
                index: quiz.get('state') == null ? 0 : parseInt(quiz.get('state')),
            });
            app.showView('#content', pView);
            pView.onRender();
            pView.startQuiz();
        }
    },

    getFacById: function (id) {
        var url = Config.serverUrl + 'fac/' + id;
        return $.ajax({
            url: url,
            dataType: "json",
            success: function (data) {
                if (data.status == STATUS.SUCCESS) {
                    console.log("faculty fetched: " + data);
                    fac.set(data.data);
                } else { // If not, show error
                    helper.showError(data.data);
                }
            }
        });
    },

    getQuizzesByFac: function (id) {
        var url = Config.serverUrl + 'quizzesByFac/' + id + '|' + streamId;
        return $.ajax({
            url: url,
            dataType: "json",
            success: function (data) {
                if (data.status == STATUS.SUCCESS) {
                    console.log("faculty fetched: " + data);
                    facQuizzes.reset(data.data); // facDirectory.reset(data);
                } else { // If not, show error
                    helper.showError(data.data);
                }
            }
        });
    },

    getRSquareData: function () {
        var dfd = [];
        dfd.push(this.getDashboardData());
        $.when.apply(null, dfd)
            .then(

        function (data) {
            activeView.switchMenu('rsquare');
            $('#main-content').append('<div class="row-fluid"><div class="page-title"><h2>Results Square</h2></div><br></div>');
            var html = [];
            html.push('<div class="row-fluid"><div class="center span3">');
            html.push('<strong>How to understand this chart</strong></div>');
            html.push('<div class="span7 center">');
            html.push('<div class="span3" style="background: #C4DDDA">Not Started</div>');
            html.push('<div class="span3" style="background: #FFFDC7">');
            html.push('Getting There</div>');
            html.push('<div class="span3" style="background: #FFB58B">Needs Improvement</div>');
            html.push('<div class="span3" style="background: #B7E6A8">Achiever!</div></div>');
            html.push('<div class="span1"></div></div>');
            $('#main-content').append(html.join(''));
            var l1 = sectionL1.models;
            var len = l1.length;
            for (var i = 0; i < len; i++) {
                var pView = new PerformanceView({
                    model: l1[i]
                });
                $('#main-content').append(pView.render().el);
                pView.onRender();
            }
            
        });
    },

    /**
     * fetch all the data for the faculty page
     * 
     * @param facId
     */
    getFaculty: function (facId) {
        var dfd = [this.getFacById(facId), this.getQuizzesByFac(facId)];
        $.when.apply(null, dfd).then(function (data) {
            var facView = new FacView({
                model: fac,
                collection: facQuizzes,
            });
            app.showView('#content', facView);
            facView.renderQuizzes();
        });
    },

    getPackagesByStreamId: function (streamId) {
        var url = Config.serverUrl + 'packagesByStreamId/' + streamId;
        return $.ajax({
            url: url,
            dataType: "json",
            success: function (data) {
                console.log("questions fetched: " + data.length);
                packages.reset(data);
                var packagesView = new PackagesView({
                    collection: packages,
                });
                app.showView('#content', packagesView);
                packagesView.onRender();
            }
        });
    },

    getAttemptedQuestions: function () {
        var url = Config.serverUrl + 'attemptedQuestions/';
        return $.ajax({
            url: url,
            data: {
                accountId: account.get('id'),
                streamId: streamId
            },
            dataType: "json",
            success: function (data) {
                if (data.status == STATUS.SUCCESS) {
                    console.log("review questions fetched: " + data);
                    attemptedQuestions.reset(data.data); // facDirectory.reset(data);
                } else { // If not, show error
                    helper.showError(data.data);
                }
            }
        });
    },

    questionsExist: function (quiz) {
        var exists = true;
        var qArray = quiz.get('questionIdsArray');
        var len = qArray.length;
        for (var i = 0; i < len; i++) {
            if (!quizQuestions.get(qArray[i])) {
                exists = false;
                break;
            }
        }
        return exists;
    },

    processQuiz: function (quizId) {
        // check if this is same as the activeQuiz then skip.
        if (activeQuiz != null && (activeQuiz.get('id') == quizId && this.questionsExist(activeQuiz))) {
            // already loaded
            this.loadQuiz2(activeQuiz);
            return;
        }
        var that = this;
        var url = Config.serverUrl + 'processQuiz/';
        return $.ajax({
            url: url,
            type: 'GET',
            dataType: "json",
            data: {
                quizId: quizId,
                accountId: account.get('id'),
                streamId: streamId
            },
            success: function (data) {
                if (data.status == STATUS.SUCCESS) {
                    activeQuiz = new Quiz(data.data.quiz);
                    quizQuestions.reset(data.data.questions);
                    if (!account.get('quizzesAttemptedArray')) {
                        account.set('quizzesAttemptedArray', []);
                    }
                    if ($.inArray(activeQuiz.get('id'), account.get('quizzesAttemptedArray')) == -1) {
                        quizHistory.unshift(activeQuiz);
                        account.get('quizzesAttemptedArray').unshift(
                        activeQuiz.get('id'));
                    }
                    that.loadQuiz2(activeQuiz);
                } else { // If not, send them back to the home page
                    helper.showError(data.data);
                }
            },
        });
    },

    getDataForMySets: function () {
        var dfd = [];
        if (!(activeView instanceof DashboardView)) {
            dfd.push(this.getDashboardData());
        }
        dfd.push(this.getHistoryById());
        $.when.apply(null, dfd).then(function (data) {
            if (activeView instanceof DashboardView) {
                activeView.switchMenu('myprepsets');
                var mySetsView = new MySetsView({
                    collection: quizHistory
                });
                activeView.switchView(mySetsView);
            }
        });
    },

    purchasePackage: function (id) {
        var url = Config.serverUrl + 'package/';
        return $.ajax({
            url: url,
            type: "POST",
            data: {
                packageId: id
            }, // gotta strinigfy the entire hash
            dataType: "json",
            success: function (data) {
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
    getDataForQuizLibrary: function (streamId) {
        var dfd = [];
        if (sectionL1.length == 0 || sectionL2.length == 0) {
            // what if the data is already is being fetched???I think jquery
            // makes sure with promises that it is not fetched again
            // @ssachan You can check on the status of a promise - tanujb
            dfd.push(this.getSubjectsByStreamId(streamId));
        }
        var that = this;
        $.when.apply(null, dfd).then(function (data) {
            that.getQuizzesByStreamId(streamId);
        });
    },

    getDataForQuiz: function (quizId) {
        this.processQuiz(quizId);
    },

    getDataForQuestion: function (qId) {
        this.getQuestion(qId);
    },

    loadQuiz2: function (quiz) {
        if (quiz != null) {
            switch (quiz.get('status')) {
                case quiz.STATUS_NOTSTARTED:
                    this.showInstructions(quiz);
                    break;
                case quiz.STATUS_INPROGRESS:
                    this.showResume(quiz);
                    break;
                case quiz.STATUS_INTERRUPTED:
                    this.showInstructions(quiz);
                    break;
                case quiz.STATUS_COMPLETED:
                    this.showResults(quiz);
                    break;
            }
        } else {
            // for now redirect to the quiz library page
            window.location = '#library';
        }
    },

    getDataForQuiz2: function (quizId) {
        var quiz = null;
        quiz = quizHistory.get(quizId) == null ? quizLibrary.get(quizId) : quizHistory.get(quizId);
        if (quiz != null) {
            switch (quiz.get('status')) {
                case quiz.STATUS_NOTSTARTED:
                    this.showInstructions(quiz);
                    break;
                case quiz.STATUS_INPROGRESS:
                    this.showResume(quiz);
                    break;
                case quiz.STATUS_INTERRUPTED:
                    this.showInstructions(quiz);
                    break;
                case quiz.STATUS_COMPLETED:
                    this.showResults(quiz);
                    break;
            }
        } else {
            // for now redirect to the quiz library page
            window.location = '#library';
        }
    },

    getDataForReview: function () {
        var dfd = [];
        if (!(activeView instanceof DashboardView)) {
            dfd.push(this.getDashboardData());
        }
        dfd.push(this.getAttemptedQuestions());
        $.when.apply(null, dfd).then(function (data) {
            activeView.switchMenu('review');
            var reviewView = new ReviewView({
                collection: attemptedQuestions
            });
            activeView.switchView(reviewView);
        });
    },

    getFacContactPage: function () {
        var facContactView = new FacContactView();
        app.showView('#content', facContactView);
    },

    getDataforActivity: function () {
        var dfd = [];
        if (!(activeView instanceof DashboardView)) {
            dfd.push(this.getDashboardData());
        }
        dfd.push(this.getAttemptedQuestions());
        $.when.apply(null, dfd)
            .then(
        function (data) {
            activeView.switchMenu('activity');
            var activityView = new ActivityView({});
            activeView.switchView(activityView);
        });
    }
};