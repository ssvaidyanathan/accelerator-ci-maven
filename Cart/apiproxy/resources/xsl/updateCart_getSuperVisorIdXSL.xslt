<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:v1="http://services.tmobile.com/OrderManagement/CartWSIL/V1"
	xmlns:base="http://services.tmobile.com/base" version="2.0" xmlns:saxon="http://saxon.sf.net/"
	exclude-result-prefixes="saxon">


	<xsl:output method="xml" indent="yes" encoding="ISO-8859-1" version="1.0"
		omit-xml-declaration="yes"/>
	<xsl:strip-space elements="*"/>

	<xsl:template match="/">
		
	 	<xsl:apply-templates select="cart/cartItem/cartSchedule/cartScheduleCharge"/>

	</xsl:template>

	<!-- CD3D.1 -->
	<xsl:template match="cart/cartItem/cartSchedule/cartScheduleCharge">
	  <xsl:variable name="supervisorid">
		<xsl:if test="supervisorID">
			<xsl:value-of select="concat(',',supervisorID,'~')"/>
		</xsl:if >
	  </xsl:variable>	
	  <xsl:if test="normalize-space($supervisorid) != ''">
            <xsl:copy-of select="$supervisorid"/>
        	<xsl:if  test="description[@usageContext='transactionId']">
				<xsl:value-of select="description"/>
	  		</xsl:if>
      </xsl:if> 
	  
	</xsl:template>
</xsl:stylesheet>
