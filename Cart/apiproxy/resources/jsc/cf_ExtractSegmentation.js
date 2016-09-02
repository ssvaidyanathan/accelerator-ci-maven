//Extract segmentation data from APP and create flow variables

  var app_channelCode = context.getVariable("app.channelcode");
  var app_subChannelCode = context.getVariable("app.subchannelcode");
  var app_category = context.getVariable("app.category");
  
  if(typeof app_channelCode == 'undefined' || app_channelCode == null){
	  app_channelCode = '';
  }
  if(typeof app_subChannelCode == 'undefined' || app_subChannelCode == null){
	  app_subChannelCode = '';
  }
  if(typeof app_category == 'undefined' || app_category == null){
	  app_category = '';
  }

  context.setVariable("app_channelCode",app_channelCode);
  context.setVariable("app_subChannelCode",app_subChannelCode);
  context.setVariable("app_category",app_category);