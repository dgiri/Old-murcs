var MurcsLoot = function(){
   this.SELECTED_VIEW_COLUMNS = [];
 };

 MurcsLoot.prototype.selectView = function(obj, whichView) {
	var url = $(obj).attr('href');
  if($.inArray(whichView, ml.SELECTED_VIEW_COLUMNS) < 0){
		ml.SELECTED_VIEW_COLUMNS.push(whichView);
		ml.addViewColumn(obj, url, whichView);
	} else {
		ml.SELECTED_VIEW_COLUMNS.splice($.inArray(whichView, ml.SELECTED_VIEW_COLUMNS), 1);
		ml.removeViewColumn(obj, url, whichView);
	}
	$("#viewPanelHolder > div").removeClass().addClass("g1of" + ml.SELECTED_VIEW_COLUMNS.length);
 }
 
 MurcsLoot.prototype.addViewColumn = function(obj, url, whichView) {
    $("#" + whichView).show();	 
	  $.ajax({
			url: url + "&did=open",
			success: function(data){ }
		});
		$(obj).children('span').addClass("buttonPressed");
 }
 
 MurcsLoot.prototype.removeViewColumn = function(obj, url, whichView) {
   $("#" + whichView).hide();		
	  $.ajax({
			url: url + "&did=close",
			success: function(data){ }
		});
		$(obj).children('span').removeClass("buttonPressed");
 }

var ml = new MurcsLoot();


$(document).ready(function(){
	if(typeof(SELECTED_VIEW_COLUMNS) != "undefined") {
		$.each(SELECTED_VIEW_COLUMNS, function(index, value){
		 	ml.selectView($("#"+value+"_link"), value);
		});
	}
});