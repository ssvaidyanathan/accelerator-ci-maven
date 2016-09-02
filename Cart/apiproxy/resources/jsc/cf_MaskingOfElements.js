	var maskXMLData = function (strXML,maskConfigData){ 
									if(strXML == null) {
				strXML = '';
			}
									for (var data in maskConfigData) {
																	var elementToMask = maskConfigData[data].tagToMask;
					var maskChar = maskConfigData[data].maskChar;
					var keepLastChars = Number(maskConfigData[data].keepLastChars);
																	 if(elementToMask.indexOf('/@') > -1){
																	var attribute = elementToMask.split('@')[1];      
																	var elementToMask=elementToMask.split('/')[0];
																	var maskingStr = '';
													}
									  if(strXML.indexOf('<soapenv:Body>') > -1){
																	var subText = strXML.split("<soapenv:Body>").pop().split(":").shift();
																	var namespace = subText.substring(2,subText.length);
													}
									  else if(strXML.indexOf('<SOAP-ENV:Body>') > -1){
																	var subText = strXML.split("<SOAP-ENV:Body>").pop().split(":").shift();
																	var namespace = subText.substring(2,subText.length);
													}
									  else if(strXML.indexOf('<soap-env:Body>') > -1){
																	var subText = strXML.split("<soap-env:Body>").pop().split(":").shift();
																	var namespace = subText.substring(2,subText.length);
													}
									  else if(strXML.indexOf('<Soap-Env:Body>') > -1){
																	var subText = strXML.split("<Soap-Env:Body>").pop().split(":").shift();
																	var namespace = subText.substring(2,subText.length);
													}
									  else{
																	var namespace = '';
													 }
													//Regular expression to pick the required tag value.
									  
													if(namespace && attribute){
																	strRegExPattern = '<'+ namespace + ':' + elementToMask + '(.*?)'+ attribute +'=\"(.*?)"(.*?)>(.*?)</(.*?):' + elementToMask + '>';
													} else if(namespace){
																	  strRegExPattern = '<'+ namespace + ':' + elementToMask + '(.*?)>(.*?)</(.*?):' + elementToMask + '>';
													} else if(attribute){
																	strRegExPattern = '<' + elementToMask + '(.*?)'+ attribute +'=\"(.*?)"(.*?)>(.*?)</' + elementToMask + '>';
													} else {
																	strRegExPattern = '<' + elementToMask + '(.*?)>(.*?)</' + elementToMask + '>';
													}
									   
													//Picking the value within the required tag. 
													//Includes the tag along with value. eg-<num>jjjj</num> will be one of the elements returned.
													var matches = strXML.match(new RegExp(strRegExPattern, 'g'));
													if(matches){
																	if(attribute) { 
																	//Masking Attributes
																					if(namespace){
																									var attrRegExPatternXML = '<'+ namespace + ':' + elementToMask +'(.*?)'+attribute + '="' + '(.*?)' + '"';
																					} else { 
																									var attrRegExPatternXML = '<'+elementToMask+'(.*?)'+attribute + '="' + '(.*?)' + '"';
																					}
																					var tagMatch = strXML.match(new RegExp(attrRegExPatternXML, 'g'));                                                                        
																					if (tagMatch) {
																									for (var i = 0; i < tagMatch.length; i++) {                                                                                                                 
																													var arrElem = tagMatch[i].split("=");                                                                                                        
																													var attribute = arrElem[1];                                                                                                           
																													var count = 1;
																													  if (attribute.length > keepLastChars) {
																													   count = attribute.length - keepLastChars -1 ;  
																													  }
																														for (var a = 0; a < count-1; a++) {	
																															if(!maskingStr){
																																maskingStr = '*';
																															}
																															else{
																																maskingStr = maskingStr + '*';
																															}
																														}
																													var maskedElement = tagMatch[i].replace(attribute.substring(1, count), maskingStr); 
																													maskingStr = '';
																													strXML = strXML.replace(tagMatch[i], maskedElement);                                                                                                                
																									}
																					}
																	} else { 
																					  for (var i = 0; i < matches.length; i++) {
																									//Picking the value within the open and close tags. eg- jjjj will be returned here.
																									var elementToMask = matches[i].substring(matches[i].indexOf(">") + 1, matches[i].indexOf("</"));
																									//masking the element by replacing all except the last 2 characters of the element.
																									var count = 1;
																									  if (elementToMask.length > keepLastChars) {
																									   count = elementToMask.length - keepLastChars;  
																									  }
																									//context.setVariable(elementToMask+"count"+data,count);
																									for (var a = 0; a < count; a++) {	
																										if(!maskingStr){
																											maskingStr = '*';
																										}
																										else{
																											maskingStr = maskingStr + '*';
																										}
																									}
																									var maskedElement = elementToMask.replace(elementToMask.substring(0, count), maskingStr);
																									maskingStr = '';
																									//replacing the masked value within the original xmlString.
																									strXML = strXML.replace(elementToMask, maskedElement);
																					}
																	}
																	
													}
													//Masking Attributes
													if(!attribute){
																	var attrRegExPatternXML = elementToMask + '="' + '(.*?)' + '"';
																	var tagMatch = strXML.match(new RegExp(attrRegExPatternXML, 'g')); 
																	if (tagMatch) {
																	
																					for (var i = 0; i < tagMatch.length; i++) {                                                                                                                 
																									var arrElem = tagMatch[i].split("=");                                                                                                        
																									var elementToMask = arrElem[1];                                                                                                            
																									var count = 1;
																									  if (elementToMask.length > keepLastChars) {
																									   count = elementToMask.length - keepLastChars -1 ;  
																									  }
																										for (var a = 0; a < count-1; a++) {	
																											if(!maskingStr){
																												maskingStr = '*';
																											}
																											else{
																												maskingStr = maskingStr + '*';
																											}
																										}
																									var maskedElement = tagMatch[i].replace(elementToMask.substring(1, count), maskingStr);  
																									maskingStr = '';
																									strXML = strXML.replace(tagMatch[i], maskedElement);                                                                                                               
																					}
																	}              
													}
									
																	
									}
					return strXML;
	}   

	var maskJSONData = function (strJSON, maskConfigData) {
		for (var data in maskConfigData) {
			var tagToMask = maskConfigData[data].tagToMask;
			var maskChar = maskConfigData[data].maskChar;
			var keepLastChars = Number(maskConfigData[data].keepLastChars);
			var maskingStr = '';
			//Checking for the path of the attributes
			if (tagToMask.indexOf('/') > -1) {	
				if (tagToMask.indexOf('@') > -1) {	
					var pathOfElement = tagToMask.split("/");
					var paretnElement = pathOfElement[0];
					var TagToBeMasked = pathOfElement[pathOfElement.length-1];
					var strRegExPatternJSON = '"' + paretnElement + '":' +'(.*?)' + '{' + '"' + TagToBeMasked + '":' + '(.*?)' +'(,|})';
					var tagMatch = strJSON.match(new RegExp(strRegExPatternJSON, 'g'));	
					if (tagMatch) {
						for (var i = 0; i < tagMatch.length; i++) {	
						var lastChar = '}';
							//Checking weather it is simple element with attribute or complex element with attribute
							if (tagMatch[i].indexOf(',') > -1) {
									lastChar = ',';
							}
								var attrRegExPattern = '"' + TagToBeMasked + '":' + '(.*?)' + lastChar;
								var matchesAttr = tagMatch[i].match(new RegExp(attrRegExPattern, 'g'));
								if (matchesAttr) {
									for (var j = 0; j < matchesAttr.length; j++) {
										var prefix = matchesAttr[j].substring(0, matchesAttr[j].indexOf("\":"));
										var elementToBeMasked = matchesAttr[j].split("\":").pop().split(lastChar).shift();
										var maskedElement = '';
										if (elementToBeMasked.length > keepLastChars) {
											var count = elementToBeMasked.length - keepLastChars;  
											if (elementToBeMasked.indexOf("\"") == -1) {
												//element to be masked is an integer
												for (var a = 0; a < count; a++) {	
													if(!maskingStr){
														maskingStr = '*';
													}
													else{
														maskingStr = maskingStr + '*';
													}
												}
												maskedElement = "\"" + elementToBeMasked.replace(elementToBeMasked.substring(0, count), maskingStr) + "\"";						
												maskingStr = '';
											} else {
												//element to be masked is a string
												for (var a = 0; a < count-2; a++) {	
													if(!maskingStr){
														maskingStr = '*';
													}
													else{
														maskingStr = maskingStr + '*';
													}
												}
												maskedElement = "\"" + elementToBeMasked.replace(elementToBeMasked.substring(0, count - 1), maskingStr);
												maskingStr = '';
											}	
										} else {
											//elementToBeMasked.length <= keepLastChars
											maskedElement = elementToBeMasked;
										}									
										//Replace the masked String in the parent json
										strJSON = strJSON.replace( matchesAttr[j], prefix + "\":" + maskedElement + lastChar);	
									}
								}						
						}
					}
				}		
			}
			else {
			
				//Expression to get all the data to be masked
				var strRegExPatternJSON = '"' + tagToMask + '":' + '(.*?)' + '(,|})';
				var tagMatch = strJSON.match(new RegExp(strRegExPatternJSON, 'g'));	
				//List created to ensure, repeated elements are not processed
				var	listOfElements = new Array();			
				if (tagMatch) {
					for (var i = 0; i < tagMatch.length; i++) {						
						if (tagMatch[i].indexOf('{') > -1) {		
							//Element to be masked contains an attribute 
							if (tagMatch[i].indexOf('[') > -1) {
								//Element to be masked contains an attribute and is an array								
								var arrRegExPatternJSON = '"' + tagToMask + '":\\[{' + '(.*?)' + '#text'+ '(.*?)' + '\\]';
								var attrArrMatch = strJSON.match(new RegExp(arrRegExPatternJSON, 'g'));
								if (attrArrMatch) {
									for (var j = 0; j < attrArrMatch.length; j++) {	
										if (listOfElements.indexOf(attrArrMatch[j]) == -1) {
											//Get the individual array elements
											var attrArrayRegExPattern = '{' + '(.*?)' + '}';
											var matchesAttrArr = attrArrMatch[j].match(new RegExp(attrArrayRegExPattern, 'g'));
											if (matchesAttrArr) {	
												//Mask Individual Object in array
												for (var k = 0; k < matchesAttrArr.length; k++) {														
													var prefix = matchesAttrArr[k].substring(0, matchesAttrArr[k].indexOf("#text\":"));
													var elementToBeMasked = matchesAttrArr[k].split("#text\":").pop().split("}").shift();
													var maskedElement = '';
													  if (elementToBeMasked.length > keepLastChars) {
															var count = elementToBeMasked.length - keepLastChars;  
															if (elementToBeMasked.indexOf("\"") == -1) {
																//element to be masked is an integer
																for (var a = 0; a < count; a++) {	
																	if(!maskingStr){
																		maskingStr = '*';
																	}
																	else{
																		maskingStr = maskingStr + '*';
																	}
																}
																maskedElement = "\"" + elementToBeMasked.replace(elementToBeMasked.substring(0, count), maskingStr) + "\"";
																maskingStr = '';
															} else {
																//element to be masked is a string
																for (var a = 0; a < count-2; a++) {	
																	if(!maskingStr){
																		maskingStr = '*';
																	}
																	else{
																		maskingStr = maskingStr + '*';
																	}
																}
																maskedElement = "\"" + elementToBeMasked.replace(elementToBeMasked.substring(0, count - 1), maskingStr);
																maskingStr = '';
															}	
														} else {
																//elementToBeMasked.length <= keepLastChars
																maskedElement = elementToBeMasked;
														}	
													//Replace the masked String in the parent json
													strJSON = strJSON.replace( matchesAttrArr[k], prefix + "#text\":" + maskedElement + "}");				
												}
											}
											listOfElements.push(attrArrMatch[j]);
										}
									}
								}
							} else {								
								//Element to be masked is a single object and contains Attribute
								var arrRegExPatternJSON = '"' + tagToMask + '":{' + '(.*?)' + '#text'+ '(.*?)' + '(,|})';
								var attrMatch = strJSON.match(new RegExp(arrRegExPatternJSON, 'g'));
								if (attrMatch) {
									for (var j = 0; j < attrMatch.length; j++) {	
										if (listOfElements.indexOf(attrMatch[j]) == -1) {											
											var prefix = attrMatch[j].substring(0, attrMatch[j].indexOf("#text\":"));
											var elementToBeMasked = attrMatch[j].split("#text\":").pop().split("}").shift();
											var maskedElement = '';
											 if (elementToBeMasked.length > keepLastChars) {
												var count = elementToBeMasked.length - keepLastChars;  
												if (elementToBeMasked.indexOf("\"") == -1) {
													//element to be masked is an integer												
													for (var a = 0; a < count; a++) {	
														if(!maskingStr){
															maskingStr = '*';
														}
														else{
															maskingStr = maskingStr + '*';
														}
													}
													maskedElement = "\"" + elementToBeMasked.replace(elementToBeMasked.substring(0, count), maskingStr) + "\"";	
													maskingStr = '';
												} else {
													//element to be masked is a string												
													for (var a = 0; a < count-2; a++) {	
														if(!maskingStr){
															maskingStr = '*';
														}
														else{
															maskingStr = maskingStr + '*';
														}
													}
													maskedElement = "\"" + elementToBeMasked.replace(elementToBeMasked.substring(0, count - 1), maskingStr);
													maskingStr = '';
												}
											} else {
												//elementToBeMasked.length <= keepLastChars
												maskedElement = elementToBeMasked;
											}									
											listOfElements.push(attrMatch[j]);
											//Replace the masked String in the parent json
											strJSON = strJSON.replace(attrMatch[j], prefix + "#text\":" + maskedElement + "}");
										}
									}
								}								
							}
						} else {	
							//Element to be masked doesnt contain an attribute
							if (tagMatch[i].indexOf('[') > -1) {	
								//Element to be masked is an array
								var arrRegExPatternJSON = '"' + tagToMask + '":' + '\\[' +'(.*?)' + '\\]';		
								var arrMatch = strJSON.match(new RegExp(arrRegExPatternJSON, 'g'));
								if (arrMatch) {
									for (var j = 0; j < arrMatch.length; j++) {
										//Condition to extract only Array with no attributes
										if (arrMatch[j].indexOf('{') == -1) {											
											if (listOfElements.indexOf(arrMatch[j]) == -1) {												
												listOfElements.push(arrMatch[j]);
												var txtcount = arrMatch[j].split("\"").length - 1;												
												if (txtcount > 2) {
													//Array of Strings
													var strArr = arrMatch[j].split("[").pop().split("]").shift();											
													var arrElem = strArr.split(",");													
													var maskedElement = '';
													for (var k =0; k< arrElem.length; k++) {														
															
														var count = 1;
													  if (arrElem[k].length > keepLastChars) {
													   count = arrElem[k].length - keepLastChars-1;  
													  }								
															for (var a = 0; a < count-1; a++) {	
																if(!maskingStr){
																	maskingStr = '*';
																}
																else{
																	maskingStr = maskingStr + '*';
																}
															}
															maskedElement = maskedElement + arrElem[k].replace(arrElem[k].substring(1, count), maskingStr);
															maskingStr = '';
														if (k != arrElem.length - 1) {
															maskedElement = maskedElement + ",";
														}																
													}
													//Replace the masked String in the parent json
													strJSON = strJSON.replace( arrMatch[j], "\"" + tagToMask + "\": [" + maskedElement + "]");				
												} else {				
													//Array of Integers
													var intArr =  arrMatch[j].split("[").pop().split("]").shift();											
													var arrElem = intArr.split(",");
													var maskedElement = '[';
													for (var k=0; k<arrElem.length;k++) {
														var count = 1;
													  if (arrElem[k].length > keepLastChars) {
													   count = arrElem[k].length - keepLastChars;  
													  }											
														
														for (var a = 0; a < count; a++) {	
															if(!maskingStr){
																maskingStr = '*';
															}
															else{
																maskingStr = maskingStr + '*';
															}
														}
														maskedElement = maskedElement + "\"" + arrElem[k].replace(arrElem[k].substring(0, count), maskingStr) + "\"";
														maskingStr = '';
														if (k != arrElem.length - 1) {
															maskedElement = maskedElement + ",";
														}																								
													}
													maskedElement = maskedElement + "]";
													//Replace the masked String in the parent json
													strJSON = strJSON.replace( arrMatch[j], "\"" + tagToMask + "\": " + maskedElement);
												}												
											}
										} 
									}
								}
							} else {
								//Element to be masked is a single object
								var txtcount = tagMatch[i].split("\"").length - 1;									
								if (txtcount == 4) {
									//Element is a String
									var elementToMask = tagMatch[i].substring(tagMatch[i].indexOf(":") + 1);
									
										var count = 1;
									  if (elementToMask.length > keepLastChars) {
									   count = elementToMask.length - keepLastChars-2;  
									  }															
									
									for (var a = 0; a < count-1; a++) {	
										if(!maskingStr){
											maskingStr = '*';
										}
										else{
											maskingStr = maskingStr + '*';
										}
									}
									
									var maskedElement = elementToMask.replace(elementToMask.substring(0, count), maskingStr);		
									maskingStr = '';
									maskedElement = maskedElement.substring(0, maskedElement.length - 1) + elementToMask.substring(elementToMask.length - 1);
									strJSON = strJSON.replace(tagMatch[i], "\"" + tagToMask + "\": \"" + maskedElement);
								} else {				
									//Element is an Integer
									var elementToMask = tagMatch[i].substring(tagMatch[i].indexOf(":") + 1);
									var count = 1;
									  if (elementToMask.length > keepLastChars) {
									   count = elementToMask.length - keepLastChars-1;  
									  }																  
									for (var a = 0; a < count; a++) {	
										if(!maskingStr){
											maskingStr = '*';
										}
										else{
											maskingStr = maskingStr + '*';
										}
									}
									
									var maskedElement = elementToMask.replace(elementToMask.substring(0, count), maskingStr);				
									maskingStr = '';
									maskedElement = maskedElement.substring(0, maskedElement.length - 1) + '\"' + elementToMask.substring(elementToMask.length - 1);									
									//Replace the masked String in the parent json
									strJSON = strJSON.replace(tagMatch[i], "\"" + tagToMask + "\": \"" + maskedElement);
								}								
							}
						}
					}					
				}
			  
							var attrRegExPatternJSON = '"@' + tagToMask + '":"' + '(.*?)' + '"';					
							tagMatch = strJSON.match(new RegExp(attrRegExPatternJSON, 'g'));					
							if (tagMatch) {
								for (var i = 0; i < tagMatch.length; i++) {	
									var attrElem = tagMatch[i].split("\"");									
									var elementToMask = attrElem[3];
										var count = 1;
									  if (elementToMask.length > keepLastChars) {
									   count = elementToMask.length - keepLastChars;  
									  }	
									for (var a = 0; a < count; a++) {	
										if(!maskingStr){
											maskingStr = '*';
										}
										else{
											maskingStr = maskingStr + '*';
										}
									}
									
									var maskedElement = elementToMask.replace(elementToMask.substring(0, count), maskingStr);	
									maskingStr = '';
									strJSON = strJSON.replace(tagMatch[i], "\"@" + tagToMask + "\":\"" + maskedElement + "\"");							
								
							}
						}	
			  }
		  }
			
			return strJSON;				
		}
