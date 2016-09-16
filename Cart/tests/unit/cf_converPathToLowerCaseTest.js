var expect = require('chai').expect;
var sinon = require('sinon');

var moduleLoader = require('./common/moduleLoader.js');
var mockFactory = require('./common/mockFactory.js');

var js = '../../../apiproxy/resources/jsc/cf_converPathToLowerCase.js';

describe('feature: convert path to lower case', function() {

	it('should convert path to lower case', function(done) {
		var mock = mockFactory.getMock();

		mock.contextGetVariableMethod.withArgs('requestpath.definition').returns('/V1/CART');

		moduleLoader.load(js, function(err) {
			expect(err).to.be.undefined;	
			expect(mock.contextSetVariableMethod.calledOnce).to.equal(true);
			expect(mock.contextSetVariableMethod.firstCall.args[1]).to.equal('/v1/cart');
			done();
		});
	});

});
