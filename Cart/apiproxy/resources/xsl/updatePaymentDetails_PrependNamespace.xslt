<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:v1="http://services.tmobile.com/OrderManagement/OrderCheckoutEnterprise/V1.0">
    <xsl:output method="xml" indent="yes" encoding="UTF-8" version="1.0"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="node()[string-length(normalize-space(name())) > 0]">
        <xsl:element name="{concat('v1:',name())}">           
            <xsl:apply-templates select="@*|node()"/>            
        </xsl:element>
    </xsl:template>
    <xsl:template match="@*">
        <xsl:attribute name="{name()}">
            <xsl:value-of select="."/>
        </xsl:attribute>
    </xsl:template>
</xsl:stylesheet>