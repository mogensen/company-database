/*
 * js/viewHelpers/formateDate.js
 */
Em.Handlebars.registerBoundHelper('formatDate', function(date){
	return moment(date).fromNow();
});
