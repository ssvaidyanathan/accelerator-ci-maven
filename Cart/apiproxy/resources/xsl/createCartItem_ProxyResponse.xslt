<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ns1="http://services.tmobile.com/OrderManagement/CartWSIL/V1"
	xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
	xmlns:ns0="http://services.tmobile.com/base" version="1.0"
	exclude-result-prefixes="ns1 ns0 soapenv">
	
	<xsl:param name="productOfferingIdRequest"/>
	<xsl:param name="lineOfServiceIdRequest"/>
	<xsl:param name="assignedProductIdRequest"/>
	
	<xsl:output method="xml" indent="no" encoding="UTF-8" version="1.0" omit-xml-declaration="yes"/>
	
	<xsl:template match="/">
		<xsl:variable name="varResponse" select="soapenv:Envelope/soapenv:Body"/>
		<xsl:apply-templates select="$varResponse/ns1:updateCartResponse"/>
	</xsl:template>
	
	<xsl:template match="ns1:updateCartResponse">
		<createCartItemResponse>			
			<statusCode>
				<xsl:value-of select="ns0:responseStatus/@code"/>
			</statusCode> 
			
			<cart>
				<xsl:if test="ns1:cart/@cartId">
					<cartId>
						<xsl:value-of select="ns1:cart/@cartId"/> 
					</cartId>
				</xsl:if>
				
				<xsl:for-each select="ns1:cart/ns1:cartItem">
					<xsl:choose>
						<xsl:when test="ns1:productOffering">
							<xsl:if test="ns1:productOffering/@productOfferingId = $productOfferingIdRequest">
								<cartItemId>
									<xsl:value-of select="@cartItemId"/>
								</cartItemId>
							</xsl:if>
						</xsl:when>
						<xsl:when test="ns1:lineOfService">
							<xsl:if test="ns1:lineOfService/@lineOfServiceId = $lineOfServiceIdRequest">
								<cartItemId>
									<xsl:value-of select="@cartItemId"/>
								</cartItemId>
							</xsl:if>
						</xsl:when>
						<xsl:when test="ns1:assignedProduct">
							<xsl:if test="ns1:assignedProduct/@assignedProductId = $assignedProductIdRequest">
								<cartItemId>
									<xsl:value-of select="@cartItemId"/>
								</cartItemId>
							</xsl:if>
						</xsl:when>
					</xsl:choose>
				</xsl:for-each>
			</cart>
		</createCartItemResponse>
	</xsl:template>
</xsl:stylesheet>