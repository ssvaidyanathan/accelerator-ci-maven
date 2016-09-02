<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:param name="faultName"/>
	<xsl:param name="jsonAttakFailed"/>
	<xsl:param name="xmlAttakFailed"/>
	
	<xsl:template match="/" >
		<xsl:choose>
			<xsl:when test="$faultName=&quot;InvalidAccessToken&quot; or $faultName = &quot;InvalidApiKey&quot; or $faultName = &quot;InvalidBasicAuthenticationSource&quot;">
				<apiError>
					<statusCode>
						<xsl:value-of select="401"/>
					</statusCode>
					<reasonPhrase>
						<xsl:value-of select="&quot;Unauthorized&quot;"/>
					</reasonPhrase>
					<errors>
						<error>
							<code>
								<xsl:value-of select="&quot;InvalidAccessToken&quot;"/>
							</code>
							<userMessage>
								<xsl:value-of select="&quot;oauth.v2.InvalidAccessToken: Invalid access token&quot;"/>
							</userMessage>
						</error>
					</errors>
				</apiError>
			</xsl:when>
			<xsl:when test="$faultName=&quot;SourceMessageNotAvailable&quot;">
				<apiError>
					<statusCode>
						<xsl:value-of select="401"/>
					</statusCode>
					<reasonPhrase>
						<xsl:value-of select="&quot;Extrave Variable Reference Not Found&quot;"/>
					</reasonPhrase>
					<errors>
						<error>
							<code>
								<xsl:value-of select="&quot;POL0001&quot;"/>
							</code>
							<userMessage>
								<xsl:value-of select="&quot;The variable could not be extracted&quot;"/>
							</userMessage>
						</error>
					</errors>
				</apiError>
			</xsl:when>
			<xsl:when test="$faultName= &quot;SetVariableFailed&quot;">
				<apiError>
					<statusCode>
						<xsl:value-of select="401"/>
					</statusCode>
					<reasonPhrase>
						<xsl:value-of select="&quot;Variable Reference Not Found&quot;"/>
					</reasonPhrase>
					<errors>
						<error>
							<code>
								<xsl:value-of select="&quot;POL0002&quot;"/>
							</code>
							<userMessage>
								<xsl:value-of select="&quot;The variable could not be assigned&quot;"/>
							</userMessage>
						</error>
					</errors>
				</apiError>
			</xsl:when>
			<xsl:when test="$faultName= &quot;SetVariableFailed&quot;">
				<apiError>
					<statusCode>
						<xsl:value-of select="401"/>
					</statusCode>
					<reasonPhrase>
						<xsl:value-of select="&quot;Bad or Missing API Key&quot;"/>
					</reasonPhrase>
					<errors>
						<error>
							<code>
								<xsl:value-of select="&quot;POL0004&quot;"/>
							</code>
							<userMessage>
								<xsl:value-of select="&quot;Apikey verification failed - Invalid ApiKey&quot;"/>
							</userMessage>
						</error>
					</errors>
				</apiError>
			</xsl:when>
			<xsl:when test="$faultName= &quot;InvalidAPICallAsNoApiProductMatchFound&quot;">
				<apiError>
					<statusCode>
						<xsl:value-of select="401"/>
					</statusCode>
					<reasonPhrase>
						<xsl:value-of select="&quot;Unauthorized&quot;"/>
					</reasonPhrase>
					<errors>
						<error>
							<code>
								<xsl:value-of select="&quot;POL0005&quot;"/>
							</code>
							<userMessage>
								<xsl:value-of select="&quot;Privacy verification failed - Invalid App Details&quot;"/>
							</userMessage>
						</error>
					</errors>
				</apiError>
			</xsl:when>
			<xsl:when test="$faultName= &quot;invalid_access_token&quot;">
				<apiError>
					<statusCode>
						<xsl:value-of select="401"/>
					</statusCode>
					<reasonPhrase>
						<xsl:value-of select="&quot;Unauthorized&quot;"/>
					</reasonPhrase>
					<errors>
						<error>
							<code>
								<xsl:value-of select="&quot;POL0006&quot;"/>
							</code>
							<userMessage>
								<xsl:value-of select="&quot;Privacy verification failed - Invalid Access Token&quot;"/>
							</userMessage>
						</error>
					</errors>
				</apiError>
			</xsl:when>
			<xsl:when test="$faultName= &quot;access_token_expired&quot;">
				<apiError>
					<statusCode>
						<xsl:value-of select="401"/>
					</statusCode>
					<reasonPhrase>
						<xsl:value-of select="&quot;Unauthorized&quot;"/>
					</reasonPhrase>
					<errors>
						<error>
							<code>
								<xsl:value-of select="&quot;POL0007&quot;"/>
							</code>
							<userMessage>
								<xsl:value-of select="&quot;Privacy verification failed - Access Token Expired&quot;"/>
							</userMessage>
						</error>
					</errors>
				</apiError>
			</xsl:when>
			<xsl:when test="$faultName= &quot;JsonPathParsingFailure&quot;  or $jsonAttakFailed = &quot;true&quot; or $xmlAttakFailed = &quot;true&quot;">
				<apiError>
					<statusCode>
						<xsl:value-of select="400"/>
					</statusCode>
					<reasonPhrase>
						<xsl:value-of select="&quot;Bad Request&quot;"/>
					</reasonPhrase>
					<errors>
						<error>
							<code>
								<xsl:value-of select="&quot;SVC0010&quot;"/>
							</code>
							<userMessage>
								<xsl:value-of select="&quot;Invalid Input Value - Payload&quot;"/>
							</userMessage>
						</error>
					</errors>
				</apiError>
			</xsl:when>
			<xsl:when test="$faultName= &quot;SpikeArrestViolation&quot;">
				<apiError>
					<statusCode>
						<xsl:value-of select="503"/>
					</statusCode>
					<reasonPhrase>
						<xsl:value-of select="&quot;Server Busy&quot;"/>
					</reasonPhrase>
					<errors>
						<error>
							<code>
								<xsl:value-of select="&quot;SVC0008&quot;"/>
							</code>
							<userMessage>
								<xsl:value-of select="&quot;Service Error - System Has Exceeded Maximum Number of Permitted Requests&quot;"/>
							</userMessage>
						</error>
					</errors>
				</apiError>
			</xsl:when>
			<xsl:when test="$faultName= &quot;QuotaViolation&quot;">
				<apiError>
					<statusCode>
						<xsl:value-of select="503"/>
					</statusCode>
					<reasonPhrase>
						<xsl:value-of select="&quot;Server Busy&quot;"/>
					</reasonPhrase>
					<errors>
						<error>
							<code>
								<xsl:value-of select="&quot;SVC0009&quot;"/>
							</code>
							<userMessage>
								<xsl:value-of select="&quot;Service Error - The client app has exceeded maximum number of permitted requests&quot;"/>
							</userMessage>
						</error>
					</errors>
				</apiError>
			</xsl:when>
			<xsl:when test="$faultName= &quot;ExecutionFailed&quot;">
				<apiError>
					<statusCode>
						<xsl:value-of select="502"/>
					</statusCode>
					<reasonPhrase>
						<xsl:value-of select="&quot;Service Call out Failed&quot;"/>
					</reasonPhrase>
					<errors>
						<error>
							<code>
								<xsl:value-of select="&quot;SVC0011&quot;"/>
							</code>
							<userMessage>
								<xsl:value-of select="&quot;Service Error - Remote System could not be reached&quot;"/>
							</userMessage>
						</error>
					</errors>
				</apiError>
			</xsl:when>
			<xsl:otherwise>
				<apiError>
					<statusCode>
						<xsl:value-of select="500"/>
					</statusCode>
					<reasonPhrase>
						<xsl:value-of select="&quot;Internal Server Error&quot;"/>
					</reasonPhrase>
					<errors>
						<error>
							<code>
								<xsl:value-of select="&quot;SVC0012&quot;"/>
							</code>
							<userMessage>
								<xsl:value-of select="&quot;Service Error - The server encountered an error while attempting to fulfill the request.&quot;"/>
							</userMessage>
						</error>
					</errors>
				</apiError>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>
