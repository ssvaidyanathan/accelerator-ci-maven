<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:v1="http://services.tmobile.com/OrderManagement/CartWSIL/V1"
	xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:base="http://services.tmobile.com/base"
	exclude-result-prefixes="v1 base xs soapenv">
		
	<xsl:param name="acceptType"/>
	<xsl:param name="pARRAY" select="'~ARRAY~'"/>
	<xsl:param name="pINTEGER" select="'~INT~'"/>

	<xsl:output method="xml" indent="no" encoding="UTF-8" version="1.0" omit-xml-declaration="yes"/>
	
	<xsl:template match="/">
		<xsl:variable name="varResponse" select="soapenv:Envelope/soapenv:Body/v1:updateCartResponse"/>
		<xsl:apply-templates select="$varResponse/v1:cart"/>
	</xsl:template>



	<xsl:template match="v1:*">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()} ">
				<xsl:apply-templates select="@* | node()"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:cart">
		<xsl:if test="normalize-space(.) != ''">
			<cart>
				<xsl:apply-templates select="v1:freightCharge"/>
			</cart>
		</xsl:if>
	</xsl:template>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
