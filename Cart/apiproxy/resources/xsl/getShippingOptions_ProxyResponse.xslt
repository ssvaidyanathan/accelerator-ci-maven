<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:v1="http://services.tmobile.com/OrderManagement/CartWSIL/V1"
	xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
	xmlns:base="http://services.tmobile.com/base" exclude-result-prefixes="xsl v1 base soapenv">
	
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no" omit-xml-declaration="yes"/>

	<xsl:param name="acceptType"/>
	<xsl:param name="pARRAY" select="'~ARRAY~'"/>
	<xsl:param name="pINTEGER" select="'~INT~'"/>
	<xsl:param name="pBOOLEAN" select="'~INT~'"/>

	<xsl:template match="/">
		<xsl:variable name="varResponse" select="soapenv:Envelope/soapenv:Body/v1:getShippingOptionsResponse"/>	
		<getShippingOptionsResponse>
			<xsl:apply-templates select="$varResponse/v1:shippingMethods"/>
			<xsl:apply-templates select="$varResponse/v1:inventoryInfo"/>
		</getShippingOptionsResponse>
	</xsl:template>

	<xsl:template match="v1:shippingMethods">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:description"/>
				<xsl:apply-templates select="v1:serviceLevelCode"/>
				<xsl:apply-templates select="v1:freightCarrier"/>
				<xsl:apply-templates select="v1:shippingCharge"/>
				<xsl:apply-templates select="v1:isDiscountEligible"/>
				<xsl:apply-templates select="v1:isWaiveEligible"/>
				<xsl:apply-templates select="v1:taxExclusive"/>
				<xsl:apply-templates select="v1:numberOfDays"/>
				<xsl:apply-templates select="v1:chargeCode"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:inventoryInfo">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:inventoryItem"/>
			</xsl:element>
		</xsl:if>
		<xsl:if test="not(contains($acceptType, 'xml'))">
			<xsl:element name="{local-name()}">
				<xsl:value-of select="$pARRAY"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:inventoryItem">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:sku"/>
				<xsl:apply-templates select="v1:inventoryStatus"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:inventoryStatus">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:estimatedAvailable"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:estimatedAvailable">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:startDate"/>
				<xsl:apply-templates select="v1:endDate"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:shippingCharge">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="@*"/>
				<xsl:choose>
					<xsl:when test="not(contains($acceptType, 'xml'))">
						<xsl:value-of select="concat($pINTEGER,.,$pINTEGER)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:numberOfDays">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:choose>
					<xsl:when test="not(contains($acceptType, 'xml'))">
						<xsl:value-of select="concat($pINTEGER,.,$pINTEGER)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:isDiscountEligible | v1:isWaiveElgiible |v1:taxExclusive">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="@*"/>
				<xsl:choose>
					<xsl:when test="not(contains($acceptType, 'xml'))">
						<xsl:value-of select="concat($pBOOLEAN,.,$pBOOLEAN)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
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
