/* 
 * models/companie.js 
 */
// the model for a company
App.Company = DS.Model.extend({
	name         : DS.attr(),
	email        : DS.attr(),
	address      : DS.attr(),
	city         : DS.attr(),
	country      : DS.attr(),
	avatar_url   : DS.attr(),
	created_at   : DS.attr()
});


