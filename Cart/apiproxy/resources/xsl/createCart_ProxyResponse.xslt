<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:v1="http://services.tmobile.com/OrderManagement/CartWSIL/V1"
	xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
	xmlns:base="http://services.tmobile.com/base" exclude-result-prefixes="v1 base soapenv">
		
	<xsl:param name="acceptType"/>
	<xsl:param name="pARRAY" select="'~ARRAY~'"/>
	<xsl:param name="pINTEGER" select="'~INT~'"/>
	<xsl:param name="pBOOLEAN" select="'~INT~'"/>
	<xsl:param name="include"/>
	<xsl:param name="exclude"/>

	<xsl:output method="xml" indent="no" encoding="UTF-8" version="1.0" omit-xml-declaration="yes"/>
	<xsl:strip-space elements="*"/>	

	<xsl:template match="/">
		<xsl:variable name="varResponse" select="soapenv:Envelope/soapenv:Body/v1:updateCartResponse"/>
		<xsl:choose>
			<xsl:when test="not($include) and not($exclude)">
				<response/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:element name="response">
					<xsl:apply-templates select="$varResponse/v1:cart"/>
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:variable name="modifyInclude">
		<xsl:choose>
			<xsl:when test="$include='cart'"/>
			<xsl:when test="$include='{}'"/>
			<xsl:when test="$include='{cart}'"/>
			<xsl:when test="contains($include,'{cart,')">
				<xsl:value-of select="substring($include,7,string-length($include)-5)"/>
			</xsl:when>
			<xsl:when test="contains($include,'cart,')">
				<xsl:value-of select="substring($include,6,string-length($include)-4)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$include"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>

	<xsl:template name="Include-Exclude">

		<!--'include' are provided and 'exlcude' are not  10 -->
		<xsl:if test="not(not($modifyInclude)) and not($exclude)">
			<xsl:choose>
				<xsl:when
					test="(normalize-space(.) != '' or count(.//@*) != 0) and (contains(string($modifyInclude),local-name()) )">
					<xsl:value-of select="'1'"/>
				</xsl:when>
			</xsl:choose>
		</xsl:if>

		<!--Both are provided  11-->
		<xsl:if test="not(not($modifyInclude)) and $exclude">
			<xsl:choose>
				<xsl:when
					test="(normalize-space(.) != '' or count(.//@*) != 0) and (contains(string($modifyInclude),local-name()) )">
					<xsl:value-of select="'1'"/>
				</xsl:when>
			</xsl:choose>
		</xsl:if>


		<!--Both are provided  00-->
		<xsl:if test="not(string($modifyInclude)) and not($exclude)">
			<xsl:choose>
				<xsl:when test="(normalize-space(.) != '' or count(.//@*) != 0)">
					<xsl:value-of select="'1'"/>
				</xsl:when>
			</xsl:choose>
		</xsl:if>


		<!--'exclude' are provided and 'inlcude' are not  01 -->
		<xsl:if test="not(string($modifyInclude)) and $exclude">
			<xsl:choose>
				<xsl:when test="contains($exclude,local-name())">
					<!--dont print-->
					<xsl:value-of select="'0'"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
						<xsl:value-of select="'1'"/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>

	</xsl:template>



	<xsl:template match="v1:cart">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

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
				<xsl:apply-templates select="v1:orderTime"/>
				<xsl:apply-templates select="v1:status"/>
				<xsl:apply-templates select="v1:reason"/>
				<xsl:apply-templates select="v1:orderType"/>
				<xsl:apply-templates select="v1:salesChannel"/>
				<xsl:apply-templates select="v1:businessUnitName"/>
				<xsl:apply-templates select="v1:salesperson"/>
				<xsl:apply-templates select="v1:cartSpecification"/>
				<xsl:apply-templates select="v1:backOrderAllowedIndicator"/>
				<xsl:apply-templates select="v1:ipAddress"/>
				<xsl:apply-templates select="v1:deviceFingerPrintId"/>
				<xsl:apply-templates select="v1:termsAndConditionsDisposition"/>
				<xsl:apply-templates select="v1:currentRecurringChargeAmount"/>
				<xsl:apply-templates select="v1:totalRecurringDueAmount"/>
				<xsl:apply-templates select="v1:totalDueAmount"/>
				<xsl:apply-templates select="v1:originalOrderId"/>
				<xsl:apply-templates select="v1:modeOfExchange"/>
				<xsl:apply-templates select="v1:relatedOrder"/>
				<xsl:apply-templates select="v1:reasonDescription"/>
				<xsl:apply-templates select="v1:fraudCheckRequired"/>
				<xsl:apply-templates select="v1:isInFlightOrder"/>

				<!--xsl:apply-templates select="v1:fraudCheckStatus"/>
				<xsl:apply-templates select="v1:relatedCart"/-->
				<xsl:apply-templates select="v1:totalDuePayNowAmount"/>
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
				<!--xsl:apply-templates select="v1:searchContext"/-->
				<xsl:apply-templates select="v1:validationMessage"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:relatedCart">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:cartId"/>
				<xsl:apply-templates select="v1:orderRelationshipType"/>
				<xsl:apply-templates select="v1:cartStatus"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:fraudCheckStatus">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:name"/>
				<xsl:apply-templates select="v1:reasonCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:salesperson">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or count(.//@*) != 0) and $check_IncludeExclude='1'">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:userName"/>
				<xsl:apply-templates select="v1:personName" mode="salesperson"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:quotation">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="v1:quotationCharge"/>
				<xsl:apply-templates select="v1:quotationDeduction"/>
				<xsl:apply-templates select="v1:quotationDate"/>
				<xsl:apply-templates select="v1:quotationLine"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:quotationCharge">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:amount"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:quotationDeduction">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:amount"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:quotationLine">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:if test="@quotationLineId">
					<xsl:attribute name="quotationLineId">
						<xsl:value-of select="@quotationLineId"/>
					</xsl:attribute>
				</xsl:if>

				<!--	<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:quoteType"/>
				<xsl:apply-templates select="v1:quotationSchedule"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:quotationSchedule">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="v1:quotationScheduleDeduction"/>
				<xsl:apply-templates select="v1:quotationScheduleCharge"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:quotationScheduleDeduction">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:amount"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:quotationScheduleCharge">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:amount"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:validationMessage">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or count(.//@*) != 0) and $check_IncludeExclude='1'">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:messageType"/>
				<xsl:apply-templates select="v1:messageCode"/>
				<xsl:apply-templates select="v1:messageText"/>
				<xsl:apply-templates select="v1:messageSource"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:searchContext">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:specificationValue"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:cartSummary">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or count(.//@*) != 0) and $check_IncludeExclude='1'">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:financialAccountId"/>
				<xsl:apply-templates select="v1:lineOfServiceId"/>
				<xsl:apply-templates select="v1:summaryScope"/>
				<xsl:apply-templates select="v1:totalDueAmount"/>
				<xsl:apply-templates select="v1:totalRecurringDueAmount"/>
				<xsl:apply-templates select="v1:charge" mode="charge-cartSummary"/>
				<xsl:apply-templates select="v1:deduction" mode="deduction-cartSummary"/>
				<xsl:apply-templates select="v1:tax" mode="tax-cartSummary"/>
				<xsl:apply-templates select="v1:calculationType"/>
				<xsl:apply-templates select="v1:totalCurrentRecurringAmount"/>
				<xsl:apply-templates select="v1:totalDeltaRecurringDueAmount"/>
				<xsl:apply-templates select="v1:totalExtendedAmount"/>
				<xsl:apply-templates select="v1:totalSoftGoodDueNowAmount"/>
				<xsl:apply-templates select="v1:totalHardGoodDueNowAmount"/>
				<xsl:apply-templates select="v1:totalSoftGoodOneTimeDueNowAmount"/>
				<xsl:apply-templates select="v1:totalSoftGoodRecurringDueNowAmount"/>
				<xsl:apply-templates select="v1:totalTaxAmount"/>
				<xsl:apply-templates select="v1:totalFeeAmount"/>
				<xsl:apply-templates select="v1:rootParentId"/>
				<xsl:apply-templates select="v1:totalRefundAmountDueLater"/>
				<xsl:apply-templates select="v1:totalRefundAmountDueNow"/>
				<xsl:apply-templates select="v1:finalRefundAmountDueNow"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:charge" mode="charge-cartSummary">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:typeCode"/>
				<xsl:apply-templates select="v1:chargeFrequencyCode"/>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:apply-templates select="v1:description" mode="multi"/>
				<xsl:apply-templates select="v1:chargeCode"/>
				<xsl:apply-templates select="v1:productOffering" mode="productOffering_charge"/>
				<xsl:apply-templates select="v1:productOfferingPriceId"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:productOffering" mode="productOffering_charge">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:keyword"/>
			</xsl:element>
			
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:deduction" mode="deduction-cartSummary">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:amount"/>
				<xsl:apply-templates select="v1:description" mode="multi"/>
				<xsl:apply-templates select="v1:recurringFrequency"/>
				<xsl:apply-templates select="v1:promotion"/>
				<xsl:apply-templates select="v1:chargeCode"/>
				<xsl:apply-templates select="v1:productOfferingPriceId"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:tax" mode="tax-cartSummary">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:code"/>
				<xsl:apply-templates select="v1:taxJurisdiction"/>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:apply-templates select="v1:typeCode"/>
				<xsl:apply-templates select="v1:description"/>
				<xsl:apply-templates select="v1:taxRate"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template
		match=" v1:middleName | v1:familyName | v1:aliasName | v1:key | v1:usageContext | v1:privacyProfile | v1:description 
		| v1:promotionDescription | v1:promotionCode 
		| v1:specialInstruction">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="@*|node()"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<!--xsl:template match="v1:preferredLanguage">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="@*"/>
			</xsl:element>
		</xsl:if>
	</xsl:template-->

	<xsl:template match="v1:addressList">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or count(.//@*) != 0) and $check_IncludeExclude='1'">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:addressCommunication" mode="addressList"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:communicationStatus">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

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

				<!--<xsl:apply-templates select="@*"/>-->
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:addressCommunication" mode="addressList">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">


				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:address" mode="addressList"/>
				<xsl:apply-templates select="v1:usageContext"/>
				<xsl:apply-templates select="v1:communicationStatus"/>
				<xsl:apply-templates select="v1:specialInstruction"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:address" mode="addressList">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:addressFormatType"/>
				<xsl:apply-templates select="v1:addressLine1"/>
				<xsl:apply-templates select="v1:addressLine2"/>
				<xsl:apply-templates select="v1:addressLine3"/>
				<xsl:apply-templates select="v1:cityName"/>
				<xsl:apply-templates select="v1:stateName"/>
				<xsl:apply-templates select="v1:stateCode"/>
				<xsl:apply-templates select="v1:countyName"/>
				<xsl:apply-templates select="v1:countryCode"/>
				<xsl:apply-templates select="v1:attentionOf"/>
				<xsl:apply-templates select="v1:careOf"/>
				<xsl:apply-templates select="v1:postalCode"/>
				<xsl:apply-templates select="v1:postalCodeExtension"/>
				<xsl:apply-templates select="v1:geoCodeID"/>
				<xsl:apply-templates select="v1:uncertaintyIndicator"/>
				<xsl:apply-templates select="v1:inCityLimitIndicator"/>
				<xsl:apply-templates select="v1:geographicCoordinates"/>
				<xsl:apply-templates select="v1:key" mode="multi"/>
				<xsl:apply-templates select="v1:residentialIndicator"/>
				<xsl:apply-templates select="v1:building"/>
				<xsl:apply-templates select="v1:floor"/>
				<xsl:apply-templates select="v1:area"/>
				<xsl:apply-templates select="v1:timeZone"/>
				<xsl:apply-templates select="v1:houseNumber"/>
				<xsl:apply-templates select="v1:streetName"/>
				<xsl:apply-templates select="v1:streetSuffix"/>
				<xsl:apply-templates select="v1:trailingDirection"/>
				<xsl:apply-templates select="v1:unitType"/>
				<xsl:apply-templates select="v1:unitNumber"/>
				<xsl:apply-templates select="v1:streetDirection"/>
				<xsl:apply-templates select="v1:urbanization"/>
				<xsl:apply-templates select="v1:deliveryPointCode"/>
				<xsl:apply-templates select="v1:confidenceLevel"/>
				<xsl:apply-templates select="v1:carrierRoute"/>
				<xsl:apply-templates select="v1:overrideIndicator"/>
				<xsl:apply-templates select="v1:observesDaylightSavingsIndicator"/>
				<xsl:apply-templates select="v1:matchIndicator"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:geoCodeID">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
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
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:geographicCoordinates">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:latitude"/>
				<xsl:apply-templates select="v1:longitude"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:cartSpecification">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or count(.//@*) != 0) and $check_IncludeExclude='1'">
			<xsl:element name="{local-name()}">

				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:specificationValue"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:status">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or count(.//@*) != 0) and $check_IncludeExclude='1'">
			<xsl:element name="{local-name()}">
				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:salesChannel">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or count(.//@*) != 0) and $check_IncludeExclude='1'">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:salesChannelCode"/>
				<xsl:apply-templates select="v1:salesSubChannelCode"/>
				<xsl:apply-templates select="v1:subChannelCategory"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:orderLocation">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or count(.//@*) != 0) and $check_IncludeExclude='1'">
			<xsl:element name="{local-name()}">

				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>

				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:location"/>
				<xsl:apply-templates select="v1:tillNumber"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:location">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:termsAndConditionsDisposition">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or count(.//@*) != 0) and $check_IncludeExclude='1'">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:acceptanceIndicator"/>
				<xsl:apply-templates select="v1:acceptanceTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:relatedOrder">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or count(.//@*) != 0) and $check_IncludeExclude='1'">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:orderId"/>
				<xsl:apply-templates select="v1:relationshipType"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:orderStatus">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:shipping">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or count(.//@*) != 0) and $check_IncludeExclude='1'">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:freightCarrier"/>
				<xsl:apply-templates select="v1:promisedDeliveryTime"/>
				<xsl:apply-templates select="v1:shipTo"/>
				<xsl:apply-templates select="v1:note"/>
				<xsl:apply-templates select="v1:serviceLevelCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:note">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:if test="@language">
					<xsl:attribute name="language">
						<xsl:value-of select="@language"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:entryTime"/>
				<xsl:apply-templates select="v1:noteType"/>
				<xsl:apply-templates select="v1:content"/>
				<xsl:apply-templates select="v1:author"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:shipTo">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:personName" mode="shipTo"/>
				<xsl:apply-templates select="v1:addressCommunication" mode="shipTo"/>
				<xsl:apply-templates select="v1:phoneCommunication"/>
				<xsl:apply-templates select="v1:emailCommunication" mode="shipToEmailCommunication"/>
				<xsl:apply-templates select="v1:preferredLanguage"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:personName" mode="shipTo">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:firstName"/>
				<xsl:apply-templates select="v1:middleName"/>
				<xsl:apply-templates select="v1:familyName"/>
				<xsl:apply-templates select="v1:aliasName"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:personName" mode="salesperson">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:firstName"/>
				<xsl:apply-templates select="v1:familyName"/>
			</xsl:element>
			<!--xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if-->
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:addressCommunication" mode="shipTo">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				
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
				<xsl:apply-templates select="v1:usageContext"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:addressCommunication" mode="billingArrangement-addressCommunication">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

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
				<xsl:apply-templates select="v1:address"/>
				<xsl:apply-templates select="v1:usageContext"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:addressCommunication" mode="accountContact-addressCommunication">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

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
				<xsl:apply-templates select="v1:privacyProfile" mode="accountHolderAddress-privacyProfile"/>
				<xsl:apply-templates select="v1:address"/>
				<xsl:apply-templates select="v1:usageContext"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:addressCommunication">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
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

				<!--<xsl:apply-templates select="@*"/>-->

				<xsl:apply-templates select="v1:preference"/>
				<xsl:apply-templates select="v1:usageContext"/>
			</xsl:element>
			<!--<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>-->
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:addressCommunication" mode="payeeParty">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:usageContext"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:address">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:key" mode="address"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:key" mode="address">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

				<xsl:if test="@domainName">
					<xsl:attribute name="domainName">
						<xsl:value-of select="@domainName"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:apply-templates select="v1:keyName"/>
				<xsl:apply-templates select="v1:keyValue"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:key" mode="multi">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

				<xsl:if test="@domainName">
					<xsl:attribute name="domainName">
						<xsl:value-of select="@domainName"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:apply-templates select="v1:keyName"/>
				<xsl:apply-templates select="v1:keyValue"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:phoneCommunication">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:phoneType"/>
				<xsl:apply-templates select="v1:phoneNumber"/>
			</xsl:element>
			<!--<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>-->
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:emailCommunication" mode="shipToEmailCommunication">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:emailAddress"/>
				<xsl:apply-templates select="v1:emailFormat"/>
			</xsl:element>
			<!--<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>-->
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:billTo">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or count(.//@*) != 0) and $check_IncludeExclude='1'">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:customerAccount"/>
				<xsl:apply-templates select="v1:customer"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:programMembership">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:programCode"/>
				<xsl:apply-templates select="v1:description"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3E-->
	<xsl:template match="v1:customerAccount">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="@customerAccountId"/>
				<xsl:apply-templates select="v1:accountClassification"/>
				<!--xsl:apply-templates select="v1:businessUnit"/-->
				<xsl:apply-templates select="v1:programMembership"/>
				<xsl:apply-templates select="v1:specificationGroup"/>
				<!--xsl:apply-templates select="v1:accountHolder"/-->
				<xsl:apply-templates select="v1:paymentProfile"/>
				<xsl:apply-templates select="v1:preferredLanguage"/>
				<xsl:apply-templates select="v1:idVerificationIndicator"/>
				<xsl:apply-templates select="v1:corporateAffiliationProgram"/>
				<xsl:apply-templates select="v1:strategicAccountIndicator"/>
				<xsl:apply-templates select="v1:financialAccount"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:paymentProfile">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:paymentTerm"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:accountHolder">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:party" mode="accountHolderParty"/>
			</xsl:element>
			<!--<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>-->
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:party" mode="accountHolderParty">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:person" mode="accountHolderPerson"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:person" mode="accountHolderPerson">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:addressCommunication" mode="accountHolderAddress"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:addressCommunication" mode="accountHolderAddress">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

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

				<xsl:apply-templates select="v1:privacyProfile"
					mode="accpuntHolderAddress-privacyProfile"/>
				<xsl:apply-templates select="v1:address"/>
				<xsl:apply-templates select="v1:usageContext"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:privacyProfile" mode="accountHolderAddress-privacyProfile">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:optOut"/>
				<xsl:apply-templates select="v1:activityType"/>
			</xsl:element>
			<!--	<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>-->
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:financialAccount">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:financialAccountNumber"/>
				<xsl:apply-templates select="v1:billingMethod"/>
				<xsl:apply-templates select="v1:status" mode="status-financialAccount"/>
				<xsl:apply-templates select="v1:billCycle"/>
				<xsl:apply-templates select="v1:billingArrangement"/>
				<xsl:apply-templates select="v1:accountBalanceSummaryGroup"/>
				<xsl:apply-templates select="v1:accountContact"/>
				<xsl:apply-templates select="v1:specificationGroup"/>
				<xsl:apply-templates select="v1:paymentProfile"/>
				<xsl:apply-templates select="v1:programMembership"/>
				<xsl:apply-templates select="v1:specialTreatment"/>
				<xsl:apply-templates select="v1:customerGroup"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:specialTreatment">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:treatmentType"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:accountContact">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:addressCommunication"
					mode="accountContact-addressCommunication"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:accountBalanceSummaryGroup">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:balanceSummary"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:balanceSummary">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:amount"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:status" mode="status-financialAccount">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:reasonCode"/>
			</xsl:element>
			<!--<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>-->
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:billCycle">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

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

				<xsl:apply-templates select="v1:dayOfMonth"/>
				<xsl:apply-templates select="v1:frequencyCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:billingArrangement">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:billingContact"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:billingContact">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:addressCommunication"
					mode="billingArrangement-addressCommunication"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--<xsl:template match="v1:dayOfMonth">
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
	</xsl:template>-->


	<xsl:template match="v1:customer">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

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

				<xsl:apply-templates select="v1:key"/>
				<xsl:apply-templates select="v1:customerType"/>
				<xsl:apply-templates select="v1:status"/>
				<xsl:apply-templates select="v1:party"/>
				<xsl:apply-templates select="v1:customerGroup"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:party">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:organization"/>
				<xsl:apply-templates select="v1:person"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:organization">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="v1:fullName"/>
				<xsl:apply-templates select="v1:shortName"/>
				<xsl:apply-templates select="v1:legalName"/>
				<xsl:apply-templates select="v1:organizationSpecification"/>
				<xsl:apply-templates select="v1:sicCode"/>
				<xsl:apply-templates select="v1:organizationEmploymentStatistics"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:organizationEmploymentStatistics">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:totalEmployment"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:totalEmployment">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:employeeCount"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:organizationSpecification">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:specificationValue"/>
			</xsl:element>
			<!--xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if-->
		</xsl:if>
	</xsl:template>


	<!--xsl:template match="v1:organizationContact">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="v1:personName"/>
				<xsl:apply-templates select="v1:companyName"/>
				<xsl:apply-templates select="v1:addressCommunication"/>
				<xsl:apply-templates select="v1:phoneCommunication"/>
				<xsl:apply-templates select="v1:emailCommunication"/>
				<xsl:apply-templates select="v1:preferredLanguage"/>
				<xsl:apply-templates select="v1:securityProfile"
					mode="securityProfile-organizationContact"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:securityProfile" mode="securityProfile-organizationContact">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:pin"/>
			</xsl:element>
		</xsl:if>
	</xsl:template-->

	<xsl:template match="v1:person">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:personName" mode="shipTo"/>
				<xsl:apply-templates select="v1:ssn"/>
				<xsl:apply-templates select="v1:preferredLanguage"/>
				<xsl:apply-templates select="v1:addressCommunication"
					mode="addressCommunicationperson"/>
				<xsl:apply-templates select="v1:birthDate"/>
				<xsl:apply-templates select="v1:phoneCommunication" mode="phoneCommunicationperson"/>
				<xsl:apply-templates select="v1:emailCommunication"/>
				<xsl:apply-templates select="v1:driversLicense"/>
				<xsl:apply-templates select="v1:nationalIdentityDocument"/>
				<xsl:apply-templates select="v1:citizenship"/>
				<xsl:apply-templates select="v1:passport"/>
				<xsl:apply-templates select="v1:visa"/>
				<xsl:apply-templates select="v1:gender"/>
				<xsl:apply-templates select="v1:maritalStatus"/>
				<xsl:apply-templates select="v1:activeDutyMilitary"/>
				<xsl:apply-templates select="v1:securityProfile"
					mode="securityProfile-person-party-customer"/>
				<xsl:apply-templates select="v1:identityDocumentVerification"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:nationalIdentityDocument">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:nationalIdentityDocumentIdentifier"/>
				<xsl:apply-templates select="v1:issuingCountryCode"/>
				<xsl:apply-templates select="v1:typeCode"/>
				<xsl:apply-templates select="v1:primaryIndicator"/>
				<xsl:apply-templates select="v1:taxIDIndicator"/>
				<xsl:apply-templates select="v1:issuedDate"/>
				<xsl:apply-templates select="v1:expirationDate"/>
				<xsl:apply-templates select="v1:issuingAuthority"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:identityDocumentVerification">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:identityDocumentType"/>
				<xsl:apply-templates select="v1:validPeriod"/>
				<xsl:apply-templates select="v1:verificationEvent"/>
				<xsl:apply-templates select="v1:verificationStatus"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:validPeriod">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:startDate"/>
				<xsl:apply-templates select="v1:endDate"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:verificationEvent">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:creationContext"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:creationContext">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:userName"/>
				<xsl:apply-templates select="v1:eventDate"/>
				<xsl:apply-templates select="v1:eventTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:verificationStatus">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:preferredLanguage">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:if test="@usageContext">
					<xsl:attribute name="usageContext">
						<xsl:value-of select="@usageContext"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:ssn | v1:cardNumber">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:if test="@maskingType">
					<xsl:attribute name="maskingType">
						<xsl:value-of select="@maskingType"/>
					</xsl:attribute>
				</xsl:if>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:driversLicense">
		<xsl:if test="normalize-space(.) != '' or @id">
			<xsl:element name="{local-name()}">
				<xsl:if test="@id">
					<xsl:attribute name="id" select="@id"/>
				</xsl:if>
				<xsl:apply-templates select="v1:legislationAuthorityCode"/>
				<xsl:apply-templates select="v1:issuingAuthority"/>
				<xsl:apply-templates select="v1:issuingCountryCode"/>
				<xsl:apply-templates select="v1:suspendedIndicator"/>
				<xsl:apply-templates select="v1:suspendedFromDate"/>
				<xsl:apply-templates select="v1:issuingLocation"/>
				<xsl:apply-templates select="v1:comment"/>
				<xsl:apply-templates select="v1:issuePeriod"/>
				<xsl:apply-templates select="v1:driversLicenseClass"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:issuePeriod">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:startTime"/>
				<xsl:apply-templates select="v1:endTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:securityProfile" mode="securityProfile-person-party-customer">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:userName"/>
				<xsl:apply-templates select="v1:pin"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:citizenship">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:countryCode"/>
			</xsl:element>
			<!--<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>-->
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:passport">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:passportNumber"/>
				<xsl:apply-templates select="v1:typeCode"/>
				<xsl:apply-templates select="v1:issuedDate"/>
				<xsl:apply-templates select="v1:expirationDate"/>
				<xsl:apply-templates select="v1:issuingCountryCode"/>
				<xsl:apply-templates select="v1:issuingStateCode"/>
				<xsl:apply-templates select="v1:issuingLocation"/>
				<xsl:apply-templates select="v1:issuingAuthority"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:visa">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:numberID"/>
				<xsl:apply-templates select="v1:typeCode"/>
				<xsl:apply-templates select="v1:classificationCode"/>
				<xsl:apply-templates select="v1:issuingCountryCode"/>
				<xsl:apply-templates select="v1:legislationCode"/>
				<xsl:apply-templates select="v1:validIndicator"/>
				<xsl:apply-templates select="v1:profession"/>
				<xsl:apply-templates select="v1:issuedDate"/>
				<xsl:apply-templates select="v1:expirationDate"/>
				<xsl:apply-templates select="v1:entryDate"/>
				<xsl:apply-templates select="v1:status" mode="visa"/>
				<xsl:apply-templates select="v1:issuingLocation"/>
				<xsl:apply-templates select="v1:issuingAuthority"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:status" mode="visa">
		<xsl:if test="@statusCode">
			<xsl:element name="{local-name()}">
				<xsl:attribute name="statusCode" select="@statusCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:addressCommunication" mode="addressCommunicationperson">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

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

				<!--<xsl:apply-templates select="@*"/>-->
				<!--<xsl:apply-templates select="v1:address"/>-->
				<xsl:apply-templates select="v1:usageContext"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:phoneCommunication" mode="phoneCommunicationperson">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:phoneType"/>
				<xsl:apply-templates select="v1:phoneNumber"/>
				<xsl:apply-templates select="v1:countryDialingCode"/>
				<xsl:apply-templates select="v1:areaCode"/>
				<xsl:apply-templates select="v1:localNumber"/>
				<xsl:apply-templates select="v1:phoneExtension"/>
			</xsl:element>
			<!--<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>-->
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:emailCommunication">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:preference"/>
				<xsl:apply-templates select="v1:emailAddress"/>
				<xsl:apply-templates select="v1:usageContext"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:preference">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:preferred"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:cartItem">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or count(.//@*) != 0) and $check_IncludeExclude='1'">
			<xsl:element name="{local-name()}">

				<xsl:if test="@cartItemId">
					<xsl:attribute name="cartItemId">
						<xsl:value-of select="@cartItemId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@actionCode or v1:cartItemStatus/@statusCode='ERROR'">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="if (v1:cartItemStatus/@statusCode='ERROR') 
							then 'REMOVE' else @actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:overridePriceAllowedIndicator"/>
				<xsl:apply-templates select="v1:quantity"/>
				<xsl:apply-templates select="v1:cartItemStatus"/>
				<xsl:apply-templates select="v1:parentCartItemId"/>
				<xsl:apply-templates select="v1:rootParentCartItemId"/>
				<xsl:apply-templates select="v1:effectivePeriod" mode="cartItem-effectivePeriod"/>
				<xsl:apply-templates select="v1:productOffering"/>
				<xsl:apply-templates select="v1:assignedProduct" mode="cartItem-assignedProduct"/>
				<xsl:apply-templates select="v1:cartSchedule"/>
				<xsl:apply-templates select="v1:specificationGroup"/>
				<xsl:apply-templates select="v1:promotion"/>
				<xsl:apply-templates select="v1:relatedCartItemId"/>
				<xsl:apply-templates select="v1:lineOfService"/>
				<xsl:apply-templates select="v1:networkResource"/>
				<xsl:apply-templates select="v1:transactionType"/>
				<xsl:apply-templates select="v1:inventoryStatus"/>
				<xsl:apply-templates select="v1:deviceConditionQuestions"/>
				<xsl:apply-templates select="v1:originalOrderLineId"/>
				<xsl:apply-templates select="v1:deviceDiagnostics"/>
				<xsl:apply-templates select="v1:reasonCode"/>
				<xsl:apply-templates select="v1:returnAuthorizationType"/>
				<xsl:apply-templates select="v1:revisionReason"/>
				<xsl:apply-templates select="v1:priceChangedIndicator"/>
				<xsl:apply-templates select="v1:financialAccount" mode="financialAccount-cartItem"/>

				<xsl:apply-templates select="v1:backendChangedIndicator"/>
				<xsl:apply-templates select="v1:extendedAmount"/>
				<xsl:apply-templates select="v1:transactionSubType"/>

				<xsl:apply-templates select="v1:totalChargeAmount"/>
				<xsl:apply-templates select="v1:totalDiscountAmount"/>
				<xsl:apply-templates select="v1:totalFeeAmount"/>
				<xsl:apply-templates select="v1:totalTaxAmount"/>
				<xsl:apply-templates select="v1:totalDueNowAmount"/>
				<xsl:apply-templates select="v1:totalDueMonthlyAmount"/>
				<xsl:apply-templates select="v1:totalAmount"/>
				<xsl:apply-templates select="v1:port"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:effectivePeriod" mode="cartItem-effectivePeriod">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:startTime"/>
				<xsl:apply-templates select="v1:endTime"/>
				<xsl:apply-templates select="v1:usageContext"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:quantity">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:if test="@measurementUnit">
					<xsl:attribute name="measurementUnit">
						<xsl:value-of select="@measurementUnit"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="not(contains($acceptType, 'xml'))">
						<xsl:value-of select="concat($pINTEGER,.,$pINTEGER)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="node()"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:port" mode="financialAccount-cartItem">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:apply-templates select="v1:MSISDN"/>
				<xsl:apply-templates select="v1:donorBillingSystem"/>
				<xsl:apply-templates select="v1:donorAccountNumber"/>
				<xsl:apply-templates select="v1:donorAccountPassword"/>
				<xsl:apply-templates select="v1:oldServiceProvider"/>
				<xsl:apply-templates select="v1:portDueTime"/>
				<xsl:apply-templates select="v1:portRequestedTime"/>
				<xsl:apply-templates select="v1:oldServiceProviderName"/>
				<xsl:apply-templates select="v1:oldVirtualServiceProviderId"/>
				<xsl:apply-templates select="v1:personProfile"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:personProfile">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="{local-name()} ">
				<xsl:apply-templates select="v1:addressCommunication" mode="port-personProfile"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:addressCommunication" mode="port-personProfile">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="{local-name()} ">
				<xsl:apply-templates select="v1:address" mode="port-personProfile"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:address" mode="port-personProfile">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="{local-name()} ">
				<xsl:apply-templates select="v1:addressLine1"/>
				<xsl:apply-templates select="v1:addressLine2"/>
				<xsl:apply-templates select="v1:cityName"/>
				<xsl:apply-templates select="v1:stateCode"/>
				<xsl:apply-templates select="v1:countryCode"/>
				<xsl:apply-templates select="v1:postalCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:financialAccount" mode="financialAccount-cartItem">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:financialAccountNumber"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:cartItemStatus">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:name"/>
				<xsl:apply-templates select="v1:description"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:deviceConditionQuestions">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:verificationQuestion"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:verificationQuestion">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:questionText"/>
				<xsl:apply-templates select="v1:verificationAnswer"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:verificationAnswer">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:answerText"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:estimatedAvailable">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:startDate"/>
				<xsl:apply-templates select="v1:endDate"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:inventoryStatus">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<!--<xsl:apply-templates select="@*"/>-->

				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:estimatedAvailable"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<!--<xsl:template match="v1:relatedCartItemId">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="@*|node()"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>-->
	<xsl:template match="v1:productOffering">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

				<xsl:if test="@productOfferingId">
					<xsl:attribute name="productOfferingId">
						<xsl:value-of select="@productOfferingId"/>
					</xsl:attribute>
				</xsl:if>

				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:name"/>
				<xsl:apply-templates select="v1:shortName"/>
				<xsl:apply-templates select="v1:displayName"/>
				<xsl:apply-templates select="v1:description"/>
				<xsl:apply-templates select="v1:shortDescription"/>
				<xsl:apply-templates select="v1:longDescription"/>
				<xsl:apply-templates select="v1:alternateDescription" mode="productOffering"/>
				<xsl:apply-templates select="v1:keyword"/>
				<xsl:apply-templates select="v1:offerType"/>
				<xsl:apply-templates select="v1:offerSubType"/>
				<xsl:apply-templates select="v1:offerLevel"/>
				<xsl:apply-templates select="v1:offeringStatus"/>
				<xsl:apply-templates select="v1:offeringClassification"/>
				<xsl:apply-templates select="v1:businessUnit"/>
				<xsl:apply-templates select="v1:productType" mode="multi"/>
				<xsl:apply-templates select="v1:productSubType" mode="multi"/>
				<xsl:apply-templates select="v1:key"/>
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
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:productOfferingComponent">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:if test="@offeringComponentId">
					<xsl:attribute name="offeringComponentId">
						<xsl:value-of select="@offeringComponentId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:offeringVariant" mode="productOfferingComponent-offeringVariant"/>
			</xsl:element>
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
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:value-of select="."/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:productType" mode="multi">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:value-of select="."/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:productOffering" mode="cartItem_cartSchedule">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

				<xsl:if test="@productOfferingId">
					<xsl:attribute name="productOfferingId">
						<xsl:value-of select="@productOfferingId"/>
					</xsl:attribute>
				</xsl:if>
			</xsl:element>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:productOffering" mode="cartItem_productOffering">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

				<xsl:if test="@productOfferingId">
					<xsl:attribute name="productOfferingId">
						<xsl:value-of select="@productOfferingId"/>
					</xsl:attribute>
				</xsl:if>

				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:name"/>
				<xsl:apply-templates select="v1:shortName"/>
				<xsl:apply-templates select="v1:displayName"/>
				<xsl:apply-templates select="v1:description" mode="multi_attrs"/>
				<xsl:apply-templates select="v1:shortDescription"/>
				<xsl:apply-templates select="v1:longDescription"/>
				<xsl:apply-templates select="v1:alternateDescription" mode="productOffering"/>
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
				<xsl:apply-templates select="v1:offeringPrice" mode="cartItem-productoffering"/>
				<xsl:apply-templates select="v1:image"/>
				<xsl:apply-templates select="v1:marketingMessage"/>
				<xsl:apply-templates select="v1:equipmentCharacteristics"/>
				<xsl:apply-templates select="v1:serviceCharacteristics"/>
				<xsl:apply-templates select="v1:offeringVariant"/>
				<xsl:apply-templates select="v1:productOfferingComponent"/>
				<xsl:apply-templates select="v1:productSpecification"/>
			</xsl:element>

			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:productOffering" mode="LOS_productOffering">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

				<xsl:if test="@productOfferingId">
					<xsl:attribute name="productOfferingId">
						<xsl:value-of select="@productOfferingId"/>
					</xsl:attribute>
				</xsl:if>

				<!--<xsl:apply-templates select="@*"/>-->
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
			</xsl:element>

			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:serviceCharacteristics">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:backDateAllowedIndicator"/>
				<xsl:apply-templates select="v1:futureDateAllowedIndicator"/>
				<xsl:apply-templates select="v1:backDateVisibleIndicator"/>
				<xsl:apply-templates select="v1:futureDateVisibleIndicator"/>
				<xsl:apply-templates select="v1:includedServiceCapacity" mode="multi"/>
				<xsl:apply-templates select="v1:billEffectiveCode"/>
				<xsl:apply-templates select="v1:billableThirdPartyServiceIndicator"/>
				<xsl:apply-templates select="v1:prorateAllowedIndicator"/>
				<xsl:apply-templates select="v1:prorateVisibleIndicator"/>
				<xsl:apply-templates select="v1:duration"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:prorateAllowedIndicator|v1:prorateVisibleIndicator">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
					<xsl:value-of select="."/>
				</xsl:if>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:includedServiceCapacity" mode="multi">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:capacityType"/>
				<xsl:apply-templates select="v1:capacitySubType"/>
				<xsl:apply-templates select="v1:unlimitedIndicator"/>
				<xsl:apply-templates select="v1:size"/>
				<xsl:apply-templates select="v1:measurementUnit"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:equipmentCharacteristics">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:model"/>
				<xsl:apply-templates select="v1:manufacturer"/>
				<xsl:apply-templates select="v1:color"/>
				<xsl:apply-templates select="v1:memory"/>
				<xsl:apply-templates select="v1:tacCode" mode="multi"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:tacCode" mode="multi">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:value-of select="."/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:marketingMessage">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:salesChannelCode"/>
				<xsl:apply-templates select="v1:relativeSize"/>
				<xsl:apply-templates select="v1:messagePart"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:messagePart">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:code"/>
				<xsl:apply-templates select="v1:messageText"/>
				<xsl:apply-templates select="v1:messageSequence"/>
			</xsl:element>
			<!--xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if-->
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:messageText">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:if test="@languageCode">
					<xsl:attribute name="languageCode">
						<xsl:value-of select="@languageCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:offeringClassification">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:classificationCode"/>
				<xsl:apply-templates select="v1:nameValue"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:description" mode="productOffering-description">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:if test="@languageCode">
					<xsl:attribute name="languageCode">
						<xsl:value-of select="@languageCode"/>
					</xsl:attribute>
				</xsl:if>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:shortDescription">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
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
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:specificationValue">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
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

	<xsl:template match="v1:specificationGroup">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="v1:specificationValue"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:offeringStatus">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>

				<!--	<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:effectivePeriod"/>
			</xsl:element>
			<!--<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>-->
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:longDescription">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:descriptionCode"/>
				<xsl:apply-templates select="v1:salesChannelCode"/>
				<xsl:apply-templates select="v1:languageCode"/>
				<xsl:apply-templates select="v1:relativeSize"/>
				<xsl:apply-templates select="v1:contentType"/>
				<xsl:apply-templates select="v1:descriptionText"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:alternateDescription">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:descriptionCode"/>
				<xsl:apply-templates select="v1:salesChannelCode"/>
				<xsl:apply-templates select="v1:languageCode"/>
				<xsl:apply-templates select="v1:relativeSize"/>
				<xsl:apply-templates select="v1:contentType"/>
				<xsl:apply-templates select="v1:descriptionText"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:alternateDescription" mode="productOffering">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:descriptionCode" mode="multi"/>
				<xsl:apply-templates select="v1:salesChannelCode"/>
				<xsl:apply-templates select="v1:languageCode"/>
				<xsl:apply-templates select="v1:relativeSize"/>
				<xsl:apply-templates select="v1:contentType"/>
				<xsl:apply-templates select="v1:descriptionText"/>
			</xsl:element>
			<!--<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>-->
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:descriptionCode" mode="multi">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="{local-name()}">
				<xsl:value-of select="."/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:offeringPrice" mode="cartItem-productoffering">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

				<xsl:if test="@priceListLineId">
					<xsl:attribute name="priceListLineId">
						<xsl:value-of select="@priceListLineId"/>
					</xsl:attribute>
				</xsl:if>

				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:name"/>
				<xsl:apply-templates select="v1:productOfferingPrice" mode="multi"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:offeringPrice">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

				<xsl:if test="@priceListLineId">
					<xsl:attribute name="priceListLineId">
						<xsl:value-of select="@priceListLineId"/>
					</xsl:attribute>
				</xsl:if>

				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:name"/>
				<xsl:apply-templates select="v1:productOfferingPrice"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:productOfferingPrice">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:name"/>
				<xsl:apply-templates select="v1:productChargeType"/>
				<xsl:apply-templates select="v1:productChargeIncurredType"/>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:apply-templates select="v1:oneTimeCharge"/>
				<!--xsl:apply-templates select="v1:recurringFeeFrequency"/-->
				<xsl:apply-templates select="v1:taxInclusiveIndicator"/>
				<xsl:apply-templates select="v1:specificationValue"/>
			</xsl:element>
		</xsl:if>
		<!--<xsl:if test="not(contains($acceptType, 'xml'))">
			<xsl:element name="{local-name()}">
				<xsl:value-of select="$pARRAY"/>
			</xsl:element>
		</xsl:if>-->
	</xsl:template>

	<xsl:template match="v1:orderBehavior">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:preOrderAllowedIndicator"/>
				<xsl:apply-templates select="v1:preOrderAvailableTime"/>
				<xsl:apply-templates select="v1:saleStartTime"/>
				<xsl:apply-templates select="v1:saleEndTime"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:image">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:URI"/>
				<xsl:apply-templates select="v1:sku"/>
				<xsl:apply-templates select="v1:imageDimensions"/>
				<xsl:apply-templates select="v1:displayPurpose"/>
			</xsl:element>
			<!--	<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>-->
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:offeringVariant">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:sku"/>
				<xsl:apply-templates select="v1:specificationGroup"/>
				<xsl:apply-templates select="v1:offeringVariantPrice"/>
				<xsl:apply-templates select="v1:productCondition"/>
				<xsl:apply-templates select="v1:color"/>
				<xsl:apply-templates select="v1:memory"/>
				<xsl:apply-templates select="v1:tacCode" mode="multi"/>
				<xsl:apply-templates select="v1:orderBehavior" mode="multi"/>

			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:orderBehavior" mode="multi">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:preOrderAllowedIndicator"/>
				<xsl:apply-templates select="v1:preOrderAvailableTime"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:preOrderAllowedIndicator">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:offeringVariantPrice">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

				<xsl:if test="@priceListLineId">
					<xsl:attribute name="priceListLineId">
						<xsl:value-of select="@priceListLineId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:name"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:productSpecification">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

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
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
		
	</xsl:template>

	<xsl:template match="v1:keyword">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:additionalSpecification">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:specificationValue"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:cartSchedule">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

				<xsl:apply-templates select="@cartScheduleId"/>
				<xsl:apply-templates select="v1:description"/>
				<xsl:apply-templates select="v1:cartScheduleStatus"/>
				<xsl:apply-templates select="v1:cartScheduleCharge"/>
				<xsl:apply-templates select="v1:cartScheduleDeduction"/>
				<xsl:apply-templates select="v1:cartScheduleTax"/>
				<xsl:apply-templates select="v1:calculationType"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:cartScheduleCharge">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>

				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:typeCode"/>
				<xsl:apply-templates select="v1:chargeFrequencyCode"/>
				<xsl:apply-templates select="v1:basisAmount"/>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:apply-templates select="v1:reason"/>
				<xsl:apply-templates select="v1:effectivePeriod" mode="LOS-effectivePeriod"/>
				<xsl:apply-templates select="v1:description"/>
				<xsl:apply-templates select="v1:chargeCode"/>
				<xsl:apply-templates select="v1:waiverIndicator"/>
				<xsl:apply-templates select="v1:waiverReason"/>
				<xsl:apply-templates select="v1:manuallyAddedCharge"/>
				<xsl:apply-templates select="v1:productOffering" mode="cartItem_cartSchedule"/>
				<xsl:apply-templates select="v1:feeOverrideAllowed"/>
				<xsl:apply-templates select="v1:overrideThresholdPercent"/>
				<xsl:apply-templates select="v1:overrideThresholdAmount"/>
				<xsl:apply-templates select="v1:supervisorID"/>
				<xsl:apply-templates select="v1:overrideAmount"/>
				<xsl:apply-templates select="v1:overrideReason"/>
				<xsl:apply-templates select="v1:productOfferingPriceId"/>
				<xsl:apply-templates select="v1:proratedIndicator"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:cartScheduleDeduction">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<!--xsl:if test="@deductionId">
					<xsl:attribute name="deductionId">
						<xsl:value-of select="@deductionId"/>
					</xsl:attribute>
				</xsl:if-->
				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:amount"/>
				<xsl:apply-templates select="v1:reason"/>
				<xsl:apply-templates select="v1:effectivePeriod" mode="LOS-effectivePeriod"/>
				<xsl:apply-templates select="v1:description"/>
				<xsl:apply-templates select="v1:recurringFrequency"/>
				<xsl:apply-templates select="v1:promotion" mode="promotion-cartScheduleDeduction"/>
				<xsl:apply-templates select="v1:chargeCode"/>
				<xsl:apply-templates select="v1:productOfferingPriceId"/>
				<xsl:apply-templates select="v1:specificationValue"/>
				<xsl:apply-templates select="v1:realizationMethod"/>
				<xsl:apply-templates select="v1:proratedIndicator"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:promotion" mode="promotion-cartScheduleDeduction">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

				<xsl:if test="@promotionId">
					<xsl:attribute name="promotionId">
						<xsl:value-of select="@promotionId"/>
					</xsl:attribute>
				</xsl:if>
				<!--<xsl:apply-templates select="@*"/>-->
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:cartScheduleTax">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="@id"/>
				<xsl:apply-templates select="v1:code"/>
				<xsl:apply-templates select="v1:taxJurisdiction"/>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:apply-templates select="v1:typeCode"/>
				<xsl:apply-templates select="v1:description"/>
				<xsl:apply-templates select="v1:taxRate"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:description" mode="multi">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:value-of select="."/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:description" mode="multi_attrs">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
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
				
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:promotion" mode="cartPromotion">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or count(.//@*) != 0) and $check_IncludeExclude='1'">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:promotionCode"/>
			</xsl:element>
			<!--	<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>-->
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:promotion">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

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

				<!--	<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:promotionName"/>
				<xsl:apply-templates select="v1:promotionCode"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:lineOfService">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

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

				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:financialAccountNumber"/>
				<xsl:apply-templates select="v1:subscriberContact"/>
				<xsl:apply-templates select="v1:networkResource"
					mode="lineOfService-networkResource"/>
				<!--xsl:apply-templates select="v1:pin"/-->
				<xsl:apply-templates select="v1:lineOfServiceStatus"/>
				<xsl:apply-templates select="v1:primaryLineIndicator"/>
				<xsl:apply-templates select="v1:lineAlias"/>
				<xsl:apply-templates select="v1:lineSequence"/>
				<xsl:apply-templates select="v1:assignedProduct"/>
				<xsl:apply-templates select="v1:preferredLanguage"/>
				<xsl:apply-templates select="v1:effectivePeriod" mode="LOS-effectivePeriod"/>
				<xsl:apply-templates select="v1:memberLineOfService"/>
				<xsl:apply-templates select="v1:specificationGroup"/>
				<xsl:apply-templates select="v1:privacyProfile" mode="accountHolderAddress-privacyProfile"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:memberLineOfService">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:primaryLineIndicator"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:lineOfServiceStatus">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:apply-templates select="v1:reasonCode"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:subscriberContact">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="v1:personName"/>
				<xsl:apply-templates select="v1:addressCommunication"
					mode="addressCommunicationsubscriberContact"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:addressCommunication" mode="addressCommunicationsubscriberContact">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

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
				<xsl:apply-templates select="v1:privacyProfile" mode="addressCommunicationsubscriberContact"/>
				<xsl:apply-templates select="v1:address"/>
				<xsl:apply-templates select="v1:usageContext"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:privacyProfile" mode="addressCommunicationsubscriberContact">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:optOut"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:networkResource" mode="lineOfService-networkResource">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:imei"/>
				<xsl:apply-templates select="v1:sim"/>
				<xsl:apply-templates select="v1:mobileNumber" mode="networkMobile"/>
				<xsl:apply-templates select="v1:resourceSpecification"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	
	<!--R1.6.4 -->
	<xsl:template match="v1:resourceSpecification">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="@name"/>
				<xsl:apply-templates select="v1:specificationValue"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:networkResource">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">

				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>

				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:imei"/>
				<xsl:apply-templates select="v1:sim" mode="networkResource-sim"/>
				<xsl:apply-templates select="v1:mobileNumber" mode="networkResource-mobileNumber"/>
				<xsl:apply-templates select="v1:resourceSpecification"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:sim" mode="networkResource-sim">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:simNumber"/>
				<xsl:apply-templates select="v1:imsi"/>
				<xsl:apply-templates select="v1:simType"/>
				<xsl:apply-templates select="v1:virtualSim"/>
				<xsl:apply-templates select="v1:embeddedSIMIndicator"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:mobileNumber" mode="networkResource-mobileNumber">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:msisdn"/>
				<xsl:apply-templates select="v1:portIndicator"/>
				<xsl:apply-templates select="v1:portReason"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:mobileNumber" mode="networkMobile">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:msisdn"/>
				<xsl:apply-templates select="v1:portIndicator"/>
				<xsl:apply-templates select="v1:portReason"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:sim">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:simNumber"/>
				<xsl:apply-templates select="v1:imsi"/>
				<xsl:apply-templates select="v1:simType"/>
				<xsl:apply-templates select="v1:virtualSim"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:assignedProduct" mode="cartItem-assignedProduct">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:productOffering" mode="cartItem_productOffering"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>



	<xsl:template match="v1:assignedProduct">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">


				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:key"/>
				<xsl:apply-templates select="v1:productOffering" mode="LOS_productOffering"/>
				<xsl:apply-templates select="v1:effectivePeriod" mode="cartItem-effectivePeriod"/>
				<xsl:apply-templates select="v1:customerOwnedIndicator"/>
				<xsl:apply-templates select="v1:serialNumber"/>
				<xsl:apply-templates select="v1:eligibilityEvaluation"/>
				<xsl:apply-templates select="v1:warranty"/>
				<!--xsl:apply-templates select="v1:effectivePeriod"
					mode="assignedProduct-effectivePeriod"/-->
			</xsl:element>
			<!--<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>-->
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:eligibilityEvaluation">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:overrideIndicator"/>
				
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:effectivePeriod" mode="LOS-effectivePeriod">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:startTime"/>
				<xsl:apply-templates select="v1:endTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:warranty">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="v1:warrantyExpirationDate"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:productOfferingPrice" mode="multi">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:name"/>
				<xsl:apply-templates select="v1:productChargeType"/>
				<xsl:apply-templates select="v1:productChargeIncurredType"/>
				<xsl:apply-templates select="v1:basisAmount"/>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:apply-templates select="v1:oneTimeCharge"/>
				<xsl:apply-templates select="v1:taxInclusiveIndicator"/>
				<xsl:apply-templates select="v1:specificationValue"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:productOfferingPrice" mode="productOfferingPriceofferingPrice">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:name"/>
				<xsl:apply-templates select="v1:productChargeType"/>
				<xsl:apply-templates select="v1:productChargeIncurredType"/>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:apply-templates select="v1:oneTimeCharge"/>
				<xsl:apply-templates select="v1:recurringFeeFrequency"/>
				<xsl:apply-templates select="v1:taxInclusiveIndicator"/>
				<xsl:apply-templates select="v1:specificationValue"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>



	<xsl:template match="v1:effectivePeriod | v1:promotionEffectivePeriod">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:startTime"/>
				<xsl:apply-templates select="v1:endTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:sim" mode="simnetworkResource">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:simNumber"/>
				<xsl:apply-templates select="v1:imsi"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:mobileNumber">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:msisdn"/>
				<xsl:apply-templates select="v1:portIndicator"/>
				<xsl:apply-templates select="v1:portReason"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:charge">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or count(.//@*) != 0) and $check_IncludeExclude='1'">
			<xsl:element name="{local-name()}">

				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:typeCode"/>
				<xsl:apply-templates select="v1:chargeFrequencyCode"/>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:apply-templates select="v1:description"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:deduction">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or count(.//@*) != 0) and $check_IncludeExclude='1'">
			<xsl:element name="{local-name()}">

				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<!--	<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:amount"/>
				<xsl:apply-templates select="v1:description"/>
				<xsl:apply-templates select="v1:recurringFrequency"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:tax">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or count(.//@*) != 0) and $check_IncludeExclude='1'">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:amount"/>
				<xsl:apply-templates select="v1:description"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:freightCharge">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or count(.//@*) != 0) and $check_IncludeExclude='1'">
			<xsl:element name="{local-name()}">
				<xsl:if test="@chargeId">
					<xsl:attribute name="chargeId">
						<xsl:value-of select="@chargeId"/>
					</xsl:attribute>
				</xsl:if>
				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:amount"/>
				<xsl:apply-templates select="v1:chargeCode"/>
				<xsl:apply-templates select="v1:waiverIndicator"/>
				<xsl:apply-templates select="v1:waiverReason"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template
		match="v1:basisAmount | v1:totalSoftGoodRecurringDueNowAmount | v1:totalSoftGoodOneTimeDueNowAmount | v1:totalHardGoodDueNowAmount | v1:totalSoftGoodDueNowAmount | v1:totalCurrentRecurringAmount | v1:totalDeltaRecurringDueAmount | v1:totalExtendedAmount | v1:amount | v1:extendedAmount | v1:totalAmount | v1:totalChargeAmount | v1:totalDiscountAmount | v1:totalFeeAmount | v1:totalTaxAmount | v1:totalDueNowAmount | v1:totalDueMonthlyAmount | v1:overrideThresholdAmount | v1:overrideAmount | v1:totalRefundAmountDueLater | v1:finalRefundAmountDueNow | v1:totalRefundAmountDueNow | v1:currentRecurringChargeAmount | v1:totalRecurringDueAmount | v1:totalDueAmount | v1:chargeAmount | v1:requestAmount | v1:totalDuePayNowAmount | v1:authorizationAmount">
		<xsl:if test="normalize-space(.) != '' or @currencyCode">
			<xsl:element name="{local-name()}">
				<xsl:attribute name="currencyCode">
					<xsl:value-of select="if (@currencyCode != '')
						then  @currencyCode else 'USD'"/>
				</xsl:attribute>
				<xsl:choose>
					<xsl:when test="not(contains($acceptType, 'xml'))">
						<xsl:value-of select="concat($pINTEGER, ., $pINTEGER)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="."/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template
		match=" v1:size |v1:employeeCount|v1:checkNumber|v1:overrideThresholdPercent|v1:dayOfMonth">
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

	<xsl:template match="v1:oneTimeCharge|v1:customerOwnedIndicator|v1:suspendedIndicator|v1:primaryIndicator|v1:taxIDIndicator">
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


	<xsl:template match="v1:payment">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or count(.//@*) != 0) and $check_IncludeExclude='1'">
			<xsl:element name="{local-name()}">

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

				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:status" mode="status-payment"/>
				<xsl:apply-templates select="v1:authorizationAmount"/>
				<xsl:apply-templates select="v1:requestAmount"/>
				<xsl:apply-templates select="v1:paymentMethodCode"/>
				<!--xsl:apply-templates select="v1:payFromParty"/-->
				<xsl:apply-templates select="v1:payeeParty"/>
				<!--xsl:apply-templates select="v1:paymentLine"/-->
				<xsl:apply-templates select="v1:voucherRedemption"/>
				<xsl:apply-templates select="v1:bankPayment"/>
				<xsl:apply-templates select="v1:creditCardPayment"/>
				<xsl:apply-templates select="v1:debitCardPayment"/>
				<!--xsl:apply-templates select="v1:merchantId"/-->
				<xsl:apply-templates select="v1:transactionType"/>
				<!--xsl:apply-templates select="v1:authorizationChannel"/>
				<xsl:apply-templates select="v1:pointOfSaleReceiptNumber"/-->
				<xsl:apply-templates select="v1:specificationGroup"/>
				<!--xsl:apply-templates select="v1:receivedPaymentId"/>
				<xsl:apply-templates select="v1:receiptMethodCode"/>
				<xsl:apply-templates select="v1:storePaymentMethodIndicator"/>
				<xsl:apply-templates select="v1:isTemporyToken"/>
				<xsl:apply-templates select="v1:settlementIndicator"/>
				<xsl:apply-templates select="v1:termsAndConditionsDisposition"/>
				<xsl:apply-templates select="v1:terminalEntryCapability"/>
				<xsl:apply-templates select="v1:cardCaptureCapability"/>
				<xsl:apply-templates select="v1:posConditionCode"/>
				<xsl:apply-templates select="v1:posId"/>
				<xsl:apply-templates select="v1:paymentTransactionType"/>
				<xsl:apply-templates select="v1:retailPinlessFlag"/>
				<xsl:apply-templates select="v1:trackData"/>
				<xsl:apply-templates select="v1:electronicAuthenticationCapability"/-->
				<xsl:apply-templates select="v1:tokenization"/>
				<!--xsl:apply-templates select="v1:terminalID"/-->
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<!--xsl:template match="v1:paymentLine">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:financialAccountNumber"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template-->

	<xsl:template match="v1:status" mode="status-payment">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:name"/>
				<xsl:apply-templates select="v1:description"/>
				<xsl:apply-templates select="v1:reasonCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:tokenization">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:encryptionTarget"/>
				<xsl:apply-templates select="v1:encryptedContent"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:bankPayment">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:payFromBankAccount"/>
				<!--xsl:apply-templates select="v1:check"/-->
				<xsl:apply-templates select="v1:chargeAccountNumberIndicator"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--xsl:template match="v1:check">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:accountNumber"/>
				<xsl:apply-templates select="v1:routingNumber"/>
				<xsl:apply-templates select="v1:checkNumber"/>
			</xsl:element>
		</xsl:if>
	</xsl:template-->

	<xsl:template match="v1:payFromBankAccount">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:name"/>
				<xsl:apply-templates select="v1:accountNumber"/>
				<xsl:apply-templates select="v1:bank"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:bank">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:routingNumber"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:payeeParty">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:personName" mode="personName-payeeParty"/>
				<xsl:apply-templates select="v1:addressCommunication" mode="payeeParty"/>
			</xsl:element>
			<!--xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if-->
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:personName" mode="personName-payeeParty">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:firstName"/>
				<xsl:apply-templates select="v1:middleName"/>
				<xsl:apply-templates select="v1:familyName"/>
			</xsl:element>			
		</xsl:if>
	</xsl:template>
	
	<!--xsl:template match="v1:payFromParty">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:securityProfile"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:securityProfile">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:msisdn"/>
			</xsl:element>
		</xsl:if>
	</xsl:template-->
	
	<xsl:template match="v1:voucherRedemption">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:serialNumber"/>
				<xsl:apply-templates select="v1:issuerId"/>
				<xsl:apply-templates select="v1:PIN"/>
				<xsl:apply-templates select="v1:voucherRedemptionType"/>
			</xsl:element>
			<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:creditCardPayment">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:authorizationId"/>
				<xsl:apply-templates select="v1:chargeAmount"/>
				<xsl:apply-templates select="v1:creditCard"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:creditCard">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:typeCode"/>
				<xsl:apply-templates select="v1:cardNumber"/>
				<xsl:apply-templates select="v1:cardHolderName"/>
				<xsl:apply-templates select="v1:expirationMonthYear"/>
				<!--xsl:apply-templates select="v1:cardHolderAddress"/>
				<xsl:apply-templates select="v1:cardHolderFirstName"/>
				<xsl:apply-templates select="v1:cardHolderLastName"/>
				<xsl:apply-templates select="v1:cardTypeIndicator"/>
				<xsl:apply-templates select="v1:chargeAccountNumberIndicator"/-->
				<xsl:apply-templates select="v1:cardHolderBillingAddress"/>
				<!--xsl:apply-templates select="v1:securityCode"/-->
			</xsl:element>
		</xsl:if>
	</xsl:template>



	<xsl:template match="v1:cardHolderAddress">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<!--xsl:apply-templates select="v1:addressFormatType"/>
				<xsl:apply-templates select="v1:addressLine1"/>
				<xsl:apply-templates select="v1:addressLine2"/>
				<xsl:apply-templates select="v1:cityName"/>
				<xsl:apply-templates select="v1:stateName"/>
				<xsl:apply-templates select="v1:countryCode"/-->
				<xsl:apply-templates select="v1:postalCode"/>
				<xsl:apply-templates select="v1:postalCodeExtension"/>
				<!--xsl:apply-templates select="v1:key"/-->
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:cardHolderBillingAddress">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<!--xsl:apply-templates select="v1:addressFormatType"/>
				<xsl:apply-templates select="v1:addressLine1"/>
				<xsl:apply-templates select="v1:addressLine2"/>
				<xsl:apply-templates select="v1:cityName"/>
				<xsl:apply-templates select="v1:stateName"/>
				<xsl:apply-templates select="v1:countryCode"/-->
				<xsl:apply-templates select="v1:postalCode"/>
				<xsl:apply-templates select="v1:postalCodeExtension"/>
				<!--xsl:apply-templates select="v1:key"/-->
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:debitCardPayment">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:authorizationId"/>
				<xsl:apply-templates select="v1:chargeAmount"/>
				<xsl:apply-templates select="v1:debitCard"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:debitCard">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:typeCode"/>
				<xsl:apply-templates select="v1:cardNumber"/>
				<xsl:apply-templates select="v1:cardHolderName"/>
				<xsl:apply-templates select="v1:expirationMonthYear"/>
				<xsl:apply-templates select="v1:cardHolderAddress"/>
				<!--xsl:apply-templates select="v1:cardHolderFirstName"/>
				<xsl:apply-templates select="v1:cardHolderLastName"/>
				<xsl:apply-templates select="v1:cardTypeIndicator"/>
				<xsl:apply-templates select="v1:chargeAccountNumberIndicator"/>
				<xsl:apply-templates select="v1:PIN"/-->
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:trackData">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:track1Data"/>
				<xsl:apply-templates select="v1:track2Data"/>
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
