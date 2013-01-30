/**
 * The modal view
 * 
 * @author ssachan
 * 
 */

window.ModalView = Backbone.View.extend({
	
	initialize : function() {
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
		$(document.body).append(this.render().el);
		myPlayer = _V_("intro-vid-"+this.model.get('id'), { "techOrder": ["flash"]});
		myPlayer.src({ type: "video/mp4", src: "http://prod.prepsquare.com/video/s"+this.model.get('id')+"video.mp4" });
		if(account.get('id')!=null){
			$('#take-btn').append('<a href="#quiz/'+this.model.get('id')+'" class="btn blue-btn">Redeem your package and take PrepSet</a>');
		}else{
			$('#take-btn').append('<a href="#signup" class="btn blue-btn">Click to Log-In/Sign-Up and take this PrepSet</a>');
		}
        $('#modal').modal({backdrop:true});
	},

	close : function() {
		$('#modal').modal('hide');
		myPlayer = _V_("intro-vid-"+this.model.get('id'));
		myPlayer.pause();
		myPlayer.src("");
		//this.remove();
		//$('video>source')[0].setAttribute('src','');
		//$('#intro-vid-'+this.model.get('id'))[0].setAttr('src','');
	},
});
