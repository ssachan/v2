window.helper = {

	// Asynchronously load templates located in separate .html files
	loadTemplate : function(views, callback) {

		var deferreds = [];

		$.each(views, function(index, view) {
			if (window[view]) {
				if (Config.phonegap == true) {
					deferreds.push($.ajax(
							{
								type : "GET",
								dataType : "html",
								url : Config.assetPath + Config.tmplatesFolder
										+ '/' + view + '.html',
								async : false,
							}).done(function(data) {
						window[view].prototype.template = _.template(data);
					}));

				} else {
					deferreds.push($.get(Config.tmplatesFolder + '/' + view
							+ '.html', function(data) {
						window[view].prototype.template = _.template(data);
					}));
				}
			} else {
				alert(view + " not found");
			}
		});

		$.when.apply(null, deferreds).done(callback);
	},
	completeHTML : function(object)
    {
        return html = $('<div>').append($(object).clone()).remove().html();
    },
	
	/*
	 * uploadFile: function (file, callbackSuccess) { var self = this; var data =
	 * new FormData(); data.append('file', file); $.ajax({ url:
	 * 'api/upload.php', type: 'POST', data: data, processData: false, cache:
	 * false, contentType: false }).done(function () { console.log(file.name + "
	 * uploaded successfully"); callbackSuccess(); }).fail(function () {
	 * self.showAlert('Error!', 'An error occurred while uploading ' +
	 * file.name, 'alert-error'); }); },
	 * 
	 * displayValidationErrors: function (messages) { for (var key in messages) {
	 * if (messages.hasOwnProperty(key)) { this.addValidationError(key,
	 * messages[key]); } } this.showAlert('Warning!', 'Fix validation errors and
	 * try again', 'alert-warning'); },
	 * 
	 * addValidationError: function (field, message) { var controlGroup = $('#' +
	 * field).parent().parent(); controlGroup.addClass('error');
	 * $('.help-inline', controlGroup).html(message); },
	 * 
	 * removeValidationError: function (field) { var controlGroup = $('#' +
	 * field).parent().parent(); controlGroup.removeClass('error');
	 * $('.help-inline', controlGroup).html(''); },
	 */
	showAlert : function(title, text, klass) {
		$('.alert').removeClass(
				"alert-error alert-warning alert-success alert-info");
		$('.alert').addClass(klass);
		$('.alert').html('<strong>' + title + '</strong> ' + text);
		$('.alert').show();
	},
	
	showError : function(text) {
		$('#errorModal').modal('show');
		$('#error').html(text);
		$('#errorModal').show();
	},
	
	hideAlert : function() {
		$('.alert').hide();
	},
	
	formatTime : function(time){
		var hrs = ~~ (time / 3600);
		var mins = ~~ ((time % 3600) / 60);
		var secs = time % 60;
		var formattedTime = '';
		if(hrs!=null && hrs!='' ){
			formattedTime += ' ' +hrs;
			if(hrs=='1'){
				formattedTime += ' hr';
			}else{
				formattedTime += ' hrs';			
			}
		}
		if(mins!=null && mins!='' ){
			formattedTime += ' ' +mins;
			if(mins=='1'){
				formattedTime += ' min';
			}else{
				formattedTime += ' mins';			
			}
		}
		if(secs!=null && secs!='' ){
			formattedTime += ' ' +secs;
			if(secs=='1'){
				formattedTime += ' sec';
			}else{
				formattedTime += ' secs';			
			}
		}
		return formattedTime;
	}, 
	
};


