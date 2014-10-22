$(function() {
    console.log( "index page ready" );

    NavBtnView = Backbone.View.extend({
        el: ('#mkh_nav_buttons'),
        events: {
            "click #mbtn_m_fwd" : "btn_move",
            "click #mbtn_m_bwd" : "btn_move",
            "click #mbtn_m_s"   : "btn_move",
            "click #mbtn_m_l"   : "btn_move",
            "click #mbtn_m_r"   : "btn_move"
        },
        btn_move: function(ev){
            var dir = $(ev.currentTarget).data('dir');    
            console.log("MOVING DIRECTIONS:" + dir);
            mkh_api({
                data: {type: "move", direction: dir}
            });
        }
    });
    var nbv = new NavBtnView();

});
