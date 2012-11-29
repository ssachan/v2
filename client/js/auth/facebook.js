window.fbAsyncInit = function() {

	console.info('FB jssdk loaded');
	FB.init({
		appId : '345218642220354', // App ID
		status : true, // check login status
		cookie : true, // enable cookies to allow the server to access
		xfbml : true
	});

	user = new FacebookUser();

	user.on('facebook:unauthorized', function(model, response) {
		console.info('facebook:unauthorized');
		if(account.get('type')=='2'){
			//login button is pressed
			FB.login(function(){}, { scope: 'email'}); //this.options.scope.join(',') }
		}
	});

	user.on('facebook:connected', function(model, response) {
		console.info('facebook:connected');
		if(account.get('type')=='2'){
			// this is a sign-up using facebook
			if(account.get('id')==null){
				// sign me up 
				account.set('type',2);
				user.attributes.type=2;
				user.attributes.streamId=streamId;
				account.signUp(user.attributes);
			}
		}else{
			// check if a session already exists 
			if(account.get('id')==null){
				account.isAuth();
			}else{
				
			}
		}
	});

	user.on('facebook:disconnected', function(model, response) {
		console.info('facebook:disconnected');
		if(account.get('type')=='2'){
			//login button is pressed
			FB.login(function(){}, { scope: 'email'}); //this.options.scope.join(',') }
		}
	});

	/*user.on('change', function() {
		console.info('change');
		if(account.get('type')=='2'){
			// this is a sign-up using facebook
			if(account.get('id')==null){
				// sign me up 
				account.set('type',2);
				user.attributes.type=2;
				user.attributes.streamId=streamId;
				account.signUp(user.attributes);
			}
		}else{
			// check if a session already exists 
			if(account.get('id')==null){
				account.isAuth();
			}else{
				
			}
		}
		/*if(account.get('id')==null){
			// sign me up 
			account.set('type',2);
			user.attributes.type=2;
			user.attributes.streamId=streamId;
			account.signUp(user.attributes);
		}*/
		//account.signup(user.attributes);

		/*app.menu();
		var table = $('.table tbody').empty();
		
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
		
	});*/
	
	//user.updateLoginStatus();
};

/*$('#login').click(function(){ user.login(); });

$('#logout').click(function(){ user.logout(); });
*/
