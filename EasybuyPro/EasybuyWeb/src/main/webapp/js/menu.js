// JavaScript Document

// var jq = jQuery.noConflict();
jQuery(function(){

	jQuery(".leftNav #menu li").hover(
		function(){
			// alert("x")
			jQuery(this).find(".fj").addClass("nuw");
			jQuery(this).find(".zj").show();

		}
		,
		function(){
			jQuery(this).find(".fj").removeClass("nuw");
			jQuery(this).find(".zj").hide();
		}
	)
})
