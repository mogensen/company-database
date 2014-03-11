/* 
 * models/companie.js 
 */
// the model for a company
App.Company = DS.Model.extend(Ember.Validations.Mixin, {
	name         : DS.attr('string'),
	address      : DS.attr('string'),
	city         : DS.attr('string'),
	country      : DS.attr('string'),
	email        : DS.attr(),
	phone        : DS.attr(),
	avatar_url   : DS.attr(),
	created_at   : DS.attr(),

	validations: {
		address: {
			presence: true
		},
		phone: {
			numericality: true,
			length: {
				moreThan: 10000000,
				lessThan: 99999999
			},
		},
		email: {
			format: /.+@.+\..{2,4}/
		}
	}
});

App.Company.reopen({
	validations: {
		name: {
			presence: true,
			length: { minimum: 5 }
		},
		address: {
			presence: true,
			length: { minimum: 5 }
		},
		city: {
			presence: true,
			length: { minimum: 2 }
		},
		country: {
			presence: true,
			length: { minimum: 2 }
		},
		email: {
			length: { minimum: 4, allowBlank: true }
		},
		phone: {
			numericality: { onlyInteger: true, greaterThan: 10000000, lessThanOrEqualTo: 99999999, allowBlank: true }
		},
	}
});
