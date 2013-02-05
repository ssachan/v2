window.fbAsyncInit = function() {

	console.info('FB jssdk loaded');
	FB.init({
		appId : '471575209563142', // App ID
		status : true, // check login status
		cookie : true, // enable cookies to allow the server to access
		xfbml : true
	});

	user = new FacebookUser();

	user.on('facebook:unauthorized', function(model, response) {
		console.info('facebook:unauthorized');
	});

	user.on('facebook:connected', function(model, response) {
		console.info('facebook:connected');
		if(account.get('type')=='2' && account.get('id')==null && user.attributes.id!=null){
			// this is a sign-up using facebook
				account.set('type',2);
				user.attributes.type=2;
				user.attributes.streamId=streamId;
				account.signUp(user.attributes);
				account.setAttribute('dp',user.get('pictures').square);
		}
	});

	user.on('facebook:disconnected', function(model, response) {
		console.info('facebook:disconnected');
	});

	user.on('change', function() {
		console.info('change');
		if(account.get('type')=='2' && account.get('id')==null){
			// this is a sign-up using facebook
				account.set('type',2);
				user.attributes.type=2;
				user.attributes.streamId=streamId;
				account.signUp(user.attributes);
				account.setAttribute('dp',user.get('pictures').square);
		}
		
		/*var table = $('.table tbody').empty();
		
		_(user.attributes).each(
				function(value, attribute) {
					if (typeof value !== 'string')
						return;

					var tr = $(document.createElement('tr'));
					var attr = $(document.createElement('td')).text(attribute)
							.appendTo(tr);
					var val = $(document.createElement('td')).text(value)
							.appendTo(tr);
					tr.append(attr).append(val).appendTo(table);
				}, this);
		user.get('pictures').square;
		*/
	});
	
	//user.updateLoginStatus();
};

/*$('#login').click(function(){ user.login(); });

$('#logout').click(function(){ user.logout(); });
*/
