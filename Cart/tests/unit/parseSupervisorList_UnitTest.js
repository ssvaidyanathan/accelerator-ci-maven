var expect = require('chai').expect;
var sinon = require('sinon');

var moduleLoader = require('./common/moduleLoader.js');
var mockFactory = require('./common/mockFactory.js');

var js = "../../../apiproxy/resources/jsc/parseSupervisorList.js";

describe('feature: tests on the good parsers', function() {

	it('tests on the good parsers with 2 items in list', function(done) {
		var mock = mockFactory.getMock();
		var supervisorList = "sid1~tid1,sid2~tid2";
		var entitlementsJSON = '{"tid1_DEFAULT": "abc1?>def1?>ghi1?>", "tid2_DEFAULT": "abc2?>def2?>ghi2?>"}';

		mock.contextGetVariableMethod.withArgs('supervisorIdListVar').returns(supervisorList);
		mock.contextGetVariableMethod.withArgs('accesstoken.abfEntitlements').returns(entitlementsJSON);

		moduleLoader.load(js, function(err) {
			expect(err).to.be.undefined;	
			expect(mock.contextSetVariableMethod.called).to.equal(true);
			expect(mock.contextSetVariableMethod.args[0][1]).to.equal(2); //"arrLenght"
			expect(mock.contextSetVariableMethod.args[1][1]).to.equal("sid2~tid2"); //"supervisor1"
			expect(mock.contextSetVariableMethod.args[2][1]).to.equal("abc2?>def2?>ghi2?>"); //"sEntitlements"
			expect(mock.contextSetVariableMethod.args[3][1]).to.equal("sid2"); //"supervisorId1"
			expect(mock.contextSetVariableMethod.args[4][1]).to.equal(null); //"supervisorId2"
			expect(mock.contextSetVariableMethod.args[5][1]).to.equal(null); //"supervisorId3"
			expect(mock.contextSetVariableMethod.args[6][1]).to.equal(null); //"supervisorId4"
			expect(mock.contextSetVariableMethod.args[7][1]).to.equal(null); //"supervisorId5"
			expect(mock.contextSetVariableMethod.args[8][1]).to.equal("tid2"); //"transactionId1"
			expect(mock.contextSetVariableMethod.args[9][1]).to.equal(null); //"transactionId2"
			expect(mock.contextSetVariableMethod.args[10][1]).to.equal(null); //"transactionId3"
			expect(mock.contextSetVariableMethod.args[11][1]).to.equal(null); //"transactionId4"
			expect(mock.contextSetVariableMethod.args[12][1]).to.equal(null); //"transactionId5"
			expect(mock.contextSetVariableMethod.args[13][1]).to.equal("DEFAULT"); //"custInfo"
			expect(mock.contextSetVariableMethod.args[14][1]).to.equal("def2"); //"supervisorEntitlementsVar1"
			expect(mock.contextSetVariableMethod.args[15][1]).to.equal(null); //"supervisorEntitlementsVar2"
			expect(mock.contextSetVariableMethod.args[16][1]).to.equal(null); //"supervisorEntitlementsVar3"
			expect(mock.contextSetVariableMethod.args[17][1]).to.equal(null); //"supervisorEntitlementsVar4"
			expect(mock.contextSetVariableMethod.args[18][1]).to.equal(null); //"supervisorEntitlementsVar5"
			done();
		});
	});

});
