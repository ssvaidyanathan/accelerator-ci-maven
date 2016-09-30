/*global
context
*/
  function createFinalResponse(resp) {
    var finalResp = [];
    var entities = resp.entities;
    if (entities!==undefined && entities.length > 0) {
       for (var i = 0, len = entities.length; i < len; i++)  {
          var entity = entities[i];
          var store = {};
          store.StoreCode = entity.StoreCode;
          store.Name = entity.Name;
          store.Address_1 = entity.Address_1;
          store.Address_2 = entity.Address_2;
          store.City = entity.City;
          store.State = entity.State;
          store.PostalCode = entity.PostalCode;
          store.MainPhone = entity.MainPhone;
          store.HomePage = entity.HomePage;
 
          var hours = [];
          var entityHours = entity.Hours;
          for (var j = 0, l = entityHours.length; j < l; j ++) {
            var hour = entityHours[j];
            var storeHour = {};
            storeHour.DayOfWeek = hour.DayOfWeek;
            storeHour.OpenTime = hour.OpenTime;
            storeHour.CloseTime = hour.CloseTime;
            hours.push(storeHour);
          }
          store.Hours = hours;
 
          var entityLoc = entity.location;
          var location = {};
          location.lat = entityLoc.latitude;
          location.lon = entityLoc.longitude;
 
          store.Location = location;
          finalResp.push(store);
      }
      return finalResp;
    }
  }

if(typeof exports !== 'undefined') {
    exports.createFinalResponse = createFinalResponse;
}
 
//############# executable code starting here #############
var isError = false;
var respBody = context.getVariable("response.content");
var finalResp = {};
try {
  var objBaaSResp = JSON.parse(respBody);
  finalResp = createFinalResponse(objBaaSResp);
} catch (e) {
    isError = true;
    context.setVariable("flow.Error", "InvalidResponse");
}
 
context.setVariable("flow.isError", isError);
context.setVariable("response.content", JSON.stringify(finalResp));
