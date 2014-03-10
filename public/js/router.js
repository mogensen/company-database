/* 
 * router.js 
 */

// router initialization
App.Router.map(function(){
	this.resource('companies', function(){
		this.resource('company', { path:'/:company_id' },
			function(){
				this.route('edit');
			});
		this.route('create');
	});
});

// index route
App.IndexRoute = Em.Route.extend({
	redirect: function(){
		this.transitionTo('companies');
	}
});
