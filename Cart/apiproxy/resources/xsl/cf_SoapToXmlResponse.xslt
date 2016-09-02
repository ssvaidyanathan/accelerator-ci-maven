<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
	exclude-result-prefixes="soapenv">
	<xsl:output method="xml" indent="yes" />
	<xsl:strip-space elements="*" />

	<xsl:template match="/">
		<xsl:copy-of select="/soapenv:Envelope/soapenv:Body/*" />
	</xsl:template>
</xsl:stylesheet>