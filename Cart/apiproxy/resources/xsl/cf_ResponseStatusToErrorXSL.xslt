<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
xmlns:base="http://services.tmobile.com/base"
xmlns:base1="http://service.tmobile.com/base"
xmlns:base2="http://esp.t-mobile.com/base"
xmlns:base3="http://esp.t-mobile.com/cso"
xmlns:sdo="http://retail.tmobile.com/sdo"
exclude-result-prefixes="xsl base base1 base2 soapenv sdo">
	<xsl:variable name="varResponseStatus" select="/soapenv:Envelope/soapenv:Body/*/base:responseStatus/base:detail"/>
	<xsl:variable name="varFault" select="/soapenv:Envelope/soapenv:Body/soapenv:Fault"/>
	<xsl:variable name="varResponseStatus1" select="/soapenv:Envelope/soapenv:Body/*/base1:responseStatus/base1:detail"/>
	<xsl:variable name="varResponseStatus2" select="/soapenv:Envelope/soapenv:Body/*/base2:responseStatus/base2:detail"/>
	<xsl:variable name="varResponseStatus3" select="/soapenv:Envelope/soapenv:Body/*/base3:responseStatus/base3:detail"/>
	<xsl:variable name="varRSPResponseStatus" select="/soapenv:Envelope/soapenv:Body/*/sdo:serviceStatus/sdo:serviceStatusItem"/>

	<xsl:template match="/">

		<apiError>
			<xsl:choose>
				<xsl:when test="count($varResponseStatus)>0">
					<count>
						<xsl:value-of select="count($varResponseStatus)"/>
					</count>		
				</xsl:when>
				<xsl:when test="count($varResponseStatus1)>0">
					<count>
						<xsl:value-of select="count($varResponseStatus1)"/>
					</count>		
				</xsl:when>
				<xsl:when test="count($varResponseStatus2)>0">
					<count>
						<xsl:value-of select="count($varResponseStatus2)"/>
					</count>		
				</xsl:when>
				<xsl:when test="count($varFault)>0">
					<count>
						<xsl:value-of select="count($varFault)"/>
					</count>
				</xsl:when>
				<xsl:when test="count($varRSPResponseStatus)>0">
					<count>
						<xsl:value-of select="count($varRSPResponseStatus)"/>
					</count>
				</xsl:when>
				<xsl:otherwise>
					<count>
						<xsl:value-of select="0"/>
					</count>		
					<statusCode>
						<xsl:value-of select="500"/>
					</statusCode>
				</xsl:otherwise>
			</xsl:choose>
			<errors>	
				<xsl:for-each select="$varFault">
					<error>
						<code>
							<xsl:value-of select="faultcode"/>
						</code>
						<xsl:if test="faultstring">
							<userMessage>
								<xsl:value-of select="faultstring"/>
							</userMessage>
						</xsl:if>
						<systemMessage>
							<xsl:value-of select="faultcode"/>
						</systemMessage>
					</error>
				</xsl:for-each>
				<xsl:for-each select="$varResponseStatus">
					<error>
						<code>
							<xsl:value-of select="@subStatusCode"/>
						</code>
						<xsl:if test="base:definition">
							<userMessage>
								<xsl:choose>
									<xsl:when test="contains(base:definition,'DESCRIPTION:')">
										<xsl:value-of select="substring-after(base:definition, 'DESCRIPTION:')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="base:explanation"/>
									</xsl:otherwise>
								</xsl:choose>

							</userMessage>
							<systemMessage>
								<xsl:choose>
									<xsl:when test="contains(base:definition,'DESCRIPTION:')">
										<xsl:value-of select="substring-before(base:definition, 'DESCRIPTION:')"/>
										<xsl:if test="base:explanation">
											<xsl:value-of select="base:explanation"/>
										</xsl:if>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="base:definition"/>
									</xsl:otherwise>
								</xsl:choose>
							</systemMessage>
						</xsl:if>
					</error>
				</xsl:for-each>
				<xsl:for-each select="$varResponseStatus1">
					<error>
						<code>
							<xsl:value-of select="@subStatusCode"/>
						</code>
						<xsl:if test="base1:definition">
							<userMessage>
								<xsl:choose>
									<xsl:when test="contains(base1:definition,'DESCRIPTION:')">
										<xsl:value-of select="substring-after(base1:definition, 'DESCRIPTION:')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="base1:explanation"/>
									</xsl:otherwise>
								</xsl:choose>

							</userMessage>
							<systemMessage>
								<xsl:choose>
									<xsl:when test="contains(base1:definition,'DESCRIPTION:')">
										<xsl:value-of select="substring-before(base1:definition, 'DESCRIPTION:')"/>
										<xsl:if test="base1:explanation">
											<xsl:value-of select="base1:explanation"/>
										</xsl:if>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="base1:definition"/>
									</xsl:otherwise>
								</xsl:choose>
							</systemMessage>
						</xsl:if>
					</error>
				</xsl:for-each>
				<xsl:for-each select="$varResponseStatus2">
					<error>
						<code>
							<xsl:value-of select="@subStatusCode"/>
						</code>
						<xsl:if test="base2:definition">
							<userMessage>
								<xsl:choose>
									<xsl:when test="contains(base2:definition,'DESCRIPTION:')">
										<xsl:value-of select="substring-after(base1:definition, 'DESCRIPTION:')"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="base2:explanation"/>
									</xsl:otherwise>
								</xsl:choose>

							</userMessage>
							<systemMessage>
								<xsl:choose>
									<xsl:when test="contains(base2:definition,'DESCRIPTION:')">
										<xsl:value-of select="substring-before(base2:definition, 'DESCRIPTION:')"/>
										<xsl:if test="base2:explanation">
											<xsl:value-of select="base2:explanation"/>
										</xsl:if>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="base2:definition"/>
									</xsl:otherwise>
								</xsl:choose>
							</systemMessage>
						</xsl:if>
					</error>
				</xsl:for-each>
				<xsl:for-each select="$varResponseStatus3">
					<error>
						<code>
							<xsl:value-of select="@subStatusCode"/>
						</code>
						<xsl:if test="base3:explanation">
							<userMessage>
								<xsl:value-of select="base3:serviceTrace/base3:description"/>
							</userMessage>
							<systemMessage>
								<xsl:value-of select="base3:explanation"/>
							</systemMessage>
						</xsl:if>
					</error>
				</xsl:for-each>
				<xsl:for-each select="$varRSPResponseStatus">
					<error>
						<code>
							<xsl:value-of select="sdo:statusCode"/>
						</code>
						<xsl:if test="sdo:statusDescription">
							<userMessage>
								<xsl:value-of select="sdo:statusDescription"/>
							</userMessage>
						</xsl:if>
						<xsl:if test="sdo:explanation">
							<systemMessage>
								<xsl:value-of select="sdo:explanation"/>
							</systemMessage>
						</xsl:if>
					</error>
				</xsl:for-each>					
			</errors>
		</apiError>
	</xsl:template>
</xsl:stylesheet>
