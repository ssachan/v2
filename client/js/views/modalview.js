/**
 * The modal view
 * 
 * @author ssachan
 * 
 */

window.ModalView = Backbone.View.extend({
	
	initialize : function() {
		this.state = false;
	},

	events : {
		//'click .close' : 'close',
		'hidden #modal' : 'close'
	},

	render : function() {
		this.$el.html(this.template(this.model.toJSON()));
		return this;
	},

	show : function() {
		this.state = true;
		$(document.body).append(this.render().el);
		myPlayer = _V_("intro-vid-"+this.model.get('id'), { "techOrder": ["flash"]});
		myPlayer.src({ type: "video/mp4", src: "http://prod.prepsquare.com/video/s"+this.model.get('id')+"video.mp4" });
		if(account.get('id')!=null){
			// check if credits exist
			if(parseInt(account.get('quizzesRemaining'))>0){
				$('#take-btn').append('<a href="#quiz/'+this.model.get('id')+'" class="btn blue-btn">START TEST</a>');
			}else{
				$('#take-btn').append('<a href="#packages" class="btn blue-btn">You need to purchase a package to take this quiz.CLICK</a>');
			}
		}else{
			$('#take-btn').append('<a href="#signup" class="btn blue-btn">Log-In/Sign-Up to take Test</a>');
		}
        $('#modal').modal({backdrop:true});
	},

	close : function() {
		if(this.state != true){
			return;
		}
		$('#modal').modal('hide');
		this.state =false;
		myPlayer = _V_("intro-vid-"+this.model.get('id'));
		myPlayer.pause();
		myPlayer.src("");
		this.remove();
		//$('video>source')[0].setAttribute('src','');
		//$('#intro-vid-'+this.model.get('id'))[0].setAttr('src','');
	},
});
