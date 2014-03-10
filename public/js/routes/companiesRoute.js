/*
 * routes/companiesRoute.js 
 */

App.CompaniesRoute = Em.Route.extend({
	model: function(){
		return this.store.find('company');
	}
});

// single companie route - dynamic segment
App.CompanyRoute = Em.Route.extend({
	model: function(params){
		return this.store.find('company', params.company_id);
	}
});

// singe company edit form route
App.CompanyEditRoute = Em.Route.extend({
	model: function(){ 
		return this.modelFor('company');
	}
});

// company creation form route
App.CompaniesCreateRoute = Em.Route.extend({
	model: function(){
		// the model for this route is a new empty Ember.Object
		return Em.Object.create({});
	},

	// in this case (the create route) we can re-use the company/edit template
	// associated with the companiesCreateController
	renderTemplate: function(){
		this.render('company.edit', {
			controller: 'companiesCreate'
		});
	}
});

