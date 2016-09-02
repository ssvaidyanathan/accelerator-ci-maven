<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:saxon="http://saxon.sf.net/" xmlns:myfunc="http://tmobile.com/xslfunction/" exclude-result-prefixes="saxon myfunc" extension-element-prefixes="saxon">
	<xsl:output method="xml" omit-xml-declaration="yes"/>

	<xsl:param name="targetname"/>
	<xsl:param name="servicename"/>
	<xsl:param name="operationname"/>
	<xsl:param name="apirequesturl"/>
	<xsl:param name="apirequestverb"/>
	<xsl:param name="facaderequestbasepathvar" select="''"/>
	<xsl:param name="apiErrorParam" select="''"/>
	<xsl:variable name="apiErrorVar" select="if (string-length($apiErrorParam) gt 0) then saxon:parse($apiErrorParam) else ()"/> 	
	<xsl:variable name="statusCodeVar" select="$apiErrorVar/apiError/statusCode"/>
	<xsl:variable name="errorCountVar" select="$apiErrorVar/apiError/count"/>
	<xsl:variable name="targetsystem" select="substring-before($targetname, '_')"/>
	<xsl:variable name="facadeproxybasepathvar1" select="if (string-length($facaderequestbasepathvar) gt 0) then 
                                                           concat('/', ((tokenize($facaderequestbasepathvar, '/'))[2])) else ''"/>
	<xsl:variable name="apirequesturl1" select="concat($facadeproxybasepathvar1, $apirequesturl)"/>
	<xsl:variable name="apiverbandurl" select="concat($apirequestverb, ':', (if (ends-with($apirequesturl1, '/')) then 
						substring($apirequesturl1, 1, (string-length($apirequesturl1) - 1)) else $apirequesturl1))"/>
	<!-- Standard HTTP codes -->
	<xsl:variable name="standardhttpcodes">
		<httpcodes>
			<httpcode code="100">Continue</httpcode>
			<httpcode code="101">Switching Protocols</httpcode>
			<httpcode code="102">Processing</httpcode>
			<httpcode code="200">OK</httpcode>
			<httpcode code="201">Created</httpcode>
			<httpcode code="202">Accepted</httpcode>
			<httpcode code="203">Non-Authoritative Information</httpcode>
			<httpcode code="204">No Content</httpcode>
			<httpcode code="205">Reset Content</httpcode>
			<httpcode code="206">Partial Content</httpcode>
			<httpcode code="207">Multi-Status</httpcode>
			<httpcode code="208">Already Reported</httpcode>
			<httpcode code="226">IM Used</httpcode>
			<httpcode code="300">Multiple Choices</httpcode>
			<httpcode code="301">Moved Permanently</httpcode>
			<httpcode code="302">Found</httpcode>
			<httpcode code="303">See Other</httpcode>
			<httpcode code="304">Not Modified</httpcode>
			<httpcode code="305">Use Proxy</httpcode>
			<httpcode code="306">(Unused)</httpcode>
			<httpcode code="307">Temporary Redirect</httpcode>
			<httpcode code="308">Permanent Redirect</httpcode>
			<httpcode code="400">Bad Request</httpcode>
			<httpcode code="401">Unauthorized</httpcode>
			<httpcode code="402">Payment Required</httpcode>
			<httpcode code="403">Forbidden</httpcode>
			<httpcode code="404">Not Found</httpcode>
			<httpcode code="405">Method Not Allowed</httpcode>
			<httpcode code="406">Not Acceptable</httpcode>
			<httpcode code="407">Proxy Authentication Required</httpcode>
			<httpcode code="408">Request Timeout</httpcode>
			<httpcode code="409">Conflict</httpcode>
			<httpcode code="410">Gone</httpcode>
			<httpcode code="411">Length Required</httpcode>
			<httpcode code="412">Precondition Failed</httpcode>
			<httpcode code="413">Payload Too Large</httpcode>
			<httpcode code="414">URI Too Long</httpcode>
			<httpcode code="415">Unsupported Media Type</httpcode>
			<httpcode code="416">Range Not Satisfiable</httpcode>
			<httpcode code="417">Expectation Failed</httpcode>
			<httpcode code="421">Misdirected Request</httpcode>
			<httpcode code="422">Unprocessable Entity</httpcode>
			<httpcode code="423">Locked</httpcode>
			<httpcode code="424">Failed Dependency</httpcode>
			<httpcode code="426">Upgrade Required</httpcode>
			<httpcode code="428">Precondition Required</httpcode>
			<httpcode code="429">Too Many Requests</httpcode>
			<httpcode code="431">Request Header Fields Too Large</httpcode>
			<httpcode code="500">Internal Server Error</httpcode>
			<httpcode code="501">Not Implemented</httpcode>
			<httpcode code="502">Bad Gateway</httpcode>
			<httpcode code="503">Service Unavailable</httpcode>
			<httpcode code="504">Gateway Timeout</httpcode>
			<httpcode code="505">HTTP Version Not Supported</httpcode>
			<httpcode code="506">Variant Also Negotiates</httpcode>
			<httpcode code="507">Insufficient Storage</httpcode>
			<httpcode code="508">Loop Detected</httpcode>
			<httpcode code="510">Not Extended</httpcode>
			<httpcode code="511">Network Authentication Required</httpcode>
		</httpcodes>
	</xsl:variable>
	<xsl:template match="/">
		<xsl:choose>
			<!-- when error code is not found in cache -->
			<xsl:when test="not(exists(/Maps/Map[1]/HttpCode))">
				<!--
				<xsl:variable name="statusCodeVar1" select="if (($errorCountVar) >= 1) then '500' else 
			      				(if (string-length($statusCodeVar) = 0) then '500' else $statusCodeVar)"/>
			 -->
				<!-- prepare output -->
				<xsl:choose>
					<xsl:when test="(($errorCountVar) >= 1) or (string-length($statusCodeVar) = 0)">
						<apiError>
							<statusCode>503</statusCode>
							<reasonPhrase>Service Unavailable</reasonPhrase>
							<xsl:copy-of select="$apiErrorVar/apiError/errors"/>
						</apiError>
					</xsl:when>
					<xsl:otherwise>
						<xsl:copy-of select="$apiErrorVar/apiError"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<!-- when error code is found in cache -->
			<xsl:otherwise>
				<xsl:variable name="ResultVar">
					<Result>
						<xsl:for-each select="/Maps/Map">
							<xsl:variable name="positionVar" select="position()"/>
							<xsl:variable name="mapCode" select="/Maps/Map[$positionVar]/Code"/>
							<xsl:variable name="errorCodeVar" select="($apiErrorVar/apiError/errors/error[code = $mapCode]/code)[1]"/>
							<xsl:variable name="errorUserMessageVar" select="($apiErrorVar/apiError/errors/error[code = $mapCode]/userMessage)[1]"/>
							<Map>
								<Code>
									<xsl:value-of select="/Maps/Map[$positionVar]/Code"/>
								</Code>
								<!-- compute http code -->
								<xsl:variable name="HttpCodeVar">
									<xsl:choose>
										<xsl:when test="string-length((/Maps/Map[$positionVar]//HttpCode)[1]) gt 0">
											<xsl:choose>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpCode) gt 0">
													<HttpCode>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpCode"/>
													</HttpCode>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpCode) gt 0">
													<HttpCode>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpCode"/>
													</HttpCode>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/API[@name=$apiverbandurl]/HttpCode) gt 0">
													<HttpCode>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/API[@name=$apiverbandurl]/HttpCode"/>
													</HttpCode>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpCode) gt 0">
													<HttpCode>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpCode"/>
													</HttpCode>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpCode) gt 0">
													<HttpCode>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpCode"/>
													</HttpCode>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/HttpCode) gt 0">
													<HttpCode>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/HttpCode"/>
													</HttpCode>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpCode) gt 0">
													<HttpCode>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpCode"/>
													</HttpCode>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpCode) gt 0">
													<HttpCode>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpCode"/>
													</HttpCode>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/API[@name=$apiverbandurl]/HttpCode) gt 0">
													<HttpCode>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/API[@name=$apiverbandurl]/HttpCode"/>
													</HttpCode>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpCode) gt 0">
													<HttpCode>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpCode"/>
													</HttpCode>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpCode) gt 0">
													<HttpCode>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpCode"/>
													</HttpCode>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/HttpCode) gt 0">
													<HttpCode>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/HttpCode"/>
													</HttpCode>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpCode) gt 0">
													<HttpCode>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpCode"/>
													</HttpCode>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpCode) gt 0">
													<HttpCode>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpCode"/>
													</HttpCode>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/API[@name=$apiverbandurl]/HttpCode) gt 0">
													<HttpCode>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/API[@name=$apiverbandurl]/HttpCode"/>
													</HttpCode>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpCode) gt 0">
													<HttpCode>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpCode"/>
													</HttpCode>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpCode) gt 0">
													<HttpCode>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpCode"/>
													</HttpCode>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/HttpCode) gt 0">
													<HttpCode>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/HttpCode"/>
													</HttpCode>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpCode) gt 0">
													<HttpCode>
														<xsl:value-of select="/Maps/Map[$positionVar]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpCode"/>
													</HttpCode>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpCode) gt 0">
													<HttpCode>
														<xsl:value-of select="/Maps/Map[$positionVar]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpCode"/>
													</HttpCode>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/HttpCode) gt 0">
													<HttpCode>
														<xsl:value-of select="/Maps/Map[$positionVar]/HttpCode"/>
													</HttpCode>
												</xsl:when>
												<xsl:otherwise>
													<HttpCode>
														<xsl:value-of select="''"/>
													</HttpCode>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
										<xsl:otherwise>
											<HttpCode>
												<xsl:value-of select="''"/>
											</HttpCode>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<!-- compute http description -->
								<xsl:variable name="HttpDescriptionVar">
									<xsl:choose>
										<xsl:when test="string-length((/Maps/Map[$positionVar]//HttpDescription)[1]) gt 0">
											<xsl:choose>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpDescription) gt 0">
													<HttpDescription>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpDescription"/>
													</HttpDescription>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpDescription) gt 0">
													<HttpDescription>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpDescription"/>
													</HttpDescription>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/API[@name=$apiverbandurl]/HttpDescription) gt 0">
													<HttpDescription>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/API[@name=$apiverbandurl]/HttpDescription"/>
													</HttpDescription>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpDescription) gt 0">
													<HttpDescription>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpDescription"/>
													</HttpDescription>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpDescription) gt 0">
													<HttpDescription>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpDescription"/>
													</HttpDescription>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/HttpDescription) gt 0">
													<HttpDescription>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/HttpDescription"/>
													</HttpDescription>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpDescription) gt 0">
													<HttpDescription>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpDescription"/>
													</HttpDescription>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpDescription) gt 0">
													<HttpDescription>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpDescription"/>
													</HttpDescription>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/API[@name=$apiverbandurl]/HttpDescription) gt 0">
													<HttpDescription>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/API[@name=$apiverbandurl]/HttpDescription"/>
													</HttpDescription>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpDescription) gt 0">
													<HttpDescription>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpDescription"/>
													</HttpDescription>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpDescription) gt 0">
													<HttpDescription>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpDescription"/>
													</HttpDescription>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/HttpDescription) gt 0">
													<HttpDescription>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/HttpDescription"/>
													</HttpDescription>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpDescription) gt 0">
													<HttpDescription>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpDescription"/>
													</HttpDescription>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpDescription) gt 0">
													<HttpDescription>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpDescription"/>
													</HttpDescription>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/API[@name=$apiverbandurl]/HttpDescription) gt 0">
													<HttpDescription>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/API[@name=$apiverbandurl]/HttpDescription"/>
													</HttpDescription>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpDescription) gt 0">
													<HttpDescription>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpDescription"/>
													</HttpDescription>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpDescription) gt 0">
													<HttpDescription>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpDescription"/>
													</HttpDescription>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/HttpDescription) gt 0">
													<HttpDescription>
														<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/HttpDescription"/>
													</HttpDescription>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpDescription) gt 0">
													<HttpDescription>
														<xsl:value-of select="/Maps/Map[$positionVar]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/HttpDescription"/>
													</HttpDescription>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpDescription) gt 0">
													<HttpDescription>
														<xsl:value-of select="/Maps/Map[$positionVar]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/HttpDescription"/>
													</HttpDescription>
												</xsl:when>
												<xsl:when test="string-length(/Maps/Map[$positionVar]/HttpDescription) gt 0">
													<HttpDescription>
														<xsl:value-of select="/Maps/Map[$positionVar]/HttpDescription"/>
													</HttpDescription>
												</xsl:when>
												<xsl:otherwise>
													<HttpDescription>
														<xsl:value-of select="$standardhttpcodes/httpcodes/httpcode[@code=$HttpCodeVar]"/>
													</HttpDescription>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:when>
										<xsl:otherwise>
											<HttpDescription>
												<xsl:value-of select="$standardhttpcodes/httpcodes/httpcode[@code=$HttpCodeVar]"/>
											</HttpDescription>
										</xsl:otherwise>
									</xsl:choose>
								</xsl:variable>
								<!-- compute target error code -->
								<xsl:variable name="OverrideTargetErrorCodeVar">
									<xsl:if test="string-length((/Maps/Map[$positionVar]//OverrideTargetErrorCode)[1]) gt 0">
										<xsl:choose>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetErrorCode) gt 0">
												<OverrideTargetErrorCode>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetErrorCode"/>
												</OverrideTargetErrorCode>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetErrorCode) gt 0">
												<OverrideTargetErrorCode>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetErrorCode"/>
												</OverrideTargetErrorCode>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/API[@name=$apiverbandurl]/OverrideTargetErrorCode) gt 0">
												<OverrideTargetErrorCode>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/API[@name=$apiverbandurl]/OverrideTargetErrorCode"/>
												</OverrideTargetErrorCode>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetErrorCode) gt 0">
												<OverrideTargetErrorCode>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetErrorCode"/>
												</OverrideTargetErrorCode>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetErrorCode) gt 0">
												<OverrideTargetErrorCode>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetErrorCode"/>
												</OverrideTargetErrorCode>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/OverrideTargetErrorCode) gt 0">
												<OverrideTargetErrorCode>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/OverrideTargetErrorCode"/>
												</OverrideTargetErrorCode>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetErrorCode) gt 0">
												<OverrideTargetErrorCode>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetErrorCode"/>
												</OverrideTargetErrorCode>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetErrorCode) gt 0">
												<OverrideTargetErrorCode>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetErrorCode"/>
												</OverrideTargetErrorCode>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/API[@name=$apiverbandurl]/OverrideTargetErrorCode) gt 0">
												<OverrideTargetErrorCode>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/API[@name=$apiverbandurl]/OverrideTargetErrorCode"/>
												</OverrideTargetErrorCode>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetErrorCode) gt 0">
												<OverrideTargetErrorCode>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetErrorCode"/>
												</OverrideTargetErrorCode>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetErrorCode) gt 0">
												<OverrideTargetErrorCode>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetErrorCode"/>
												</OverrideTargetErrorCode>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/OverrideTargetErrorCode) gt 0">
												<OverrideTargetErrorCode>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/OverrideTargetErrorCode"/>
												</OverrideTargetErrorCode>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetErrorCode) gt 0">
												<OverrideTargetErrorCode>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetErrorCode"/>
												</OverrideTargetErrorCode>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetErrorCode) gt 0">
												<OverrideTargetErrorCode>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetErrorCode"/>
												</OverrideTargetErrorCode>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/API[@name=$apiverbandurl]/OverrideTargetErrorCode) gt 0">
												<OverrideTargetErrorCode>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/API[@name=$apiverbandurl]/OverrideTargetErrorCode"/>
												</OverrideTargetErrorCode>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetErrorCode) gt 0">
												<OverrideTargetErrorCode>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetErrorCode"/>
												</OverrideTargetErrorCode>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetErrorCode) gt 0">
												<OverrideTargetErrorCode>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetErrorCode"/>
												</OverrideTargetErrorCode>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/OverrideTargetErrorCode) gt 0">
												<OverrideTargetErrorCode>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/OverrideTargetErrorCode"/>
												</OverrideTargetErrorCode>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetErrorCode) gt 0">
												<OverrideTargetErrorCode>
													<xsl:value-of select="/Maps/Map[$positionVar]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetErrorCode"/>
												</OverrideTargetErrorCode>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetErrorCode) gt 0">
												<OverrideTargetErrorCode>
													<xsl:value-of select="/Maps/Map[$positionVar]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetErrorCode"/>
												</OverrideTargetErrorCode>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/OverrideTargetErrorCode) gt 0">
												<OverrideTargetErrorCode>
													<xsl:value-of select="/Maps/Map[$positionVar]/OverrideTargetErrorCode"/>
												</OverrideTargetErrorCode>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/TargetErrorCodeUserMessageMap/Map/OverrideTargetErrorCode) gt 0">
												<OverrideTargetErrorCode>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/TargetErrorCodeUserMessageMap/Map/OverrideTargetErrorCode"/>
												</OverrideTargetErrorCode>
											</xsl:when>									
											<xsl:otherwise>
												<OverrideTargetErrorCode>
													<xsl:value-of select="''"/>
												</OverrideTargetErrorCode>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:if>
								</xsl:variable>
								<!-- compute target user message  -->
								<xsl:variable name="OverrideTargetUserMessageVar">
									<xsl:if test="string-length((/Maps/Map[$positionVar]//OverrideTargetUserMessage)[1]) gt 0">
										<xsl:choose>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetUserMessage) gt 0">
												<OverrideTargetUserMessage>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetUserMessage"/>
												</OverrideTargetUserMessage>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetUserMessage) gt 0">
												<OverrideTargetUserMessage>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetUserMessage"/>
												</OverrideTargetUserMessage>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/API[@name=$apiverbandurl]/OverrideTargetUserMessage) gt 0">
												<OverrideTargetUserMessage>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/API[@name=$apiverbandurl]/OverrideTargetUserMessage"/>
												</OverrideTargetUserMessage>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetUserMessage) gt 0">
												<OverrideTargetUserMessage>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetUserMessage"/>
												</OverrideTargetUserMessage>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetUserMessage) gt 0">
												<OverrideTargetUserMessage>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetUserMessage"/>
												</OverrideTargetUserMessage>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/OverrideTargetUserMessage) gt 0">
												<OverrideTargetUserMessage>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/OverrideTargetUserMessage"/>
												</OverrideTargetUserMessage>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetUserMessage) gt 0">
												<OverrideTargetUserMessage>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetUserMessage"/>
												</OverrideTargetUserMessage>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetUserMessage) gt 0">
												<OverrideTargetUserMessage>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetUserMessage"/>
												</OverrideTargetUserMessage>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/API[@name=$apiverbandurl]/OverrideTargetUserMessage) gt 0">
												<OverrideTargetUserMessage>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/API[@name=$apiverbandurl]/OverrideTargetUserMessage"/>
												</OverrideTargetUserMessage>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetUserMessage) gt 0">
												<OverrideTargetUserMessage>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetUserMessage"/>
												</OverrideTargetUserMessage>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetUserMessage) gt 0">
												<OverrideTargetUserMessage>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetUserMessage"/>
												</OverrideTargetUserMessage>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/OverrideTargetUserMessage) gt 0">
												<OverrideTargetUserMessage>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/OverrideTargetUserMessage"/>
												</OverrideTargetUserMessage>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetUserMessage) gt 0">
												<OverrideTargetUserMessage>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetUserMessage"/>
												</OverrideTargetUserMessage>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetUserMessage) gt 0">
												<OverrideTargetUserMessage>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/API[@name=$apiverbandurl]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetUserMessage"/>
												</OverrideTargetUserMessage>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/API[@name=$apiverbandurl]/OverrideTargetUserMessage) gt 0">
												<OverrideTargetUserMessage>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/API[@name=$apiverbandurl]/OverrideTargetUserMessage"/>
												</OverrideTargetUserMessage>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetUserMessage) gt 0">
												<OverrideTargetUserMessage>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetUserMessage"/>
												</OverrideTargetUserMessage>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetUserMessage) gt 0">
												<OverrideTargetUserMessage>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetUserMessage"/>
												</OverrideTargetUserMessage>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/OverrideTargetUserMessage) gt 0">
												<OverrideTargetUserMessage>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/OverrideTargetUserMessage"/>
												</OverrideTargetUserMessage>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/TargetErrorCodeUserMessageMap/Map[
											     ((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
											     (contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
											     (upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetUserMessage) gt 0">
												<OverrideTargetUserMessage>
													<xsl:value-of select="/Maps/Map[$positionVar]/TargetErrorCodeUserMessageMap/Map[
															((./TargetUserMessage/@match = 'pattern') and (matches(normalize-space($errorUserMessageVar), normalize-space(./TargetUserMessage), 'si'))) or ((./TargetUserMessage/@match = 'contains') and 
															(contains(upper-case(normalize-space($errorUserMessageVar)), upper-case(normalize-space(./TargetUserMessage))))) or 
															(upper-case(normalize-space($errorUserMessageVar)) = upper-case(normalize-space(./TargetUserMessage)))][1]/OverrideTargetUserMessage"/>
												</OverrideTargetUserMessage>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetUserMessage) gt 0">
												<OverrideTargetUserMessage>
													<xsl:value-of select="/Maps/Map[$positionVar]/TargetErrorCodeUserMessageMap/Map[
															(./TargetUserMessage = 'CATCH-ALL')][1]/OverrideTargetUserMessage"/>
												</OverrideTargetUserMessage>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/OverrideTargetUserMessage) gt 0">
												<OverrideTargetUserMessage>
													<xsl:value-of select="/Maps/Map[$positionVar]/OverrideTargetUserMessage"/>
												</OverrideTargetUserMessage>
											</xsl:when>
											<xsl:when test="string-length(/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/TargetErrorCodeUserMessageMap/Map/OverrideTargetUserMessage) gt 0">
												<OverrideTargetUserMessage>
													<xsl:value-of select="/Maps/Map[$positionVar]/CustomMap/Targets/TargetSystem[@name=$targetsystem]/Services/Service[@name=$servicename]/Operation[@name=$operationname]/TargetErrorCodeUserMessageMap/Map/OverrideTargetUserMessage"/>
												</OverrideTargetUserMessage>
											</xsl:when>		
											<xsl:otherwise>
												<OverrideTargetUserMessage>
													<xsl:value-of select="''"/>
												</OverrideTargetUserMessage>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:if>
								</xsl:variable>
								<xsl:copy-of select="$HttpCodeVar"/>
								<xsl:copy-of select="$HttpDescriptionVar"/>
								<xsl:copy-of select="$OverrideTargetErrorCodeVar"/>
								<xsl:copy-of select="$OverrideTargetUserMessageVar"/>
								<!-- <xsl:copy-of select="$OverrideTargetErrorCodeUserMessageVar"/> -->
								<!-- <xsl:copy-of select="$OverrideCatchAllTargetErrorCodeUserMessageVar"/> -->
							</Map>
						</xsl:for-each>
					</Result>
				</xsl:variable>	
				<!-- prepare output -->
				<apiError>
					<xsl:choose>
						<xsl:when test="string-length($ResultVar/Result/Map[./Code = $apiErrorVar/apiError/errors/error[1]/code][1]/HttpDescription) gt 0">
							<statusCode>
								<xsl:value-of select="$ResultVar/Result/Map[./Code = $apiErrorVar/apiError/errors/error[1]/code][1]/HttpCode"/>
							</statusCode>
							<reasonPhrase>
								<xsl:value-of select="$ResultVar/Result/Map[./Code = $apiErrorVar/apiError/errors/error[1]/code][1]/HttpDescription"/>
							</reasonPhrase>
						</xsl:when>
						<xsl:when test="string-length($ResultVar/Result/Map[./Code = 'COMMON_ERROR_CODE_KEY'][1]/HttpDescription) gt 0">
							<statusCode>
								<xsl:value-of select="$ResultVar/Result/Map[./Code = 'COMMON_ERROR_CODE_KEY'][1]/HttpCode"/>
							</statusCode>
							<reasonPhrase>
								<xsl:value-of select="$ResultVar/Result/Map[./Code = 'COMMON_ERROR_CODE_KEY'][1]/HttpDescription"/>
							</reasonPhrase>
						</xsl:when>
						<xsl:otherwise>
							<statusCode>503</statusCode>
							<reasonPhrase>Service Unavailable</reasonPhrase>
						</xsl:otherwise>
					</xsl:choose>
					<errors>
						<xsl:for-each select="$apiErrorVar/apiError/errors/error">
							<xsl:variable name="codeVar" select="./code"/>
							<xsl:variable name="userMessageVar" select="./userMessage"/>
							<xsl:variable name="systemMessageVar" select="./systemMessage"/>
							<error>
								<xsl:choose>
									<xsl:when test="(string-length($ResultVar/Result/Map[./Code = $codeVar][1]/OverrideTargetErrorCode) gt 0)  and (not($ResultVar/Result/Map[./Code = $codeVar][1]/OverrideTargetErrorCode = 'USE_BACKEND_VALUE'))">
										<code>
											<xsl:value-of select="$ResultVar/Result/Map[./Code = $codeVar][1]/OverrideTargetErrorCode"/>
										</code>
									</xsl:when>
									<xsl:when test="(not(exists($ResultVar/Result/Map[./Code = $codeVar][1]))) and (string-length($ResultVar/Result/Map[./Code = 'COMMON_ERROR_CODE_KEY'][1]/OverrideTargetErrorCode) gt 0)  and (not($ResultVar/Result/Map[./Code = 'COMMON_ERROR_CODE_KEY'][1]/OverrideTargetErrorCode = 'USE_BACKEND_VALUE'))">
										<code>
											<xsl:value-of select="$ResultVar/Result/Map[./Code = 'COMMON_ERROR_CODE_KEY'][1]/OverrideTargetErrorCode"/>
										</code>
									</xsl:when>
									<xsl:otherwise>
										<code>
											<xsl:value-of select="$codeVar"/>
										</code>
									</xsl:otherwise>
								</xsl:choose>
								<xsl:choose>
									<xsl:when test="(string-length($ResultVar/Result/Map[./Code = $codeVar][1]/OverrideTargetUserMessage) gt 0) and (not($ResultVar/Result/Map[./Code = $codeVar][1]/OverrideTargetUserMessage = 'USE_BACKEND_VALUE'))">
										<userMessage>
											<xsl:value-of select="$ResultVar/Result/Map[./Code = $codeVar][1]/OverrideTargetUserMessage"/>
										</userMessage>
									</xsl:when>
									<xsl:when test="(not(exists($ResultVar/Result/Map[./Code = $codeVar][1]))) and (string-length($ResultVar/Result/Map[./Code = 'COMMON_ERROR_CODE_KEY'][1]/OverrideTargetUserMessage) gt 0) and (not($ResultVar/Result/Map[./Code = 'COMMON_ERROR_CODE_KEY'][1]/OverrideTargetUserMessage = 'USE_BACKEND_VALUE'))">
										<userMessage>
											<xsl:value-of select="$ResultVar/Result/Map[./Code = 'COMMON_ERROR_CODE_KEY'][1]/OverrideTargetUserMessage"/>
										</userMessage>
									</xsl:when>
									<xsl:otherwise>
										<xsl:copy-of select="$userMessageVar"/>
									</xsl:otherwise>
								</xsl:choose>
								<systemMessage>
									<xsl:value-of select="concat($systemMessageVar, ' :USER-MESSAGE:- ', $userMessageVar)"/>
								</systemMessage>
							</error>
						</xsl:for-each>
					</errors>
				</apiError>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


</xsl:stylesheet>
