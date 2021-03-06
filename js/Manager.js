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
                    helper.processStatus(data);
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
                    helper.processStatus(data);
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
                    helper.processStatus(data);
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
                            if(quiz.get('available')=='2' && account.get('paid')=='1'){
                                quiz.set('paid',true);
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
                    helper.processStatus(data);
                }
            }
        });
    },

    makeRecos: function () {
        var url = Config.serverUrl + 'reco/';
        return $.ajax({
            url: url,
			type : 'POST',
            data: {
                accountId: account.get('id'),
            },
            dataType: "json",
            success: function (data) {
                if (data.status == STATUS.SUCCESS) {
                    quizReco.reset(data.data);
                } else { // If not, send them back to the home page
                    helper.processStatus(data);
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
                    helper.processStatus(data);
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
                    helper.processStatus(data);
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
                	var qView = new ReviewQuestionView({
                        model: question,
                    });
                    app.showView('#content', qView);
                    qView.onRender();
                } else { // If not, send them back to the home page
                    helper.processStatus(data);
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
            qView.onRender();
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
                    helper.processStatus(data);
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
                    if (account.get('id') == null) {
                        // just load the library
                        facQuizzes.reset(data.data);
                    } else {
                        // set the hasAttempted flag to true.
                        facQuizzes.reset();
                        var len = data.data.length;
                        for (var i = 0; i < len; i++) {
                            var quiz = new Quiz(data.data[i]);
                            if ($.inArray(quiz.get('id'), account.get('quizzesAttemptedArray')) != -1) {
                                quiz.set('hasAttempted', true);
                            }
                            if(quiz.get('available')=='2' && account.get('paid')=='1'){
                                quiz.set('paid',true);
                            }
                            facQuizzes.push(quiz);
                        }
                    }
                    //facQuizzes.reset(data.data); // facDirectory.reset(data);
                } else { // If not, show error
                    helper.processStatus(data);
                }
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
        var url = Config.serverUrl + 'packagesByStreamId';
        return $.ajax({
            url: url,
            data:{streamId:streamId},
            dataType: "json",
            success: function (data) {
                if (data.status == STATUS.SUCCESS) {
                    console.log("faculty fetched: " + data);
                    packages.reset(data.data); // facDirectory.reset(data);
                    var packagesView = new PackagesView({
                        collection: packages,
                    });
                    app.showView('#content', packagesView);
                    packagesView.onRender();
                } else { // If not, show error
                    helper.processStatus(data);
                }
                /*packages.reset(data);
                packages.add(new Package());
                var packagesView = new PackagesView({
                    collection: packages,
                });
                app.showView('#content', packagesView);
                packagesView.onRender();
                */
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
                    attemptedQuestions.reset(data.data); // facDirectory.reset(data);
                } else { // If not, show error
                    helper.processStatus(data);
                }
            }
        });
    },
    
    purchasePackage: function (id) {
        var url = Config.serverUrl + 'purchase';
        return $.ajax({
            url: url,
            data: {
                accountId: account.get('id'),
                packageId: id
            },
            dataType: "json",
            success: function (data) {
                if (data.status == STATUS.SUCCESS) {
                    attemptedQuestions.reset(data.data); // facDirectory.reset(data);
                } else { // If not, show error
                    helper.processStatus(data);
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
                    if ($.inArray(activeQuiz.get('id'), account.get('quizzesAttemptedArray')) == -1) {
                        quizHistory.unshift(activeQuiz);
                        account.get('quizzesAttemptedArray').unshift(
                        activeQuiz.get('id'));
                    }
                    that.loadQuiz2(activeQuiz);
                } else { // If not, send them back to the home page
                    helper.processStatus(data);
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

    /**
     * ensure all questions are loaded in the quizQuestions collection
     * 
     * @param quiz
     * @returns
     */
    getDataForQuizLibrary: function (streamId) {
        var dfd = [];
        if (sectionL1.length == 0 || sectionL2.length == 0) {
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
                	account.set('quizzesRemaining',parseInt(account.get('quizzesRemaining'))-1);
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
        dfd.push(this.makeRecos());
        $.when.apply(null, dfd)
            .then(
        function (data) {
            activeView.switchMenu('activity');
            var activityView = new ActivityView({collection:quizReco});
            activeView.switchView(activityView);
        });
    }
};