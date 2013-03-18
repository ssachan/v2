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
		//myPlayer = _V_("intro-vid-"+this.model.get('id'), { "techOrder": ["flash"]});
		//::video:ModalView
         jwplayer("intro-vid-"+this.model.get('id')).setup({
                        file: "videos/s"+this.model.get('id')+"introvid1.mp4",
                        image: "img/introvid.png",
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
		//::video::
		jwplayer("intro-vid-"+this.model.get('id')).onReady(function(){jwplayer("intro-vid-"+this.model.get('id')).remove();});
		this.remove();
	},
});
