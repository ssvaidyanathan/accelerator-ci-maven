<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:v1="http://services.tmobile.com/OrderManagement/CartWSIL/V1"
    xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:base="http://services.tmobile.com/base" exclude-result-prefixes="v1 base soapenv">
   
    <xsl:output method="xml" indent="no" encoding="UTF-8" version="1.0" omit-xml-declaration="yes"/>
    
    <xsl:param name="acceptType"/>

    <xsl:template match="/">
        <xsl:variable name="varResponse" select="soapenv:Envelope/soapenv:Body/v1:getCartDetailsResponse/v1:cart"/>	        
        <cart>
            <xsl:apply-templates select="$varResponse/v1:status"/>
        </cart>
    </xsl:template>

    <xsl:template match="v1:status">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="@statusCode"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:*">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()} ">
                <xsl:apply-templates select="@*|node()"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
