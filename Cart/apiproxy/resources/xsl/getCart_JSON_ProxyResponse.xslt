<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:v1="http://services.tmobile.com/OrderManagement/CartWSIL/V1"
	xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
	xmlns:base="http://services.tmobile.com/base" exclude-result-prefixes="v1 base soapenv">

	<xsl:param name="acceptType"/>
	<xsl:param name="pARRAY" select="'~ARRAY~'"/>
	<xsl:param name="pINTEGER" select="'~INT~'"/>
	<xsl:param name="pBOOLEAN" select="'~INT~'"/>

	<xsl:output method="xml" indent="no" encoding="UTF-8" version="1.0" omit-xml-declaration="yes"/>
	<xsl:strip-space elements="*"/>

	<xsl:template match="/">
		<xsl:variable name="varResponse"
			select="soapenv:Envelope/soapenv:Body/v1:getCartDetailsResponse"/>
		<xsl:apply-templates select="$varResponse/v1:cart"/>
	</xsl:template>

	<xsl:template match="v1:cart">
		<xsl:if test="normalize-space(.) != '' or @cartId or @actionCode">
			<cart>
				<xsl:if test="@cartId">
					<xsl:attribute name="cartId">
						<xsl:value-of select="@cartId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:totalTaxAmount"/>
				<xsl:apply-templates select="v1:extendedAmount"/>
				<xsl:apply-templates select="v1:orderLocation"/>
				<xsl:if test="v1:orderTime">
					<orderTime>
						<xsl:value-of select="v1:orderTime"/>
					</orderTime>
				</xsl:if>
				<xsl:apply-templates select="v1:status"/>
				<xsl:if test="v1:reason">
					<reason>
						<xsl:value-of select="v1:reason"/>
					</reason>
				</xsl:if>
				<xsl:if test="v1:orderType">
					<orderType>
						<xsl:value-of select="v1:orderType"/>
					</orderType>
				</xsl:if>
				<xsl:apply-templates select="v1:salesChannel"/>
				<xsl:if test="v1:businessUnitName">
					<businessUnitName>
						<xsl:value-of select="v1:businessUnitName"/>
					</businessUnitName>
				</xsl:if>
				<xsl:apply-templates select="v1:salesperson"/>
				<xsl:apply-templates select="v1:cartSpecification"/>
				<xsl:if test="v1:backOrderAllowedIndicator">
					<backOrderAllowedIndicator>
						<xsl:value-of select="v1:backOrderAllowedIndicator"/>
					</backOrderAllowedIndicator>
				</xsl:if>
				<xsl:if test="v1:ipAddress">
					<ipAddress>
						<xsl:value-of select="v1:ipAddress"/>
					</ipAddress>
				</xsl:if>
				<xsl:if test="v1:deviceFingerPrintId">
					<deviceFingerPrintId>
						<xsl:value-of select="v1:deviceFingerPrintId"/>
					</deviceFingerPrintId>
				</xsl:if>
				<xsl:apply-templates select="v1:termsAndConditionsDisposition"/>
				<xsl:apply-templates select="v1:currentRecurringChargeAmount"/>
				<xsl:apply-templates select="v1:totalRecurringDueAmount"/>
				<xsl:apply-templates select="v1:totalDueAmount"/>
				<xsl:apply-templates select="v1:totalDuePayNowAmount"/>
				<xsl:if test="v1:originalOrderId">
					<originalOrderId>
						<xsl:value-of select="v1:originalOrderId"/>
					</originalOrderId>
				</xsl:if>
				<xsl:if test="v1:modeOfExchange">
					<modeOfExchange>
						<xsl:value-of select="v1:modeOfExchange"/>
					</modeOfExchange>
				</xsl:if>
				<xsl:apply-templates select="v1:relatedOrder"/>
				<xsl:if test="v1:reasonDescription">
					<reasonDescription>
						<xsl:value-of select="v1:reasonDescription"/>
					</reasonDescription>
				</xsl:if>
				<xsl:if test="v1:fraudCheckRequired">
					<fraudCheckRequired>
						<xsl:value-of select="v1:fraudCheckRequired"/>
					</fraudCheckRequired>
				</xsl:if>
				<xsl:if test="v1:isInFlightOrder">
					<isInFlightOrder>
						<xsl:value-of select="v1:isInFlightOrder"/>
					</isInFlightOrder>
				</xsl:if>
				<xsl:apply-templates select="v1:fraudCheckStatus"/>
				<xsl:apply-templates select="v1:relatedCart"/>
				<xsl:apply-templates select="v1:shipping"/>
				<xsl:apply-templates select="v1:billTo"/>
				<xsl:apply-templates select="v1:cartItem"/>
				<xsl:apply-templates select="v1:charge"/>
				<xsl:apply-templates select="v1:deduction"/>
				<xsl:apply-templates select="v1:tax"/>
				<xsl:apply-templates select="v1:freightCharge"/>
				<xsl:apply-templates select="v1:payment"/>
				<xsl:apply-templates select="v1:addressList"/>
				<xsl:apply-templates select="v1:cartSummary"/>
				<xsl:apply-templates select="v1:searchContext"/>
				<xsl:apply-templates select="v1:validationMessage"/>
			</cart>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:relatedCart">
		<xsl:if test="normalize-space(.) != ''">
			<relatedCart>
				<xsl:if test="v1:cartId">
					<cartId>
						<xsl:value-of select="v1:cartId"/>
					</cartId>
				</xsl:if>
				<xsl:if test="v1:orderRelationshipType">
					<orderRelationshipType>
						<xsl:value-of select="v1:orderRelationshipType"/>
					</orderRelationshipType>
				</xsl:if>
				<xsl:apply-templates select="v1:cartStatus"/>
			</relatedCart>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:cartStatus">
		<xsl:if test="normalize-space(.) != '' or @statusCode">
			<cartStatus>
				<xsl:attribute name="statusCode">
					<xsl:value-of select="@statusCode"/>
				</xsl:attribute>
			</cartStatus>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:fraudCheckStatus">
		<!--<xsl:if test="v1:fraudCheckStatus != ''">-->
		<xsl:if test="normalize-space(.) != ''">
			<fraudCheckStatus>
				<xsl:if test="v1:name">
					<name>
						<xsl:value-of select="v1:name"/>
					</name>
				</xsl:if>
				<xsl:if test="v1:reasonCode">
					<reasonCode>
						<xsl:value-of select="v1:reasonCode"/>
					</reasonCode>
				</xsl:if>
			</fraudCheckStatus>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:salesperson">
		<xsl:if test="normalize-space(.) != ''">
			<salesperson>
				<xsl:if test="v1:userName">
					<userName>
						<xsl:value-of select="v1:userName"/>
					</userName>
				</xsl:if>
				<xsl:apply-templates select="v1:personName" mode="salesperson"/>
			</salesperson>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:validationMessage">
		<xsl:if test="normalize-space(.) != ''">
			<validationMessage>
				<xsl:if test="v1:messageType">
					<messageType>
						<xsl:value-of select="v1:messageType"/>
					</messageType>
				</xsl:if>
				<xsl:if test="v1:messageCode">
					<messageCode>
						<xsl:value-of select="v1:messageCode"/>
					</messageCode>
				</xsl:if>
				<xsl:apply-templates select="v1:messageText"/>
				<xsl:if test="v1:messageSource">
					<messageSource>
						<xsl:value-of select="v1:messageSource"/>
					</messageSource>
				</xsl:if>
			</validationMessage>
			<validationMessage>
				<xsl:value-of select="$pARRAY"/>
			</validationMessage>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:searchContext">
		<xsl:if test="v1:searchContext != '' or @name">
			<searchContext>
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:specificationValue"/>
			</searchContext>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:cartSummary">
		<xsl:if test="normalize-space(.) != ''">
			<cartSummary>
				<xsl:if test="v1:financialAccountId">
					<financialAccountId>
						<xsl:value-of select="v1:financialAccountId"/>
					</financialAccountId>
				</xsl:if>
				<xsl:if test="v1:lineOfServiceId">
					<lineOfServiceId>
						<xsl:value-of select="v1:lineOfServiceId"/>
					</lineOfServiceId>
				</xsl:if>
				<xsl:if test="v1:summaryScope">
					<summaryScope>
						<xsl:value-of select="v1:summaryScope"/>
					</summaryScope>
				</xsl:if>
				<xsl:apply-templates select="v1:totalDueAmount"/>
				<xsl:apply-templates select="v1:totalRecurringDueAmount"/>
				<xsl:apply-templates select="v1:charge" mode="charge-cartSummary"/>
				<xsl:apply-templates select="v1:deduction" mode="deduction-cartSummary"/>
				<xsl:apply-templates select="v1:tax" mode="tax-cartSummary"/>
				<xsl:if test="v1:calculationType">
					<calculationType>
						<xsl:value-of select="v1:calculationType"/>
					</calculationType>
				</xsl:if>
				<xsl:apply-templates select="v1:totalCurrentRecurringAmount"/>
				<xsl:apply-templates select="v1:totalDeltaRecurringDueAmount"/>
				<xsl:apply-templates select="v1:totalExtendedAmount"/>
				<xsl:apply-templates select="v1:totalSoftGoodDueNowAmount"/>
				<xsl:apply-templates select="v1:totalHardGoodDueNowAmount"/>
				<xsl:apply-templates select="v1:totalSoftGoodOneTimeDueNowAmount"/>
				<xsl:apply-templates select="v1:totalSoftGoodRecurringDueNowAmount"/>
				<xsl:apply-templates select="v1:totalTaxAmount"/>
				<xsl:apply-templates select="v1:totalFeeAmount"/>
				<xsl:if test="v1:rootParentId">
					<rootParentId>
						<xsl:value-of select="v1:rootParentId"/>
					</rootParentId>
				</xsl:if>
				<xsl:apply-templates select="v1:totalRefundAmountDueLater"/>
				<xsl:apply-templates select="v1:totalRefundAmountDueNow"/>
				<xsl:apply-templates select="v1:finalRefundAmountDueNow"/>
			</cartSummary>
			<cartSummary>
				<xsl:value-of select="$pARRAY"/>
			</cartSummary>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:charge" mode="charge-cartSummary">
		<xsl:if test="normalize-space(.) != ''">
			<charge>
				<xsl:if test="v1:typeCode">
					<typeCode>
						<xsl:value-of select="v1:typeCode"/>
					</typeCode>
				</xsl:if>
				<xsl:if test="v1:chargeFrequencyCode">
					<chargeFrequencyCode>
						<xsl:value-of select="v1:chargeFrequencyCode"/>
					</chargeFrequencyCode>
				</xsl:if>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:apply-templates select="v1:description" mode="multi"/>
				<xsl:if test="v1:chargeCode">
					<chargeCode>
						<xsl:value-of select="v1:chargeCode"/>
					</chargeCode>
				</xsl:if>
				<xsl:apply-templates select="v1:productOffering" mode="productOffering_charge"/>
				<xsl:if test="v1:productOfferingPriceId">
					<productOfferingPriceId>
						<xsl:value-of select="v1:productOfferingPriceId"/>
					</productOfferingPriceId>
				</xsl:if>
			</charge>
			<charge>
				<xsl:value-of select="$pARRAY"/>
			</charge>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:productOffering" mode="productOffering_charge">
		<xsl:if test="normalize-space(.) != ''">
			<productOffering>
				<xsl:apply-templates select="v1:keyword"/>
			</productOffering>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:deduction" mode="deduction-cartSummary">
		<xsl:if test="normalize-space(.) != ''">
			<deduction>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:apply-templates select="v1:description" mode="multi"/>
				<xsl:if test="v1:recurringFrequency">
					<recurringFrequency>
						<xsl:value-of select="v1:recurringFrequency"/>
					</recurringFrequency>
				</xsl:if>
				<xsl:apply-templates select="v1:promotion"/>
				<xsl:if test="v1:chargeCode">
					<chargeCode>
						<xsl:value-of select="v1:chargeCode"/>
					</chargeCode>
				</xsl:if>
				<xsl:if test="v1:productOfferingPriceId">
					<productOfferingPriceId>
						<xsl:value-of select="v1:productOfferingPriceId"/>
					</productOfferingPriceId>
				</xsl:if>
			</deduction>
			<deduction>
				<xsl:value-of select="$pARRAY"/>
			</deduction>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:tax" mode="tax-cartSummary">
		<xsl:if test="normalize-space(.) != '' or @id">
			<tax>
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="v1:code">
					<code>
						<xsl:value-of select="v1:code"/>
					</code>
				</xsl:if>
				<xsl:if test="v1:taxJurisdiction">
					<taxJurisdiction>
						<xsl:value-of select="v1:taxJurisdiction"/>
					</taxJurisdiction>
				</xsl:if>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:if test="v1:typeCode">
					<typeCode>
						<xsl:value-of select="v1:typeCode"/>
					</typeCode>
				</xsl:if>
				<xsl:apply-templates select="v1:description"/>

				<xsl:if test="v1:taxRate">
					<taxRate>
						<xsl:value-of select="v1:taxRate"/>
					</taxRate>
				</xsl:if>
			</tax>
			<tax>
				<xsl:value-of select="$pARRAY"/>
			</tax>
		</xsl:if>
	</xsl:template>

	<xsl:template
		match="v1:aliasName | v1:key | v1:usageContext |v1:description | v1:specificationValue | v1:promotionDescription | v1:promotionCode | v1:specialInstruction">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="@* | node()"/>
			</xsl:element>
			<xsl:element name="{local-name()}">
				<xsl:value-of select="$pARRAY"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:addressList">
		<xsl:if test="normalize-space(.) != ''">
			<addressList>
				<xsl:apply-templates select="v1:addressCommunication" mode="addressList"/>
			</addressList>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:communicationStatus">
		<xsl:if test="@subStatusCode or @statusCode">
			<communicationStatus>

				<xsl:if test="@subStatusCode">
					<xsl:attribute name="subStatusCode">
						<xsl:value-of select="@subStatusCode"/>
					</xsl:attribute>
				</xsl:if>


				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
			</communicationStatus>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:addressCommunication" mode="addressList">
		<xsl:if test="normalize-space(.) != '' or @id">
			<addressCommunication>
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:address" mode="addressList"/>
				<xsl:apply-templates select="v1:usageContext"/>
				<xsl:apply-templates select="v1:communicationStatus"/>
				<xsl:apply-templates select="v1:specialInstruction"/>
			</addressCommunication>

			<addressCommunication>
				<xsl:value-of select="$pARRAY"/>
			</addressCommunication>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:address" mode="addressList">
		<xsl:if test="normalize-space(.) != ''">
			<address>
				<xsl:if test="v1:addressFormatType">
					<addressFormatType>
						<xsl:value-of select="v1:addressFormatType"/>
					</addressFormatType>
				</xsl:if>
				<xsl:if test="v1:addressLine1">
					<addressLine1>
						<xsl:value-of select="v1:addressLine1"/>
					</addressLine1>
				</xsl:if>
				<xsl:if test="v1:addressLine2">
					<addressLine2>
						<xsl:value-of select="v1:addressLine2"/>
					</addressLine2>
				</xsl:if>
				<xsl:if test="v1:addressLine3">
					<addressLine3>
						<xsl:value-of select="v1:addressLine3"/>
					</addressLine3>
				</xsl:if>
				<xsl:if test="v1:cityName">
					<cityName>
						<xsl:value-of select="v1:cityName"/>
					</cityName>
				</xsl:if>
				<xsl:if test="v1:stateName">
					<stateName>
						<xsl:value-of select="v1:stateName"/>
					</stateName>
				</xsl:if>
				<xsl:if test="v1:stateCode">
					<stateCode>
						<xsl:value-of select="v1:stateCode"/>
					</stateCode>
				</xsl:if>
				<xsl:if test="v1:countyName">
					<countyName>
						<xsl:value-of select="v1:countyName"/>
					</countyName>
				</xsl:if>
				<xsl:if test="v1:countryCode">
					<countryCode>
						<xsl:value-of select="v1:countryCode"/>
					</countryCode>
				</xsl:if>
				<xsl:if test="v1:attentionOf">
					<attentionOf>
						<xsl:value-of select="v1:attentionOf"/>
					</attentionOf>
				</xsl:if>
				<xsl:if test="v1:careOf">
					<careOf>
						<xsl:value-of select="v1:careOf"/>
					</careOf>
				</xsl:if>
				<xsl:if test="v1:postalCode">
					<postalCode>
						<xsl:value-of select="v1:postalCode"/>
					</postalCode>
				</xsl:if>
				<xsl:if test="v1:postalCodeExtension">
					<postalCodeExtension>
						<xsl:value-of select="v1:postalCodeExtension"/>
					</postalCodeExtension>
				</xsl:if>
				<xsl:apply-templates select="v1:geoCodeID"/>
				<xsl:if test="v1:uncertaintyIndicator">
					<uncertaintyIndicator>
						<xsl:value-of select="v1:uncertaintyIndicator"/>
					</uncertaintyIndicator>
				</xsl:if>
				<xsl:if test="v1:inCityLimitIndicator">
					<inCityLimitIndicator>
						<xsl:value-of select="v1:inCityLimitIndicator"/>
					</inCityLimitIndicator>
				</xsl:if>
				<xsl:apply-templates select="v1:geographicCoordinates"/>
				<xsl:apply-templates select="v1:key" mode="multi"/>
				<xsl:if test="v1:residentialIndicator">
					<residentialIndicator>
						<xsl:value-of select="v1:residentialIndicator"/>
					</residentialIndicator>
				</xsl:if>
				<xsl:if test="v1:timeZone">
					<timeZone>
						<xsl:value-of select="v1:timeZone"/>
					</timeZone>
				</xsl:if>
				<xsl:if test="v1:houseNumber">
					<houseNumber>
						<xsl:value-of select="v1:houseNumber"/>
					</houseNumber>
				</xsl:if>
				<xsl:if test="v1:streetName">
					<streetName>
						<xsl:value-of select="v1:streetName"/>
					</streetName>
				</xsl:if>
				<xsl:if test="v1:streetSuffix">
					<streetSuffix>
						<xsl:value-of select="v1:streetSuffix"/>
					</streetSuffix>
				</xsl:if>
				<xsl:if test="v1:trailingDirection">
					<trailingDirection>
						<xsl:value-of select="v1:trailingDirection"/>
					</trailingDirection>
				</xsl:if>
				<xsl:if test="v1:unitType">
					<unitType>
						<xsl:value-of select="v1:unitType"/>
					</unitType>
				</xsl:if>
				<xsl:if test="v1:unitNumber">
					<unitNumber>
						<xsl:value-of select="v1:unitNumber"/>
					</unitNumber>
				</xsl:if>
				<xsl:if test="v1:streetDirection">
					<streetDirection>
						<xsl:value-of select="v1:streetDirection"/>
					</streetDirection>
				</xsl:if>
				<xsl:if test="v1:urbanization">
					<urbanization>
						<xsl:value-of select="v1:urbanization"/>
					</urbanization>
				</xsl:if>
				<xsl:if test="v1:deliveryPointCode">
					<deliveryPointCode>
						<xsl:value-of select="v1:deliveryPointCode"/>
					</deliveryPointCode>
				</xsl:if>
				<xsl:if test="v1:confidenceLevel">
					<confidenceLevel>
						<xsl:value-of select="v1:confidenceLevel"/>
					</confidenceLevel>
				</xsl:if>
				<xsl:if test="v1:carrierRoute">
					<carrierRoute>
						<xsl:value-of select="v1:carrierRoute"/>
					</carrierRoute>
				</xsl:if>
				<xsl:if test="v1:overrideIndicator">
					<overrideIndicator>
						<xsl:value-of select="v1:overrideIndicator"/>
					</overrideIndicator>
				</xsl:if>
				<xsl:if test="v1:observesDaylightSavingsIndicator">
					<observesDaylightSavingsIndicator>
						<xsl:value-of select="v1:observesDaylightSavingsIndicator"/>
					</observesDaylightSavingsIndicator>
				</xsl:if>
				<xsl:if test="v1:matchIndicator">
					<matchIndicator>
						<xsl:value-of select="v1:matchIndicator"/>
					</matchIndicator>
				</xsl:if>
			</address>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:geoCodeID">
		<xsl:if
			test="normalize-space(.) != '' or @manualIndicator or @referenceLayer or @usageContext">
			<geoCodeID>
				<xsl:if test="@manualIndicator">
					<xsl:attribute name="manualIndicator">
						<xsl:value-of select="@manualIndicator"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@referenceLayer">
					<xsl:attribute name="referenceLayer">
						<xsl:value-of select="@referenceLayer"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@usageContext">
					<xsl:attribute name="usageContext">
						<xsl:value-of select="@usageContext"/>
					</xsl:attribute>
				</xsl:if>
			    <xsl:value-of select="."/>
			</geoCodeID>

			<geoCodeID>
				<xsl:value-of select="$pARRAY"/>
			</geoCodeID>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:geographicCoordinates">
		<xsl:if test="normalize-space(.) != ''">
			<geographicCoordinates>
				<xsl:if test="v1:latitude">
					<latitude>
						<xsl:value-of select="v1:latitude"/>
					</latitude>
				</xsl:if>
				<xsl:if test="v1:longitude">
					<longitude>
						<xsl:value-of select="v1:longitude"/>
					</longitude>
				</xsl:if>
			</geographicCoordinates>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:cartSpecification">
		<xsl:if test="normalize-space(.) != '' or @name">
			<cartSpecification>
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:specificationValue"/>
			</cartSpecification>
			<cartSpecification>
				<xsl:value-of select="$pARRAY"/>
			</cartSpecification>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:status">
		<xsl:if test="normalize-space(.) != '' or @statusCode">
			<status>
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</status>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:salesChannel">
		<xsl:if test="normalize-space(.) != ''">
			<salesChannel>
				<xsl:if test="v1:salesChannelCode">
					<salesChannelCode>
						<xsl:value-of select="v1:salesChannelCode"/>
					</salesChannelCode>
				</xsl:if>
				<xsl:if test="v1:salesSubChannelCode">
					<salesSubChannelCode>
						<xsl:value-of select="v1:salesSubChannelCode"/>
					</salesSubChannelCode>
				</xsl:if>
				<xsl:if test="v1:subChannelCategory">
					<subChannelCategory>
						<xsl:value-of select="v1:subChannelCategory"/>
					</subChannelCategory>
				</xsl:if>
			</salesChannel>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:orderLocation">
		<xsl:if test="normalize-space(.) != '' or @id">
			<orderLocation>
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:location"/>
				<xsl:if test="v1:tillNumber">
					<tillNumber>
						<xsl:value-of select="v1:tillNumber"/>
					</tillNumber>
				</xsl:if>
			</orderLocation>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:location">
		<xsl:if test="normalize-space(.) != '' or @id">
			<location>
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</location>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:termsAndConditionsDisposition">
		<xsl:if test="normalize-space(.) != ''">
			<termsAndConditionsDisposition>
				<xsl:if test="v1:acceptanceIndicator">
					<acceptanceIndicator>
						<xsl:value-of select="v1:acceptanceIndicator"/>
					</acceptanceIndicator>
				</xsl:if>
				<xsl:if test="v1:acceptanceTime">
					<acceptanceTime>
						<xsl:value-of select="v1:acceptanceTime"/>
					</acceptanceTime>
				</xsl:if>
			</termsAndConditionsDisposition>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:relatedOrder">
		<xsl:if test="normalize-space(.) != ''">
			<relatedOrder>
				<xsl:apply-templates select="v1:orderId"/>
				<xsl:apply-templates select="v1:relationshipType"/>
				<xsl:apply-templates select="v1:orderStatus"/>
			</relatedOrder>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:orderStatus">
		<xsl:if test="@statusCode">
			<orderStatus>
				<xsl:attribute name="statusCode">
					<xsl:value-of select="@statusCode"/>
				</xsl:attribute>
			</orderStatus>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:shipping">
		<xsl:if test="normalize-space(.) != ''">
			<shipping>
				<xsl:if test="v1:freightCarrier">
					<freightCarrier>
						<xsl:value-of select="v1:freightCarrier"/>
					</freightCarrier>
				</xsl:if>
				<xsl:if test="v1:promisedDeliveryTime">
					<promisedDeliveryTime>
						<xsl:value-of select="v1:promisedDeliveryTime"/>
					</promisedDeliveryTime>
				</xsl:if>
				<xsl:apply-templates select="v1:shipTo"/>
				<xsl:apply-templates select="v1:note"/>
				<xsl:if test="v1:serviceLevelCode">
					<serviceLevelCode>
						<xsl:value-of select="v1:serviceLevelCode"/>
					</serviceLevelCode>
				</xsl:if>
			</shipping>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:note">
		<xsl:if test="normalize-space(.) != '' or @language">
			<note>
				<xsl:if test="@language">
					<xsl:attribute name="language">
						<xsl:value-of select="@language"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="v1:entryTime">
					<entryTime>
						<xsl:value-of select="v1:entryTime"/>
					</entryTime>
				</xsl:if>
				<xsl:if test="v1:noteType">
					<noteType>
						<xsl:value-of select="v1:noteType"/>
					</noteType>
				</xsl:if>
				<xsl:if test="v1:content">
					<content>
						<xsl:value-of select="v1:content"/>
					</content>
				</xsl:if>
				<xsl:if test="v1:author">
					<author>
						<xsl:value-of select="v1:author"/>
					</author>
				</xsl:if>
			</note>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:shipTo">
		<xsl:if test="normalize-space(.) != ''">
			<shipTo>
				<xsl:apply-templates select="v1:personName" mode="shipTo"/>
				<xsl:apply-templates select="v1:addressCommunication" mode="shipTo"/>
				<xsl:apply-templates select="v1:phoneCommunication"/>
				<xsl:apply-templates select="v1:emailCommunication" mode="shipToEmailCommunication"/>
				<xsl:apply-templates select="v1:preferredLanguage"/>
			</shipTo>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:personName" mode="shipTo">
		<xsl:if test="normalize-space(.) != ''">
			<personName>
				<xsl:if test="v1:firstName">
					<firstName>
						<xsl:value-of select="v1:firstName"/>
					</firstName>
				</xsl:if>
				<xsl:if test="v1:middleName">
					<middleName>
						<xsl:value-of select="v1:middleName"/>
					</middleName>
				</xsl:if>
				<xsl:if test="v1:familyName">
					<familyName>
						<xsl:value-of select="v1:familyName"/>
					</familyName>
				</xsl:if>
				<xsl:apply-templates select="v1:aliasName"/>
			</personName>
			<personName>
				<xsl:value-of select="$pARRAY"/>
			</personName>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:personName" mode="salesperson">
		<xsl:if test="normalize-space(.) != ''">
			<personName>
				<xsl:apply-templates select="v1:firstName"/>
				<xsl:apply-templates select="v1:familyName"/>
			</personName>
			<!--xsl:if test="not(contains($acceptType, 'xml'))">
                                                                <xsl:element name="{local-name()}">
                                                                <xsl:value-of select="$pARRAY"/>
                                                                </xsl:element>
                                                                </xsl:if-->
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:addressCommunication" mode="billingArrangement-addressCommunication">
		<xsl:if test="normalize-space(.) != '' or @actionCode or @id">
			<addressCommunication>

				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:apply-templates select="v1:address"/>
				
				<xsl:if test="v1:usageContext">
					<usageContext>
						<xsl:value-of select="v1:usageContext"/>
					</usageContext>
				</xsl:if>
				
			</addressCommunication>

			<addressCommunication>
				<xsl:value-of select="$pARRAY"/>
			</addressCommunication>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:addressCommunication" mode="accountContact-addressCommunication">
		<xsl:if test="normalize-space(.) != '' or @actionCode or @id">
			<addressCommunication>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:privacyProfile" mode="privacyProfile-accountContact"/>
				<xsl:apply-templates select="v1:address"/>
				<xsl:if test="v1:usageContext">
					<usageContext>
						<xsl:value-of select="v1:usageContext"/>
					</usageContext>
				</xsl:if>
			</addressCommunication>
			<addressCommunication>
				<xsl:value-of select="$pARRAY"/>
			</addressCommunication>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:privacyProfile" mode="privacyProfile-accountContact">
		<xsl:if test="normalize-space(.) != ''">
			<privacyProfile>
				<xsl:if test="v1:optOut">
					<optOut>
						<xsl:value-of select="v1:optOut"/>
					</optOut>
				</xsl:if>
				<xsl:if test="v1:activityType">
					<activityType>
						<xsl:value-of select="v1:activityType"/>
					</activityType>
				</xsl:if>
			</privacyProfile>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:addressCommunication" mode="shipTo">
		<xsl:if test="normalize-space(.) != '' or @id or @actionCode">
			<addressCommunication>
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:preference"/>
				<xsl:if test="v1:usageContext">
					<usageContext>
						<xsl:value-of select="v1:usageContext"/>
					</usageContext>
				</xsl:if>
			</addressCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:preference">
		<xsl:if test="normalize-space(.) != ''">
			<preference>
				<xsl:if test="v1:preferred">
					<preferred>
						<xsl:value-of select="v1:preferred"/>
					</preferred>
				</xsl:if>
			</preference>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:addressCommunication" mode="payeeParty">
		<xsl:if test="normalize-space(.) != '' or @id">
			<addressCommunication>
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="v1:usageContext">
					<usageContext>
						<xsl:value-of select="v1:usageContext"/>
					</usageContext>
				</xsl:if>
			</addressCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:address">
		<xsl:if test="normalize-space(.) != ''">
			<address>
				<xsl:apply-templates select="v1:key" mode="address"/>
			</address>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:key" mode="address">
		<xsl:if test="normalize-space(.) != '' or @domainName">
			<key>
				<xsl:if test="@domainName">
					<xsl:attribute name="domainName">
						<xsl:value-of select="@domainName"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="v1:keyName">
					<keyName>
						<xsl:value-of select="v1:keyName"/>
					</keyName>
				</xsl:if>
				<xsl:if test="v1:keyValue">
					<keyValue>
						<xsl:value-of select="v1:keyValue"/>
					</keyValue>
				</xsl:if>
			</key>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:key" mode="multi">
		<xsl:if test="normalize-space(.) != '' or @domainName">
			<key>

				<xsl:if test="@domainName">
					<xsl:attribute name="domainName">
						<xsl:value-of select="@domainName"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:apply-templates select="v1:keyName"/>
				<xsl:apply-templates select="v1:keyValue"/>
			</key>

			<key>
				<xsl:value-of select="$pARRAY"/>
			</key>

		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:phoneCommunication">
		<xsl:if test="normalize-space(.) != ''">
			<phoneCommunication>
				<xsl:if test="v1:phoneType">
					<phoneType>
						<xsl:value-of select="v1:phoneType"/>
					</phoneType>
				</xsl:if>
				<xsl:if test="v1:phoneNumber">
					<phoneNumber>
						<xsl:value-of select="v1:phoneNumber"/>
					</phoneNumber>
				</xsl:if>
			</phoneCommunication>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:emailCommunication" mode="shipToEmailCommunication">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:if test="normalize-space(v1:emailAddress) != ''">
				<emailAddress>
					<xsl:apply-templates select="v1:emailAddress"/>
				</emailAddress>
			</xsl:if>
			<xsl:if test="normalize-space(v1:emailFormat) != ''">
				<emailCommunication>
					<xsl:apply-templates select="v1:emailFormat"/>
				</emailCommunication>
			</xsl:if>
		</xsl:if>

	</xsl:template>

	<xsl:template match="v1:billTo">
		<xsl:if test="normalize-space(.) != ''">
			<billTo>
				<xsl:apply-templates select="v1:customerAccount"/>
				<xsl:apply-templates select="v1:customer"/>
			</billTo>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:programMembership">
		<xsl:if test="normalize-space(.) != ''">
			<programMembership>
				<xsl:if test="v1:programCode">
					<programCode>
						<xsl:value-of select="v1:programCode"/>
					</programCode>
				</xsl:if>
				<xsl:apply-templates select="v1:description"/>
			</programMembership>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:customerAccount">
		<xsl:if test="normalize-space(.) != '' or @customerAccountId">
			<customerAccount>
				<xsl:apply-templates select="@customerAccountId"/>
				<xsl:if test="v1:accountClassification">
					<accountClassification>
						<xsl:value-of select="v1:accountClassification"/>
					</accountClassification>
				</xsl:if>
				<xsl:apply-templates select="v1:programMembership"/>
				<xsl:apply-templates select="v1:specificationGroup"/>
				<xsl:apply-templates select="v1:paymentProfile"/>

				<xsl:apply-templates select="v1:preferredLanguage"/>

				<xsl:if test="v1:idVerificationIndicator">
					<idVerificationIndicator>
						<xsl:value-of select="v1:idVerificationIndicator"/>
					</idVerificationIndicator>
				</xsl:if>
				<xsl:if test="v1:corporateAffiliationProgram">
					<corporateAffiliationProgram>
						<xsl:value-of select="v1:corporateAffiliationProgram"/>
					</corporateAffiliationProgram>
				</xsl:if>
				<xsl:if test="v1:strategicAccountIndicator">
					<strategicAccountIndicator>
						<xsl:value-of select="v1:strategicAccountIndicator"/>
					</strategicAccountIndicator>
				</xsl:if>
				<xsl:apply-templates select="v1:financialAccount"/>
			</customerAccount>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:paymentProfile">
		<xsl:if test="normalize-space(.) != ''">
			<paymentProfile>
				<xsl:if test="v1:paymentTerm">
					<paymentTerm>
						<xsl:value-of select="v1:paymentTerm"/>
					</paymentTerm>
				</xsl:if>
			</paymentProfile>
		</xsl:if>
	</xsl:template>

	<!--xsl:template match="v1:accountHolder">
		<xsl:if test="normalize-space(.) != ''">
			<accountHolder>
				<xsl:apply-templates select="v1:party" mode="accountHolderParty"/>
			</accountHolder>
			
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:party" mode="accountHolderParty">
		<xsl:if test="normalize-space(.) != ''">
			<party>
				<xsl:apply-templates select="v1:person" mode="accountHolderPerson"/>
			</party>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:person" mode="accountHolderPerson">
		<xsl:if test="normalize-space(.) != ''">
			<person>
				<xsl:apply-templates select="v1:addressCommunication" mode="accpuntHolderAddress"/>
			</person>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:addressCommunication" mode="accpuntHolderAddress">
		<xsl:if test="normalize-space(.) != '' or @actionCode or @id">
			<addressCommunication>

				<xsl:if test="normalize-space(.) != '' or @actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:if test="normalize-space(.) != '' or @id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:apply-templates select="v1:privacyProfile"
					mode="accpuntHolderAddress-privacyProfile"/>
				<xsl:apply-templates select="v1:address"/>
				<xsl:apply-templates select="v1:usageContext"/>
			</addressCommunication>

			<addressCommunication>
				<xsl:value-of select="$pARRAY"/>
			</addressCommunication>

		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:privacyProfile" mode="accpuntHolderAddress-privacyProfile">
		<xsl:if test="normalize-space(.) != ''">
			<privacyProfile>
				<xsl:apply-templates select="v1:optOut"/>
				<xsl:apply-templates select="v1:activityType"/>
			</privacyProfile>
		</xsl:if>
	</xsl:template-->

	<xsl:template match="v1:financialAccount">
		<xsl:if test="normalize-space(.) != '' or @actionCode">
			<financialAccount>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="v1:financialAccountNumber">
					<financialAccountNumber>
						<xsl:value-of select="v1:financialAccountNumber"/>
					</financialAccountNumber>
				</xsl:if>
				<xsl:if test="v1:billingMethod">
					<billingMethod>
						<xsl:value-of select="v1:billingMethod"/>
					</billingMethod>
				</xsl:if>
				<xsl:apply-templates select="v1:status" mode="status-financialAccount"/>
				<xsl:apply-templates select="v1:billCycle"/>
				<xsl:apply-templates select="v1:billingArrangement"/>
				<xsl:apply-templates select="v1:accountBalanceSummaryGroup"/>
				<xsl:apply-templates select="v1:accountContact"/>
				<xsl:apply-templates select="v1:specificationGroup"/>
				<xsl:apply-templates select="v1:paymentProfile"/>
				<xsl:apply-templates select="v1:programMembership"/>
				<xsl:apply-templates select="v1:specialTreatment"/>
				<xsl:if test="v1:customerGroup">
					<customerGroup>
						<xsl:value-of select="v1:customerGroup"/>
					</customerGroup>
				</xsl:if>
			</financialAccount>
			<financialAccount>
				<xsl:value-of select="$pARRAY"/>
			</financialAccount>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:specialTreatment">
		<xsl:if test="current() != ''">
			<specialTreatment>
				<xsl:if test="normalize-space(v1:treatmentType) != ''">
					<treatmentType>
						<xsl:value-of select="v1:treatmentType"/>
					</treatmentType>
				</xsl:if>
			</specialTreatment>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:accountContact">
		<xsl:if test="normalize-space(.) != ''">
			<accountContact>
				<xsl:apply-templates select="v1:addressCommunication"
					mode="accountContact-addressCommunication"/>
			</accountContact>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:accountBalanceSummaryGroup">
		<xsl:if test="normalize-space(.) != ''">
			<accountBalanceSummaryGroup>
				<xsl:apply-templates select="v1:balanceSummary"/>
			</accountBalanceSummaryGroup>

			<accountBalanceSummaryGroup>
				<xsl:value-of select="$pARRAY"/>
			</accountBalanceSummaryGroup>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:balanceSummary">
		<xsl:if test="normalize-space(.) != ''">
			<balanceSummary>
				<xsl:apply-templates select="v1:amount"/>
			</balanceSummary>

			<balanceSummary>
				<xsl:value-of select="$pARRAY"/>
			</balanceSummary>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:status" mode="status-financialAccount">
		<xsl:if test="normalize-space(.) != '' or @statusCode">
			<status>
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="v1:reasonCode">
					<reasonCode>
						<xsl:value-of select="v1:reasonCode"/>
					</reasonCode>
				</xsl:if>
			</status>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:billCycle">
		<xsl:if test="normalize-space(.) != '' or @billCycleId or @actionCode">
			<billCycle>
				<xsl:if test="@billCycleId">
					<xsl:attribute name="billCycleId">
						<xsl:value-of select="@billCycleId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="v1:dayOfMonth">
					<dayOfMonth>
						<xsl:value-of select="v1:dayOfMonth"/>
					</dayOfMonth>
				</xsl:if>
				<xsl:if test="v1:frequencyCode">
					<frequencyCode>
						<xsl:value-of select="v1:frequencyCode"/>
					</frequencyCode>
				</xsl:if>
			</billCycle>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:billingArrangement">
		<xsl:if test="normalize-space(.) != ''">
			<billingArrangement>
				<xsl:apply-templates select="v1:billingContact"/>
			</billingArrangement>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:billingContact">
		<xsl:if test="normalize-space(.) != ''">
			<billingContact>
				<xsl:apply-templates select="v1:addressCommunication"
					mode="billingArrangement-addressCommunication"/>
			</billingContact>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:customer">
		<xsl:if test="normalize-space(.) != '' or @actionCode or @customerId">
			<customer>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@customerId">
					<xsl:attribute name="customerId">
						<xsl:value-of select="@customerId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:key" mode="address"/>

				<xsl:if test="v1:customerType">
					<customerType>
						<xsl:value-of select="v1:customerType"/>
					</customerType>
				</xsl:if>
				<xsl:apply-templates select="v1:status"/>
				<xsl:apply-templates select="v1:party"/>
				<xsl:if test="v1:customerGroup">
					<customerGroup>
						<xsl:value-of select="v1:customerGroup"/>
					</customerGroup>
				</xsl:if>
			</customer>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:party">
		<xsl:if test="normalize-space(.) != ''">
			<party>
				<xsl:apply-templates select="v1:organization"/>
				<xsl:apply-templates select="v1:person"/>
			</party>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:organization">
		<xsl:if test="normalize-space(.) != ''">
			<organization>
				<xsl:if test="v1:fullName">
					<fullName>
						<xsl:value-of select="v1:fullName"/>
					</fullName>
				</xsl:if>
				<xsl:if test="v1:shortName">
					<shortName>
						<xsl:value-of select="v1:shortName"/>
					</shortName>
				</xsl:if>
				<xsl:if test="v1:legalName">
					<legalName>
						<xsl:value-of select="v1:legalName"/>
					</legalName>
				</xsl:if>
				<xsl:apply-templates select="v1:organizationSpecification"/>
				<xsl:if test="v1:sicCode">
					<sicCode>
						<xsl:value-of select="v1:sicCode"/>
					</sicCode>
				</xsl:if>
				<xsl:apply-templates select="v1:organizationEmploymentStatistics"/>
			</organization>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:organizationEmploymentStatistics">
		<xsl:if test="normalize-space(.) != ''">
			<organizationEmploymentStatistics>
				<xsl:apply-templates select="v1:totalEmployment"/>
			</organizationEmploymentStatistics>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:totalEmployment">
		<xsl:if test="normalize-space(.) != ''">
			<totalEmployment>
				<xsl:apply-templates select="v1:employeeCount"/>
			</totalEmployment>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:organizationSpecification">
		<xsl:if test="normalize-space(.) != ''">
			<organizationSpecification>
				<xsl:apply-templates select="v1:specificationValue"/>
			</organizationSpecification>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:person">
		<xsl:if test="normalize-space(.) != ''">
			<person>
				<xsl:apply-templates select="v1:personName" mode="shipTo"/>
				<xsl:apply-templates select="v1:ssn"/>
				<xsl:apply-templates select="v1:preferredLanguage"/>
				<xsl:apply-templates select="v1:addressCommunication"
					mode="addressCommunicationperson"/>
				<xsl:if test="v1:birthDate">
					<birthDate>
						<xsl:value-of select="v1:birthDate"/>
					</birthDate>
				</xsl:if>
				<xsl:apply-templates select="v1:phoneCommunication" mode="phoneCommunicationperson"/>
				<xsl:apply-templates select="v1:emailCommunication"/>
				<xsl:apply-templates select="v1:driversLicense"/>

				<xsl:apply-templates select="v1:nationalIdentityDocument"/>

				<xsl:apply-templates select="v1:citizenship"/>
				<xsl:apply-templates select="v1:passport"/>
				<xsl:apply-templates select="v1:visa"/>
				<xsl:if test="v1:gender">
					<gender>
						<xsl:value-of select="v1:gender"/>
					</gender>
				</xsl:if>
				<xsl:if test="v1:maritalStatus">
					<maritalStatus>
						<xsl:value-of select="v1:maritalStatus"/>
					</maritalStatus>
				</xsl:if>
				<xsl:if test="v1:activeDutyMilitary">
					<activeDutyMilitary>
						<xsl:value-of select="v1:activeDutyMilitary"/>
					</activeDutyMilitary>
				</xsl:if>
				<xsl:apply-templates select="v1:securityProfile"
					mode="securityProfile-person-party-customer"/>
				<xsl:apply-templates select="v1:identityDocumentVerification"/>
			</person>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:visa">
		<visa>
			<xsl:if test="normalize-space(v1:numberID) != ''">
				<numberID>
					<xsl:value-of select="v1:numberID"/>
				</numberID>
			</xsl:if>
			<xsl:if test="normalize-space(v1:typeCode) != ''">
				<typeCode>
					<xsl:value-of select="v1:typeCode"/>
				</typeCode>
			</xsl:if>
			<xsl:if test="normalize-space(v1:classificationCode) != ''">
				<classificationCode>
					<xsl:value-of select="v1:classificationCode"/>
				</classificationCode>
			</xsl:if>
			<xsl:if test="normalize-space(v1:issuingCountryCode) != ''">
				<issuingCountryCode>
					<xsl:value-of select="v1:issuingCountryCode"/>
				</issuingCountryCode>
			</xsl:if>

			<xsl:if test="normalize-space(v1:legislationCode) != ''">
				<legislationCode>
					<xsl:value-of select="v1:legislationCode"/>
				</legislationCode>
			</xsl:if>

			<xsl:if test="normalize-space(v1:validIndicator) != ''">
				<validIndicator>
					<xsl:value-of select="concat($pBOOLEAN, v1:validIndicator, $pBOOLEAN)"/>
				</validIndicator>
			</xsl:if>
			<xsl:if test="normalize-space(v1:profession) != ''">
				<profession>
					<xsl:value-of select="v1:profession"/>
				</profession>
			</xsl:if>

			<xsl:if test="normalize-space(v1:issuedDate) != ''">
				<issuedDate>
					<xsl:value-of select="v1:issuedDate"/>
				</issuedDate>
			</xsl:if>
			<xsl:if test="normalize-space(v1:expirationDate) != ''">
				<expirationDate>
					<xsl:value-of select="v1:expirationDate"/>
				</expirationDate>
			</xsl:if>
			<xsl:if test="normalize-space(v1:entryDate) != ''">
				<entryDate>
					<xsl:value-of select="v1:entryDate"/>
				</entryDate>
			</xsl:if>
			
			<xsl:if test="normalize-space(v1:status) != '' or @statusCode">
				<status>
					<xsl:if test="@statusCode">
						<xsl:attribute name="statusCode">
							<xsl:value-of select="@statusCode"/>
						</xsl:attribute>
					</xsl:if>
			    </status>
			</xsl:if>
			
			<xsl:if test="normalize-space(v1:issuingLocation) != ''">
				<issuingLocation>
					<xsl:value-of select="v1:issuingLocation"/>
				</issuingLocation>
			</xsl:if>
			
			<xsl:if test="normalize-space(v1:issuingAuthority) != ''">
				<issuingAuthority>
					<xsl:value-of select="v1:issuingAuthority"/>
				</issuingAuthority>
			</xsl:if>
		</visa>
	</xsl:template>

	<xsl:template match="v1:nationalIdentityDocument">
		<nationalIdentityDocument>
			<xsl:if test="normalize-space(v1:nationalIdentityDocumentIdentifier) != ''">
				<nationalIdentityDocumentIdentifier>
					<xsl:value-of select="v1:nationalIdentityDocumentIdentifier"/>
				</nationalIdentityDocumentIdentifier>
			</xsl:if>

			<xsl:if test="normalize-space(v1:issuingCountryCode) != ''">
				<issuingCountryCode>
					<xsl:value-of select="v1:issuingCountryCode"/>
				</issuingCountryCode>
			</xsl:if>

			<xsl:if test="normalize-space(v1:typeCode) != ''">
				<typeCode>
					<xsl:value-of select="v1:typeCode"/>
				</typeCode>
			</xsl:if>
			<xsl:if test="normalize-space(v1:primaryIndicator) != ''">
				<primaryIndicator>
					<xsl:value-of select="concat($pBOOLEAN, v1:primaryIndicator, $pBOOLEAN)"/>
				</primaryIndicator>
			</xsl:if>
			<xsl:if test="normalize-space(v1:taxIDIndicator) != ''">
				<taxIDIndicator>
					<xsl:value-of select="concat($pBOOLEAN, v1:taxIDIndicator, $pBOOLEAN)"/>
				</taxIDIndicator>
			</xsl:if>

			<xsl:if test="normalize-space(v1:expirationDate) != ''">
				<expirationDate>
					<xsl:value-of select="v1:expirationDate"/>
				</expirationDate>
			</xsl:if>

			<xsl:if test="normalize-space(v1:issuingAuthority) != ''">
				<issuingAuthority>
					<xsl:value-of select="v1:issuingAuthority"/>
				</issuingAuthority>
			</xsl:if>

		</nationalIdentityDocument>
	</xsl:template>

	<xsl:template match="v1:identityDocumentVerification">
		<xsl:if test="normalize-space(.) != ''">
			<identityDocumentVerification>
				<xsl:if test="v1:identityDocumentType">
					<identityDocumentType>
						<xsl:value-of select="v1:identityDocumentType"/>
					</identityDocumentType>
				</xsl:if>
				<xsl:apply-templates select="v1:validPeriod"/>
				<xsl:apply-templates select="v1:verificationEvent"/>
				<xsl:apply-templates select="v1:verificationStatus"/>
			</identityDocumentVerification>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:validPeriod">
		<xsl:if test="normalize-space(.) != ''">
			<validPeriod>
				<xsl:if test="v1:startDate">
					<startDate>
						<xsl:value-of select="v1:startDate"/>
					</startDate>
				</xsl:if>
				<xsl:if test="v1:endDate">
					<endDate>
						<xsl:value-of select="v1:endDate"/>
					</endDate>
				</xsl:if>
			</validPeriod>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:verificationEvent">
		<xsl:if test="normalize-space(.) != ''">
			<verificationEvent>
				<xsl:apply-templates select="v1:creationContext"/>
			</verificationEvent>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:creationContext">
		<xsl:if test="normalize-space(.) != ''">
			<creationContext>
				<xsl:if test="v1:userName">
					<userName>
						<xsl:value-of select="v1:userName"/>
					</userName>
				</xsl:if>
				<xsl:if test="v1:eventTime">
					<eventTime>
						<xsl:value-of select="v1:eventTime"/>
					</eventTime>
				</xsl:if>
				<!--<xsl:if test="normalize-space(v1:eventDate) != ''">
					<eventDate>
						<xsl:value-of select="v1:eventDate"/>
					</eventDate>
				</xsl:if>-->
			</creationContext>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:verificationStatus">
		<xsl:if test="normalize-space(.) != '' or @statusCode">
			<verificationStatus>
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
			</verificationStatus>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:preferredLanguage">
		<xsl:if test="normalize-space(.) != '' or @usageContext">
			<preferredLanguage>
				<xsl:if test="@usageContext">
					<xsl:attribute name="usageContext">
						<xsl:value-of select="@usageContext"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</preferredLanguage>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:ssn">
		<xsl:if test="normalize-space(.) != '' or @maskingType">
			<ssn>
				<xsl:if test="@maskingType">
					<xsl:attribute name="maskingType">
						<xsl:value-of select="@maskingType"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</ssn>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:driversLicense">
		<xsl:if test="normalize-space(.) != '' or @id">
			<driversLicense>
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="normalize-space(v1:legislationAuthorityCode) != ''">
					<legislationAuthorityCode>
						<xsl:value-of select="v1:legislationAuthorityCode"/>
					</legislationAuthorityCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:issuingAuthority) != ''">
					<issuingAuthority>
						<xsl:value-of select="v1:issuingAuthority"/>
					</issuingAuthority>
				</xsl:if>
				<xsl:if test="normalize-space(v1:issuingCountryCode) != ''">
					<issuingCountryCode>
						<xsl:value-of select="v1:issuingCountryCode"/>
					</issuingCountryCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:suspendedIndicator) != ''">
					<suspendedIndicator>
						<xsl:value-of select="concat($pBOOLEAN, v1:suspendedIndicator, $pBOOLEAN)"/>
					</suspendedIndicator>
				</xsl:if>

				<xsl:if test="normalize-space(v1:suspendedFromDate) != ''">
					<suspendedFromDate>
						<xsl:value-of select="v1:suspendedFromDate"/>
					</suspendedFromDate>
				</xsl:if>
				<xsl:if test="normalize-space(v1:issuingLocation) != ''">
					<issuingLocation>
						<xsl:value-of select="v1:issuingLocation"/>
					</issuingLocation>
				</xsl:if>
				<xsl:if test="normalize-space(v1:comment) != ''">
					<comment>
						<xsl:value-of select="v1:comment"/>
					</comment>
				</xsl:if>

				<xsl:if test="normalize-space(v1:issuePeriod) != ''">
					<issuePeriod>
						<xsl:apply-templates select="v1:startTime"/>
						<xsl:apply-templates select="v1:endTime"/>
					</issuePeriod>
				</xsl:if>

				<xsl:if test="normalize-space(v1:driversLicenseClass) != ''">
					<driversLicenseClass>
						<xsl:value-of select="v1:driversLicenseClass"/>
					</driversLicenseClass>
				</xsl:if>


			</driversLicense>
			<driversLicense>
				<xsl:value-of select="$pARRAY"/>
			</driversLicense>

		</xsl:if>
	</xsl:template>



	<xsl:template match="v1:securityProfile" mode="securityProfile-person-party-customer">
		<xsl:if test="normalize-space(.) != ''">
			<securityProfile>
				<xsl:if test="v1:userName">
					<userName>
						<xsl:value-of select="v1:userName"/>
					</userName>
				</xsl:if>
				<xsl:if test="v1:pin">
					<pin>
						<xsl:value-of select="v1:pin"/>
					</pin>
				</xsl:if>
			</securityProfile>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:citizenship">
		<xsl:if test="normalize-space(.) != ''">
			<citizenship>
				<xsl:if test="v1:countryCode">
					<countryCode>
						<xsl:value-of select="v1:countryCode"/>
					</countryCode>
				</xsl:if>
			</citizenship>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:passport">
		<xsl:if test="normalize-space(.) != ''">
			<passport>
				<xsl:if test="normalize-space(v1:passportNumber) != ''">
					<passportNumber>
						<xsl:value-of select="v1:passportNumber"/>
					</passportNumber>
				</xsl:if>
				<xsl:if test="normalize-space(v1:typeCode) != ''">
					<typeCode>
						<xsl:value-of select="v1:typeCode"/>
					</typeCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:issuedDate) != ''">
					<issuedDate>
						<xsl:value-of select="v1:issuedDate"/>
					</issuedDate>
				</xsl:if>

				<xsl:if test="normalize-space(v1:expirationDate) != ''">
					<expirationDate>
						<xsl:value-of select="v1:expirationDate"/>
					</expirationDate>
				</xsl:if>
				<xsl:if test="normalize-space(v1:issuingCountryCode) != ''">
					<issuingCountryCode>
						<xsl:value-of select="v1:issuingCountryCode"/>
					</issuingCountryCode>
				</xsl:if>

				<xsl:if test="normalize-space(v1:issuingStateCode) != ''">
					<issuingStateCode>
						<xsl:value-of select="v1:issuingStateCode"/>
					</issuingStateCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:issuingLocation) != ''">
					<issuingLocation>
						<xsl:value-of select="v1:issuingLocation"/>
					</issuingLocation>
				</xsl:if>
				<xsl:if test="normalize-space(v1:issuingAuthority) != ''">
					<issuingAuthority>
						<xsl:value-of select="v1:issuingAuthority"/>
					</issuingAuthority>
				</xsl:if>
			</passport>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:addressCommunication" mode="addressCommunicationperson">
		<xsl:if test="normalize-space(.) != '' or @actionCode or @id">
			<addressCommunication>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="v1:usageContext">
					<usageContext>
						<xsl:value-of select="v1:usageContext"/>
					</usageContext>
				</xsl:if>
			</addressCommunication>
			<addressCommunication>
				<xsl:value-of select="$pARRAY"/>
			</addressCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:phoneCommunication" mode="phoneCommunicationperson">
		<xsl:if test="normalize-space(.) != ''">
			<phoneCommunication>
				<xsl:if test="v1:phoneType">
					<phoneType>
						<xsl:value-of select="v1:phoneType"/>
					</phoneType>
				</xsl:if>
				<xsl:if test="v1:phoneNumber">
					<phoneNumber>
						<xsl:value-of select="v1:phoneNumber"/>
					</phoneNumber>
				</xsl:if>
				<xsl:if test="v1:countryDialingCode">
					<countryDialingCode>
						<xsl:value-of select="v1:countryDialingCode"/>
					</countryDialingCode>
				</xsl:if>
				<xsl:if test="v1:areaCode">
					<areaCode>
						<xsl:value-of select="v1:areaCode"/>
					</areaCode>
				</xsl:if>
				<xsl:if test="v1:localNumber">
					<localNumber>
						<xsl:value-of select="v1:localNumber"/>
					</localNumber>
				</xsl:if>
				<xsl:if test="v1:phoneExtension">
					<phoneExtension>
						<xsl:value-of select="v1:phoneExtension"/>
					</phoneExtension>
				</xsl:if>
			</phoneCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:emailCommunication">
		<xsl:if test="normalize-space(.) != ''">
			<emailCommunication>
				<xsl:apply-templates select="v1:preference" mode="emailCommunication"/>
				<xsl:if test="v1:emailAddress">
					<emailAddress>
						<xsl:value-of select="v1:emailAddress"/>
					</emailAddress>
				</xsl:if>
				<xsl:apply-templates select="v1:usageContext"/>
			</emailCommunication>
			<emailCommunication>
				<xsl:value-of select="$pARRAY"/>
			</emailCommunication>
		</xsl:if>
	</xsl:template>
	

	<xsl:template match="v1:preference" mode="emailCommunication">
		<xsl:if test="normalize-space(.) != ''">
			<preference>
				<xsl:if test="v1:preferred">
					<preferred>
						<xsl:value-of select="v1:preferred"/>
					</preferred>
				</xsl:if>
			</preference>
			<preference>
				<xsl:value-of select="$pARRAY"/>
			</preference>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:cartItem">
		<xsl:if test="normalize-space(.) != '' or @cartItemId or @actionCode">
			<cartItem>
				<xsl:if test="@cartItemId">
					<xsl:attribute name="cartItemId">
						<xsl:value-of select="@cartItemId"/>
					</xsl:attribute>
				</xsl:if>

				<!-- CR#607.1 -->
				<xsl:if test="@actionCode or v1:cartItemStatus/@statusCode='ERROR'">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="if (v1:cartItemStatus/@statusCode='ERROR') 
							then 'REMOVE' else @actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<!-- CR#607.1 -->

				<xsl:if test="v1:overridePriceAllowedIndicator">
					<overridePriceAllowedIndicator>
						<xsl:value-of select="v1:overridePriceAllowedIndicator"/>
					</overridePriceAllowedIndicator>
				</xsl:if>
				<xsl:apply-templates select="v1:quantity"/>
				<xsl:apply-templates select="v1:cartItemStatus"/>
				<xsl:if test="v1:parentCartItemId">
					<parentCartItemId>
						<xsl:value-of select="v1:parentCartItemId"/>
					</parentCartItemId>
				</xsl:if>
				<xsl:if test="v1:rootParentCartItemId">
					<rootParentCartItemId>
						<xsl:value-of select="v1:rootParentCartItemId"/>
					</rootParentCartItemId>
				</xsl:if>
				<xsl:apply-templates select="v1:effectivePeriod" mode="cartItem-effectivePeriod"/>
				<xsl:apply-templates select="v1:productOffering"/>
				<xsl:apply-templates select="v1:assignedProduct" mode="cartItem-assignedProduct"/>
				<xsl:apply-templates select="v1:cartSchedule"/>
				<xsl:apply-templates select="v1:specificationGroup"/>
				<xsl:apply-templates select="v1:promotion"/>
				<xsl:if test="v1:relatedCartItemId">
					<relatedCartItemId>
						<xsl:value-of select="v1:relatedCartItemId"/>
					</relatedCartItemId>
				</xsl:if>
				<xsl:apply-templates select="v1:lineOfService"/>
				<xsl:apply-templates select="v1:networkResource"/>
				<xsl:if test="v1:transactionType">
					<transactionType>
						<xsl:value-of select="v1:transactionType"/>
					</transactionType>
				</xsl:if>
				<xsl:apply-templates select="v1:inventoryStatus"/>
				<xsl:apply-templates select="v1:deviceConditionQuestions"/>
				<xsl:if test="v1:originalOrderLineId">
					<originalOrderLineId>
						<xsl:value-of select="v1:originalOrderLineId"/>
					</originalOrderLineId>
				</xsl:if>
				<xsl:if test="v1:deviceDiagnostics">
					<deviceDiagnostics>
						<xsl:value-of select="v1:deviceDiagnostics"/>
					</deviceDiagnostics>
				</xsl:if>
				<xsl:if test="v1:reasonCode">
					<reasonCode>
						<xsl:value-of select="v1:reasonCode"/>
					</reasonCode>
				</xsl:if>
				<xsl:if test="v1:returnAuthorizationType">
					<returnAuthorizationType>
						<xsl:value-of select="v1:returnAuthorizationType"/>
					</returnAuthorizationType>
				</xsl:if>
				<xsl:if test="v1:revisionReason">
					<revisionReason>
						<xsl:value-of select="v1:revisionReason"/>
					</revisionReason>
				</xsl:if>
				<xsl:if test="v1:priceChangedIndicator">
					<priceChangedIndicator>
						<xsl:value-of select="v1:priceChangedIndicator"/>
					</priceChangedIndicator>
				</xsl:if>
				<xsl:apply-templates select="v1:financialAccount" mode="financialAccount-cartItem"/>
				<xsl:if test="v1:backendChangedIndicator">
					<backendChangedIndicator>
						<xsl:value-of select="v1:backendChangedIndicator"/>
					</backendChangedIndicator>
				</xsl:if>
				<xsl:apply-templates select="v1:extendedAmount"/>
				<xsl:if test="v1:transactionSubType">
					<transactionSubType>
						<xsl:value-of select="v1:transactionSubType"/>
					</transactionSubType>
				</xsl:if>
				<xsl:apply-templates select="v1:totalChargeAmount"/>
				<xsl:apply-templates select="v1:totalDiscountAmount"/>
				<xsl:apply-templates select="v1:totalFeeAmount"/>
				<xsl:apply-templates select="v1:totalTaxAmount"/>
				<xsl:apply-templates select="v1:totalDueNowAmount"/>
				<xsl:apply-templates select="v1:totalDueMonthlyAmount"/>
				<xsl:apply-templates select="v1:totalAmount"/>
				<xsl:apply-templates select="v1:port"/>
			</cartItem>
			<cartItem>
				<xsl:value-of select="$pARRAY"/>
			</cartItem>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:effectivePeriod" mode="cartItem-effectivePeriod">
		<xsl:if test="normalize-space(.) != ''">
			<effectivePeriod>
				<xsl:if test="v1:startTime">
					<startTime>
						<xsl:value-of select="v1:startTime"/>
					</startTime>
				</xsl:if>
				<xsl:if test="v1:endTime">
					<endTime>
						<xsl:value-of select="v1:endTime"/>
					</endTime>
				</xsl:if>
				<xsl:if test="v1:usageContext">
					<usageContext>
						<xsl:value-of select="v1:usageContext"/>
					</usageContext>
				</xsl:if>
			</effectivePeriod>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:quantity">
		<xsl:if test="normalize-space(.) != '' or @measurementUnit">
			<quantity>
				<xsl:if test="normalize-space(.) != '' or @measurementUnit">
					<xsl:attribute name="measurementUnit">
						<xsl:value-of select="@measurementUnit"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="concat($pINTEGER, ., $pINTEGER)"/>
			</quantity>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:port">
		<xsl:if test="normalize-space(.) != '' or @actionCode">
			<port>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="v1:MSISDN">
					<MSISDN>
						<xsl:value-of select="v1:MSISDN"/>
					</MSISDN>
				</xsl:if>
				<xsl:if test="v1:donorBillingSystem">
					<donorBillingSystem>
						<xsl:value-of select="v1:donorBillingSystem"/>
					</donorBillingSystem>
				</xsl:if>
				<xsl:if test="v1:donorAccountNumber">
					<donorAccountNumber>
						<xsl:value-of select="v1:donorAccountNumber"/>
					</donorAccountNumber>
				</xsl:if>
				<xsl:if test="v1:donorAccountPassword">
					<donorAccountPassword>
						<xsl:value-of select="v1:donorAccountPassword"/>
					</donorAccountPassword>
				</xsl:if>
				<xsl:if test="v1:oldServiceProvider">
					<oldServiceProvider>
						<xsl:value-of select="v1:oldServiceProvider"/>
					</oldServiceProvider>
				</xsl:if>
				<xsl:if test="v1:portDueTime">
					<portDueTime>
						<xsl:value-of select="v1:portDueTime"/>
					</portDueTime>
				</xsl:if>
				<xsl:if test="v1:portRequestedTime">
					<portRequestedTime>
						<xsl:value-of select="v1:portRequestedTime"/>
					</portRequestedTime>
				</xsl:if>
				<xsl:if test="v1:oldServiceProviderName">
					<oldServiceProviderName>
						<xsl:value-of select="v1:oldServiceProviderName"/>
					</oldServiceProviderName>
				</xsl:if>
				<xsl:if test="v1:oldVirtualServiceProviderId">
					<oldVirtualServiceProviderId>
						<xsl:value-of select="v1:oldVirtualServiceProviderId"/>
					</oldVirtualServiceProviderId>
				</xsl:if>
				<xsl:apply-templates select="v1:personProfile"/>
			</port>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:personProfile">
		<xsl:if test="normalize-space(.) != ''">
			<personProfile>
				<xsl:apply-templates select="v1:addressCommunication"
					mode="addressCommunicationpersonProfile"/>
			</personProfile>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:addressCommunication" mode="addressCommunicationpersonProfile">
		<xsl:if test="normalize-space(.) != ''">
			<addressCommunication>
				<xsl:apply-templates select="v1:address" mode="addresspersonProfile"/>
			</addressCommunication>

			<addressCommunication>
				<xsl:value-of select="$pARRAY"/>
			</addressCommunication>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:address" mode="addresspersonProfile">
		<xsl:if test="normalize-space(.) != ''">
			<address>
				<xsl:apply-templates select="v1:addressLine1"/>
				<xsl:apply-templates select="v1:addressLine2"/>
				<xsl:apply-templates select="v1:cityName"/>
				<xsl:apply-templates select="v1:stateCode"/>
				<xsl:apply-templates select="v1:countryCode"/>
				<xsl:apply-templates select="v1:postalCode"/>
			</address>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:financialAccount" mode="financialAccount-cartItem">
		<xsl:if test="normalize-space(.) != ''">
			<financialAccount>
				<xsl:if test="v1:financialAccountNumber">
					<financialAccountNumber>
						<xsl:value-of select="v1:financialAccountNumber"/>
					</financialAccountNumber>
				</xsl:if>
			</financialAccount>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:cartItemStatus">
		<xsl:if test="normalize-space(.) != '' or @statusCode">
			<cartItemStatus>
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:name"/>
				<xsl:apply-templates select="v1:description" mode="description-cartItemStatus"/>
			</cartItemStatus>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:description" mode="description-cartItemStatus">
		<xsl:if test="normalize-space(.) != '' or @usageContext">
			<description>
				<xsl:if test="@usageContext">
					<xsl:attribute name="usageContext">
						<xsl:value-of select="@usageContext"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</description>
			<description>
				<xsl:value-of select="$pARRAY"/>
			</description>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:deviceConditionQuestions">
		<xsl:if test="normalize-space(.) != ''">
			<deviceConditionQuestions>
				<xsl:apply-templates select="v1:verificationQuestion"/>
			</deviceConditionQuestions>

			<deviceConditionQuestions>
				<xsl:value-of select="$pARRAY"/>
			</deviceConditionQuestions>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:verificationQuestion">
		<xsl:if test="normalize-space(.) != ''">
			<verificationQuestion>
				<xsl:if test="v1:questionText">
					<questionText>
						<xsl:value-of select="v1:questionText"/>
					</questionText>
				</xsl:if>
				<xsl:apply-templates select="v1:verificationAnswer"/>
			</verificationQuestion>
			<verificationQuestion>
				<xsl:value-of select="$pARRAY"/>
			</verificationQuestion>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:verificationAnswer">
		<xsl:if test="normalize-space(.) != ''">
			<verificationAnswer>
				<xsl:if test="v1:answerText">
					<answerText>
						<xsl:value-of select="v1:answerText"/>
					</answerText>
				</xsl:if>
			</verificationAnswer>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:estimatedAvailable">
		<xsl:if test="normalize-space(.) != ''">
			<estimatedAvailable>
				<xsl:if test="v1:startDate">
					<startDate>
						<xsl:value-of select="v1:startDate"/>
					</startDate>
				</xsl:if>
			</estimatedAvailable>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:inventoryStatus">
		<xsl:if test="normalize-space(.) != '' or @statusCode">
			<inventoryStatus>
				<!--<xsl:apply-templates select="@*"/>-->

				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:estimatedAvailable"/>
			</inventoryStatus>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:productOffering">
		<xsl:if test="normalize-space(.) != '' or @productOfferingId">
			<productOffering>
				<xsl:if test="@productOfferingId">
					<xsl:attribute name="productOfferingId">
						<xsl:value-of select="@productOfferingId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="v1:name">
					<name>
						<xsl:value-of select="v1:name"/>
					</name>
				</xsl:if>
				<xsl:if test="v1:shortName">
					<shortName>
						<xsl:value-of select="v1:shortName"/>
					</shortName>
				</xsl:if>
				<xsl:if test="v1:displayName">
					<displayName>
						<xsl:value-of select="v1:displayName"/>
					</displayName>
				</xsl:if>
				<xsl:apply-templates select="v1:description"/>
				<xsl:apply-templates select="v1:shortDescription"/>
				<xsl:apply-templates select="v1:longDescription"/>
				<xsl:apply-templates select="v1:alternateDescription" mode="productOffering"/>
				<xsl:apply-templates select="v1:keyword"/>
				<xsl:if test="v1:offerType">
					<offerType>
						<xsl:value-of select="v1:offerType"/>
					</offerType>
				</xsl:if>
				<xsl:if test="v1:offerSubType">
					<offerSubType>
						<xsl:value-of select="v1:offerSubType"/>
					</offerSubType>
				</xsl:if>
				<xsl:if test="v1:offerLevel">
					<offerLevel>
						<xsl:value-of select="v1:offerLevel"/>
					</offerLevel>
				</xsl:if>
				<!--xsl:apply-templates select="v1:offeringStatus"/-->
				<xsl:apply-templates select="v1:offeringClassification"/>
				<xsl:if test="v1:businessUnit">
					<businessUnit>
						<xsl:value-of select="v1:businessUnit"/>
					</businessUnit>
				</xsl:if>
				<xsl:apply-templates select="v1:productType" mode="multi"/>
				<xsl:apply-templates select="v1:productSubType" mode="multi"/>
				<xsl:apply-templates select="v1:key" mode="multi"/>
				<xsl:apply-templates select="v1:specificationGroup"/>
				<xsl:apply-templates select="v1:offeringPrice"/>
				<xsl:apply-templates select="v1:orderBehavior"/>
				<xsl:apply-templates select="v1:image"/>
				<xsl:apply-templates select="v1:marketingMessage"/>
				<xsl:apply-templates select="v1:equipmentCharacteristics"/>
				<xsl:apply-templates select="v1:serviceCharacteristics"/>
				<xsl:apply-templates select="v1:offeringVariant"/>
				<xsl:apply-templates select="v1:productOfferingComponent"/>
				<xsl:apply-templates select="v1:productSpecification"/>
			</productOffering>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:productOfferingComponent">
		<xsl:if test="normalize-space(.) != '' or @offeringComponentId">
			<productOfferingComponent>
				<xsl:if test="@offeringComponentId">
					<xsl:attribute name="offeringComponentId">
						<xsl:value-of select="@offeringComponentId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:offeringVariant" mode="productOfferingComponent-offeringVariant"/>
			</productOfferingComponent>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:offeringVariant" mode="productOfferingComponent-offeringVariant">
		<xsl:if test="normalize-space(.) != ''">
			<sku>
				<xsl:value-of select="v1:sku"/>
			</sku>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:productSubType" mode="multi">
		<xsl:if test="normalize-space(.) != ''">
			<productSubType>
				<xsl:value-of select="."/>
			</productSubType>

			<productSubType>
				<xsl:value-of select="$pARRAY"/>
			</productSubType>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:productType" mode="multi">
		<xsl:if test="normalize-space(.) != ''">
			<productType>
				<xsl:value-of select="."/>
			</productType>

			<productType>
				<xsl:value-of select="$pARRAY"/>
			</productType>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:productOffering" mode="cartItem_cartSchedule">
		<xsl:if test="normalize-space(.) != '' or @productOfferingId">
			<productOffering>

				<xsl:if test="@productOfferingId">
					<xsl:attribute name="productOfferingId">
						<xsl:value-of select="@productOfferingId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</productOffering>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:productOffering" mode="cartItem_productOffering">
		<xsl:if test="normalize-space(.) != '' or @productOfferingId">
			<productOffering>

				<xsl:if test="@productOfferingId">
					<xsl:attribute name="productOfferingId">
						<xsl:value-of select="@productOfferingId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="v1:name">
					<name>
						<xsl:value-of select="v1:name"/>
					</name>
				</xsl:if>
				<xsl:if test="v1:shortName">
					<shortName>
						<xsl:value-of select="v1:shortName"/>
					</shortName>
				</xsl:if>
				<xsl:if test="v1:displayName">
					<displayName>
						<xsl:value-of select="v1:displayName"/>
					</displayName>
				</xsl:if>
				<xsl:apply-templates select="v1:description" mode="multi_attrs"/>
				<xsl:apply-templates select="v1:shortDescription"/>
				<xsl:apply-templates select="v1:longDescription"/>
				<xsl:apply-templates select="v1:alternateDescription"/>
				<xsl:apply-templates select="v1:keyword"/>
				<xsl:if test="v1:offerType">
					<offerType>
						<xsl:value-of select="v1:offerType"/>
					</offerType>
				</xsl:if>
				<xsl:if test="v1:offerSubType">
					<offerSubType>
						<xsl:value-of select="v1:offerSubType"/>
					</offerSubType>
				</xsl:if>
				<xsl:if test="v1:offerLevel">
					<offerLevel>
						<xsl:value-of select="v1:offerLevel"/>
					</offerLevel>
				</xsl:if>
				<xsl:apply-templates select="v1:offeringClassification"/>
				<xsl:if test="v1:businessUnit">
					<businessUnit>
						<xsl:value-of select="v1:businessUnit"/>
					</businessUnit>
				</xsl:if>
				<xsl:apply-templates select="v1:productType" mode="multi"/>
				<xsl:apply-templates select="v1:productSubType" mode="multi"/>
				<xsl:apply-templates select="v1:key" mode="multi"/>
				<xsl:apply-templates select="v1:specificationGroup"/>
				<xsl:apply-templates select="v1:offeringPrice" mode="cartItem-productoffering"/>
				<xsl:apply-templates select="v1:image"/>
				<xsl:apply-templates select="v1:marketingMessage"/>
				<xsl:apply-templates select="v1:equipmentCharacteristics"/>
				<xsl:apply-templates select="v1:serviceCharacteristics"/>
				<xsl:apply-templates select="v1:offeringVariant"/>
				<xsl:apply-templates select="v1:productOfferingComponent"/>
				<xsl:apply-templates select="v1:productSpecification"/>
			</productOffering>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:productOffering" mode="LOS_productOffering">
		<xsl:if test="normalize-space(.) != '' or @productOfferingId">
			<productOffering>

				<xsl:if test="@productOfferingId">
					<xsl:attribute name="productOfferingId">
						<xsl:value-of select="@productOfferingId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:name"/>
				<xsl:apply-templates select="v1:shortName"/>
				<xsl:apply-templates select="v1:displayName"/>
				<xsl:apply-templates select="v1:description" mode="multi_attrs"/>
				<xsl:apply-templates select="v1:shortDescription"/>
				<xsl:apply-templates select="v1:longDescription"/>
				<xsl:apply-templates select="v1:alternateDescription"/>
				<xsl:apply-templates select="v1:keyword"/>
				<xsl:apply-templates select="v1:offerType"/>
				<xsl:apply-templates select="v1:offerSubType"/>
				<xsl:apply-templates select="v1:offerLevel"/>
				<xsl:apply-templates select="v1:offeringClassification"/>
				<xsl:apply-templates select="v1:businessUnit"/>
				<xsl:apply-templates select="v1:productType" mode="multi"/>
				<xsl:apply-templates select="v1:productSubType" mode="multi"/>
				<xsl:apply-templates select="v1:key" mode="multi"/>
				<xsl:apply-templates select="v1:specificationGroup"/>
				<xsl:apply-templates select="v1:offeringPrice"/>
				<xsl:apply-templates select="v1:orderBehavior"/>
				<xsl:apply-templates select="v1:image"/>
				<xsl:apply-templates select="v1:marketingMessage"/>
				<xsl:apply-templates select="v1:equipmentCharacteristics"/>
				<xsl:apply-templates select="v1:serviceCharacteristics"/>
				<xsl:apply-templates select="v1:offeringVariant"/>
				<xsl:apply-templates select="v1:productSpecification"/>
			</productOffering>
			<!--productOffering>
				<xsl:value-of select="$pARRAY"/>
			</productOffering-->
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:serviceCharacteristics">
		<xsl:if test="normalize-space(.) != ''">
			<serviceCharacteristics>
				<xsl:apply-templates select="v1:backDateAllowedIndicator"/>
				<xsl:apply-templates select="v1:futureDateAllowedIndicator"/>
				<xsl:apply-templates select="v1:backDateVisibleIndicator"/>
				<xsl:apply-templates select="v1:futureDateVisibleIndicator"/>
				<xsl:apply-templates select="v1:includedServiceCapacity" mode="multi"/>
				<xsl:if test="v1:billEffectiveCode">
					<billEffectiveCode>
						<xsl:value-of select="v1:billEffectiveCode"/>
					</billEffectiveCode>
				</xsl:if>
				<xsl:apply-templates select="v1:billableThirdPartyServiceIndicator"/>
				<xsl:apply-templates select="v1:prorateAllowedIndicator"/>
				<xsl:apply-templates select="v1:prorateVisibleIndicator"/>
				<xsl:if test="v1:duration">
					<duration>
						<xsl:value-of select="v1:duration"/>
					</duration>
				</xsl:if>
			</serviceCharacteristics>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:backDateAllowedIndicator">
		<xsl:if test="normalize-space(.) != '' or @name">
			<backDateAllowedIndicator>
				<xsl:apply-templates select="@name | node()"/>
			</backDateAllowedIndicator>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:futureDateAllowedIndicator">
		<xsl:if test="normalize-space(.) != '' or @name">
			<futureDateAllowedIndicator>
				<xsl:apply-templates select="@name | node()"/>
			</futureDateAllowedIndicator>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:backDateVisibleIndicator">
		<xsl:if test="normalize-space(.) != '' or @name">
			<backDateVisibleIndicator>
				<xsl:apply-templates select="@name | node()"/>
			</backDateVisibleIndicator>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:futureDateVisibleIndicator">
		<xsl:if test="normalize-space(.) != '' or @name">
			<futureDateVisibleIndicator>
				<xsl:apply-templates select="@name | node()"/>
			</futureDateVisibleIndicator>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:unlimitedIndicator">
		<xsl:if test="normalize-space(.) != '' or @name">
			<unlimitedIndicator>
				<xsl:apply-templates select="@name | node()"/>
			</unlimitedIndicator>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:billableThirdPartyServiceIndicator">
		<xsl:if test="normalize-space(.) != '' or @name">
			<billableThirdPartyServiceIndicator>
				<xsl:apply-templates select="@name | node()"/>
			</billableThirdPartyServiceIndicator>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:prorateVisibleIndicator">
		<xsl:if test="normalize-space(.) != '' or @name">
			<prorateVisibleIndicator>
				<xsl:apply-templates select="@name | node()"/>
			</prorateVisibleIndicator>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:prorateAllowedIndicator">
		<xsl:if test="normalize-space(.) != '' or @name">
			<prorateAllowedIndicator>
				<xsl:apply-templates select="@name | node()"/>
			</prorateAllowedIndicator>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:includedServiceCapacity" mode="multi">
		<xsl:if test="normalize-space(.) != ''">
			<includedServiceCapacity>
				<xsl:if test="v1:capacityType">
					<capacityType>
						<xsl:value-of select="v1:capacityType"/>
					</capacityType>
				</xsl:if>
				<xsl:if test="v1:capacitySubType">
					<capacitySubType>
						<xsl:value-of select="v1:capacitySubType"/>
					</capacitySubType>
				</xsl:if>
				<xsl:apply-templates select="v1:unlimitedIndicator"/>
				<xsl:apply-templates select="v1:size"/>
				<xsl:if test="v1:measurementUnit">
					<measurementUnit>
						<xsl:value-of select="v1:measurementUnit"/>
					</measurementUnit>
				</xsl:if>
			</includedServiceCapacity>
			<includedServiceCapacity>
				<xsl:value-of select="$pARRAY"/>
			</includedServiceCapacity>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:equipmentCharacteristics">
		<xsl:if test="normalize-space(.) != ''">
			<equipmentCharacteristics>
				<xsl:if test="v1:model">
					<model>
						<xsl:value-of select="v1:model"/>
					</model>
				</xsl:if>
				<xsl:if test="v1:manufacturer">
					<manufacturer>
						<xsl:value-of select="v1:manufacturer"/>
					</manufacturer>
				</xsl:if>
				<xsl:if test="v1:color">
					<color>
						<xsl:value-of select="v1:color"/>
					</color>
				</xsl:if>
				<xsl:if test="v1:memory">
					<memory>
						<xsl:value-of select="v1:memory"/>
					</memory>
				</xsl:if>
				<xsl:apply-templates select="v1:tacCode" mode="multi"/>
			</equipmentCharacteristics>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:tacCode" mode="multi">
		<xsl:if test="normalize-space(.) != ''">
			<tacCode>
				<xsl:value-of select="."/>
			</tacCode>

			<tacCode>
				<xsl:value-of select="$pARRAY"/>
			</tacCode>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:marketingMessage">
		<xsl:if test="normalize-space(.) != ''">
			<marketingMessage>
				<xsl:if test="v1:salesChannelCode">
					<salesChannelCode>
						<xsl:value-of select="v1:salesChannelCode"/>
					</salesChannelCode>
				</xsl:if>
				<xsl:if test="v1:relativeSize">
					<relativeSize>
						<xsl:value-of select="v1:relativeSize"/>
					</relativeSize>
				</xsl:if>
				<xsl:apply-templates select="v1:messagePart"/>
			</marketingMessage>
			<marketingMessage>
				<xsl:value-of select="$pARRAY"/>
			</marketingMessage>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:messagePart">
		<xsl:if test="normalize-space(.) != ''">
			<messagePart>
				<xsl:if test="v1:code">
					<code>
						<xsl:value-of select="v1:code"/>
					</code>
				</xsl:if>
				<xsl:apply-templates select="v1:messageText"/>
				<xsl:if test="v1:messageSequence">
					<messageSequence>
						<xsl:value-of select="v1:messageSequence"/>
					</messageSequence>
				</xsl:if>
			</messagePart>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:messageText">
		<xsl:if test="normalize-space(.) != '' or @languageCode">
			<messageText>
				<xsl:if test="@languageCode">
					<xsl:attribute name="languageCode">
						<xsl:value-of select="@languageCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</messageText>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:offeringClassification">
		<xsl:if test="normalize-space(.) != ''">
			<offeringClassification>
				<xsl:if test="v1:classificationCode">
					<classificationCode>
						<xsl:value-of select="v1:classificationCode"/>
					</classificationCode>
				</xsl:if>
				<xsl:if test="v1:nameValue">
					<nameValue>
						<xsl:value-of select="v1:nameValue"/>
					</nameValue>
				</xsl:if>
			</offeringClassification>
			<offeringClassification>
				<xsl:value-of select="$pARRAY"/>
			</offeringClassification>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:description" mode="productOffering-description">
		<xsl:if test="normalize-space(.) != '' or @languageCode">
			<description>
				<xsl:if test="@languageCode">
					<xsl:attribute name="languageCode">
						<xsl:value-of select="@languageCode"/>
					</xsl:attribute>
				</xsl:if>
			</description>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:shortDescription">
		<xsl:if
			test="normalize-space(.) != '' or @languageCode or @usageContext or @salesChannelCode">
			<shortDescription>
				<xsl:if test="@languageCode">
					<xsl:attribute name="languageCode">
						<xsl:value-of select="@languageCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@usageContext">
					<xsl:attribute name="usageContext">
						<xsl:value-of select="@usageContext"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@salesChannelCode">
					<xsl:attribute name="salesChannelCode">
						<xsl:value-of select="@salesChannelCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</shortDescription>

			<shortDescription>
				<xsl:value-of select="$pARRAY"/>
			</shortDescription>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:specificationValue">
		<xsl:if test="normalize-space(.) != '' or @name">
			<specificationValue>
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</specificationValue>
			<specificationValue>
				<xsl:value-of select="$pARRAY"/>
			</specificationValue>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:specificationGroup">
		<xsl:if test="normalize-space(.) != '' or @name">
			<specificationGroup>
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:specificationValue"/>
			</specificationGroup>
			<specificationGroup>
				<xsl:value-of select="$pARRAY"/>
			</specificationGroup>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:offeringStatus">
		<xsl:if test="@statusCode">
			<offeringStatus>
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:effectivePeriod"/>
			</offeringStatus>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:longDescription">
		<xsl:if test="normalize-space(.) != ''">
			<longDescription>
				<xsl:if test="v1:descriptionCode">
					<descriptionCode>
						<xsl:value-of select="v1:descriptionCode"/>
					</descriptionCode>
				</xsl:if>
				<xsl:if test="v1:salesChannelCode">
					<salesChannelCode>
						<xsl:value-of select="v1:salesChannelCode"/>
					</salesChannelCode>
				</xsl:if>
				<xsl:if test="v1:languageCode">
					<languageCode>
						<xsl:value-of select="v1:languageCode"/>
					</languageCode>
				</xsl:if>
				<xsl:if test="v1:relativeSize">
					<relativeSize>
						<xsl:value-of select="v1:relativeSize"/>
					</relativeSize>
				</xsl:if>
				<xsl:if test="v1:contentType">
					<contentType>
						<xsl:value-of select="v1:contentType"/>
					</contentType>
				</xsl:if>
				<xsl:if test="v1:descriptionText">
					<descriptionText>
						<xsl:value-of select="v1:descriptionText"/>
					</descriptionText>
				</xsl:if>
			</longDescription>
			<longDescription>
				<xsl:value-of select="$pARRAY"/>
			</longDescription>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:alternateDescription">
		<xsl:if test="normalize-space(.) != ''">
			<alternateDescription>
				<xsl:if test="v1:descriptionCode">
					<descriptionCode>
						<xsl:value-of select="v1:descriptionCode"/>
					</descriptionCode>
				</xsl:if>
				<xsl:if test="v1:salesChannelCode">
					<salesChannelCode>
						<xsl:value-of select="v1:salesChannelCode"/>
					</salesChannelCode>
				</xsl:if>
				<xsl:if test="v1:languageCode">
					<languageCode>
						<xsl:value-of select="v1:languageCode"/>
					</languageCode>
				</xsl:if>
				<xsl:if test="v1:relativeSize">
					<relativeSize>
						<xsl:value-of select="v1:relativeSize"/>
					</relativeSize>
				</xsl:if>
				<xsl:if test="v1:contentType">
					<contentType>
						<xsl:value-of select="v1:contentType"/>
					</contentType>
				</xsl:if>
				<xsl:if test="v1:descriptionText">
					<descriptionText>
						<xsl:value-of select="v1:descriptionText"/>
					</descriptionText>
				</xsl:if>
			</alternateDescription>
			<alternateDescription>
				<xsl:value-of select="$pARRAY"/>
			</alternateDescription>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:alternateDescription" mode="productOffering">
		<xsl:if test="normalize-space(.) != ''">
			<alternateDescription>
				<xsl:apply-templates select="v1:descriptionCode" mode="multi"/>
				<xsl:if test="v1:salesChannelCode">
					<salesChannelCode>
						<xsl:value-of select="v1:salesChannelCode"/>
					</salesChannelCode>
				</xsl:if>
				<xsl:if test="v1:languageCode">
					<languageCode>
						<xsl:value-of select="v1:languageCode"/>
					</languageCode>
				</xsl:if>
				<xsl:if test="v1:relativeSize">
					<relativeSize>
						<xsl:value-of select="v1:relativeSize"/>
					</relativeSize>
				</xsl:if>
				<xsl:if test="v1:contentType">
					<contentType>
						<xsl:value-of select="v1:contentType"/>
					</contentType>
				</xsl:if>
				<xsl:if test="v1:descriptionText">
					<descriptionText>
						<xsl:value-of select="v1:descriptionText"/>
					</descriptionText>
				</xsl:if>
			</alternateDescription>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:descriptionCode" mode="multi">
		<xsl:if test="normalize-space(.) != ''">
			<descriptionCode>
				<xsl:value-of select="."/>
			</descriptionCode>

			<descriptionCode>
				<xsl:value-of select="$pARRAY"/>
			</descriptionCode>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:offeringPrice" mode="cartItem-productoffering">
		<xsl:if test="normalize-space(.) != '' or @priceListLineId">
			<offeringPrice>

				<xsl:if test="@priceListLineId">
					<xsl:attribute name="priceListLineId">
						<xsl:value-of select="@priceListLineId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:name"/>
				<xsl:apply-templates select="v1:productOfferingPrice" mode="multi"/>
			</offeringPrice>

			<offeringPrice>
				<xsl:value-of select="$pARRAY"/>
			</offeringPrice>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:offeringPrice">
		<xsl:if test="normalize-space(.) != '' or @priceListLineId">
			<offeringPrice>
				<xsl:if test="@priceListLineId">
					<xsl:attribute name="priceListLineId">
						<xsl:value-of select="@priceListLineId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="v1:name">
					<name>
						<xsl:value-of select="v1:name"/>
					</name>
				</xsl:if>
				<xsl:apply-templates select="v1:productOfferingPrice"/>
			</offeringPrice>
			<offeringPrice>
				<xsl:value-of select="$pARRAY"/>
			</offeringPrice>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:productOfferingPrice">
		<xsl:if test="normalize-space(.) != ''">
			<productOfferingPrice>
				<xsl:if test="v1:name">
					<name>
						<xsl:value-of select="v1:name"/>
					</name>
				</xsl:if>
				<xsl:if test="v1:productChargeType">
					<productChargeType>
						<xsl:value-of select="v1:productChargeType"/>
					</productChargeType>
				</xsl:if>
				<xsl:if test="v1:productChargeIncurredType">
					<productChargeIncurredType>
						<xsl:value-of select="v1:productChargeIncurredType"/>
					</productChargeIncurredType>
				</xsl:if>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:apply-templates select="v1:oneTimeCharge"/>
				<xsl:if test="v1:recurringFeeFrequency">
					<recurringFeeFrequency>
						<xsl:value-of select="v1:recurringFeeFrequency"/>
					</recurringFeeFrequency>
				</xsl:if>
				<xsl:if test="v1:taxInclusiveIndicator">
					<taxInclusiveIndicator>
						<xsl:value-of select="v1:taxInclusiveIndicator"/>
					</taxInclusiveIndicator>
				</xsl:if>
				<xsl:apply-templates select="v1:specificationValue"/>
			</productOfferingPrice>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:orderBehavior">
		<xsl:if test="normalize-space(.) != ''">
			<orderBehavior>
				<xsl:apply-templates select="v1:preOrderAllowedIndicator"/>
				<xsl:if test="v1:preOrderAvailableTime">
					<preOrderAvailableTime>
						<xsl:value-of select="v1:preOrderAvailableTime"/>
					</preOrderAvailableTime>
				</xsl:if>
			</orderBehavior>
			<orderBehavior>
				<xsl:value-of select="$pARRAY"/>
			</orderBehavior>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:image">
		<xsl:if test="normalize-space(.) != ''">
			<image>
				<xsl:if test="v1:URI">
					<URI>
						<xsl:value-of select="v1:URI"/>
					</URI>
				</xsl:if>
				<xsl:if test="v1:sku">
					<sku>
						<xsl:value-of select="v1:sku"/>
					</sku>
				</xsl:if>
				<xsl:if test="v1:imageDimensions">
					<imageDimensions>
						<xsl:value-of select="v1:imageDimensions"/>
					</imageDimensions>
				</xsl:if>
				<xsl:if test="v1:displayPurpose">
					<displayPurpose>
						<xsl:value-of select="v1:displayPurpose"/>
					</displayPurpose>
				</xsl:if>
			</image>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:offeringVariant">
		<xsl:if test="normalize-space(.) != ''">
			<offeringVariant>
				<xsl:if test="v1:sku">
					<sku>
						<xsl:value-of select="v1:sku"/>
					</sku>
				</xsl:if>
				<xsl:apply-templates select="v1:specificationGroup"/>
				<xsl:apply-templates select="v1:offeringVariantPrice"/>
				<xsl:if test="v1:productCondition">
					<productCondition>
						<xsl:value-of select="v1:productCondition"/>
					</productCondition>
				</xsl:if>
				<xsl:if test="v1:color">
					<color>
						<xsl:value-of select="v1:color"/>
					</color>
				</xsl:if>
				<xsl:if test="v1:memory">
					<memory>
						<xsl:value-of select="v1:memory"/>
					</memory>
				</xsl:if>
				<xsl:apply-templates select="v1:tacCode" mode="multi"/>
				<xsl:apply-templates select="v1:orderBehavior" mode="multi"/>
			</offeringVariant>
			<offeringVariant>
				<xsl:value-of select="$pARRAY"/>
			</offeringVariant>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:orderBehavior" mode="multi">
		<xsl:if test="normalize-space(.) != ''">
			<orderBehavior>
				<xsl:apply-templates select="v1:preOrderAllowedIndicator"/>
				<xsl:if test="v1:preOrderAvailableTime">
					<preOrderAvailableTime>
						<xsl:value-of select="v1:preOrderAvailableTime"/>
					</preOrderAvailableTime>
				</xsl:if>
			</orderBehavior>

			<orderBehavior>
				<xsl:value-of select="$pARRAY"/>
			</orderBehavior>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:preOrderAllowedIndicator">
		<xsl:if test="normalize-space(.) != '' or @name">
			<preOrderAllowedIndicator>
				<xsl:if test="normalize-space(.) != '' or @name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</preOrderAllowedIndicator>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:offeringVariantPrice">
		<xsl:if test="normalize-space(.) != '' or @priceListLineId">
			<offeringVariantPrice>

				<xsl:if test="@priceListLineId">
					<xsl:attribute name="priceListLineId">
						<xsl:value-of select="@priceListLineId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:name"/>
			</offeringVariantPrice>

			<offeringVariantPrice>
				<xsl:value-of select="$pARRAY"/>
			</offeringVariantPrice>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:productSpecification">
		<xsl:if test="normalize-space(.) != '' or @actionCode or @productSpecificationId">
			<productSpecification>

				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:if test="@productSpecificationId">
					<xsl:attribute name="productSpecificationId">
						<xsl:value-of select="@productSpecificationId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:name"/>
				<xsl:apply-templates select="v1:keyword"/>
				<xsl:apply-templates select="v1:productType"/>
				<xsl:apply-templates select="v1:productSubType"/>
				<xsl:apply-templates select="v1:additionalSpecification"/>
			</productSpecification>

			<productSpecification>
				<xsl:value-of select="$pARRAY"/>
			</productSpecification>

		</xsl:if>

	</xsl:template>

	<xsl:template match="v1:keyword">
		<xsl:if test="normalize-space(.) != '' or @name">
			<keyword>
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</keyword>

			<keyword>
				<xsl:value-of select="$pARRAY"/>
			</keyword>

		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:additionalSpecification">
		<xsl:if test="normalize-space(.) != ''">
			<additionalSpecification>
				<xsl:apply-templates select="v1:specificationValue"/>
			</additionalSpecification>

			<additionalSpecification>
				<xsl:value-of select="$pARRAY"/>
			</additionalSpecification>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:cartSchedule">
		<xsl:if test="normalize-space(.) != '' or @cartScheduleId">
			<cartSchedule>
				<xsl:apply-templates select="@cartScheduleId"/>
				<xsl:apply-templates select="v1:description"/>
				<xsl:apply-templates select="v1:cartScheduleStatus"/>
				<xsl:apply-templates select="v1:cartScheduleCharge"/>
				<xsl:apply-templates select="v1:cartScheduleDeduction"/>
				<xsl:apply-templates select="v1:cartScheduleTax"/>
				<xsl:if test="v1:calculationType">
					<calculationType>
						<xsl:value-of select="v1:calculationType"/>
					</calculationType>
				</xsl:if>
			</cartSchedule>

			<cartSchedule>
				<xsl:value-of select="$pARRAY"/>
			</cartSchedule>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:cartScheduleStatus">
		<xsl:if test="normalize-space(.) != '' or @statusCode">
			<cartScheduleStatus>
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</cartScheduleStatus>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:cartScheduleCharge">
		<xsl:if test="normalize-space(.) != '' or @actionCode">
			<cartScheduleCharge>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="v1:typeCode">
					<typeCode>
						<xsl:value-of select="v1:typeCode"/>
					</typeCode>
				</xsl:if>
				<xsl:if test="v1:chargeFrequencyCode">
					<chargeFrequencyCode>
						<xsl:value-of select="v1:chargeFrequencyCode"/>
					</chargeFrequencyCode>
				</xsl:if>
				<xsl:apply-templates select="v1:basisAmount"/>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:if test="v1:reason">
					<reason>
						<xsl:value-of select="v1:reason"/>
					</reason>
				</xsl:if>
				<xsl:apply-templates select="v1:effectivePeriod"/>
				<xsl:apply-templates select="v1:description"/>
				<xsl:if test="v1:chargeCode">
					<chargeCode>
						<xsl:value-of select="v1:chargeCode"/>
					</chargeCode>
				</xsl:if>
				<xsl:if test="v1:waiverIndicator">
					<waiverIndicator>
						<xsl:value-of select="v1:waiverIndicator"/>
					</waiverIndicator>
				</xsl:if>
				<xsl:if test="v1:waiverReason">
					<waiverReason>
						<xsl:value-of select="v1:waiverReason"/>
					</waiverReason>
				</xsl:if>
				<xsl:if test="v1:manuallyAddedCharge">
					<manuallyAddedCharge>
						<xsl:value-of select="v1:manuallyAddedCharge"/>
					</manuallyAddedCharge>
				</xsl:if>
				<xsl:apply-templates select="v1:productOffering" mode="cartItem_cartSchedule"/>
				<xsl:apply-templates select="v1:feeOverrideAllowed"/>
				<xsl:apply-templates select="v1:overrideThresholdPercent"/>
				<xsl:apply-templates select="v1:overrideThresholdAmount"/>
				<xsl:if test="v1:supervisorID">
					<supervisorID>
						<xsl:value-of select="v1:supervisorID"/>
					</supervisorID>
				</xsl:if>
				<xsl:apply-templates select="v1:overrideAmount"/>
				<xsl:if test="v1:overrideReason">
					<overrideReason>
						<xsl:value-of select="v1:overrideReason"/>
					</overrideReason>
				</xsl:if>
				<xsl:if test="v1:productOfferingPriceId">
					<productOfferingPriceId>
						<xsl:value-of select="v1:productOfferingPriceId"/>
					</productOfferingPriceId>
				</xsl:if>
				<xsl:if test="v1:proratedIndicator">
					<proratedIndicator>
						<xsl:value-of select="v1:proratedIndicator"/>
					</proratedIndicator>
				</xsl:if>
			</cartScheduleCharge>
			<cartScheduleCharge>
				<xsl:value-of select="$pARRAY"/>
			</cartScheduleCharge>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:feeOverrideAllowed">
		<xsl:if test="normalize-space(.) != '' or @name">
			<feeOverrideAllowed>
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</feeOverrideAllowed>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:cartScheduleDeduction">
		<xsl:if test="normalize-space(.) != '' or @actionCode">
			<cartScheduleDeduction>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:if test="v1:reason">
					<reason>
						<xsl:value-of select="v1:reason"/>
					</reason>
				</xsl:if>
				<xsl:apply-templates select="v1:effectivePeriod"/>
				<xsl:apply-templates select="v1:description" mode="multi"/>
				<xsl:if test="v1:recurringFrequency">
					<recurringFrequency>
						<xsl:value-of select="v1:recurringFrequency"/>
					</recurringFrequency>
				</xsl:if>
				<xsl:apply-templates select="v1:promotion" mode="promotion-cartScheduleDeduction"/>
				<xsl:if test="v1:chargeCode">
					<chargeCode>
						<xsl:value-of select="v1:chargeCode"/>
					</chargeCode>
				</xsl:if>
				<xsl:if test="v1:productOfferingPriceId">
					<productOfferingPriceId>
						<xsl:value-of select="v1:productOfferingPriceId"/>
					</productOfferingPriceId>
				</xsl:if>
				<xsl:apply-templates select="v1:specificationValue"/>
				<xsl:if test="v1:realizationMethod">
					<realizationMethod>
						<xsl:value-of select="v1:realizationMethod"/>
					</realizationMethod>
				</xsl:if>
				<xsl:if test="v1:proratedIndicator">
					<proratedIndicator>
						<xsl:value-of select="v1:proratedIndicator"/>
					</proratedIndicator>
				</xsl:if>
			</cartScheduleDeduction>
			<cartScheduleDeduction>
				<xsl:value-of select="$pARRAY"/>
			</cartScheduleDeduction>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:promotion" mode="promotion-cartScheduleDeduction">
		<xsl:if test="normalize-space(.) != '' or @promotionId">
			<promotion>
				<xsl:if test="@promotionId">
					<xsl:attribute name="promotionId">
						<xsl:value-of select="@promotionId"/>
					</xsl:attribute>
				</xsl:if>
			</promotion>
			<promotion>
				<xsl:value-of select="$pARRAY"/>
			</promotion>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:cartScheduleTax">
		<xsl:if test="normalize-space(.) != '' or @id">
			<cartScheduleTax>
				<xsl:apply-templates select="@id"/>
				<xsl:if test="v1:code">
					<code>
						<xsl:value-of select="v1:code"/>
					</code>
				</xsl:if>
				<xsl:if test="v1:taxJurisdiction">
					<taxJurisdiction>
						<xsl:value-of select="v1:taxJurisdiction"/>
					</taxJurisdiction>
				</xsl:if>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:if test="v1:typeCode">
					<typeCode>
						<xsl:value-of select="v1:typeCode"/>
					</typeCode>
				</xsl:if>
				<xsl:apply-templates select="v1:description"/>
				<xsl:if test="v1:taxRate">
					<taxRate>
						<xsl:value-of select="v1:taxRate"/>
					</taxRate>
				</xsl:if>
			</cartScheduleTax>
			<cartScheduleTax>
				<xsl:value-of select="$pARRAY"/>
			</cartScheduleTax>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:description" mode="multi">
		<xsl:if test="normalize-space(.) != ''">
			<description>
				<xsl:value-of select="."/>
			</description>

			<description>
				<xsl:value-of select="$pARRAY"/>
			</description>


		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:description" mode="description-payment">
		<xsl:if test="normalize-space(.) != '' or @languageCode or @usageContext">
			<description>
				<xsl:if test="@languageCode">
					<xsl:attribute name="languageCode">
						<xsl:value-of select="@languageCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@usageContext">
					<xsl:attribute name="usageContext">
						<xsl:value-of select="@usageContext"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</description>
			<description>
				<xsl:value-of select="$pARRAY"/>
			</description>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:description" mode="multi_attrs">
		<xsl:if
			test="normalize-space(.) != '' or @languageCode or @usageContext or @salesChannelCode">
			<description>
				<xsl:if test="@languageCode">
					<xsl:attribute name="languageCode">
						<xsl:value-of select="@languageCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@usageContext">
					<xsl:attribute name="usageContext">
						<xsl:value-of select="@usageContext"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@salesChannelCode">
					<xsl:attribute name="salesChannelCode">
						<xsl:value-of select="@salesChannelCode"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:value-of select="."/>

			</description>

			<description>
				<xsl:value-of select="$pARRAY"/>
			</description>

		</xsl:if>
	</xsl:template>

	<!--xsl:template match="v1:promotion" mode="cartPromotion">
		<xsl:if test="normalize-space(.) != ''">
			<promotion>
				<xsl:apply-templates select="v1:promotionCode"/>
			</promotion>
		</xsl:if>
	</xsl:template-->

	<xsl:template match="v1:promotion">
		<xsl:if test="normalize-space(.) != '' or @actionCode or @promotionId">
			<promotion>

				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@promotionId">
					<xsl:attribute name="promotionId">
						<xsl:value-of select="@promotionId"/>
					</xsl:attribute>
				</xsl:if>

				<!--        <xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:promotionName"/>
				<xsl:apply-templates select="v1:promotionCode"/>
			</promotion>

			<promotion>
				<xsl:value-of select="$pARRAY"/>
			</promotion>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:lineOfService">
		<xsl:if test="normalize-space(.) != '' or @lineOfServiceId or @actionCode">
			<lineOfService>
				<xsl:if test="@lineOfServiceId">
					<xsl:attribute name="lineOfServiceId">
						<xsl:value-of select="@lineOfServiceId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="v1:financialAccountNumber">
					<financialAccountNumber>
						<xsl:value-of select="v1:financialAccountNumber"/>
					</financialAccountNumber>
				</xsl:if>
				<xsl:apply-templates select="v1:subscriberContact"/>
				<xsl:apply-templates select="v1:networkResource"
					mode="lineOfService-networkResource"/>
				<xsl:apply-templates select="v1:lineOfServiceStatus"/>
				<xsl:if test="v1:primaryLineIndicator">
					<primaryLineIndicator>
						<xsl:value-of select="v1:primaryLineIndicator"/>
					</primaryLineIndicator>
				</xsl:if>
				<xsl:if test="v1:lineAlias">
					<lineAlias>
						<xsl:value-of select="v1:lineAlias"/>
					</lineAlias>
				</xsl:if>
				<xsl:if test="v1:lineSequence">
					<lineSequence>
						<xsl:value-of select="v1:lineSequence"/>
					</lineSequence>
				</xsl:if>
				<xsl:apply-templates select="v1:assignedProduct" mode="LOS"/>
				<xsl:apply-templates select="v1:preferredLanguage"/>
				<xsl:apply-templates select="v1:effectivePeriod" mode="LOS-effectivePeriod"/>
				<xsl:apply-templates select="v1:memberLineOfService"/>
				<xsl:apply-templates select="v1:specificationGroup"/>
				<xsl:apply-templates select="v1:privacyProfile" mode="privacyProfile-accountContact"
				/>
			</lineOfService>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:memberLineOfService">
		<xsl:if test="normalize-space(.) != ''">
			<memberLineOfService>
				<xsl:if test="v1:primaryLineIndicator">
					<primaryLineIndicator>
						<xsl:value-of select="v1:primaryLineIndicator"/>
					</primaryLineIndicator>
				</xsl:if>
			</memberLineOfService>

			<memberLineOfService>
				<xsl:value-of select="$pARRAY"/>
			</memberLineOfService>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:lineOfServiceStatus">
		<xsl:if test="normalize-space(.) != '' or @statusCode">
			<lineOfServiceStatus>
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="v1:reasonCode">
					<reasonCode>
						<xsl:value-of select="v1:reasonCode"/>
					</reasonCode>
				</xsl:if>
			</lineOfServiceStatus>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:subscriberContact">
		<xsl:if test="normalize-space(.) != ''">
			<subscriberContact>
				<xsl:apply-templates select="v1:personName"/>
				<xsl:apply-templates select="v1:addressCommunication"
					mode="addressCommunicationsubscriberContact"/>
			</subscriberContact>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:addressCommunication" mode="addressCommunicationsubscriberContact">
		<xsl:if test="normalize-space(.) != '' or @id">
			<addressCommunication>

				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:privacyProfile"/>
				<xsl:apply-templates select="v1:address"/>
				<xsl:if test="v1:usageContext">
					<usageContext>
						<xsl:value-of select="v1:usageContext"/>
					</usageContext>
				</xsl:if>
			</addressCommunication>

			<addressCommunication>
				<xsl:value-of select="$pARRAY"/>
			</addressCommunication>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:privacyProfile">
		<xsl:if test="normalize-space(.) != ''">
			<privacyProfile>
				<xsl:if test="v1:optOut">
					<optOut>
						<xsl:value-of select="v1:optOut"/>
					</optOut>
				</xsl:if>
			</privacyProfile>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:networkResource" mode="lineOfService-networkResource">
		<xsl:if test="normalize-space(.) != '' or @actionCode">
			<networkResource>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="v1:imei">
					<imei>
						<xsl:value-of select="v1:imei"/>
					</imei>
				</xsl:if>
				<xsl:apply-templates select="v1:sim"/>
				<xsl:apply-templates select="v1:mobileNumber" mode="networkMobile"/>
				<xsl:apply-templates select="v1:resourceSpecification"/>
			</networkResource>
			<networkResource>
				<xsl:value-of select="$pARRAY"/>
			</networkResource>
		</xsl:if>
	</xsl:template>



	<xsl:template match="v1:networkResource">
		<xsl:if test="normalize-space(.) != '' or @actionCode">
			<networkResource>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="v1:imei">
					<imei>
						<xsl:value-of select="v1:imei"/>
					</imei>
				</xsl:if>
				<xsl:apply-templates select="v1:sim" mode="networkResource-sim"/>
				<xsl:apply-templates select="v1:mobileNumber" mode="networkResource-mobileNumber"/>
				<xsl:apply-templates select="v1:resourceSpecification"/>
			</networkResource>
			<networkResource>
				<xsl:value-of select="$pARRAY"/>
			</networkResource>
		</xsl:if>
	</xsl:template>

	<!--R1.6.4 -->
	<xsl:template match="v1:resourceSpecification">
		<xsl:if test="normalize-space(.) != '' or @name">
			<resourceSpecification>
				<xsl:apply-templates select="@name"/>
				<xsl:apply-templates select="v1:specificationValue"/>
			</resourceSpecification>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:sim" mode="networkResource-sim">
		<xsl:if test="normalize-space(.) != ''">
			<sim>
				<xsl:if test="v1:simNumber">
					<simNumber>
						<xsl:value-of select="v1:simNumber"/>
					</simNumber>
				</xsl:if>
				<xsl:if test="v1:imsi">
					<imsi>
						<xsl:value-of select="v1:imsi"/>
					</imsi>
				</xsl:if>
				<xsl:if test="v1:simType">
					<simType>
						<xsl:value-of select="v1:simType"/>
					</simType>
				</xsl:if>
				<xsl:if test="v1:virtualSim">
					<virtualSim>
						<xsl:value-of select="v1:virtualSim"/>
					</virtualSim>
				</xsl:if>
				<xsl:if test="v1:embeddedSIMIndicator">
					<embeddedSIMIndicator>
						<xsl:value-of select="v1:embeddedSIMIndicator"/>
					</embeddedSIMIndicator>
				</xsl:if>
			</sim>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:mobileNumber" mode="networkResource-mobileNumber">
		<xsl:if test="normalize-space(.) != ''">
			<mobileNumber>
				<xsl:if test="v1:msisdn">
					<msisdn>
						<xsl:value-of select="v1:msisdn"/>
					</msisdn>
				</xsl:if>
				<xsl:if test="v1:portIndicator">
					<portIndicator>
						<xsl:value-of select="v1:portIndicator"/>
					</portIndicator>
				</xsl:if>
				<xsl:if test="v1:portReason">
					<portReason>
						<xsl:value-of select="v1:portReason"/>
					</portReason>
				</xsl:if>
			</mobileNumber>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:mobileNumber" mode="networkMobile">
		<xsl:if test="normalize-space(.) != ''">
			<mobileNumber>
				<xsl:if test="v1:msisdn">
					<msisdn>
						<xsl:value-of select="v1:msisdn"/>
					</msisdn>
				</xsl:if>
				<xsl:if test="v1:portIndicator">
					<portIndicator>
						<xsl:value-of select="v1:portIndicator"/>
					</portIndicator>
				</xsl:if>
				<xsl:if test="v1:portReason">
					<portReason>
						<xsl:value-of select="v1:portReason"/>
					</portReason>
				</xsl:if>
			</mobileNumber>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:sim">
		<xsl:if test="normalize-space(.) != ''">

			<sim>
				<xsl:if test="v1:simNumber">
					<simNumber>
						<xsl:value-of select="v1:simNumber"/>
					</simNumber>
				</xsl:if>
				<xsl:if test="v1:imsi">
					<imsi>
						<xsl:value-of select="v1:imsi"/>
					</imsi>
				</xsl:if>
				<xsl:if test="v1:simType">
					<simType>
						<xsl:value-of select="v1:simType"/>
					</simType>
				</xsl:if>
				<xsl:if test="v1:virtualSim">
					<virtualSim>
						<xsl:value-of select="v1:virtualSim"/>
					</virtualSim>
				</xsl:if>
			</sim>

		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:assignedProduct" mode="cartItem-assignedProduct">
		<xsl:if test="normalize-space(.) != '' or @actionCode">
			<assignedProduct>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:productOffering" mode="cartItem_productOffering"/>
			</assignedProduct>
		</xsl:if>
	</xsl:template>



	<xsl:template match="v1:assignedProduct" mode="LOS">
		<xsl:if test="normalize-space(.) != '' or @actionCode">
			<assignedProduct>


				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:key" mode="address"/>
				<xsl:apply-templates select="v1:productOffering" mode="LOS_productOffering"/>
				<xsl:apply-templates select="v1:effectivePeriod" mode="cartItem-effectivePeriod"/>
				<xsl:apply-templates select="v1:customerOwnedIndicator"/>
				<xsl:apply-templates select="v1:eligibilityEvaluation"/>
				<xsl:apply-templates select="v1:warranty"/>
			</assignedProduct>

		</xsl:if>
	</xsl:template>

	<!--Missing ELEMENTS ADDED -->

	<xsl:template match="v1:eligibilityEvaluation">
		<xsl:if test="normalize-space(.) != ''">
			<eligibilityEvaluation>
				<xsl:apply-templates select="v1:overrideIndicator"/>
			</eligibilityEvaluation>
			<eligibilityEvaluation>
				<xsl:value-of select="$pARRAY"/>
			</eligibilityEvaluation>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:overrideIndicator">
		<xsl:if test="normalize-space(.) != '' or @name">
			<overrideIndicator>
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="v1:overrideIndicator"/>
			</overrideIndicator>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:effectivePeriod" mode="LOS-effectivePeriod">
		<xsl:if test="normalize-space(.) != ''">
			<effectivePeriod>
				<xsl:if test="v1:startTime">
					<startTime>
						<xsl:value-of select="v1:startTime"/>
					</startTime>
				</xsl:if>
				<xsl:if test="v1:endTime">
					<endTime>
						<xsl:value-of select="v1:endTime"/>
					</endTime>
				</xsl:if>
			</effectivePeriod>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:warranty">
		<xsl:if test="normalize-space(.) != ''">
			<warranty>
				<xsl:if test="v1:warrantyExpirationDate">
					<warrantyExpirationDate>
						<xsl:value-of select="v1:warrantyExpirationDate"/>
					</warrantyExpirationDate>
				</xsl:if>
			</warranty>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:productOfferingPrice" mode="multi">
		<xsl:if test="normalize-space(.) != ''">
			<productOfferingPrice>
				<xsl:apply-templates select="v1:name"/>
				<xsl:apply-templates select="v1:productChargeType"/>
				<xsl:apply-templates select="v1:productChargeIncurredType"/>
				<xsl:apply-templates select="v1:basisAmount"/>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:apply-templates select="v1:oneTimeCharge"/>
				<xsl:apply-templates select="v1:taxInclusiveIndicator"/>
				<xsl:apply-templates select="v1:specificationValue"/>
			</productOfferingPrice>
		</xsl:if>
	</xsl:template>


	<!--xsl:template match="v1:productOfferingPrice" mode="productOfferingPriceofferingPrice">
		<xsl:if test="normalize-space(.) != ''">
			<productOfferingPrice>
				<xsl:apply-templates select="v1:name"/>
				<xsl:apply-templates select="v1:productChargeType"/>
				<xsl:apply-templates select="v1:productChargeIncurredType"/>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:apply-templates select="v1:oneTimeCharge"/>
				<xsl:apply-templates select="v1:recurringFeeFrequency"/>
				<xsl:apply-templates select="v1:taxInclusiveIndicator"/>
				<xsl:apply-templates select="v1:specificationValue"/>
			</productOfferingPrice>
		</xsl:if>
	</xsl:template-->



	<xsl:template match="v1:effectivePeriod | v1:promotionEffectivePeriod">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:startTime"/>
				<xsl:apply-templates select="v1:endTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--xsl:template match="v1:sim" mode="simnetworkResource">
		<xsl:if test="normalize-space(.) != ''">
			<sim>
				<xsl:apply-templates select="v1:simNumber"/>
				<xsl:apply-templates select="v1:imsi"/>
			</sim>
		</xsl:if>
	</xsl:template-->

	<!--xsl:template match="v1:mobileNumber">
		<xsl:if test="normalize-space(.) != ''">
			<mobileNumber>
				<xsl:apply-templates select="v1:msisdn"/>
				<xsl:apply-templates select="v1:portIndicator"/>
				<xsl:apply-templates select="v1:portReason"/>
			</mobileNumber>
		</xsl:if>
	</xsl:template-->

	<xsl:template match="v1:charge">
		<xsl:if test="normalize-space(.) != '' or @actionCode">
			<charge>

				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="v1:typeCode">
					<typeCode>
						<xsl:value-of select="v1:typeCode"/>
					</typeCode>
				</xsl:if>
				<xsl:if test="v1:chargeFrequencyCode">
					<chargeFrequencyCode>
						<xsl:value-of select="v1:chargeFrequencyCode"/>
					</chargeFrequencyCode>
				</xsl:if>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:apply-templates select="v1:description"/>
			</charge>
			<charge>
				<xsl:value-of select="$pARRAY"/>
			</charge>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:deduction">
		<xsl:if test="normalize-space(.) != '' or @actionCode">
			<deduction>

				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:apply-templates select="v1:description"/>
				<xsl:if test="v1:recurringFrequency">
					<recurringFrequency>
						<xsl:value-of select="v1:recurringFrequency"/>
					</recurringFrequency>
				</xsl:if>
			</deduction>

			<deduction>
				<xsl:value-of select="$pARRAY"/>
			</deduction>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:tax">

		<xsl:if test="normalize-space(.) != ''">
			<tax>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:apply-templates select="v1:description"/>
			</tax>
			<tax>
				<xsl:value-of select="$pARRAY"/>
			</tax>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:freightCharge">
		<xsl:if test="normalize-space(.) != '' or @chargeId">
			<freightCharge>
				<xsl:if test="@chargeId">
					<xsl:attribute name="chargeId">
						<xsl:value-of select="@chargeId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:if test="v1:chargeCode">
					<chargeCode>
						<xsl:value-of select="v1:chargeCode"/>
					</chargeCode>
				</xsl:if>
				<xsl:if test="v1:waiverIndicator">
					<waiverIndicator>
						<xsl:value-of select="v1:waiverIndicator"/>
					</waiverIndicator>
				</xsl:if>
				<xsl:if test="v1:waiverReason">
					<waiverReason>
						<xsl:value-of select="v1:waiverReason"/>
					</waiverReason>
				</xsl:if>
			</freightCharge>
		</xsl:if>
	</xsl:template>

	<xsl:template
		match="v1:basisAmount | v1:chargeAmount | v1:requestAmount | v1:totalDueAmount | v1:totalSoftGoodRecurringDueNowAmount | v1:totalSoftGoodOneTimeDueNowAmount | v1:totalHardGoodDueNowAmount | v1:totalSoftGoodDueNowAmount | v1:totalCurrentRecurringAmount | v1:totalDeltaRecurringDueAmount | v1:totalExtendedAmount | v1:amount | v1:extendedAmount | v1:totalAmount | v1:totalChargeAmount | v1:totalDiscountAmount | v1:totalFeeAmount | v1:totalTaxAmount | v1:totalDueNowAmount | v1:totalDueMonthlyAmount | v1:overrideThresholdAmount | v1:overrideAmount | v1:totalRefundAmountDueLater | v1:finalRefundAmountDueNow | v1:totalRefundAmountDueNow | v1:totalRecurringDueAmount | v1:currentRecurringChargeAmount | v1:totalDuePayNowAmount | v1:authorizationAmount">
		<xsl:if test="normalize-space(.) != '' or @currencyCode">
			<xsl:element name="{local-name()}">
					<xsl:attribute name="currencyCode">
						<xsl:value-of select="if (@currencyCode != '')
							then  @currencyCode else 'USD'"/>
					</xsl:attribute>
				<xsl:value-of select="concat($pINTEGER, ., $pINTEGER)"/>

			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template
		match="v1:size | v1:employeeCount | v1:checkNumber | v1:overrideThresholdPercent | v1:dayOfMonth">
		<xsl:if test="normalize-space(.) != '' or count(@*) > 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="@*"/>
				<xsl:value-of select="concat($pINTEGER, ., $pINTEGER)"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:oneTimeCharge | v1:customerOwnedIndicator">
		<xsl:if test="normalize-space(.) != '' or count(@*) > 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="@*"/>
				<xsl:value-of select="concat($pBOOLEAN, ., $pBOOLEAN)"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:payment">
		<xsl:if test="normalize-space(.) != '' or @actionCode or @paymentId">
			<payment>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@paymentId">
					<xsl:attribute name="paymentId">
						<xsl:value-of select="@paymentId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:status" mode="status-payment"/>
				<xsl:apply-templates select="v1:authorizationAmount"/>
				<xsl:apply-templates select="v1:requestAmount"/>
				<xsl:if test="v1:paymentMethodCode">
					<paymentMethodCode>
						<xsl:value-of select="v1:paymentMethodCode"/>
					</paymentMethodCode>
				</xsl:if>
				<xsl:apply-templates select="v1:payeeParty"/>
				<xsl:apply-templates select="v1:paymentLine"/>
				<xsl:apply-templates select="v1:voucherRedemption"/>
				<xsl:apply-templates select="v1:bankPayment"/>
				<xsl:apply-templates select="v1:creditCardPayment"/>
				<xsl:apply-templates select="v1:debitCardPayment"/>
				<xsl:if test="v1:merchantId">
					<merchantId>
						<xsl:value-of select="v1:merchantId"/>
					</merchantId>
				</xsl:if>
				<xsl:if test="v1:transactionType">
					<transactionType>
						<xsl:value-of select="v1:transactionType"/>
					</transactionType>
				</xsl:if>
				<xsl:if test="v1:authorizationChannel">
					<authorizationChannel>
						<xsl:value-of select="v1:authorizationChannel"/>
					</authorizationChannel>
				</xsl:if>
				<xsl:if test="v1:pointOfSaleReceiptNumber">
					<pointOfSaleReceiptNumber>
						<xsl:value-of select="v1:pointOfSaleReceiptNumber"/>
					</pointOfSaleReceiptNumber>
				</xsl:if>
				<xsl:apply-templates select="v1:specificationGroup"/>
				<xsl:if test="v1:receivedPaymentId">
					<receivedPaymentId>
						<xsl:value-of select="v1:receivedPaymentId"/>
					</receivedPaymentId>
				</xsl:if>
				<xsl:if test="v1:receiptMethodCode">
					<receiptMethodCode>
						<xsl:value-of select="v1:receiptMethodCode"/>
					</receiptMethodCode>
				</xsl:if>
				<xsl:if test="v1:storePaymentMethodIndicator">
					<storePaymentMethodIndicator>
						<xsl:value-of select="v1:storePaymentMethodIndicator"/>
					</storePaymentMethodIndicator>
				</xsl:if>
				<xsl:if test="v1:isTemporyToken">
					<isTemporyToken>
						<xsl:value-of select="v1:isTemporyToken"/>
					</isTemporyToken>
				</xsl:if>
				<xsl:if test="v1:settlementIndicator">
					<settlementIndicator>
						<xsl:value-of select="v1:settlementIndicator"/>
					</settlementIndicator>
				</xsl:if>
				<xsl:apply-templates select="v1:termsAndConditionsDisposition"/>
				<xsl:if test="v1:terminalEntryCapability">
					<terminalEntryCapability>
						<xsl:value-of select="v1:terminalEntryCapability"/>
					</terminalEntryCapability>
				</xsl:if>
				<xsl:if test="v1:cardCaptureCapability">
					<cardCaptureCapability>
						<xsl:value-of select="v1:cardCaptureCapability"/>
					</cardCaptureCapability>
				</xsl:if>
				<xsl:if test="v1:posConditionCode">
					<posConditionCode>
						<xsl:value-of select="v1:posConditionCode"/>
					</posConditionCode>
				</xsl:if>
				<xsl:if test="v1:posId">
					<posId>
						<xsl:value-of select="v1:posId"/>
					</posId>
				</xsl:if>
				<xsl:if test="v1:paymentTransactionType">
					<paymentTransactionType>
						<xsl:value-of select="v1:paymentTransactionType"/>
					</paymentTransactionType>
				</xsl:if>
				<xsl:if test="v1:retailPinlessFlag">
					<retailPinlessFlag>
						<xsl:value-of select="v1:retailPinlessFlag"/>
					</retailPinlessFlag>
				</xsl:if>
				<xsl:apply-templates select="v1:trackData"/>
				<xsl:if test="v1:electronicAuthenticationCapability">
					<electronicAuthenticationCapability>
						<xsl:value-of select="v1:electronicAuthenticationCapability"/>
					</electronicAuthenticationCapability>
				</xsl:if>
				<xsl:apply-templates select="v1:tokenization"/>
				<xsl:if test="v1:terminalID">
					<terminalID>
						<xsl:value-of select="v1:terminalID"/>
					</terminalID>
				</xsl:if>
			</payment>
			<payment>
				<xsl:value-of select="$pARRAY"/>
			</payment>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:paymentLine">
		<xsl:if test="normalize-space(.) != ''">
			<paymentLine>
				<xsl:if test="v1:financialAccountNumber">
					<financialAccountNumber>
						<xsl:value-of select="v1:financialAccountNumber"/>
					</financialAccountNumber>
				</xsl:if>
			</paymentLine>

			<paymentLine>
				<xsl:value-of select="$pARRAY"/>
			</paymentLine>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:status" mode="status-payment">
		<xsl:if test="normalize-space(.) != '' or @statusCode">
			<status>
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:name"/>
				<xsl:apply-templates select="v1:description" mode="description-payment"/>
				<xsl:apply-templates select="v1:reasonCode"/>
			</status>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:tokenization">
		<xsl:if test="normalize-space(.) != ''">
			<tokenization>
				<xsl:if test="v1:encryptionTarget">
					<encryptionTarget>
						<xsl:value-of select="v1:encryptionTarget"/>
					</encryptionTarget>
				</xsl:if>
				<xsl:if test="v1:encryptedContent">
					<encryptedContent>
						<xsl:value-of select="v1:encryptedContent"/>
					</encryptedContent>
				</xsl:if>
			</tokenization>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:bankPayment">
		<xsl:if test="normalize-space(.) != ''">
			<bankPayment>
				<xsl:apply-templates select="v1:payFromBankAccount"/>
				<xsl:apply-templates select="v1:check"/>
				<xsl:if test="v1:chargeAccountNumberIndicator">
					<chargeAccountNumberIndicator>
						<xsl:value-of select="v1:chargeAccountNumberIndicator"/>
					</chargeAccountNumberIndicator>
				</xsl:if>
			</bankPayment>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:check">
		<xsl:if test="normalize-space(.) != ''">
			<check>
				<xsl:apply-templates select="v1:accountNumber"/>
				<xsl:apply-templates select="v1:routingNumber"/>
				<xsl:apply-templates select="v1:checkNumber"/>
			</check>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:payFromBankAccount">
		<xsl:if test="normalize-space(.) != ''">
			<payFromBankAccount>
				<xsl:if test="v1:name">
					<name>
						<xsl:value-of select="v1:name"/>
					</name>
				</xsl:if>
				<xsl:if test="v1:accountNumber">
					<accountNumber>
						<xsl:value-of select="v1:accountNumber"/>
					</accountNumber>
				</xsl:if>
				<xsl:apply-templates select="v1:bankAccountHolder"/>
				<xsl:apply-templates select="v1:bank"/>
			</payFromBankAccount>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:bankAccountHolder">
		<xsl:if test="normalize-space(.) != ''">
			<bankAccountHolder>
				<xsl:apply-templates select="v1:person" mode="bankAccountHolder"/>
			</bankAccountHolder>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:person" mode="bankAccountHolder">
		<xsl:if test="normalize-space(.) != ''">
			<person>
				<xsl:apply-templates select="v1:personName" mode="bankAccountHolder"/>
			</person>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:personName" mode="bankAccountHolder">
		<xsl:if test="normalize-space(.) != ''">
			<personName>

				<xsl:if test="v1:firstName">
					<firstName>
						<xsl:value-of select="v1:firstName"/>
					</firstName>
				</xsl:if>
				<xsl:if test="v1:familyName">
					<familyName>
						<xsl:value-of select="v1:familyName"/>
					</familyName>
				</xsl:if>
			</personName>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:bank">
		<xsl:if test="normalize-space(.) != ''">
			<bank>
				<xsl:if test="v1:swiftCode">
					<swiftCode>
						<xsl:value-of select="v1:swiftCode"/>
					</swiftCode>
				</xsl:if>
				<xsl:if test="v1:routingNumber">
					<routingNumber>
						<xsl:value-of select="v1:routingNumber"/>
					</routingNumber>
				</xsl:if>
			</bank>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:payeeParty">
		<xsl:if test="normalize-space(.) != ''">
			<payeeParty>
				<xsl:apply-templates select="v1:personName" mode="personName-payeeParty"/>
				<xsl:apply-templates select="v1:addressCommunication" mode="payeeParty"/>
			</payeeParty>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:personName" mode="personName-payeeParty">
		<xsl:if test="normalize-space(.) != ''">
			<personName>
				<xsl:if test="v1:firstName">
					<firstName>
						<xsl:value-of select="v1:firstName"/>
					</firstName>
				</xsl:if>
				<xsl:if test="v1:middleName">
					<middleName>
						<xsl:value-of select="v1:middleName"/>
					</middleName>
				</xsl:if>
				<xsl:if test="v1:familyName">
					<familyName>
						<xsl:value-of select="v1:familyName"/>
					</familyName>
				</xsl:if>
			</personName>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:payFromParty">
		<xsl:if test="normalize-space(.) != ''">
			<payFromParty>
				<xsl:apply-templates select="v1:securityProfile"/>
			</payFromParty>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:securityProfile">
		<xsl:if test="normalize-space(.) != ''">
			<securityProfile>
				<xsl:apply-templates select="v1:msisdn"/>
			</securityProfile>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:voucherRedemption">
		<xsl:if test="normalize-space(.) != ''">
			<voucherRedemption>
				<xsl:if test="v1:serialNumber">
					<serialNumber>
						<xsl:value-of select="v1:serialNumber"/>
					</serialNumber>
				</xsl:if>
				<xsl:if test="v1:issuerId">
					<issuerId>
						<xsl:value-of select="v1:issuerId"/>
					</issuerId>
				</xsl:if>
				<xsl:if test="v1:PIN">
					<PIN>
						<xsl:value-of select="v1:PIN"/>
					</PIN>
				</xsl:if>
				<xsl:if test="v1:voucherRedemptionType">
					<voucherRedemptionType>
						<xsl:value-of select="v1:voucherRedemptionType"/>
					</voucherRedemptionType>
				</xsl:if>
			</voucherRedemption>
			<voucherRedemption>
				<xsl:value-of select="$pARRAY"/>
			</voucherRedemption>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:creditCardPayment">
		<xsl:if test="normalize-space(.) != ''">
			<creditCardPayment>
				<xsl:if test="v1:authorizationId">
					<authorizationId>
						<xsl:value-of select="v1:authorizationId"/>
					</authorizationId>
				</xsl:if>
				<xsl:apply-templates select="v1:chargeAmount"/>
				<xsl:apply-templates select="v1:creditCard"/>
			</creditCardPayment>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:creditCard">
		<xsl:if test="normalize-space(.) != ''">
			<creditCard>
				<xsl:if test="v1:typeCode">
					<typeCode>
						<xsl:value-of select="v1:typeCode"/>
					</typeCode>
				</xsl:if>
				<xsl:apply-templates select="v1:cardNumber"/>
				<xsl:if test="v1:cardHolderName">
					<cardHolderName>
						<xsl:value-of select="v1:cardHolderName"/>
					</cardHolderName>
				</xsl:if>
				<xsl:if test="v1:expirationMonthYear">
					<expirationMonthYear>
						<xsl:value-of select="v1:expirationMonthYear"/>
					</expirationMonthYear>
				</xsl:if>
				<xsl:apply-templates select="v1:cardHolderAddress"/>
				<xsl:if test="v1:cardHolderFirstName">
					<cardHolderFirstName>
						<xsl:value-of select="v1:cardHolderFirstName"/>
					</cardHolderFirstName>
				</xsl:if>
				<xsl:if test="v1:cardHolderLastName">
					<cardHolderLastName>
						<xsl:value-of select="v1:cardHolderLastName"/>
					</cardHolderLastName>
				</xsl:if>
				<xsl:if test="v1:cardTypeIndicator">
					<cardTypeIndicator>
						<xsl:value-of select="v1:cardTypeIndicator"/>
					</cardTypeIndicator>
				</xsl:if>
				<xsl:if test="v1:chargeAccountNumberIndicator">
					<chargeAccountNumberIndicator>
						<xsl:value-of select="v1:chargeAccountNumberIndicator"/>
					</chargeAccountNumberIndicator>
				</xsl:if>
				<xsl:apply-templates select="v1:cardHolderBillingAddress"/>
				<xsl:if test="v1:securityCode">
					<securityCode>
						<xsl:value-of select="v1:securityCode"/>
					</securityCode>
				</xsl:if>
			</creditCard>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:cardNumber">
		<xsl:if test="normalize-space(.) != '' or @maskingType">
			<cardNumber>
				<xsl:if test="@maskingType">
					<xsl:attribute name="maskingType">
						<xsl:value-of select="@maskingType"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</cardNumber>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:cardHolderBillingAddress">
		<xsl:if test="normalize-space(.) != ''">
			<cardHolderBillingAddress>
				<xsl:if test="v1:addressFormatType">
					<addressFormatType>
						<xsl:value-of select="v1:addressFormatType"/>
					</addressFormatType>
				</xsl:if>
				<xsl:if test="v1:addressLine1">
					<addressLine1>
						<xsl:value-of select="v1:addressLine1"/>
					</addressLine1>
				</xsl:if>
				<xsl:if test="v1:addressLine2">
					<addressLine2>
						<xsl:value-of select="v1:addressLine2"/>
					</addressLine2>
				</xsl:if>
				<xsl:if test="v1:cityName">
					<cityName>
						<xsl:value-of select="v1:cityName"/>
					</cityName>
				</xsl:if>
				<xsl:if test="v1:stateCode">
					<stateCode>
						<xsl:value-of select="v1:stateCode"/>
					</stateCode>
				</xsl:if>
				<xsl:if test="v1:countryCode">
					<countryCode>
						<xsl:value-of select="v1:countryCode"/>
					</countryCode>
				</xsl:if>
				<xsl:if test="v1:postalCode">
					<postalCode>
						<xsl:value-of select="v1:postalCode"/>
					</postalCode>
				</xsl:if>
				<xsl:if test="v1:postalCodeExtension">
					<postalCodeExtension>
						<xsl:value-of select="v1:postalCodeExtension"/>
					</postalCodeExtension>
				</xsl:if>
				<xsl:apply-templates select="v1:key" mode="address"/>
			</cardHolderBillingAddress>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:debitCardPayment">
		<xsl:if test="normalize-space(.) != ''">
			<debitCardPayment>
				<xsl:if test="v1:authorizationId">
					<authorizationId>
						<xsl:value-of select="v1:authorizationId"/>
					</authorizationId>
				</xsl:if>
				<xsl:apply-templates select="v1:chargeAmount"/>
				<xsl:apply-templates select="v1:debitCard"/>
			</debitCardPayment>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:debitCard">
		<xsl:if test="normalize-space(.) != ''">
			<debitCard>
				<xsl:if test="v1:typeCode">
					<typeCode>
						<xsl:value-of select="v1:typeCode"/>
					</typeCode>
				</xsl:if>
				<xsl:apply-templates select="v1:cardNumber"/>
				<xsl:if test="v1:cardHolderName">
					<cardHolderName>
						<xsl:value-of select="v1:cardHolderName"/>
					</cardHolderName>
				</xsl:if>
				<xsl:if test="v1:expirationMonthYear">
					<expirationMonthYear>
						<xsl:value-of select="v1:expirationMonthYear"/>
					</expirationMonthYear>
				</xsl:if>
				<xsl:apply-templates select="v1:cardHolderAddress"/>
				<xsl:if test="v1:cardHolderFirstName">
					<cardHolderFirstName>
						<xsl:value-of select="v1:cardHolderFirstName"/>
					</cardHolderFirstName>
				</xsl:if>
				<xsl:if test="v1:cardHolderLastName">
					<cardHolderLastName>
						<xsl:value-of select="v1:cardHolderLastName"/>
					</cardHolderLastName>
				</xsl:if>
				<xsl:if test="v1:cardTypeIndicator">
					<cardTypeIndicator>
						<xsl:value-of select="v1:cardTypeIndicator"/>
					</cardTypeIndicator>
				</xsl:if>
				<xsl:if test="v1:chargeAccountNumberIndicator">
					<chargeAccountNumberIndicator>
						<xsl:value-of select="v1:chargeAccountNumberIndicator"/>
					</chargeAccountNumberIndicator>
				</xsl:if>
				<xsl:if test="v1:PIN">
					<PIN>
						<xsl:value-of select="v1:PIN"/>
					</PIN>
				</xsl:if>
			</debitCard>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:cardHolderAddress">
		<xsl:if test="normalize-space(.) != ''">
			<cardHolderAddress>
				<xsl:if test="v1:addressFormatType">
					<addressFormatType>
						<xsl:value-of select="v1:addressFormatType"/>
					</addressFormatType>
				</xsl:if>
				<xsl:if test="v1:addressLine1">
					<addressLine1>
						<xsl:value-of select="v1:addressLine1"/>
					</addressLine1>
				</xsl:if>
				<xsl:if test="v1:addressLine2">
					<addressLine2>
						<xsl:value-of select="v1:addressLine2"/>
					</addressLine2>
				</xsl:if>
				<xsl:if test="v1:cityName">
					<cityName>
						<xsl:value-of select="v1:cityName"/>
					</cityName>
				</xsl:if>
				<xsl:if test="v1:stateCode">
					<stateCode>
						<xsl:value-of select="v1:stateCode"/>
					</stateCode>
				</xsl:if>
				<xsl:if test="v1:countryCode">
					<countryCode>
						<xsl:value-of select="v1:countryCode"/>
					</countryCode>
				</xsl:if>
				<xsl:if test="v1:postalCode">
					<postalCode>
						<xsl:value-of select="v1:postalCode"/>
					</postalCode>
				</xsl:if>
				<xsl:if test="v1:postalCodeExtension">
					<postalCodeExtension>
						<xsl:value-of select="v1:postalCodeExtension"/>
					</postalCodeExtension>
				</xsl:if>
				<xsl:apply-templates select="v1:key" mode="address"/>
			</cardHolderAddress>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:trackData">
		<xsl:if test="normalize-space(.) != ''">
			<trackData>
				<xsl:if test="v1:track1Data">
					<track1Data>
						<xsl:value-of select="v1:track1Data"/>
					</track1Data>
				</xsl:if>
				<xsl:if test="v1:track2Data">
					<track2Data>
						<xsl:value-of select="v1:track2Data"/>
					</track2Data>
				</xsl:if>
			</trackData>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:*">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="{local-name()} ">
				<xsl:apply-templates select="@* | node()"/>
			</xsl:element>
		</xsl:if>

	</xsl:template>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
