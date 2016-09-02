<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:v1="http://services.tmobile.com/OrderManagement/OrderCheckoutEnterprise/V1.0"
    xmlns:base="http://service.tmobile.com/base" exclude-result-prefixes="v1 base ">

	<xsl:output method="xml" indent="yes" version="1.0" encoding="UTF-8"/>
	<xsl:param name="pARRAY"/>
	<xsl:param name="acceptType"/>
	<xsl:strip-space elements="*"/>

	<xsl:template match="/">
		<xsl:apply-templates select="//v1:order"/>
	</xsl:template>

	<xsl:template match="v1:order">
		<xsl:if test="normalize-space(.) != '' or @orderId != ''">
			<xsl:element name="cart">
				<xsl:if test="@orderId !=''">
					<xsl:attribute name="cartId">
						<xsl:value-of select="@orderId"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:apply-templates select="v1:fraudCheckStatus"/>
				<xsl:apply-templates select="v1:orderStatus"/>
				<xsl:apply-templates select="v1:orderLine"/>
				<xsl:apply-templates select="v1:orderPayment"/>
			</xsl:element>

		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:fraudCheckStatus">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:name"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:orderLine">
		<xsl:if test="normalize-space(.) != '' or @orderLineId != ''">
			<xsl:element name="cartItem">
				<xsl:if test="@orderLineId !=''">
					<xsl:attribute name="cartItemId">
						<xsl:value-of select="@orderLineId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:specificationGroup"/>
				<xsl:apply-templates select="v1:inventoryStatus"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:specificationGroup">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<!-- <xsl:apply-templates select="@*"/>-->
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:specificationValue"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:specificationValue">
		<xsl:if test="normalize-space(.) != '' or @name != ''">
			<xsl:element name="{local-name()}">
				<xsl:if test="@name !=''">
					<xsl:attribute name="name" select="@name"/>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:inventoryStatus">
		<xsl:if test="v1:estimatedAvailable/v1:startDate != '' or @statusCode !=''">
			<xsl:element name="inventoryStatus">
				<xsl:if test="@statusCode !=''">
					<xsl:attribute name="statusCode" select="@statusCode"/>
				</xsl:if>
				<xsl:if test="v1:estimatedAvailable/v1:startDate != ''">
					<estimatedAvailable>
						<startDate>
							<xsl:value-of select="v1:estimatedAvailable/v1:startDate/text()"/>
						</startDate>
					</estimatedAvailable>
				</xsl:if>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:status">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="status">
				<xsl:apply-templates select="v1:name"/>
				<xsl:apply-templates select="v1:description"/>
				<xsl:apply-templates select="v1:reasonCode"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:orderStatus">
        <xsl:if test="normalize-space(.) != ''">
            <xsl:element name="status">
                <xsl:apply-templates select="v1:name"/>
                <xsl:apply-templates select="v1:description"/>
                <xsl:apply-templates select="v1:reasonCode"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

	

		<xsl:template match="v1:description">
			<xsl:if test="normalize-space(.) != '' or @usageContext">
				<description>                
					<xsl:if test="@usageContext">
						<xsl:attribute name="usageContext">
							<xsl:value-of select="@usageContext"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="."/>
				</description>       
				<xsl:if test="not(contains($acceptType, 'xml'))">
					<xsl:element name="{local-name()}">
						<xsl:value-of select="$pARRAY"/>
					</xsl:element>
				</xsl:if>
			</xsl:if>
		</xsl:template>

		<xsl:template match="v1:orderPayment">
			<xsl:if test="normalize-space(.) != ''">
				<xsl:element name="payment">
					<xsl:apply-templates select="v1:paymentMethodCode"/>
					<xsl:apply-templates select="v1:receivedPaymentId"/>
					<xsl:apply-templates select="v1:status"/>
					<xsl:apply-templates select="v1:creditCardPayment"/>
					<xsl:apply-templates select="v1:debitCardPayment"/>
				</xsl:element>
			</xsl:if>
		</xsl:template>

		<xsl:template match="v1:creditCardPayment">
			<xsl:if test="normalize-space(.) != ''">
				<xsl:element name="{local-name()}">
					<xsl:apply-templates select="v1:creditChargeAuthorizationResponse"/>
					<!--xsl:apply-templates select="v1:authorizedAmount"/>-->
					<xsl:apply-templates select="v1:authorizationId"/>
					<xsl:apply-templates select="v1:creditCard"/>
				</xsl:element>
			</xsl:if>
		</xsl:template>

		<xsl:template match="v1:debitCardPayment">
			<xsl:if test="normalize-space(.) != ''">
				<xsl:element name="{local-name()}">
					<xsl:apply-templates select="v1:debitChargeAuthorizationResponse"/>
					<xsl:apply-templates select="v1:authorizationId"/>
					<xsl:apply-templates select="v1:debitCard"/>
				</xsl:element>
			</xsl:if>
		</xsl:template>

		<xsl:template match="v1:creditChargeAuthorizationResponse">
			<xsl:if test="normalize-space(.) != ''">
				<xsl:element name="{local-name()}">
					<xsl:apply-templates select="v1:authorizedAmount"/>
				</xsl:element>
			</xsl:if>
		</xsl:template>

		<xsl:template match="v1:debitChargeAuthorizationResponse">
			<xsl:if test="normalize-space(.) != ''">
				<xsl:element name="{local-name()}">
					<xsl:apply-templates select="v1:authorizedAmount"/>
					<xsl:apply-templates select="v1:additionalResponseData"/>
				</xsl:element>
			</xsl:if>
		</xsl:template>

		<xsl:template match="v1:creditCard">
			<xsl:if test="normalize-space(.) != ''">
				<xsl:element name="{local-name()}">
					<xsl:apply-templates select="v1:cardNumber"/>
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
	
