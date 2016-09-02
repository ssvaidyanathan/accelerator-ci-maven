<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:param name="partnerId"/>
    <xsl:param name="requestId"/>
    <xsl:param name="partnerTransactionId"/>
    <xsl:param name="application"/>
    <xsl:param name="channel"/>
    <xsl:param name="storeId"/>
    <xsl:param name="dealerCode"/>
    <xsl:param name="masterDealerCode"/>
    <xsl:output omit-xml-declaration="yes"/>
    <xsl:template match="/">
			<Envelope
				xmlns="http://schemas.xmlsoap.org/soap/envelope/">
				<Header/>
				<Body>
					<userProfilesAndPermissionsRequest
						xmlns="http://retail.tmobile.com/sdo">
						<header>
							<partnerId><xsl:value-of select="(if (string-length($partnerId) gt 0) then $partnerId else 'RETAILDIRECT')"/></partnerId>
							<requestId><xsl:value-of select="(if (string-length($requestId) gt 0) then $requestId else '1234512345')"/></requestId>
							<partnerTransactionId><xsl:value-of select="(if (string-length($partnerTransactionId) gt 0) then $partnerTransactionId else '3898700245929543859-2')"/></partnerTransactionId>
							<partnerTimestamp><xsl:value-of select="current-dateTime()"/></partnerTimestamp>
							<application><xsl:value-of select="(if (string-length($application) gt 0) then $application else 'API')"/></application>
							<channel><xsl:value-of select="(if (string-length($channel) gt 0) then $channel else 'direct')"/></channel>
							<storeId><xsl:value-of select="(if (string-length($storeId) gt 0) then $storeId else '1988')"/></storeId>
							<dealerCode><xsl:value-of select="(if (string-length($dealerCode) gt 0) then $dealerCode else '3501486')"/></dealerCode>
						</header>
						<masterDealerCode><xsl:value-of select="(if (string-length($masterDealerCode) gt 0) then $masterDealerCode else '3501486')"/></masterDealerCode>
					</userProfilesAndPermissionsRequest>
				</Body>
			</Envelope>
    </xsl:template>
</xsl:stylesheet>
