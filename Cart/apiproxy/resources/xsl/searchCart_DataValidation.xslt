<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:strip-space elements="*"/>
	<xsl:variable name="search" select="searchCriteria"/>
	<xsl:param name="authfinancialaccountid"/>
	<xsl:param name="tokenScope"/>

	<xsl:template match="/">
		<apiError>
			<statusCode>
				<xsl:value-of select="&quot;400&quot;"/>
			</statusCode>
			<reasonPhrase>
				<xsl:value-of select="&quot;Bad Request&quot;"/>
			</reasonPhrase>
			<errors>
				<xsl:choose>
					<xsl:when
						test="
							(string-length(normalize-space($search/cartId/text())) + string-length(normalize-space($search/customerId/text())) + string-length(normalize-space($search/emailAddress/text())) + string-length(normalize-space($search/phoneNumber/text()))
							+ string-length(normalize-space($search/changeOfResponsibility/receiverEmailAddress/text())) + string-length(normalize-space($search/changeOfResponsibility/receiverMSISDN/text())) + string-length(normalize-space($search/userId/text())) + string-length(normalize-space($search/dealerCode/text())) + string-length(normalize-space($search/firstName/text()))
							+ string-length(normalize-space($search/lastName/text())) + string-length(normalize-space($search/cartDate/text())) + string-length(normalize-space($search/taxId/text())) + string-length(normalize-space($search/SSN/text())) + string-length(normalize-space($search/financialAccountNumber/text())) = 0)">
						<error>
							<code>
								<xsl:value-of select="&quot;GENERAL-0001&quot;"/>
							</code>
							<userMessage>
								<xsl:value-of select="&quot;Input Data Invalid&quot;"/>
							</userMessage>
							<systemMessage>
								<xsl:value-of
									select="&quot;Input should atleast one searchCriteria&quot;"/>
							</systemMessage>
						</error>
					</xsl:when>
					
					<xsl:when test="$tokenScope = 'logged-in' and ($authfinancialaccountid != '' and $search/financialAccountNumber/text() != '' and $authfinancialaccountid != $search/financialAccountNumber/text())">
							<error>
								<code>
									<xsl:value-of select="&quot;SECURITY-0054&quot;"/>
								</code>
								<userMessage>
									<xsl:value-of select="&quot;Insufficient permission on the requested Financial Account&quot;"/>
								</userMessage>
								<systemMessage>
									<xsl:value-of select="&quot;Insufficient permission on the requested Financial Account&quot;" />
								</systemMessage>
							</error>
					</xsl:when>
				</xsl:choose>
			</errors>
		</apiError>
	</xsl:template>
</xsl:stylesheet>
