/*
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
*/

var expect = require('chai').expect;
var sinon = require('sinon');

var contextGetVariableMethod,
	contextSetVariableMethod,
	httpClientSendMethod,
	requestConstr;

beforeEach(function() {
	GLOBAL.context = {
		getVariable: function(s) {},
		setVariable: function(a, b) {}
	};

	GLOBAL.httpClient = {
		send: function(s) {}
	};

	GLOBAL.Request = function(s) {};

	contextGetVariableMethod = sinon.stub(GLOBAL.context, 'getVariable');
	contextSetVariableMethod = sinon.spy(GLOBAL.context, 'setVariable');
	httpClientSendMethod = sinon.stub(httpClient, 'send');
	requestConstr = sinon.spy(GLOBAL, 'Request');

});

afterEach(function() {
	contextGetVariableMethod.restore();
	contextSetVariableMethod.restore();
	httpClientSendMethod.restore();
	requestConstr.restore();
});

exports.getMock = function() {
	return {
		contextGetVariableMethod: contextGetVariableMethod,
		contextSetVariableMethod: contextSetVariableMethod,
		httpClientSendMethod: httpClientSendMethod,
		requestConstr: requestConstr
	};
}
