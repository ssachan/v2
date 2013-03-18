/**
 * The quiz views
 * 
 * @author ssachan
 * 
 */
window.QuizQuestionView = Backbone.View.extend({

    initialize: function () {},

    events: {
        'click #single-type button': 'handleSingleType',
        'click #multiple-type button': 'handleMultipleType',
        'keypress #integer-type': 'checkIntegerType',
        'change #integer-type': 'handleIntegerType',
        'click #matrix-type input': 'handleMatrixType',
    },

    handleSingleType: function (e) {
        var oldOptionSelected = this.model.get('optionSelected');
        var optionSelected = e.target.value;
        if (optionSelected === oldOptionSelected) {
            logs.addEntry("OPTION_DESELECT", this.model.get('id'),
            oldOptionSelected);
            this.model.set('optionSelected', null);
            $(e.target).removeClass('active');
            e.stopPropagation();
        } else {
            if (oldOptionSelected !== null) logs.addEntry("OPTION_DESELECT", this.model.get('id'),
            oldOptionSelected);
            logs.addEntry("OPTION_SELECT", this.model.get('id'),
            optionSelected);
            this.model.set('optionSelected', optionSelected);
        }
    },

    handleMultipleType: function (e) {
        var optionSelectedArray = [];
        var optionSelected = this.model.get('optionSelected');
        var optionLength = ((this.model.get('options'))
            .split(SEPARATOR)).length;
        if (optionSelected != null) {
            var temp = (optionSelected).split(SEPARATOR); // (SEPARATOR.SEPARATOR);
            for (var j = 0; j < optionLength; j++) {
                optionSelectedArray[j] = (temp.indexOf(''+j) != -1) ? 1 : 0;
            }
        } else {
            // fill all the fields with null
            for (var j = 0; j < optionLength; j++) {
                optionSelectedArray[j] = 0;
            }
        }
        // get the class for selected button...if its active then it has
        // been clicked again.
        var currentClass = e.target.getAttribute('class');
        var value = parseInt(e.target.getAttribute('value'));
        if (currentClass.indexOf('active') != -1) {
            // unselect this
            logs.addEntry("OPTION_DESELECT", this.model.get('id'),
            value);
            optionSelectedArray[value] = 0;
            // optionSelectedArray[value] = "";
        } else {
            logs.addEntry("OPTION_SELECT", this.model.get('id'), value);
            optionSelectedArray[value] = 1;
        }
        var temp = [];
        for (var i = 0; i < optionLength; i++) {
            if (optionSelectedArray[i]) {
                temp.push(i);
            }
        }
        optionSelected = temp.join(SEPARATOR);
        this.model.set('optionSelected', optionSelected);
    },

    checkIntegerType: function (e) {
        // we need to use a plug-in
        // https://github.com/SamWM/jQuery-Plugins/blob/master/numeric/jquery.numeric.js
        // or http://www.texotela.co.uk/code/jquery/numeric/
        // other scripts are buggy
    },

    handleIntegerType: function (e) {
        this.model.set('optionSelected', $('#integer-type').val());
        logs.addEntry("OPTION_SELECT", this.model.get('id'), this.model.get('optionSelected'));
    },

    handleMatrixType: function (e) {
        // tanujb:TODO:add logs
        var optionSelectedArray = [];
        var optionSelected = this.model.get('optionSelected');
        if (optionSelected != null) {
            optionSelectedArray = (optionSelected).split(SEPARATOR + SEPARATOR); // (SEPARATOR.SEPARATOR);
        } else {
            // fill all the fields with null
            var len = (((this.model.get('options')).split(SEPARATOR + SEPARATOR))[0]).split(SEPARATOR).length;
            for (var j = 0; j < len; j++) {
                optionSelectedArray[j] = null;
            }
        }
        // get all checks for this particular row and add to the
        // solution
        var checkboxSelected = (e.target).getAttribute('name');
        var index = parseInt((checkboxSelected.split('-'))[1]);
        // var checks = $('.myCheckbox').attr('checked','checked');
        var selectedChecks = $("." + checkboxSelected + ":checked");
        var optionAtIndex = [];
        var len = selectedChecks.length;
        for (var i = 0; i < len; i++) {
            optionAtIndex.push(selectedChecks[i].value);
        }
        optionSelectedArray[index] = optionAtIndex.join(SEPARATOR);
        this.model.set('optionSelected', optionSelectedArray.join(SEPARATOR + SEPARATOR));
    },

    render: function () {
    	$(this.el).html(this.template(this.model.toJSON()));
    	this.delegateEvents();
        return this;
    },
    
    onRender : function (){
    	 this.renderOptions();
         $('#qtype').html(this.model.get('typeString'));
         $('#status').hide();
         $('#solution').hide();
         $('#q-video').hide();
         if (this.model.get('hasAttempted')) {
             this.renderInfo();
             $('#analytics').show();
             $('#hq').html('Solution');
         } else {
             logs.addEntry("QUESTION_OPEN", this.model.get('id'));
             $('#analytics').hide();
             $('#hq').html('Question');
         }
         // diable right click for this page
         $('.quizview').bind("contextmenu", function (e) {
             e.preventDefault();
         });
         var math = document.getElementById('quiz-view');
         MathJax.Hub.Queue(["Typeset", MathJax.Hub, math]);
    },
    
    renderOptions: function () {
        var htmlOpt = [];
        var buttonOpt = [];
        var options = this.model.get('options');
        var optionSelected = this.model.get('optionSelected');
        switch (this.model.get('typeId')) {
            case "1":
                // single option
                htmlOpt.push('<div class="span10"><div class="option-box"><ol type="A">');
                buttonOpt.push('<div class="span2 btn-group" data-toggle="buttons-radio" id="single-type">');
                var optionsArray = options.split(SEPARATOR);
                var len = optionsArray.length;
                for (var i = 0; i < len; i++) {
                    htmlOpt.push('<li>' + optionsArray[i] + '</li>');
                    if (optionSelected != null && optionSelected == i) {
                        buttonOpt.push('<button type="button" name="option" value="' + i + '" class="btn btn-large btn-block active">' + String.fromCharCode(65 + i) + '</button>');
                    } else {
                        buttonOpt.push('<button type="button" name="option" value="' + i + '" class="btn btn-large btn-block">' + String.fromCharCode(65 + i) + '</button>');
                    }
                }
                htmlOpt.push('</ol></div></div>');
                buttonOpt.push('</div>');
                $('#options').html(htmlOpt.join(''));
                $('#options').append(buttonOpt.join(''));
                break;
            case "2":
                // multiple option
                htmlOpt.push('<div class="span10"><div class="option-box"><ol type="A">');
                buttonOpt.push('<div class="span2 btn-group" data-toggle="buttons-checkbox" id="multiple-type">');
                var optionsArray = options.split(SEPARATOR);
                var len = optionsArray.length;
                var optionSelectedArray = [];
                if (optionSelected != null) {
                    optionSelectedArray = optionSelected.split(SEPARATOR);
                }
                for (var i = 0; i < len; i++) {
                    htmlOpt.push('<li>' + optionsArray[i] + '</li>');
                    if (jQuery.inArray(i.toString(), optionSelectedArray) >= 0) {
                        buttonOpt.push('<button type="button" name="mult" value="' + i + '" class="btn btn-large btn-block active">' + String.fromCharCode(65 + i) + '</button>');
                    } else {
                        buttonOpt.push('<button type="button" name="mult" value="' + i + '" class="btn btn-large btn-block">' + String.fromCharCode(65 + i) + '</button>');
                    }
                }
                htmlOpt.push('</ol></div></div>');
                buttonOpt.push('</div>');
                $('#options').html(htmlOpt.join(''));
                $('#options').append(buttonOpt.join(''));
                break;
            case "3":
                // integer type
                htmlOpt.push('<input type="number" id="integer-type" value="' + optionSelected + '">');
                $('#options').html(htmlOpt);
                break;
            case "4":
                // matrix type
                var optionsArray = options.split(SEPARATOR + SEPARATOR);
                var leftList = optionsArray[0].split(SEPARATOR);
                var rightList = optionsArray[1].split(SEPARATOR);
                var lLen = leftList.length;
                var rLen = rightList.length;
                // create the left right table
                htmlOpt.push('<div class="span6">');
                htmlOpt.push('<table class="table"><tr><td>');
                htmlOpt.push('<ol type="1">');
                for (var i = 0; i < lLen; i++) {
                    htmlOpt.push('<li>' + leftList[i] + '</li>');
                }
                htmlOpt.push('</ol></td><td>');
                htmlOpt.push('<ol type="A">');
                for (var i = 0; i < rLen; i++) {
                    htmlOpt.push('<li>' + rightList[i] + '</li>');
                }
                htmlOpt.push('</ol></td></tr></table>');
                htmlOpt.push('</div>');

                // create the checkboxes table
                var optionSelectedArray = [];
                if (optionSelected != null) {
                    optionSelectedArray = optionSelected.split(SEPARATOR + SEPARATOR);
                }
                buttonOpt.push('<div class="span6">');
                buttonOpt.push('<table class="table" id="matrix-type">');
                // define the top row
                buttonOpt.push('<tr><td></td>');
                for (var j = 0; j < rLen; j++) {
                    buttonOpt.push('<td>' + String.fromCharCode(65 + j) + '</td>');
                }
                buttonOpt.push('</tr>');
                // create checkboxes
                for (i = 0; i < lLen; i++) {
                    buttonOpt.push('<tr><td>' + (i) + '</td>');
                    for (var j = 0; j < rLen; j++) {
                        if (optionSelectedArray[i] != null && optionSelectedArray[i].indexOf(j) != -1) {
                            buttonOpt.push('<td><input type="checkbox" name="multicheck-' + i + '" class="multicheck-' + i + '" value="' + j + '" checked></td>');
                        } else {
                            buttonOpt.push('<td><input type="checkbox" name="multicheck-' + i + '" class="multicheck-' + i + '" value="' + j + '"></td>');
                        }
                    }
                    buttonOpt.push('</tr>');
                }
                buttonOpt.push('</div>');
                $('#options').html(htmlOpt.join(''));
                $('#options').append(buttonOpt.join(''));
                break;
        }
    },
    renderInfo: function () {
        // tanujb:TODO:add retrieval of data
        var html = [];
        $('#single-type').hide();
        $('#multiple-type').hide();
        $('#integer-type').hide();
        $('#matrix-type').hide();

        $('#status').show();
        $('#options').show();
        $('#q-video').show();
        
        switch (this.model.get('typeId')) {
        case "1":
        	var status = this.model.get('status');
            if (status == null) {
            	html.push('<a class="pull-left" ><img class="media-object" src="img/cross.png"></a>');
                html.push('<div class="media-body">');
                html.push('<h3>YOU SELECTED NONE</h3>');
                html.push('<h3>CORRECT OPTION ' + String.fromCharCode(65 + parseInt(this.model.get('correctAnswer'))) + '</h3>');
                html.push('</div>');
            } else {
                if (status == true) {
                    html.push('<img class="media-object pull-left" src="img/tick.png">');
                    html.push('<div class="media-body">');
                    html.push('<h3>YOU MARKED OPTION ' + String.fromCharCode(65 + parseInt(this.model.get('optionSelected'))) + '</h3>');
                    html.push('</div>');
                } else if(status==false) {
                    html.push('<img class="media-object pull-left" src="img/cross.png">');
                    html.push('<div class="media-body">');
                    html.push('<h3>YOU MARKED OPTION ' + String.fromCharCode(65 + parseInt(this.model.get('optionSelected'))) + '</h3>');
                    html.push('<h3>CORRECT OPTION ' + String.fromCharCode(65 + parseInt(this.model.get('correctAnswer'))) + '</h3>');
                    html.push('</div>');
                }
            }
        	break;
        case "2":
        	var status = this.model.get('status');
        	var correctAnswerArray = (this.model.get('correctAnswer')).split(SEPARATOR);
        	var optionSelectedArray = null;
        	if(this.model.get('optionSelected')!=null){
        		optionSelectedArray = (this.model.get('optionSelected')).split(SEPARATOR);
        	}
            if (status == null) {
            	html.push('<a class="pull-left" ><img class="media-object" src="img/cross.png"></a>');
                html.push('<div class="media-body">');
                html.push('<h3>YOU SELECTED NONE</h3>');
                html.push('<h3>CORRECT OPTION ');
                for(var i = 0; i<correctAnswerArray.length;i++){
                	html.push(String.fromCharCode(65 + parseInt(correctAnswerArray[i]))+',');
                }
                html.push('</h3></div>');
            } else {
                if (status == true) {
                    html.push('<img class="media-object pull-left" src="img/tick.png">');
                    html.push('<div class="media-body">');
                    html.push('<h3>YOU MARKED OPTION ');
                    for(var i = 0; i<correctAnswerArray.length;i++){
                    	html.push(String.fromCharCode(65 + parseInt(correctAnswerArray[i]))+',');
                    }
                    html.push('</h3></div>');
                } else if(status==false) {
                    html.push('<img class="media-object pull-left" src="img/cross.png">');
                    html.push('<div class="media-body">');
                    html.push('<h3>YOU MARKED OPTION ');
                    var dummy = [];
                    for(var i = 0; i<optionSelectedArray.length;i++){
                        dummy.push(String.fromCharCode(65 + parseInt(optionSelectedArray[i])));
                    }
                    html.push(dummy.join(','));
                    html.push('</h3>');
                    html.push('<h3>CORRECT OPTION ');
                    var dummy = [];
                    for(var i = 0; i<correctAnswerArray.length;i++){
                    	dummy.push(String.fromCharCode(65 + parseInt(correctAnswerArray[i])));
                    	//html.push(String.fromCharCode(65 + parseInt(correctAnswerArray[i]))+',');
                    }
                    html.push(dummy.join(','));
                    html.push('</h3></div>');
                }
            }
        	break;
        case "3":
        	var status = this.model.get('status');
            if (status == null) {
            	html.push('<a class="pull-left" ><img class="media-object" src="img/cross.png"></a>');
                html.push('<div class="media-body">');
                html.push('<h3>YOU ANSWERED NONE</h3>');
                html.push('<h3>CORRECT ANSWER ' + this.model.get('correctAnswer') + '</h3>');
                html.push('</div>');
            } else {
                if (status == true) {
                    html.push('<img class="media-object pull-left" src="img/tick.png">');
                    html.push('<div class="media-body">');
                    html.push('<h3>YOU ANSWERED ' + this.model.get('optionSelected') + '</h3>');
                    html.push('</div>');
                } else if(status==false) {
                    html.push('<img class="media-object pull-left" src="img/cross.png">');
                    html.push('<div class="media-body">');
                    html.push('<h3>YOU ANSWERED ' + this.model.get('optionSelected') + '</h3>');
                    html.push('<h3>CORRECT ANSWER ' + this.model.get('correctAnswer') + '</h3>');
                    html.push('</div>');
                }
            }
        	break;
        case "4":
        	 // matrix type
        	var htmlOpt = [];
            var options = this.model.get('options');
            if(this.model.get('optionSelected')!=null){
        		optionSelectedArray = (this.model.get('optionSelected')).split(SEPARATOR + SEPARATOR);
        	}
            if(this.model.get('correctAnswer')!=null){
            	correctAnswerArray = (this.model.get('correctAnswer')).split(SEPARATOR + SEPARATOR);
        	}
        	var status = this.model.get('status');
            if (status == null) {
                html.push('<h3>YOU ANSWERED NONE</h3>');
            } else {
                if (status == true) {
                    html.push('<h3>YOU ANSWERED CORRECTLY</h3>');
                } else if(status==false) {
                    html.push('<h3>YOU ANSWERED INCORRECTLY</h3>');
                }
            }
            var optionsArray = options.split(SEPARATOR + SEPARATOR);
            var leftList = optionsArray[0].split(SEPARATOR);
            var rightList = optionsArray[1].split(SEPARATOR);
            var lLen = leftList.length;
            var rLen = rightList.length;
            // create the left right table
            html.push('<div class="span12">');
            html.push('<table class="table">');
            html.push('<tr><th>Option</th><th>Selected</th><th>Correct</th></tr>');
            //html.push('<ol type="1">');
            for (var i = 0; i < lLen; i++) {
                html.push('<tr><td>' + leftList[i]+'</td>');
                if (status != null){
                	var selectedOptArray = optionSelectedArray[i].split(SEPARATOR);
                	var len = selectedOptArray.length;
                	var dummy = [];
                	for(var j = 0; j< len; j++){
                		dummy.push(String.fromCharCode(65 + parseInt(selectedOptArray[j])));
                	}
                	html.push('<td>' + dummy.join(',') + '</td>');                
                }else{
                	html.push('<td>None</td>');
                }
                var correctOptArray = correctAnswerArray[i].split(SEPARATOR);
                var len = correctOptArray.length;
                var dummy = [];
                for(var j = 0; j< len; j++){
                	dummy.push(String.fromCharCode(65 + parseInt(correctOptArray[j])));
                }
                html.push('<td>'+dummy.join(',')+'</td>');
                html.push('</tr>');
            }
            html.push('</table>');
            html.push('</div>');
            break;        	
        }
        $('#stathead').html(html.join(' '));
        $('#diff').html(this.model.get('difficulty'));
        $('#avgAcc').html(this.model.get('averageCorrect'));
        $('#avgTime').html(helper.formatTime(this.model.get('timeTaken')));
        $('#tags').html(this.model.get('tagIds'));
        $('#solutionText').html(this.model.get('explanation'));
        $('#solution').show(); 
        jwplayer("analysis-video-"+this.model.get('id')).setup({ //::video::QuizQuestion 
                        file: this.model.get('videoSrc'),
                        image: this.model.get('posterSrc'),
                        startparam: "start",
                        height : 180,
                        width: 320,
                        autostart : true,
                        fallback : false,
                        primary: "flash" //,
                        /*playlist: [{
                            title: "",
                            description: "",
                            image: "",
                            sources : [{file: "", label: "360p"}]
                        }],*/
                        //skin : "",
                        /*listbar: {
                                    position: 'bottom',
                                    size: 180
                                 },*/
                    });
        $('#time').html(helper.formatTime(this.model.get('timeTaken')));
        $('#submit').hide();
    }
});