// Companies array controller
App.CompaniesController = Em.ArrayController.extend({
	sortProperties: ['name'],
	sortAscending: true, // false = descending

	companiesCount: function(){
		return this.get('model.length');
	}.property('@each')
});


// single companie controller
App.CompanyController = Em.ObjectController.extend({
	deleteMode: false,

	actions: {
		delete: function(){
			// the delete method only toggles deleteMode value
			this.toggleProperty('deleteMode');
		},
		cancelDelete: function(){
			// set deleteMode back to false
			this.set('deleteMode', false);
		},
		confirmDelete: function(){
			// this will tell Ember-Data to delete the current companie
			this.get('model').deleteRecord();
			this.get('model').save();
			// and then go to the companies route
			this.transitionToRoute('companies');
			// set deleteMode back to false
			this.set('deleteMode', false);
		},
		edit: function(){
			this.transitionToRoute('company.edit');
		}
	}
});

// single company edit form controller
App.CompanyEditController = Em.ObjectController.extend({
	actions: {
		save: function(){
			var company = this.get('model');
			if (company.get('isValid')) {
				company.save();
				this.transitionToRoute('company', company);
			}
		}
	}
});


// company creation form controller
App.CompaniesCreateController = Em.ObjectController.extend({
	actions: {
		save: function () {
			// just before saving, we set the created_at
			this.get('model').set('created_at', new Date());

			// save and commit
			var newCompany = this.store.createRecord('company', this.get('model'));

			if (newCompany.get('isValid')) {
				newCompany.save();
				this.transitionToRoute('company', newCompany);
			} else {
				this.transitionToRoute('company.edit', newCompany);
			}
		}
	}
});
