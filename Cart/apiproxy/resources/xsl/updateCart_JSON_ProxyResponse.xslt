<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:v1="http://services.tmobile.com/OrderManagement/CartWSIL/V1"
	xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:base="http://services.tmobile.com/base"
	exclude-result-prefixes="v1 base xs soapenv">	
	<xsl:param name="acceptType"/>
	<xsl:param name="cartItemId"/>
	<xsl:param name="pARRAY" select="'~ARRAY~'"/>
	<xsl:param name="pINTEGER" select="'~INT~'"/>
	<xsl:param name="pBOOLEAN" select="'~INT~'"/>

	<xsl:param name="include"/>
	<xsl:param name="exclude"/>

	<xsl:output method="xml" indent="no" encoding="UTF-8" version="1.0" omit-xml-declaration="yes"/>
	
	<xsl:strip-space elements="*"/>
	<xsl:variable name="modifyInclude">
		<xsl:choose>
			<xsl:when test="$include = 'cart'"/>
			<xsl:when test="$include = '{}'"/>
			<xsl:when test="$include = '{cart}'"/>
			<xsl:when test="contains($include, '{cart,')">
				<xsl:value-of select="substring($include, 7, string-length($include) - 5)"/>
			</xsl:when>
			<xsl:when test="contains($include, 'cart,')">
				<xsl:value-of select="substring($include, 6, string-length($include) - 4)"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$include"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:template match="/">
		<xsl:variable name="varResponse" select="soapenv:Envelope/soapenv:Body/v1:updateCartResponse"/>
		<xsl:choose>
			<xsl:when test="not($include) and not($exclude)">
				<response/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="$varResponse/v1:cart"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<xsl:template match="v1:*">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()} ">
				<xsl:apply-templates select="@* | node()"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template name="Include-Exclude">

		<!--'include' are provided and 'exlcude' are not  10 -->
		<xsl:if test="not(not($modifyInclude)) and not($exclude)">
			<xsl:choose>
				<xsl:when
					test="(normalize-space(.) != '' or count(.//@*) != 0) and (contains(string($modifyInclude), local-name()))">
					<xsl:value-of select="'1'"/>
				</xsl:when>
			</xsl:choose>
		</xsl:if>

		<!--Both are provided  11-->
		<xsl:if test="not(not($modifyInclude)) and $exclude">
			<xsl:choose>
				<xsl:when
					test="(normalize-space(.) != '' or count(.//@*) != 0) and (contains(string($modifyInclude), local-name()))">
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
				<xsl:when test="contains($exclude, local-name())">
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

	<xsl:template match="comment()"/>

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
				<xsl:if test="normalize-space(v1:orderTime) != ''">
					<orderTime>
						<xsl:value-of select="v1:orderTime"/>
					</orderTime>
				</xsl:if>

				<xsl:apply-templates select="v1:status"/>
				<xsl:if test="normalize-space(v1:reason) != ''">
					<reason>
						<xsl:value-of select="v1:reason"/>
					</reason>
				</xsl:if>

				<xsl:if test="normalize-space(v1:orderType) != ''">
					<orderType>
						<xsl:value-of select="v1:orderType"/>
					</orderType>
				</xsl:if>

				<xsl:apply-templates select="v1:salesChannel"/>
				<xsl:if test="normalize-space(v1:businessUnitName) != ''">
					<businessUnitName>
						<xsl:value-of select="v1:businessUnitName"/>
					</businessUnitName>
				</xsl:if>

				<xsl:apply-templates select="v1:salesperson"/>
				<!--xsl:apply-templates select="v1:promotion" mode="cartPromotion"/-->
				<xsl:apply-templates select="v1:cartSpecification"/>
				<xsl:if test="normalize-space(v1:backOrderAllowedIndicator) != ''">
					<backOrderAllowedIndicator>
						<xsl:value-of select="v1:backOrderAllowedIndicator"/>
					</backOrderAllowedIndicator>
				</xsl:if>

				<xsl:if test="normalize-space(v1:ipAddress) != ''">
					<ipAddress>
						<xsl:value-of select="v1:ipAddress"/>
					</ipAddress>
				</xsl:if>

				<xsl:if test="normalize-space(v1:deviceFingerPrintId) != ''">
					<deviceFingerPrintId>
						<xsl:value-of select="v1:deviceFingerPrintId"/>
					</deviceFingerPrintId>
				</xsl:if>

				<xsl:apply-templates select="v1:termsAndConditionsDisposition"/>
				<xsl:apply-templates select="v1:currentRecurringChargeAmount"/>
				<xsl:apply-templates select="v1:totalRecurringDueAmount"/>
				<!--	<xsl:if test="normalize-space(v1:currentRecurringChargeAmount) != ''">
					<currentRecurringChargeAmount>
						<xsl:value-of select="v1:currentRecurringChargeAmount"/>
					</currentRecurringChargeAmount>
				</xsl:if>
				<xsl:if test="normalize-space(v1:totalRecurringDueAmount) != ''">
					<totalRecurringDueAmount>
						<xsl:value-of select="v1:totalRecurringDueAmount"/>
					</totalRecurringDueAmount>
				</xsl:if>-->
				<xsl:apply-templates select="v1:totalDueAmount"/>

				<xsl:if test="normalize-space(v1:originalOrderId) != ''">
					<originalOrderId>
						<xsl:value-of select="v1:originalOrderId"/>
					</originalOrderId>
				</xsl:if>
				<xsl:if test="normalize-space(v1:modeOfExchange) != ''">
					<modeOfExchange>
						<xsl:value-of select="v1:modeOfExchange"/>
					</modeOfExchange>
				</xsl:if>

				<xsl:apply-templates select="v1:relatedOrder"/>
				<xsl:if test="normalize-space(v1:fraudCheckRequired) != ''">
					<fraudCheckRequired>
						<xsl:value-of select="v1:fraudCheckRequired"/>
					</fraudCheckRequired>
				</xsl:if>
				<xsl:if test="normalize-space(v1:isInFlightOrder) != ''">
					<isInFlightOrder>
						<xsl:value-of select="v1:isInFlightOrder"/>
					</isInFlightOrder>
				</xsl:if>
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
				<xsl:apply-templates select="v1:validationMessage"/>
			</cart>
		</xsl:if>
	</xsl:template>


	<!--__________________________Start Cart Children____________________________-->

	<xsl:template match="v1:orderLocation">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>

		<xsl:if test="(normalize-space(.) != '' or @id) and $check_IncludeExclude = '1'">
			<orderLocation>
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="normalize-space(v1:location) != '' or v1:location/@id">
					<location>
						<xsl:if test="v1:location/@id">
							<xsl:attribute name="id">
								<xsl:value-of select="v1:location/@id"/>
							</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="v1:location"/>
					</location>
				</xsl:if>
				<xsl:if test="normalize-space(v1:tillNumber) != ''">
					<tillNumber>
						<xsl:value-of select="v1:tillNumber"/>
					</tillNumber>
				</xsl:if>
			</orderLocation>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:orderTime">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>

		<xsl:if test="(normalize-space(.) != '') and $check_IncludeExclude = '1'">
			<orderTime>
				<xsl:value-of select="."/>
			</orderTime>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:status">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or @statusCode) and $check_IncludeExclude = '1'">
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

	<xsl:template match="v1:reason">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>

		<xsl:if test="normalize-space(.) != '' and $check_IncludeExclude = '1'">
			<reason>
				<xsl:value-of select="."/>
			</reason>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:orderType">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>

		<xsl:if test="normalize-space(.) != '' and $check_IncludeExclude = '1'">
			<orderType>
				<xsl:value-of select="."/>
			</orderType>
		</xsl:if>
	</xsl:template>

	<!-- CD3D1-->
	<xsl:template match="v1:salesChannel">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="normalize-space(.) != '' and $check_IncludeExclude = '1'">
			<salesChannel>
				<xsl:if test="normalize-space(v1:salesChannelCode) != ''">
					<salesChannelCode>
						<xsl:value-of select="v1:salesChannelCode"/>
					</salesChannelCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:salesSubChannelCode) != ''">
					<salesSubChannelCode>
						<xsl:value-of select="v1:salesSubChannelCode"/>
					</salesSubChannelCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:subChannelCategory) != ''">
					<subChannelCategory>
						<xsl:value-of select="v1:subChannelCategory"/>
					</subChannelCategory>
				</xsl:if>
			</salesChannel>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:businessUnitName">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>

		<xsl:if test="normalize-space(.) != '' and $check_IncludeExclude = '1'">
			<businessUnitName>
				<xsl:apply-templates select="@* | node()"/>
			</businessUnitName>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:salesperson">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>

		<xsl:if test="normalize-space(.) != '' and $check_IncludeExclude = '1'">
			<salesperson>
				<xsl:if test="normalize-space(v1:userName) != ''">
					<userName>
						<xsl:value-of select="v1:userName"/>
					</userName>
				</xsl:if>
				<xsl:apply-templates select="v1:personName" mode="personName-salesperson"/>
			</salesperson>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:personName" mode="personName-salesperson">
		<xsl:if test="normalize-space(.) != ''">
			<personName>
				<xsl:if test="normalize-space(v1:firstName) != ''">
					<firstName>
						<xsl:value-of select="v1:firstName"/>
					</firstName>
				</xsl:if>
				<xsl:if test="normalize-space(v1:familyName) != ''">
					<familyName>
						<xsl:value-of select="v1:familyName"/>
					</familyName>
				</xsl:if>
			</personName>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:promotion" mode="cartPromotion">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="normalize-space(.) != '' and $check_IncludeExclude = '1'">
			<promotion>
				<xsl:apply-templates select="v1:promotionCode"/>
			</promotion>
	<!--		<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>-->
		</xsl:if>
	</xsl:template>

	<!-- CD3D1-->
	<xsl:template match="v1:cartSpecification">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or @name) and $check_IncludeExclude = '1'">
			<cartSpecification>
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:specificationValue"/>
			</cartSpecification>
			<cartSpecification>
				<xsl:value-of select="$pARRAY"/>
			</cartSpecification>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:backOrderAllowedIndicator">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>

		<xsl:if test="normalize-space(.) != '' and $check_IncludeExclude = '1'">
			<backOrderAllowedIndicator>
				<xsl:apply-templates select="@* | node()"/>
			</backOrderAllowedIndicator>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:ipAddress">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>

		<xsl:if test="(normalize-space(.) != '') and $check_IncludeExclude = '1'">
			<ipAddress>
				<xsl:apply-templates select="@* | node()"/>
			</ipAddress>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:deviceFingerPrintId">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>

		<xsl:if test="(normalize-space(.) != '') and $check_IncludeExclude = '1'">
			<deviceFingerPrintId>
				<xsl:apply-templates select="@* | node()"/>
			</deviceFingerPrintId>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:termsAndConditionsDisposition">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '') and $check_IncludeExclude = '1'">
			<termsAndConditionsDisposition>
				<xsl:if test="normalize-space(v1:acceptanceIndicator) != ''">
					<acceptanceIndicator>
						<xsl:value-of select="v1:acceptanceIndicator"/>
					</acceptanceIndicator>
				</xsl:if>
				<xsl:if test="normalize-space(v1:acceptanceTime) != ''">
					<acceptanceTime>
						<xsl:value-of select="v1:acceptanceTime"/>
					</acceptanceTime>
				</xsl:if>
			</termsAndConditionsDisposition>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:currentRecurringChargeAmount">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or @currencyCode) and $check_IncludeExclude = '1'">
			<currentRecurringChargeAmount>
				<xsl:attribute name="currencyCode">
					<xsl:value-of select="if (@currencyCode != '')
						then  @currencyCode else 'USD'"/>
				</xsl:attribute>
				<xsl:value-of select="concat($pINTEGER, ., $pINTEGER)"/>
			</currentRecurringChargeAmount>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:totalRecurringDueAmount">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or @currencyCode) and $check_IncludeExclude = '1'">
			<totalRecurringDueAmount>
				<xsl:attribute name="currencyCode">
					<xsl:value-of select="if (@currencyCode != '')
						then  @currencyCode else 'USD'"/>
				</xsl:attribute>
				<xsl:value-of select="concat($pINTEGER, ., $pINTEGER)"/>
			</totalRecurringDueAmount>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:totalDueAmount">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if
			test="(normalize-space(.) != '' or @currencyCode) and $check_IncludeExclude = '1'">
			<totalDueAmount>
				<xsl:attribute name="currencyCode">
					<xsl:value-of select="if (@currencyCode != '')
						then  @currencyCode else 'USD'"/>
				</xsl:attribute>
				<xsl:value-of select="concat($pINTEGER, ., $pINTEGER)"/>
			</totalDueAmount>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:originalOrderId">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>

		<xsl:if test="(normalize-space(.) != '') and $check_IncludeExclude = '1'">
			<originalOrderId>
				<xsl:value-of select="."/>
			</originalOrderId>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:modeOfExchange">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>

		<xsl:if test="(normalize-space(.) != '') and $check_IncludeExclude = '1'">
			<modeOfExchange>
				<xsl:value-of select="."/>
			</modeOfExchange>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:relatedOrder">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '') and $check_IncludeExclude = '1'">
			<relatedOrder>
				<xsl:if test="normalize-space(v1:orderId) != ''">
					<orderId>
						<xsl:value-of select="v1:orderId"/>
					</orderId>
				</xsl:if>
				<xsl:if test="normalize-space(v1:relationshipType) != ''">
					<relationshipType>
						<xsl:value-of select="v1:relationshipType"/>
					</relationshipType>
				</xsl:if>
				<xsl:apply-templates select="v1:orderStatus"/>
			</relatedOrder>

		</xsl:if>
	</xsl:template>

	<!--	<xsl:template match="v1:reasonDescription">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>

		<xsl:if test="(normalize-space(.) != '' ) and $check_IncludeExclude='1'">
			<reasonDescription>
				<xsl:value-of select="."/>
			</reasonDescription>
		</xsl:if>
	</xsl:template>-->

	<xsl:template match="v1:fraudCheckRequired">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>

		<xsl:if test="(normalize-space(.) != '') and $check_IncludeExclude = '1'">
			<fraudCheckRequired>
				<xsl:value-of select="."/>
			</fraudCheckRequired>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:isInFlightOrder">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>

		<xsl:if test="(normalize-space(.) != '') and $check_IncludeExclude = '1'">
			<isInFlightOrder>
				<xsl:value-of select="."/>
			</isInFlightOrder>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:shipping">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '') and $check_IncludeExclude = '1'">
			<shipping>
				<xsl:if test="normalize-space(v1:freightCarrier) != ''">
					<freightCarrier>
						<xsl:value-of select="v1:freightCarrier"/>
					</freightCarrier>
				</xsl:if>
				<xsl:if test="normalize-space(v1:promisedDeliveryTime) != ''">
					<promisedDeliveryTime>
						<xsl:value-of select="v1:promisedDeliveryTime"/>
					</promisedDeliveryTime>
				</xsl:if>
				<xsl:apply-templates select="v1:shipTo"/>
				<xsl:apply-templates select="v1:note"/>
				<xsl:if test="normalize-space(v1:serviceLevelCode) != ''">
					<serviceLevelCode>
						<xsl:value-of select="v1:serviceLevelCode"/>
					</serviceLevelCode>
				</xsl:if>
			</shipping>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:note">
		<xsl:if test="(normalize-space(.) != '' or @language)">
			<note>
				<xsl:if test="@language != ''">
					<xsl:attribute name="language">
						<xsl:value-of select="@language"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="normalize-space(v1:entryTime) != ''">
					<entryTime>
						<xsl:value-of select="v1:entryTime"/>
					</entryTime>
				</xsl:if>
				<xsl:if test="normalize-space(v1:noteType) != ''">
					<noteType>
						<xsl:value-of select="v1:noteType"/>
					</noteType>
				</xsl:if>
				<xsl:if test="normalize-space(v1:content) != ''">
					<content>
						<xsl:value-of select="v1:content"/>
					</content>
				</xsl:if>
				<xsl:if test="normalize-space(v1:author) != ''">
					<author>
						<xsl:value-of select="v1:author"/>
					</author>
				</xsl:if>
			</note>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:billTo">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '') and $check_IncludeExclude = '1'">
			<billTo>
				<xsl:apply-templates select="v1:customerAccount"/>
				<xsl:apply-templates select="v1:customer"/>
			</billTo>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:cartItem">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if
			test="(normalize-space(.) != '' or @cartItemId or @actionCode) and $check_IncludeExclude = '1'">
			<cartItem>
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
				<xsl:apply-templates select="v1:uiAddedIndicator"/>
				<xsl:if test="normalize-space(v1:overridePriceAllowedIndicator) != ''">
					<overridePriceAllowedIndicator>
						<xsl:value-of select="v1:overridePriceAllowedIndicator"/>
					</overridePriceAllowedIndicator>
				</xsl:if>
				<xsl:apply-templates select="v1:quantity"/>
				<xsl:apply-templates select="v1:cartItemStatus"/>
				<xsl:if test="normalize-space(v1:parentCartItemId) != ''">
					<parentCartItemId>
						<xsl:value-of select="v1:parentCartItemId"/>
					</parentCartItemId>
				</xsl:if>
				<xsl:if test="normalize-space(v1:rootParentCartItemId) != ''">
					<rootParentCartItemId>
						<xsl:value-of select="v1:rootParentCartItemId"/>
					</rootParentCartItemId>
				</xsl:if>
				<xsl:apply-templates select="v1:effectivePeriod" mode="cartItem-effectivePeriod"/>
				<xsl:apply-templates select="v1:productOffering"/>
				<xsl:apply-templates select="v1:assignedProduct"/>
				<xsl:apply-templates select="v1:cartSchedule"/>
				<xsl:apply-templates select="v1:specificationGroup"/>
				<xsl:apply-templates select="v1:promotion"/>
				<xsl:if test="normalize-space(v1:relatedCartItemId) != ''">
					<relatedCartItemId>
						<xsl:value-of select="v1:relatedCartItemId"/>
					</relatedCartItemId>
				</xsl:if>
				<xsl:apply-templates select="v1:lineOfService"/>
				<xsl:apply-templates select="v1:networkResource"/>
				<xsl:if test="normalize-space(v1:transactionType) != ''">
					<transactionType>
						<xsl:value-of select="v1:transactionType"/>
					</transactionType>
				</xsl:if>
				<xsl:apply-templates select="v1:inventoryStatus"/>
				<xsl:apply-templates select="v1:deviceConditionQuestions"/>
				<xsl:if test="normalize-space(v1:originalOrderLineId) != ''">
					<originalOrderLineId>
						<xsl:value-of select="v1:originalOrderLineId"/>
					</originalOrderLineId>
				</xsl:if>
				<xsl:if test="normalize-space(v1:deviceDiagnostics) != ''">
					<deviceDiagnostics>
						<xsl:value-of select="v1:deviceDiagnostics"/>
					</deviceDiagnostics>
				</xsl:if>
				<xsl:if test="normalize-space(v1:reasonCode) != ''">
					<reasonCode>
						<xsl:value-of select="v1:reasonCode"/>
					</reasonCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:returnAuthorizationType) != ''">
					<returnAuthorizationType>
						<xsl:value-of select="v1:returnAuthorizationType"/>
					</returnAuthorizationType>
				</xsl:if>
				<xsl:if test="normalize-space(v1:revisionReason) != ''">
					<revisionReason>
						<xsl:value-of select="v1:revisionReason"/>
					</revisionReason>
				</xsl:if>
				<xsl:if test="normalize-space(v1:priceChangedIndicator) != ''">
					<priceChangedIndicator>
						<xsl:value-of select="v1:priceChangedIndicator"/>
					</priceChangedIndicator>
				</xsl:if>
				<xsl:apply-templates select="v1:financialAccount" mode="financialAccount-cartItem"/>
				<xsl:if test="normalize-space(v1:backendChangedIndicator) != ''">
					<backendChangedIndicator>
						<xsl:value-of select="v1:backendChangedIndicator"/>
					</backendChangedIndicator>
				</xsl:if>
				<xsl:apply-templates select="v1:extendedAmount"/>
				<xsl:if test="normalize-space(v1:transactionSubType) != ''">
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

	<!--<xsl:template match="v1:totalAmount">
		<xsl:if test="normalize-space(.) != '' or @currencyCode">
			<totalAmount>
				<xsl:if test="@currencyCode">
					<xsl:attribute name="currencyCode">
						<xsl:value-of select="@currencyCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</totalAmount>
		</xsl:if>
	</xsl:template>-->

	<xsl:template match="v1:charge">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or @actionCode) and $check_IncludeExclude = '1'">
			<charge>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="normalize-space(v1:typeCode) != ''">
					<typeCode>
						<xsl:value-of select="v1:typeCode"/>
					</typeCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:chargeFrequencyCode) != ''">
					<chargeFrequencyCode>
						<xsl:value-of select="v1:chargeFrequencyCode"/>
					</chargeFrequencyCode>
				</xsl:if>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:if test="normalize-space(v1:description) != ''">
					<description>
						<xsl:value-of select="v1:description"/>
					</description>
				</xsl:if>
			</charge>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:deduction">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or @actionCode) and $check_IncludeExclude = '1'">
			<deduction>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:apply-templates select="v1:description" mode="description-cartItemStatus"/>
				<xsl:if test="normalize-space(v1:recurringFrequency) != ''">
					<recurringFrequency>
						<xsl:value-of select="v1:recurringFrequency"/>
					</recurringFrequency>
				</xsl:if>
			</deduction>
		</xsl:if>
	</xsl:template>



	<xsl:template match="v1:tax">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '') and $check_IncludeExclude = '1'">
			<tax>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:if test="normalize-space(v1:description) != ''">
					<description>
						<xsl:value-of select="v1:description"/>
					</description>
				</xsl:if>
			</tax>

			<!--xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if-->
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:freightCharge">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or @chargeId) and $check_IncludeExclude = '1'">
			<freightCharge>
				<xsl:if test="@chargeId != ''">
					<xsl:attribute name="chargeId">
						<xsl:value-of select="@chargeId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:if test="normalize-space(v1:chargeCode) != ''">
					<chargeCode>
						<xsl:value-of select="v1:chargeCode"/>
					</chargeCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:waiverIndicator) != ''">
					<waiverIndicator>
						<xsl:value-of select="v1:waiverIndicator"/>
					</waiverIndicator>
				</xsl:if>
				<xsl:if test="normalize-space(v1:waiverReason) != ''">
					<waiverReason>
						<xsl:value-of select="v1:waiverReason"/>
					</waiverReason>
				</xsl:if>
			</freightCharge>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:payment">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '' or @actionCode) and $check_IncludeExclude = '1'">
			<payment>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:status" mode="status-payment"/>
				<xsl:apply-templates select="v1:requestAmount"/>
				<xsl:apply-templates select="v1:authorizationAmount"/>
				<xsl:if test="normalize-space(v1:paymentMethodCode) != ''">
					<paymentMethodCode>
						<xsl:value-of select="v1:paymentMethodCode"/>
					</paymentMethodCode>
				</xsl:if>
				<xsl:apply-templates select="v1:payeeParty"/>
				<xsl:apply-templates select="v1:payFromParty"/>
				<xsl:apply-templates select="v1:voucherRedemption"/>
				<xsl:apply-templates select="v1:bankPayment"/>
				<xsl:apply-templates select="v1:creditCardPayment"/>
				<xsl:apply-templates select="v1:debitCardPayment"/>
				<xsl:if test="normalize-space(v1:transactionType) != ''">
					<transactionType>
						<xsl:value-of select="v1:transactionType"/>
					</transactionType>
				</xsl:if>
				<xsl:apply-templates select="v1:specificationGroup"/>
				<xsl:apply-templates select="v1:tokenization"/>
			</payment>
			<payment>
				<xsl:value-of select="$pARRAY"/>
			</payment>
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

	<xsl:template match="v1:payeeParty">
		<xsl:if test="normalize-space(.) != ''">
			<payeeParty>
				<xsl:apply-templates select="v1:personName" mode="personName-payeeParty"/>
				<xsl:apply-templates select="v1:addressCommunication"
					mode="addressCommunication-payeeParty"/>
			</payeeParty>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:personName" mode="personName-payeeParty">
		<xsl:if test="normalize-space(.) != ''">
			<personName>
				<xsl:if test="normalize-space(v1:firstName) != ''">
					<firstName>
						<xsl:value-of select="v1:firstName"/>
					</firstName>
				</xsl:if>
				<xsl:if test="normalize-space(v1:middleName) != ''">
					<middleName>
						<xsl:value-of select="v1:middleName"/>
					</middleName>
				</xsl:if>
				<xsl:if test="normalize-space(v1:familyName) != ''">
					<familyName>
						<xsl:value-of select="v1:familyName"/>
					</familyName>
				</xsl:if>
			</personName>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:addressCommunication" mode="addressCommunication-payeeParty">
		<xsl:if test="normalize-space(.) != '' or @id">
			<addressCommunication>
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="normalize-space(v1:usageContext) != ''">
					<usageContext>
						<xsl:value-of select="v1:usageContext"/>
					</usageContext>
				</xsl:if>
			</addressCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:bankPayment">
		<xsl:if test="normalize-space(.) != ''">
			<bankPayment>
				<xsl:apply-templates select="v1:payFromBankAccount"/>
			</bankPayment>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:payFromBankAccount">
		<xsl:if test="normalize-space(.) != ''">
			<payFromBankAccount>
				<xsl:if test="normalize-space(v1:name) != ''">
					<name>
						<xsl:value-of select="v1:name"/>
					</name>
				</xsl:if>
				<xsl:if test="normalize-space(v1:accountNumber) != ''">
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
				<xsl:apply-templates select="v1:person"/>
			</bankAccountHolder>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:person" mode="person-bankPayment">
		<xsl:if test="normalize-space(.) != ''">
			<person>
				<xsl:apply-templates select="v1:personName"/>
			</person>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:personName">
		<xsl:if test="normalize-space(.) != ''">
			<personName>
				<xsl:if test="normalize-space(v1:familyName) != ''">
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
				<xsl:if test="normalize-space(v1:swiftCode) != ''">
					<swiftCode>
						<xsl:value-of select="v1:swiftCode"/>
					</swiftCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:routingNumber) != ''">
					<routingNumber>
						<xsl:value-of select="v1:routingNumber"/>
					</routingNumber>
				</xsl:if>
			</bank>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:addressList">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '') and $check_IncludeExclude = '1'">
			<addressList>
				<xsl:apply-templates select="v1:addressCommunication" mode="addressList"/>
			</addressList>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:cartSummary">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '') and $check_IncludeExclude = '1'">
			<cartSummary>
				<xsl:if test="normalize-space(v1:financialAccountId) != ''">
					<financialAccountId>
						<xsl:value-of select="v1:financialAccountId"/>
					</financialAccountId>
				</xsl:if>
				<xsl:if test="normalize-space(v1:lineOfServiceId) != ''">
					<lineOfServiceId>
						<xsl:value-of select="v1:lineOfServiceId"/>
					</lineOfServiceId>
				</xsl:if>
				<xsl:if test="normalize-space(v1:summaryScope) != ''">
					<summaryScope>
						<xsl:value-of select="v1:summaryScope"/>
					</summaryScope>
				</xsl:if>
				<xsl:apply-templates select="v1:totalDueAmount"/>
				<xsl:apply-templates select="v1:totalRecurringDueAmount"/>
				<xsl:apply-templates select="v1:charge" mode="charge-cartSummary"/>
				<xsl:apply-templates select="v1:deduction" mode="deduction-cartSummary"/>
				<xsl:apply-templates select="v1:tax" mode="tax-cartSummary"/>
				<xsl:if test="normalize-space(v1:calculationType) != ''">
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
				<xsl:if test="normalize-space(v1:rootParentId)!=''">
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



	<xsl:template match="v1:validationMessage">
		<xsl:variable name="check_IncludeExclude">
			<xsl:call-template name="Include-Exclude"/>
		</xsl:variable>
		<xsl:if test="(normalize-space(.) != '') and $check_IncludeExclude = '1'">
			<validationMessage>
				<xsl:if test="normalize-space(v1:messageType) != ''">
					<messageType>
						<xsl:value-of select="v1:messageType"/>
					</messageType>
				</xsl:if>
				<xsl:if test="normalize-space(v1:messageCode) != ''">
					<messageCode>
						<xsl:value-of select="v1:messageCode"/>
					</messageCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:messageText) != ''">
					<messageText>
						<xsl:value-of select="v1:messageText"/>
					</messageText>
				</xsl:if>
				<xsl:if test="normalize-space(v1:messageSource) != ''">
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

	<!--__________________________End Cart Children________________________________-->


	<!--	<xsl:template match="v1:quotation">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<quotation>
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="v1:quotationCharge"/>
				<xsl:apply-templates select="v1:quotationDeduction"/>
				<xsl:apply-templates select="v1:quotationDate"/>
				<xsl:apply-templates select="v1:quotationLine"/>
			</quotation>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:quotationCharge">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<quotationCharge>
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="v1:amount"/>
			</quotationCharge>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:quotationDeduction">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<quotationDeduction>
				
				<xsl:apply-templates select="v1:amount"/>
			</quotationDeduction>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:quotationLine">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<quotationLine>
				<xsl:if test="@quotationLineId!=''">
					<xsl:attribute name="quotationLineId">
						<xsl:value-of select="@quotationLineId"/>
					</xsl:attribute>
				</xsl:if>

				
				<xsl:apply-templates select="v1:quoteType"/>
				<xsl:apply-templates select="v1:quotationSchedule"/>
			</quotationLine>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:quotationSchedule">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<quotationSchedule>
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="v1:quotationScheduleDeduction"/>
				<xsl:apply-templates select="v1:quotationScheduleCharge"/>
			</quotationSchedule>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:quotationScheduleDeduction">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<quotationScheduleDeduction>
				
				<xsl:apply-templates select="v1:amount"/>
			</quotationScheduleDeduction>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:quotationScheduleCharge">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<quotationScheduleCharge>
				
				<xsl:apply-templates select="v1:amount"/>
			</quotationScheduleCharge>
		</xsl:if>
	</xsl:template>

-->

	<xsl:template match="v1:charge" mode="charge-cartSummary">
		<xsl:if test="normalize-space(.) != ''">
			<charge>
				<xsl:apply-templates select="v1:typeCode"/>
				<xsl:apply-templates select="v1:chargeFrequencyCode"/>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:if test="normalize-space(v1:description) != ''">
					<description>
						<xsl:value-of select="v1:description"/>
					</description>
				</xsl:if>
				<xsl:if test="normalize-space(v1:chargeCode) != ''">
					<chargeCode>
						<xsl:value-of select="v1:chargeCode"/>
					</chargeCode>
				</xsl:if>
				<xsl:apply-templates select="v1:productOffering" mode="cartSummary-charge"/>
				<xsl:apply-templates select="v1:productOfferingPriceId"/>
			</charge>

			<charge>
				<xsl:value-of select="$pARRAY"/>
			</charge>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:productOffering" mode="cartSummary-charge">
		<xsl:if test="normalize-space(.) != ''">
			<productOffering>
				<xsl:apply-templates select="v1:keyword" mode="keyword-cartSummary"/>
			</productOffering>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:keyword" mode="keyword-cartSummary">
		<xsl:if test="normalize-space(.) != '' or @name">
			<keyword>
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</keyword>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:deduction" mode="deduction-cartSummary">
		<xsl:if test="normalize-space(.) != ''">
			<deduction>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:if test="normalize-space(v1:description) != ''">
					<description>
						<xsl:value-of select="v1:description"/>
					</description>
				</xsl:if>
				<xsl:if test="normalize-space(v1:recurringFrequency) != ''">
					<recurringFrequency>
						<xsl:value-of select="v1:recurringFrequency"/>
					</recurringFrequency>
				</xsl:if>
				<xsl:apply-templates select="v1:promotion" mode="promotion-cartScheduleDeduction"/>
				<xsl:apply-templates select="v1:chargeCode"/>
				<xsl:if test="normalize-space(v1:productOfferingPriceId) != ''">
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
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<tax>
				<xsl:apply-templates select="@id"/>
				<xsl:apply-templates select="v1:code"/>
				<xsl:apply-templates select="v1:taxJurisdiction"/>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:apply-templates select="v1:typeCode"/>
				<xsl:if test="normalize-space(v1:description) != ''">
					<description>
						<xsl:value-of select="v1:description"/>
					</description>
				</xsl:if>
				<xsl:apply-templates select="v1:taxRate"/>
				<xsl:if test="normalize-space(v1:taxRate) != ''">
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
		match="v1:description|v1:key
			| v1:shortDescription | v1:promotionDescription | v1:promotionCode
			| v1:specialInstruction | v1:sku | v1:tacCode">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="@* | node()"/>
			</xsl:element>
			<xsl:element name="{local-name()}">
				<xsl:value-of select="$pARRAY"/>
			</xsl:element>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:communicationStatus">
		<xsl:if test="normalize-space(.) != '' or @subStatusCode or @statusCode">
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

				<!--<xsl:apply-templates select="@*"/>-->
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
				<xsl:apply-templates select="v1:address"
					mode="addressList-addressCommunication-address"/>
				<xsl:apply-templates select="v1:communicationStatus"/>
				<xsl:apply-templates select="v1:usageContext" mode="addressList"/>
				<xsl:apply-templates select="v1:specialInstruction"/>
			</addressCommunication>

			<addressCommunication>
				<xsl:value-of select="$pARRAY"/>
			</addressCommunication>

		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:usageContext" mode="addressList">
		<xsl:if test="normalize-space(.) != ''">
			<usageContext>
				<xsl:value-of select="."/>
			</usageContext>
			<usageContext>
				<xsl:value-of select="$pARRAY"/>
			</usageContext>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:address" mode="addressList-addressCommunication-address">
		<xsl:if test="normalize-space(.) != ''">
			<address>
				<xsl:if test="normalize-space(v1:addressFormatType) != ''">
					<addressFormatType>
						<xsl:value-of select="v1:addressFormatType"/>
					</addressFormatType>
				</xsl:if>
				<xsl:if test="normalize-space(v1:addressLine1) != ''">
					<addressLine1>
						<xsl:value-of select="v1:addressLine1"/>
					</addressLine1>
				</xsl:if>
				<xsl:if test="normalize-space(v1:addressLine2) != ''">
					<addressLine2>
						<xsl:value-of select="v1:addressLine2"/>
					</addressLine2>
				</xsl:if>
				<xsl:if test="normalize-space(v1:addressLine3) != ''">
					<addressLine3>
						<xsl:value-of select="v1:addressLine3"/>
					</addressLine3>
				</xsl:if>
				<xsl:if test="normalize-space(v1:cityName) != ''">
					<cityName>
						<xsl:value-of select="v1:cityName"/>
					</cityName>
				</xsl:if>
				<xsl:if test="normalize-space(v1:stateName) != ''">
					<stateName>
						<xsl:value-of select="v1:stateName"/>
					</stateName>
				</xsl:if>
				<xsl:if test="normalize-space(v1:stateCode) != ''">
					<stateCode>
						<xsl:value-of select="v1:stateCode"/>
					</stateCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:countyName) != ''">
					<countyName>
						<xsl:value-of select="v1:countyName"/>
					</countyName>
				</xsl:if>
				<xsl:if test="normalize-space(v1:countryCode) != ''">
					<countryCode>
						<xsl:value-of select="v1:countryCode"/>
					</countryCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:attentionOf) != ''">
					<attentionOf>
						<xsl:value-of select="v1:attentionOf"/>
					</attentionOf>
				</xsl:if>
				<xsl:if test="normalize-space(v1:careOf) != ''">
					<careOf>
						<xsl:value-of select="v1:careOf"/>
					</careOf>
				</xsl:if>
				<xsl:if test="normalize-space(v1:postalCode) != ''">
					<postalCode>
						<xsl:value-of select="v1:postalCode"/>
					</postalCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:postalCodeExtension) != ''">
					<postalCodeExtension>
						<xsl:value-of select="v1:postalCodeExtension"/>
					</postalCodeExtension>
				</xsl:if>
				<xsl:apply-templates select="v1:geoCodeID"/>
				<xsl:if test="normalize-space(v1:uncertaintyIndicator) != ''">
					<uncertaintyIndicator>
						<xsl:value-of select="v1:uncertaintyIndicator"/>
					</uncertaintyIndicator>
				</xsl:if>
				<xsl:if test="normalize-space(v1:inCityLimitIndicator) != ''">
					<inCityLimitIndicator>
						<xsl:value-of select="v1:inCityLimitIndicator"/>
					</inCityLimitIndicator>
				</xsl:if>
				<xsl:apply-templates select="v1:geographicCoordinates"/>
				<xsl:apply-templates select="v1:key"/>
				<xsl:if test="normalize-space(v1:residentialIndicator) != ''">
					<residentialIndicator>
						<xsl:value-of select="v1:residentialIndicator"/>
					</residentialIndicator>
				</xsl:if>
				<xsl:if test="normalize-space(v1:building) != ''">
					<building>
						<xsl:value-of select="v1:building"/>
					</building>
				</xsl:if>
				<xsl:if test="normalize-space(v1:floor) != ''">
					<floor>
						<xsl:value-of select="v1:floor"/>
					</floor>
				</xsl:if>
				<xsl:if test="normalize-space(v1:area) != ''">
					<area>
						<xsl:value-of select="v1:area"/>
					</area>
				</xsl:if>
				<xsl:if test="normalize-space(v1:ruralRoute) != ''">
					<ruralRoute>
						<xsl:value-of select="v1:ruralRoute"/>
					</ruralRoute>
				</xsl:if>
				<xsl:if test="normalize-space(v1:timeZone) != ''">
					<timeZone>
						<xsl:value-of select="v1:timeZone"/>
					</timeZone>
				</xsl:if>
				<xsl:if test="normalize-space(v1:houseNumber) != ''">
					<houseNumber>
						<xsl:value-of select="v1:houseNumber"/>
					</houseNumber>
				</xsl:if>
				<xsl:if test="normalize-space(v1:streetName) != ''">
					<streetName>
						<xsl:value-of select="v1:streetName"/>
					</streetName>
				</xsl:if>
				<xsl:if test="normalize-space(v1:streetSuffix) != ''">
					<streetSuffix>
						<xsl:value-of select="v1:streetSuffix"/>
					</streetSuffix>
				</xsl:if>
				<xsl:if test="normalize-space(v1:trailingDirection) != ''">
					<trailingDirection>
						<xsl:value-of select="v1:trailingDirection"/>
					</trailingDirection>
				</xsl:if>
				<xsl:if test="normalize-space(v1:unitType) != ''">
					<unitType>
						<xsl:value-of select="v1:unitType"/>
					</unitType>
				</xsl:if>
				<xsl:if test="normalize-space(v1:unitNumber) != ''">
					<unitNumber>
						<xsl:value-of select="v1:unitNumber"/>
					</unitNumber>
				</xsl:if>
				<xsl:if test="normalize-space(v1:streetDirection) != ''">
					<streetDirection>
						<xsl:value-of select="v1:streetDirection"/>
					</streetDirection>
				</xsl:if>
				<xsl:if test="normalize-space(v1:urbanization) != ''">
					<urbanization>
						<xsl:value-of select="v1:urbanization"/>
					</urbanization>
				</xsl:if>
				<xsl:if test="normalize-space(v1:deliveryPointCode) != ''">
					<deliveryPointCode>
						<xsl:value-of select="v1:deliveryPointCode"/>
					</deliveryPointCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:confidenceLevel) != ''">
					<confidenceLevel>
						<xsl:value-of select="v1:confidenceLevel"/>
					</confidenceLevel>
				</xsl:if>
				<xsl:if test="normalize-space(v1:carrierRoute) != ''">
					<carrierRoute>
						<xsl:value-of select="v1:carrierRoute"/>
					</carrierRoute>
				</xsl:if>
				<xsl:if test="normalize-space(v1:overrideIndicator) != ''">
					<overrideIndicator>
						<xsl:value-of select="v1:overrideIndicator"/>
					</overrideIndicator>
				</xsl:if>
				<xsl:apply-templates select="v1:postOfficeBox"/>
				<xsl:if test="normalize-space(v1:observesDaylightSavingsIndicator) != ''">
					<observesDaylightSavingsIndicator>
						<xsl:value-of select="v1:observesDaylightSavingsIndicator"/>
					</observesDaylightSavingsIndicator>
				</xsl:if>
				<xsl:if test="normalize-space(v1:matchIndicator) != ''">
					<matchIndicator>
						<xsl:value-of select="v1:matchIndicator"/>
					</matchIndicator>
				</xsl:if>
			</address>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:geoCodeID">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
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
				<xsl:apply-templates select="v1:latitude"/>
				<xsl:apply-templates select="v1:longitude"/>
			</geographicCoordinates>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:location">
		<xsl:if test="normalize-space(.) != '' or @id">
			<location>
				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
			</location>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:orderStatus">
		<xsl:if test="normalize-space(.) != '' or @statusCode">
			<orderStatus>
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
			</orderStatus>
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
				<xsl:if test="normalize-space(v1:firstName) != ''">
					<firstName>
						<xsl:value-of select="v1:firstName"/>
					</firstName>
				</xsl:if>
				<xsl:if test="normalize-space(v1:middleName) != ''">
					<middleName>
						<xsl:value-of select="v1:middleName"/>
					</middleName>
				</xsl:if>
				<xsl:if test="normalize-space(v1:familyName) != ''">
					<familyName>
						<xsl:value-of select="v1:familyName"/>
					</familyName>
				</xsl:if>
				<xsl:if test="normalize-space(v1:aliasName) != ''">
					<aliasName>
						<xsl:value-of select="v1:aliasName"/>
					</aliasName>
				</xsl:if>
			</personName>
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
				<xsl:if test="normalize-space(v1:usageContext) != ''">
					<usageContext>
						<xsl:value-of select="v1:usageContext"/>
					</usageContext>
				</xsl:if>
			</addressCommunication>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:preference" mode="preference-emailCommunication">
		<xsl:if test="normalize-space(.) != ''">
			<preference>
				<xsl:if test="normalize-space(v1:preferred) != ''">
					<preferred>
						<xsl:value-of select="v1:preferred"/>
					</preferred>
				</xsl:if>
			</preference>

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
				<xsl:if test="normalize-space(v1:keyName) != ''">
					<keyName>
						<xsl:value-of select="v1:keyName"/>
					</keyName>
				</xsl:if>
				<xsl:if test="normalize-space(v1:keyValue) != ''">
					<keyValue>
						<xsl:value-of select="v1:keyValue"/>
					</keyValue>
				</xsl:if>
			</key>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:phoneCommunication">
		<xsl:if test="normalize-space(.) != '' or @actionCode">
			<phoneCommunication>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="normalize-space(v1:phoneType) != ''">
					<phoneType>
						<xsl:value-of select="v1:phoneType"/>
					</phoneType>
				</xsl:if>
				<xsl:if test="normalize-space(v1:phoneNumber) != ''">
					<phoneNumber>
						<xsl:value-of select="v1:phoneNumber"/>
					</phoneNumber>
				</xsl:if>
			</phoneCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:emailCommunication" mode="shipToEmailCommunication">
		<xsl:if test="normalize-space(.) != '' or @actionCode">
			<emailCommunication>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="normalize-space(v1:emailAddress) != ''">
					<emailAddress>
						<xsl:value-of select="v1:emailAddress"/>
					</emailAddress>
				</xsl:if>
				<xsl:if test="normalize-space(v1:emailFormat) != ''">
					<emailFormat>
						<xsl:value-of select="v1:emailFormat"/>
					</emailFormat>
				</xsl:if>
			</emailCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:customerAccount">
		<xsl:if test="normalize-space(.) != ''">
			<customerAccount>				
				<xsl:if test="@customerAccountId">
					<xsl:attribute name="customerAccountId">
						<xsl:value-of select="@customerAccountId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:programMembership"/>
				<xsl:apply-templates select="v1:specificationGroup"/>
				<xsl:apply-templates select="v1:paymentProfile"/>
				<xsl:apply-templates select="v1:preferredLanguage"/>
				<xsl:if test="normalize-space(v1:idVerificationIndicator) != ''">
					<idVerificationIndicator>
						<xsl:value-of select="v1:idVerificationIndicator"/>
					</idVerificationIndicator>
				</xsl:if>
				<xsl:if test="normalize-space(v1:corporateAffiliationProgram) != ''">
					<corporateAffiliationProgram>
						<xsl:value-of select="v1:corporateAffiliationProgram"/>
					</corporateAffiliationProgram>
				</xsl:if>
				<xsl:if test="normalize-space(v1:strategicAccountIndicator) != ''">
					<strategicAccountIndicator>
						<xsl:value-of select="v1:strategicAccountIndicator"/>
					</strategicAccountIndicator>
				</xsl:if>
				<xsl:apply-templates select="v1:financialAccount"/>
			</customerAccount>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:programMembership">
		<xsl:if test="normalize-space(.) != ''">
			<programMembership>
				<xsl:if test="normalize-space(v1:programCode) != ''">
					<programCode>
						<xsl:value-of select="v1:programCode"/>
					</programCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:description) != ''">
					<description>
						<xsl:value-of select="v1:description"/>
					</description>
				</xsl:if>
			</programMembership>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:paymentProfile">
		<xsl:if test="normalize-space(.) != ''">
			<paymentProfile>
				<xsl:if test="normalize-space(v1:paymentTerm) != ''">
					<paymentTerm>
						<xsl:value-of select="v1:paymentTerm"/>
					</paymentTerm>
				</xsl:if>
			</paymentProfile>
		</xsl:if>
	</xsl:template>



	<xsl:template match="v1:accountHolder">
		<xsl:if test="normalize-space(.) != ''">
			<accountHolder>
				<xsl:apply-templates select="v1:party" mode="accountHolderParty"/>
			</accountHolder>
			<!--<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>-->
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
				<xsl:apply-templates select="v1:addressCommunication" mode="accountHolderAddress"/>
			</person>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:addressCommunication" mode="accountHolderAddress">
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
				<xsl:apply-templates select="v1:privacyProfile"
					mode="accountHolderAddress-privacyProfile"/>
				<xsl:apply-templates select="v1:address"/>
				<xsl:if test="normalize-space(v1:usageContext) != ''">
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


	<xsl:template match="v1:privacyProfile" mode="accountHolderAddress-privacyProfile">
		<xsl:if test="normalize-space(.) != ''">
			<privacyProfile>
				<xsl:apply-templates select="v1:optOut"/>
				<xsl:apply-templates select="v1:activityType"/>
			</privacyProfile>
			<!--	<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>-->
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:financialAccount">
		<xsl:if test="normalize-space(.) != '' or @actionCode">

			<financialAccount>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="normalize-space(v1:financialAccountNumber) != ''">
					<financialAccountNumber>
						<xsl:value-of select="v1:financialAccountNumber"/>
					</financialAccountNumber>
				</xsl:if>
				<xsl:if test="normalize-space(v1:billingMethod) != ''">
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
				<xsl:if test="normalize-space(v1:customerGroup) != ''">
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
					mode="addressCommunication-billingContact"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:addressCommunication" mode="addressCommunication-billingContact">
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
				<xsl:apply-templates select="v1:uiAddedIndicator"/>
				<xsl:apply-templates select="v1:address"/>
				<xsl:apply-templates select="v1:usageContext"/>
			</addressCommunication>
			<addressCommunication>
				<xsl:value-of select="$pARRAY"/>
			</addressCommunication>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:accountContact">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<accountContact>
				<xsl:apply-templates select="v1:addressCommunication"
					mode="addressCommunication-accountContact"/>
			</accountContact>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:addressCommunication" mode="addressCommunication-accountContact">
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
				<xsl:apply-templates select="v1:privacyProfile" mode="accounContact-privacyProfile"/>
				<xsl:apply-templates select="v1:address"/>
				<xsl:apply-templates select="v1:usageContext"/>
			</addressCommunication>

			<addressCommunication>
				<xsl:value-of select="$pARRAY"/>
			</addressCommunication>
		</xsl:if>

	</xsl:template>

	<xsl:template match="v1:privacyProfile" mode="accounContact-privacyProfile">
		<xsl:if test="normalize-space(.) != ''">
			<privacyProfile>
				<xsl:apply-templates select="v1:optOut"/>
				<xsl:apply-templates select="v1:activityType"/>
			</privacyProfile>
			<!--	<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>-->
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:specialTreatment">
		<xsl:if test="normalize-space(.) != ''">
			<specialTreatment>
				<xsl:if test="normalize-space(v1:treatmentType) != ''">
					<treatmentType>
						<xsl:value-of select="v1:treatmentType"/>
					</treatmentType>
				</xsl:if>
			</specialTreatment>
			<!--xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if-->
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:treatmentType">
		<xsl:if test="normalize-space(.) != ''">
			<specialTreatment>
				<xsl:if test="normalize-space(v1:treatmentType) != ''">
					<treatmentType>
						<xsl:value-of select="v1:treatmentType"/>
					</treatmentType>
				</xsl:if>
			</specialTreatment>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:accountBalanceSummaryGroup">
		<xsl:if test="normalize-space(.) != ''">

			<accountBalanceSummaryGroup>
				<xsl:apply-templates select="v1:balanceSummary"/>
			</accountBalanceSummaryGroup>

			<!--xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if-->

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:balanceSummary">
		<xsl:if test="normalize-space(.) != ''">
			<balanceSummary>

				<xsl:apply-templates select="v1:amount"/>
			</balanceSummary>
			<!--xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if-->
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
				<xsl:if test="normalize-space(v1:reasonCode) != ''">
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

				<xsl:if test="normalize-space(v1:dayOfMonth) != ''">
					<dayOfMonth>
						<xsl:value-of select="v1:dayOfMonth"/>
					</dayOfMonth>
				</xsl:if>
				<xsl:if test="normalize-space(v1:frequencyCode) != ''">
					<frequencyCode>
						<xsl:value-of select="v1:frequencyCode"/>
					</frequencyCode>
				</xsl:if>
				<xsl:apply-templates select="v1:uiAddedIndicator"/>
			</billCycle>
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

				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:key" mode="key-customer-billTo"/>
				<xsl:if test="normalize-space(v1:customerType) != ''">
					<customerType>
						<xsl:value-of select="v1:customerType"/>
					</customerType>
				</xsl:if>
				<xsl:apply-templates select="v1:status"/>

				<xsl:apply-templates select="v1:party"/>
				<xsl:if test="normalize-space(v1:customerGroup) != ''">
					<customerGroup>
						<xsl:value-of select="v1:customerGroup"/>
					</customerGroup>
				</xsl:if>
			</customer>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:key" mode="key-customer-billTo">
		<xsl:if test="normalize-space(.) != '' or @domainName">
			<key>
				
				<xsl:if test="@domainName">
					<xsl:attribute name="domainName">
						<xsl:value-of select="@domainName"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="normalize-space(v1:keyName) != ''">
					<keyName>
						<xsl:value-of select="v1:keyName"/>
					</keyName>
				</xsl:if>
				<xsl:if test="normalize-space(v1:keyValue) != ''">
					<keyValue>
						<xsl:value-of select="v1:keyValue"/>
					</keyValue>
				</xsl:if>
			</key>
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
				<xsl:if test="normalize-space(v1:fullName) != ''">
					<fullName>
						<xsl:value-of select="v1:fullName"/>
					</fullName>
				</xsl:if>
				<xsl:if test="normalize-space(v1:shortName) != ''">
					<shortName>
						<xsl:value-of select="v1:shortName"/>
					</shortName>
				</xsl:if>
				<xsl:if test="normalize-space(v1:legalName) != ''">
					<legalName>
						<xsl:value-of select="v1:legalName"/>
					</legalName>
				</xsl:if>
				<xsl:apply-templates select="v1:organizationSpecification"/>
				<xsl:if test="normalize-space(v1:sicCode) != ''">
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
				<xsl:if test="normalize-space(v1:employeeCount) != ''">
					<employeeCount>
						<xsl:value-of select="v1:employeeCount"/>
					</employeeCount>
				</xsl:if>
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


	<!--<xsl:template match="v1:securityProfile" mode="securityProfile-organizationContact">
		<xsl:if test="normalize-space(.) != ''">
			<securityProfile>
				<xsl:if test="normalize-space(v1:userName) != ''">
					<userName>
						<xsl:value-of select="v1:userName"/>
					</userName>
				</xsl:if>
				<xsl:if test="normalize-space(v1:pin) != ''">
					<pin>
						<xsl:value-of select="v1:pin"/>
					</pin>
				
				</xsl:if>
			</securityProfile>
		</xsl:if>
	</xsl:template>-->



	<xsl:template match="v1:person">
		<xsl:if test="normalize-space(.) != ''">
			<person>
				<xsl:apply-templates select="v1:personName" mode="shipTo"/>
				<xsl:apply-templates select="v1:ssn"/>
				<xsl:apply-templates select="v1:preferredLanguage"/>
				<xsl:apply-templates select="v1:addressCommunication"
					mode="addressCommunicationperson"/>
				<xsl:if test="normalize-space(v1:birthDate) != ''">
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
				<xsl:if test="normalize-space(v1:gender) != ''">
					<gender>
						<xsl:value-of select="v1:gender"/>
					</gender>
				</xsl:if>
				<xsl:apply-templates select="v1:visa"/>
				<xsl:if test="normalize-space(v1:maritalStatus) != ''">
					<maritalStatus>
						<xsl:value-of select="v1:maritalStatus"/>
					</maritalStatus>
				</xsl:if>
				<xsl:if test="normalize-space(v1:activeDutyMilitary) != ''">
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

	<xsl:template match="v1:nationalIdentityDocument">
		<xsl:if test="normalize-space(.) != ''">
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
						<xsl:value-of select="concat($pBOOLEAN,v1:primaryIndicator,$pBOOLEAN)"/>
					</primaryIndicator>
				</xsl:if>
				<xsl:if test="normalize-space(v1:taxIDIndicator) != ''">
					<taxIDIndicator>
						<xsl:value-of select="concat($pBOOLEAN,v1:taxIDIndicator,$pBOOLEAN)"/>
					</taxIDIndicator>
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
				<xsl:if test="normalize-space(v1:issuingAuthority) != ''">
					<issuingAuthority>
						<xsl:value-of select="v1:issuingAuthority"/>
					</issuingAuthority>
				</xsl:if>
			</nationalIdentityDocument>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:identityDocumentVerification">
		<xsl:if test="normalize-space(.) != ''">
			<identityDocumentVerification>
				<xsl:if test="normalize-space(v1:identityDocumentType) != ''">
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
				<xsl:if test="normalize-space(v1:startDate) != ''">
					<startDate>
						<xsl:value-of select="v1:startDate"/>
					</startDate>
				</xsl:if>
				<xsl:if test="normalize-space(v1:endDate) != ''">
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
				<xsl:if test="normalize-space(v1:userName) != ''">
					<userName>
						<xsl:value-of select="v1:userName"/>
					</userName>
				</xsl:if>
				<xsl:if test="normalize-space(v1:eventTime) != ''">
					<eventTime>
						<xsl:value-of select="v1:eventTime"/>
					</eventTime>
				</xsl:if>
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

	<xsl:template match="v1:ssn | v1:cardNumber">
		<xsl:if test="normalize-space(.) != '' or @maskingType">
			<xsl:element name="{local-name()}">
				<xsl:if test="normalize-space(.) != '' or @maskingType">
					<xsl:attribute name="maskingType">
						<xsl:value-of select="@maskingType"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:driversLicense">
		<xsl:if test="normalize-space(.) != '' or @id">
			<driversLicense>
				<xsl:if test="@id">
					<xsl:attribute name="id" select="@id"/>
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
						<xsl:value-of select="concat($pBOOLEAN,v1:suspendedIndicator,$pBOOLEAN)"/>
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
				<xsl:apply-templates select="v1:issuePeriod"/>
				<xsl:if test="normalize-space(v1:driversLicenseClass) != ''">
					<driversLicenseClass>
						<xsl:value-of select="v1:driversLicenseClass"/>
					</driversLicenseClass>
				</xsl:if>
			</driversLicense>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:issuePeriod">
		<xsl:if test="normalize-space(.) != ''">
			<issuePeriod>
				<xsl:if test="normalize-space(v1:startTime) != ''">
					<startTime>
						<xsl:value-of select="v1:startTime"/>
					</startTime>
				</xsl:if>
				<xsl:if test="normalize-space(v1:endTime) != ''">
					<endTime>
						<xsl:value-of select="v1:endTime"/>
					</endTime>
				</xsl:if>
			</issuePeriod>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:securityProfile" mode="securityProfile-person-party-customer">
		<xsl:if test="normalize-space(.) != ''">
			<securityProfile>
				<xsl:if test="normalize-space(v1:userName) != ''">
					<userName>
						<xsl:value-of select="v1:userName"/>
					</userName>
				</xsl:if>
				<xsl:if test="normalize-space(v1:pin) != ''">
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
				<xsl:if test="normalize-space(v1:countryCode) != ''">
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
	
	<xsl:template match="v1:visa">
		<xsl:if test="normalize-space(.) != ''">
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
						<xsl:value-of select="v1:validIndicator"/>
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
				<xsl:apply-templates select="v1:status" mode="visa"/>
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
				<xsl:apply-templates select="v1:uiAddedIndicator"/>
				<!--<xsl:apply-templates select="@*"/>-->
				<!--<xsl:apply-templates select="v1:address"/>-->
				<xsl:apply-templates select="v1:usageContext"/>
			</addressCommunication>

			<addressCommunication>
				<xsl:value-of select="$pARRAY"/>
			</addressCommunication>

		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:phoneCommunication" mode="phoneCommunicationperson">
		<xsl:if test="normalize-space(.) != ''">
			<phoneCommunication>
				<xsl:if test="normalize-space(v1:phoneType) != ''">
					<phoneType>
						<xsl:value-of select="v1:phoneType"/>
					</phoneType>
				</xsl:if>
				<xsl:if test="normalize-space(v1:phoneNumber) != ''">
					<phoneNumber>
						<xsl:value-of select="v1:phoneNumber"/>
					</phoneNumber>
				</xsl:if>
				<xsl:if test="normalize-space(v1:countryDialingCode) != ''">
					<countryDialingCode>
						<xsl:value-of select="v1:countryDialingCode"/>
					</countryDialingCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:areaCode) != ''">
					<areaCode>
						<xsl:value-of select="v1:areaCode"/>
					</areaCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:localNumber) != ''">
					<localNumber>
						<xsl:value-of select="v1:localNumber"/>
					</localNumber>
				</xsl:if>
				<xsl:if test="normalize-space(v1:phoneExtension) != ''">
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
				<xsl:apply-templates select="v1:preference" mode="single"/>
				<xsl:if test="normalize-space(v1:emailAddress) != ''">
					<emailAddress>
						<xsl:value-of select="v1:emailAddress"/>
					</emailAddress>
				</xsl:if>
				<xsl:if test="normalize-space(v1:usageContext) != ''">
					<usageContext>
						<xsl:value-of select="v1:usageContext"/>
					</usageContext>
					<usageContext>
						<xsl:value-of select="$pARRAY"/>
					</usageContext>
				</xsl:if>
			</emailCommunication>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="v1:preference" mode="single">
		<xsl:if test="normalize-space(.) != ''">
			<preference>
				<xsl:if test="normalize-space(v1:preferred) != ''">
					<preferred>
						<xsl:value-of select="v1:preferred"/>
					</preferred>
				</xsl:if>
			</preference>
			
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:effectivePeriod" mode="cartItem-effectivePeriod">
		<xsl:if test="normalize-space(.) != ''">
			<effectivePeriod>
				<xsl:if test="normalize-space(v1:startTime) != ''">
					<startTime>
						<xsl:value-of select="v1:startTime"/>
					</startTime>
				</xsl:if>
			</effectivePeriod>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:quantity">
		<xsl:if test="normalize-space(.) != '' or @measurementUnit">
			<quantity>
				<xsl:if test="@measurementUnit">
					<xsl:attribute name="measurementUnit">
						<xsl:value-of select="@measurementUnit"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="concat($pINTEGER,., $pINTEGER)"/>
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
				<xsl:if test="normalize-space(v1:MSISDN) != ''">
					<MSISDN>
						<xsl:value-of select="v1:MSISDN"/>
					</MSISDN>
				</xsl:if>
				<xsl:if test="normalize-space(v1:donorBillingSystem) != ''">
					<donorBillingSystem>
						<xsl:value-of select="v1:donorBillingSystem"/>
					</donorBillingSystem>
				</xsl:if>
				<xsl:if test="normalize-space(v1:donorAccountNumber) != ''">
					<donorAccountNumber>
						<xsl:value-of select="v1:donorAccountNumber"/>
					</donorAccountNumber>
				</xsl:if>
				<xsl:if test="normalize-space(v1:donorAccountPassword) != ''">
					<donorAccountPassword>
						<xsl:value-of select="v1:donorAccountPassword"/>
					</donorAccountPassword>
				</xsl:if>
				<xsl:if test="normalize-space(v1:oldServiceProvider) != ''">
					<oldServiceProvider>
						<xsl:value-of select="v1:oldServiceProvider"/>
					</oldServiceProvider>
				</xsl:if>
				<xsl:if test="normalize-space(v1:portDueTime) != ''">
					<portDueTime>
						<xsl:value-of select="v1:portDueTime"/>
					</portDueTime>
				</xsl:if>
				<xsl:if test="normalize-space(v1:portRequestedTime) != ''">
					<portRequestedTime>
						<xsl:value-of select="v1:portRequestedTime"/>
					</portRequestedTime>
				</xsl:if>
				<xsl:if test="normalize-space(v1:oldServiceProviderName) != ''">
					<oldServiceProviderName>
						<xsl:value-of select="v1:oldServiceProviderName"/>
					</oldServiceProviderName>
				</xsl:if>
				<xsl:if test="normalize-space(v1:oldVirtualServiceProviderId) != ''">
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
				<xsl:apply-templates select="v1:addressCommunication" mode="port-personProfile"/>
			</personProfile>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:addressCommunication" mode="port-personProfile">
		<xsl:if test="normalize-space(.) != ''">
			<addressCommunication>
				<xsl:apply-templates select="v1:address" mode="port-personProfile"/>
			</addressCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:address" mode="port-personProfile">
		<xsl:if test="normalize-space(.) != ''">
			<address>

				<xsl:if test="normalize-space(v1:addressLine1) != ''">
					<addressLine1>
						<xsl:value-of select="v1:addressLine1"/>
					</addressLine1>
				</xsl:if>
				<xsl:if test="normalize-space(v1:addressLine2) != ''">
					<addressLine2>
						<xsl:value-of select="v1:addressLine2"/>
					</addressLine2>
				</xsl:if>

				<xsl:if test="normalize-space(v1:cityName) != ''">
					<cityName>
						<xsl:value-of select="v1:cityName"/>
					</cityName>
				</xsl:if>

				<xsl:if test="normalize-space(v1:stateCode) != ''">
					<stateCode>
						<xsl:value-of select="v1:stateCode"/>
					</stateCode>
				</xsl:if>

				<xsl:if test="normalize-space(v1:countryCode) != ''">
					<countryCode>
						<xsl:value-of select="v1:countryCode"/>
					</countryCode>
				</xsl:if>

				<xsl:if test="normalize-space(v1:postalCode) != ''">
					<postalCode>
						<xsl:value-of select="v1:postalCode"/>
					</postalCode>
				</xsl:if>

			</address>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:financialAccount" mode="financialAccount-cartItem">
		<xsl:if test="normalize-space(.) != ''">
			<financialAccount>
				<xsl:apply-templates select="v1:financialAccountNumber"/>
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
	<xsl:template match="v1:deviceConditionQuestions">
		<xsl:if test="normalize-space(.) != ''">
			<deviceConditionQuestions>
				<xsl:apply-templates select="v1:verificationQuestion"/>
			</deviceConditionQuestions>
			<!--xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if-->
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:verificationQuestion">
		<xsl:if test="normalize-space(.) != ''">
			<verificationQuestion>
				<xsl:if test="normalize-space(v1:questionText) != ''">
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
				<xsl:if test="normalize-space(v1:answerText) != ''">
					<answerText>
						<xsl:value-of select="v1:answerText"/>
					</answerText>
				</xsl:if>
			</verificationAnswer>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:inventoryStatus">
		<xsl:if test="normalize-space(.) != '' or @statusCode">
			<inventoryStatus>
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:estimatedAvailable"/>
			</inventoryStatus>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:estimatedAvailable">
		<xsl:if test="normalize-space(.) != ''">
			<estimatedAvailable>
				<xsl:if test="normalize-space(v1:startDate) != ''">
					<startDate>
						<xsl:value-of select="v1:startDate"/>
					</startDate>
				</xsl:if>
				<xsl:if test="normalize-space(v1:endDate) != ''">
					<endDate>
						<xsl:value-of select="v1:endDate"/>
					</endDate>
				</xsl:if>
			</estimatedAvailable>
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

			<productOffering>
				<xsl:if test="@productOfferingId">
					<xsl:attribute name="productOfferingId">
						<xsl:value-of select="@productOfferingId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="normalize-space(v1:name) != ''">
					<name>
						<xsl:value-of select="v1:name"/>
					</name>
				</xsl:if>
				<xsl:if test="normalize-space(v1:shortName) != ''">
					<shortName>
						<xsl:value-of select="v1:shortName"/>
					</shortName>
				</xsl:if>
				<xsl:if test="normalize-space(v1:displayName) != ''">
					<displayName>
						<xsl:value-of select="v1:displayName"/>
					</displayName>
				</xsl:if>
				<xsl:apply-templates select="v1:description" mode="productOffering-description"/>
				<xsl:apply-templates select="v1:shortDescription"
					mode="productOffering-shortDescription"/>
				<xsl:apply-templates select="v1:longDescription"/>
				<xsl:apply-templates select="v1:alternateDescription"/>
				<xsl:apply-templates select="v1:keyword"/>
				<xsl:if test="normalize-space(v1:offerType) != ''">
					<offerType>
						<xsl:value-of select="v1:offerType"/>
					</offerType>
				</xsl:if>
				<xsl:if test="normalize-space(v1:offerSubType) != ''">
					<offerSubType>
						<xsl:value-of select="v1:offerSubType"/>
					</offerSubType>
				</xsl:if>
				<xsl:if test="normalize-space(v1:offerLevel) != ''">
					<offerLevel>
						<xsl:value-of select="v1:offerLevel"/>
					</offerLevel>
				</xsl:if>
				<xsl:apply-templates select="v1:offeringClassification"/>
				<!--xsl:apply-templates select="v1:offeringStatus"/-->
				<xsl:if test="normalize-space(v1:businessUnit) != ''">
					<businessUnit>
						<xsl:value-of select="v1:businessUnit"/>
					</businessUnit>
				</xsl:if>
				<xsl:apply-templates select="v1:productType" mode="productOffering"/>
				<xsl:apply-templates select="v1:productSubType" mode="productOffering"/>
				<xsl:apply-templates select="v1:key" mode="productOffering-key"/>
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

	<xsl:template match="v1:productType" mode="productOffering">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<productType>
				<xsl:value-of select="."/>
			</productType>

			<productType>
				<xsl:value-of select="$pARRAY"/>
			</productType>
		</xsl:if>

	</xsl:template>

	<xsl:template match="v1:productSubType" mode="productOffering">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<productSubType>
				<xsl:value-of select="."/>
			</productSubType>

			<productSubType>
				<xsl:value-of select="$pARRAY"/>
			</productSubType>

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

	<xsl:template match="v1:serviceCharacteristics">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<serviceCharacteristics>
				<xsl:apply-templates select="v1:backDateAllowedIndicator"/>
				<xsl:apply-templates select="v1:futureDateAllowedIndicator"/>
				<xsl:apply-templates select="v1:backDateVisibleIndicator"/>
				<xsl:apply-templates select="v1:futureDateVisibleIndicator"/>
				<xsl:apply-templates select="v1:includedServiceCapacity"/>
				<xsl:if test="normalize-space(v1:billEffectiveCode) != ''">
					<billEffectiveCode>
						<xsl:value-of select="v1:billEffectiveCode"/>
					</billEffectiveCode>
				</xsl:if>
				<xsl:apply-templates select="v1:billableThirdPartyServiceIndicator"/>
				<xsl:apply-templates select="v1:prorateAllowedIndicator"/>
				<xsl:apply-templates select="v1:prorateVisibleIndicator"/>
				<xsl:if test="normalize-space(v1:duration) != ''">
					<duration>
						<xsl:value-of select="v1:duration"/>
					</duration>
				</xsl:if>
			</serviceCharacteristics>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:includedServiceCapacity">
		<xsl:if test="normalize-space(.) != ''">
			<includedServiceCapacity>
				<xsl:if test="normalize-space(v1:capacityType) != ''">
					<capacityType>
						<xsl:value-of select="v1:capacityType"/>
					</capacityType>
				</xsl:if>
				<xsl:if test="normalize-space(v1:capacitySubType) != ''">
					<capacitySubType>
						<xsl:value-of select="v1:capacitySubType"/>
					</capacitySubType>
				</xsl:if>
				<xsl:apply-templates select="v1:unlimitedIndicator"/>

				<xsl:if test="normalize-space(v1:size) != ''">
					<size>
						<xsl:value-of select="v1:size"/>
					</size>
				</xsl:if>
				<xsl:if test="normalize-space(v1:measurementUnit) != ''">
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

	<xsl:template
		match="
			v1:backDateAllowedIndicator
			| v1:futureDateAllowedIndicator
			| v1:backDateVisibleIndicator
			| v1:futureDateVisibleIndicator
			| v1:unlimitedIndicator
			| v1:billableThirdPartyServiceIndicator
			| v1:prorateAllowedIndicator
			| v1:prorateVisibleIndicator">

		<xsl:if test="current() != '' or @name">
			<xsl:element name="{local-name()} ">
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:equipmentCharacteristics">
		<xsl:if test="normalize-space(.) != ''">
			<equipmentCharacteristics>
				<xsl:if test="normalize-space(v1:model) != ''">
					<model>
						<xsl:value-of select="v1:model"/>
					</model>
				</xsl:if>
				<xsl:if test="normalize-space(v1:manufacturer) != ''">
					<manufacturer>
						<xsl:value-of select="v1:manufacturer"/>
					</manufacturer>
				</xsl:if>
				<xsl:if test="normalize-space(v1:color) != ''">
					<color>
						<xsl:value-of select="v1:color"/>
					</color>
				</xsl:if>
				<xsl:if test="normalize-space(v1:memory) != ''">
					<memory>
						<xsl:value-of select="v1:memory"/>
					</memory>
				</xsl:if>
				<xsl:if test="normalize-space(v1:tacCode) != ''">
					<tacCode>
						<xsl:value-of select="v1:tacCode"/>
					</tacCode>
				</xsl:if>
			</equipmentCharacteristics>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:marketingMessage">
		<xsl:if test="normalize-space(.) != ''">
			<marketingMessage>
				<xsl:if test="normalize-space(.) != ''">
					<salesChannelCode>
						<xsl:value-of select="v1:salesChannelCode"/>
					</salesChannelCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:relativeSize) != ''">
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
				<xsl:if test="normalize-space(v1:code) != ''">
					<code>
						<xsl:value-of select="v1:code"/>
					</code>
				</xsl:if>
				<xsl:if test="normalize-space(v1:messageText) != '' or v1:messageText/@languageCode">
					<messageText>
						<xsl:if test="v1:messageText/@languageCode">
							<xsl:attribute name="languageCode">
								<xsl:value-of select="v1:messageText/@languageCode"/>
							</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="v1:messageText"/>
					</messageText>
				</xsl:if>
				<xsl:if test="normalize-space(v1:messageSequence) != ''">
					<messageSequence>
						<xsl:value-of select="v1:messageSequence"/>
					</messageSequence>
				</xsl:if>
			</messagePart>
		</xsl:if>
	</xsl:template>



	<xsl:template match="v1:key" mode="productOffering-key">
		<xsl:if test="normalize-space(.) != '' or @domainName">
			<key>
				<xsl:if test="@domainName">
					<xsl:attribute name="domainName">
						<xsl:value-of select="@domainName"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="normalize-space(v1:keyName) != ''">
					<keyName>
						<xsl:value-of select="v1:keyName"/>
					</keyName>
				</xsl:if>
				<xsl:if test="normalize-space(v1:keyValue) != ''">
					<keyValue>
						<xsl:value-of select="v1:keyValue"/>
					</keyValue>
				</xsl:if>
			</key>
			<key>
				<xsl:value-of select="$pARRAY"/>
			</key>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:offeringClassification">
		<xsl:if test="normalize-space(.) != ''">
			<offeringClassification>
				<xsl:if test="normalize-space(v1:classificationCode) != ''">
					<classificationCode>
						<xsl:value-of select="v1:classificationCode"/>
					</classificationCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:nameValue) != ''">
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

	<xsl:template match="v1:description" mode="productOffering-description">
		<xsl:if
			test="normalize-space(.) != '' or @salesChannelCode or @usageContext or @languageCode">
			<description>
				<xsl:if test="@salesChannelCode">
					<xsl:attribute name="salesChannelCode">
						<xsl:value-of select="@salesChannelCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@usageContext">
					<xsl:attribute name="usageContext">
						<xsl:value-of select="@usageContext"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@languageCode">
					<xsl:attribute name="languageCode">
						<xsl:value-of select="@languageCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</description>

			<description>
				<xsl:value-of select="$pARRAY"/>
			</description>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:description" mode="description-cartItemStatus">
		<xsl:if test="normalize-space(.) != '' or @usageContext">
			<description>
				<xsl:if test="@usageContext != ''">
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

	<xsl:template match="v1:shortDescription">
		<xsl:if test="normalize-space(.) != '' or @languageCode">
			<shortDescription>
				<xsl:if test="@languageCode">
					<xsl:attribute name="languageCode">
						<xsl:value-of select="@languageCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</shortDescription>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:shortDescription" mode="productOffering-shortDescription">
		<xsl:if
			test="normalize-space(.) != '' or @languageCode or @salesChannelCode or @usageContext">
			<shortDescription>
				<xsl:if test="@languageCode">
					<xsl:attribute name="languageCode">
						<xsl:value-of select="@languageCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@salesChannelCode">
					<xsl:attribute name="salesChannelCode">
						<xsl:value-of select="@salesChannelCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@usageContext">
					<xsl:attribute name="usageContext">
						<xsl:value-of select="@usageContext"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</shortDescription>

			<shortDescription>
				<xsl:value-of select="$pARRAY"/>
			</shortDescription>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:specificationGroup">
		<xsl:if test="normalize-space(.) != ''">
			<specificationGroup>
				<xsl:apply-templates select="v1:specificationValue"/>
			</specificationGroup>
			<specificationGroup>
				<xsl:value-of select="$pARRAY"/>
			</specificationGroup>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:offeringStatus">
		<xsl:if test="normalize-space(.) != '' or @statusCode">
			<offeringStatus>

				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>

				<!--	<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:effectivePeriod"/>
			</offeringStatus>
			<!--<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>-->
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:longDescription | v1:alternateDescription">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:descriptionCode"/>
				<xsl:if test="normalize-space(v1:salesChannelCode) != ''">
					<salesChannelCode>
						<xsl:value-of select="v1:salesChannelCode"/>
					</salesChannelCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:languageCode) != ''">
					<languageCode>
						<xsl:value-of select="v1:languageCode"/>
					</languageCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:relativeSize) != ''">
					<relativeSize>
						<xsl:value-of select="v1:relativeSize"/>
					</relativeSize>
				</xsl:if>
				<xsl:if test="normalize-space(v1:contentType) != ''">
					<contentType>
						<xsl:value-of select="v1:contentType"/>
					</contentType>
				</xsl:if>
				<xsl:if test="normalize-space(v1:descriptionText) != ''">
					<descriptionText>
						<xsl:value-of select="v1:descriptionText"/>
					</descriptionText>
				</xsl:if>
			</xsl:element>
			<xsl:element name="{local-name()}">
				<xsl:value-of select="$pARRAY"/>
			</xsl:element>
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
				<xsl:if test="normalize-space(v1:name) != ''">
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
				<xsl:if test="normalize-space(v1:name) != ''">
					<name>
						<xsl:value-of select="v1:name"/>
					</name>
				</xsl:if>
				<xsl:if test="normalize-space(v1:productChargeType) != ''">
					<productChargeType>
						<xsl:value-of select="v1:productChargeType"/>
					</productChargeType>
				</xsl:if>
				<xsl:if test="normalize-space(v1:productChargeIncurredType) != ''">
					<productChargeIncurredType>
						<xsl:value-of select="v1:productChargeIncurredType"/>
					</productChargeIncurredType>
				</xsl:if>
				<xsl:apply-templates select="v1:basisAmount"/>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:if test="normalize-space(v1:oneTimeCharge) != ''">
					<oneTimeCharge>
						<xsl:value-of select="v1:oneTimeCharge"/>
					</oneTimeCharge>
				</xsl:if>
				<!--xsl:apply-templates select="v1:recurringFeeFrequency"/-->
				<xsl:if test="normalize-space(v1:taxInclusiveIndicator) != ''">
					<taxInclusiveIndicator>
						<xsl:value-of select="v1:taxInclusiveIndicator"/>
					</taxInclusiveIndicator>
				</xsl:if>
				<xsl:apply-templates select="v1:specificationValue"/>
			</productOfferingPrice>
		</xsl:if>
		<productOfferingPrice>
			<xsl:value-of select="$pARRAY"/>
		</productOfferingPrice>
	</xsl:template>

	<!--<xsl:template match="v1:basisAmount">
		<xsl:if test="normalize-space(.) != '' or @currencyCode">
			<basisAmount>
				<xsl:if test="@currencyCode">
					<xsl:attribute name="currencyCode">
						<xsl:value-of select="@currencyCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</basisAmount>
		</xsl:if>
	</xsl:template>-->

	
	<xsl:template match="v1:orderBehavior">
		<xsl:if test="normalize-space(.) != ''">
			<orderBehavior>
				<xsl:if test="normalize-space(v1:preOrderAllowedIndicator) != '' or v1:preOrderAllowedIndicator/@name">
					<preOrderAllowedIndicator>
						<xsl:if test="v1:preOrderAllowedIndicator/@name">
							<xsl:attribute name="name">
								<xsl:value-of select="v1:preOrderAllowedIndicator/@name"/>
							</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="v1:preOrderAllowedIndicator"/>
					</preOrderAllowedIndicator>
				</xsl:if>
				<xsl:if test="normalize-space(v1:preOrderAvailableTime) != ''">
					<preOrderAvailableTime>
						<xsl:value-of select="v1:preOrderAvailableTime"/>
					</preOrderAvailableTime>
				</xsl:if>
				<!--xsl:apply-templates select="v1:saleStartTime"/><xsl:apply-templates select="v1:saleEndTime"/-->
			</orderBehavior>
			<orderBehavior>
				<xsl:value-of select="$pARRAY"/>
			</orderBehavior>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:image">
		<xsl:if test="normalize-space(.) != ''">
			<image>
				<xsl:if test="normalize-space(v1:URI) != ''">
					<URI>
						<xsl:value-of select="v1:URI"/>
					</URI>
				</xsl:if>
				<xsl:if test="normalize-space(v1:sku) != ''">
					<sku>
						<xsl:value-of select="v1:sku"/>
					</sku>
				</xsl:if>
				<xsl:if test="normalize-space(v1:imageDimensions) != ''">
					<imageDimensions>
						<xsl:value-of select="v1:imageDimensions"/>
					</imageDimensions>
				</xsl:if>
				<xsl:if test="normalize-space(v1:displayPurpose) != ''">
					<displayPurpose>
						<xsl:value-of select="v1:displayPurpose"/>
					</displayPurpose>
				</xsl:if>
			</image>
			<image>
				<xsl:value-of select="$pARRAY"/>
			</image>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:offeringVariant">
		<xsl:if test="normalize-space(.) != ''">
			<offeringVariant>
				<xsl:if test="normalize-space(v1:sku) != ''">
					<sku>
						<xsl:value-of select="v1:sku"/>
					</sku>
				</xsl:if>
				<xsl:apply-templates select="v1:specificationGroup"/>
				<xsl:apply-templates select="v1:offeringVariantPrice"/>
				<xsl:if test="normalize-space(v1:productCondition) != ''">
					<productCondition>
						<xsl:value-of select="v1:productCondition"/>
					</productCondition>
				</xsl:if>
				<xsl:if test="normalize-space(v1:color) != ''">
					<color>
						<xsl:value-of select="v1:color"/>
					</color>
				</xsl:if>
				<xsl:if test="normalize-space(v1:memory) != ''">
					<memory>
						<xsl:value-of select="v1:memory"/>
					</memory>
				</xsl:if>
				<xsl:if test="normalize-space(v1:tacCode) != ''">
					<tacCode>
						<xsl:value-of select="v1:tacCode"/>
					</tacCode>
				</xsl:if>
				<xsl:apply-templates select="v1:orderBehavior"/>
			</offeringVariant>
			<offeringVariant>
				<xsl:value-of select="$pARRAY"/>
			</offeringVariant>
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
				<xsl:if test="normalize-space(v1:name) != ''">
					<name>
						<xsl:value-of select="v1:name"/>
					</name>
				</xsl:if>
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
				<xsl:if test="normalize-space(v1:name) != ''">
					<name>
						<xsl:value-of select="v1:name"/>
					</name>
				</xsl:if>
				<xsl:apply-templates select="v1:keyword" mode="productSpecification-keyword"/>
				<xsl:if test="normalize-space(v1:productType) != ''">
					<productType>
						<xsl:value-of select="v1:productType"/>
					</productType>
				</xsl:if>
				<xsl:if test="normalize-space(v1:productSubType) != ''">
					<productSubType>
						<xsl:value-of select="v1:productSubType"/>
					</productSubType>
				</xsl:if>
				<xsl:apply-templates select="v1:additionalSpecification"/>
			</productSpecification>
		</xsl:if>
		<!--xsl:if test="not(contains($acceptType, 'xml'))">
			<xsl:element name="{local-name()}">
				<xsl:value-of select="$pARRAY"/>
			</xsl:element>
		</xsl:if-->
	</xsl:template>

	<xsl:template match="v1:keyword" mode="productSpecification-keyword">
		<xsl:if test="normalize-space(.) != '' or @name">
			<keyword>
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
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
		<xsl:if test="normalize-space(.) != ''">
			<cartSchedule>
				<xsl:if test="@cartScheduleId != ''">
					<xsl:attribute name="cartScheduleId">
						<xsl:value-of select="@cartScheduleId"/>
					</xsl:attribute>
				</xsl:if>				
				<xsl:if test="normalize-space(v1:description) != ''">
					<description>
						<xsl:value-of select="v1:description"/>
					</description>
				</xsl:if>
				<xsl:apply-templates select="v1:cartScheduleStatus"/>
				<xsl:apply-templates select="v1:cartScheduleCharge"/>
				<xsl:apply-templates select="v1:cartScheduleDeduction"/>
				<xsl:apply-templates select="v1:cartScheduleTax"/>
				<xsl:if test="normalize-space(v1:calculationType) != ''">
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
				<xsl:if test="@statusCode != ''">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				
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
				<xsl:if test="normalize-space(v1:typeCode) != ''">
					<typeCode>
						<xsl:value-of select="v1:typeCode"/>
					</typeCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:chargeFrequencyCode) != ''">
					<chargeFrequencyCode>
						<xsl:value-of select="v1:chargeFrequencyCode"/>
					</chargeFrequencyCode>
				</xsl:if>
				<xsl:apply-templates select="v1:basisAmount"/>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:if test="normalize-space(v1:reason) != ''">
					<reason>
						<xsl:value-of select="v1:reason"/>
					</reason>
				</xsl:if>
				<xsl:apply-templates select="v1:effectivePeriod"
					mode="effectivePeriod-cartScheduleCharge"/>
				<xsl:if test="normalize-space(v1:proratedIndicator) != ''">
					<proratedIndicator>
						<xsl:value-of select="v1:proratedIndicator"/>
					</proratedIndicator>
				</xsl:if>
				<xsl:if test="normalize-space(v1:description) != ''">
					<description>
						<xsl:value-of select="v1:description"/>
					</description>
					<description>		
						<xsl:value-of select="$pARRAY" />		
					</description>
				</xsl:if>
				<xsl:if test="normalize-space(v1:chargeCode) != ''">
					<chargeCode>
						<xsl:value-of select="v1:chargeCode"/>
					</chargeCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:waiverIndicator) != ''">
					<waiverIndicator>
						<xsl:value-of select="v1:waiverIndicator"/>
					</waiverIndicator>
				</xsl:if>
				<xsl:if test="normalize-space(v1:waiverReason) != ''">
					<waiverReason>
						<xsl:value-of select="v1:waiverReason"/>
					</waiverReason>
				</xsl:if>
				<xsl:if test="normalize-space(v1:manuallyAddedCharge) != ''">
					<manuallyAddedCharge>
						<xsl:value-of select="v1:manuallyAddedCharge"/>
					</manuallyAddedCharge>
				</xsl:if>
				<xsl:apply-templates select="v1:productOffering"
					mode="cartScheduleCharge-productOffering"/>
				<xsl:apply-templates select="v1:feeOverrideAllowed"/>
				<xsl:if test="normalize-space(v1:overrideThresholdPercent) != ''">
					<overrideThresholdPercent>
						<xsl:value-of select="v1:overrideThresholdPercent"/>
					</overrideThresholdPercent>
				</xsl:if>
				<xsl:apply-templates select="v1:overrideThresholdAmount"/>
				<xsl:if test="normalize-space(v1:supervisorID) != ''">
					<supervisorID>
						<xsl:value-of select="v1:supervisorID"/>
					</supervisorID>
				</xsl:if>
				<xsl:apply-templates select="v1:overrideAmount"/>
				<xsl:if test="normalize-space(v1:overrideReason) != ''">
					<overrideReason>
						<xsl:value-of select="v1:overrideReason"/>
					</overrideReason>
				</xsl:if>
				<xsl:if test="normalize-space(v1:productOfferingPriceId) != ''">
					<productOfferingPriceId>
						<xsl:value-of select="v1:productOfferingPriceId"/>
					</productOfferingPriceId>
				</xsl:if>
			</cartScheduleCharge>
			<cartScheduleCharge>
				<xsl:value-of select="$pARRAY"/>
			</cartScheduleCharge>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:effectivePeriod" mode="effectivePeriod-cartScheduleCharge">
		<xsl:if test="normalize-space(.) != ''">
			<effectivePeriod>
				<xsl:if test="normalize-space(v1:startTime) != ''">
					<startTime>
						<xsl:value-of select="v1:startTime"/>
					</startTime>
				</xsl:if>
				<xsl:if test="normalize-space(v1:endTime) != ''">
					<endTime>
						<xsl:value-of select="v1:endTime"/>
					</endTime>
				</xsl:if>
			</effectivePeriod>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:feeOverrideAllowed">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:if test="normalize-space(.) != ''">
				<feeOverrideAllowed>
					<xsl:apply-templates select="@name | node()"/>
				</feeOverrideAllowed>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:productOffering" mode="cartScheduleCharge-productOffering">
		<xsl:if test="normalize-space(.) != '' or @productOfferingId">
			<productOffering>
				<xsl:if test="@productOfferingId">
					<xsl:attribute name="productOfferingId">
						<xsl:value-of select="@productOfferingId"/>
					</xsl:attribute>
				</xsl:if>				
			</productOffering>
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
				<xsl:if test="normalize-space(v1:reason) != ''">
					<reason>
						<xsl:value-of select="v1:reason"/>
					</reason>
				</xsl:if>
				<xsl:apply-templates select="v1:effectivePeriod"
					mode="effectivePeriod-cartScheduleDeduction"/>
				<xsl:if test="normalize-space(v1:proratedIndicator) != ''">
					<proratedIndicator>
						<xsl:value-of select="v1:proratedIndicator"/>
					</proratedIndicator>
				</xsl:if>
				<xsl:apply-templates select="v1:description"
					mode="cartScheduleDeduction-description"/>
				<xsl:if test="normalize-space(v1:recurringFrequency) != ''">
					<recurringFrequency>
						<xsl:value-of select="v1:recurringFrequency"/>
					</recurringFrequency>
				</xsl:if>
				<xsl:apply-templates select="v1:promotion" mode="promotion-cartScheduleDeduction"/>
				<xsl:if test="normalize-space(v1:chargeCode) != ''">
					<chargeCode>
						<xsl:value-of select="v1:chargeCode"/>
					</chargeCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:productOfferingPriceId) != ''">
					<productOfferingPriceId>
						<xsl:value-of select="v1:productOfferingPriceId"/>
					</productOfferingPriceId>
				</xsl:if>
				<xsl:apply-templates select="v1:specificationValue"/>
				<xsl:if test="normalize-space(v1:realizationMethod) != ''">
					<realizationMethod>
						<xsl:value-of select="v1:realizationMethod"/>
					</realizationMethod>
				</xsl:if>
			</cartScheduleDeduction>
			<cartScheduleDeduction>
				<xsl:value-of select="$pARRAY"/>
			</cartScheduleDeduction>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:description" mode="cartScheduleDeduction-description">
		<xsl:if test="normalize-space(.) != ''">
			<description>
				<xsl:value-of select="."/>
			</description>

			<description>
				<xsl:value-of select="$pARRAY"/>
			</description>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:effectivePeriod" mode="effectivePeriod-cartScheduleDeduction">
		<xsl:if test="normalize-space(.) != ''">
			<effectivePeriod>
				<xsl:if test="normalize-space(v1:startTime) != ''">
					<startTime>
						<xsl:value-of select="v1:startTime"/>
					</startTime>
				</xsl:if>
				<xsl:if test="normalize-space(v1:endTime) != ''">
					<endTime>
						<xsl:value-of select="v1:endTime"/>
					</endTime>
				</xsl:if>
			</effectivePeriod>
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
		<xsl:if test="normalize-space(.) != ''  or @id">
			<cartScheduleTax>
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				
				<xsl:if test="normalize-space(v1:code) != ''">
					<code>
						<xsl:value-of select="v1:code"/>
					</code>
				</xsl:if>
				<xsl:if test="normalize-space(v1:taxJurisdiction) != ''">
					<taxJurisdiction>
						<xsl:value-of select="v1:taxJurisdiction"/>
					</taxJurisdiction>
				</xsl:if>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:if test="normalize-space(v1:typeCode) != ''">
					<typeCode>
						<xsl:value-of select="v1:typeCode"/>
					</typeCode>
				</xsl:if>
				<xsl:if test="normalize-space(v1:description) != ''">
					<description>
						<xsl:value-of select="v1:description"/>
					</description>
				</xsl:if>
				<xsl:if test="normalize-space(v1:taxRate) != ''">
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


	<xsl:template match="v1:promotion">
		<xsl:if test="normalize-space(.) != '' or @promotionId or @actionCode">
			<promotion>
				<xsl:if test="@promotionId != ''">
					<xsl:attribute name="promotionId">
						<xsl:value-of select="@promotionId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:if test="normalize-space(v1:promotionName) != ''">
					<promotionName>
						<xsl:value-of select="v1:promotionName"/>
					</promotionName>
				</xsl:if>
				<xsl:if test="normalize-space(v1:promotionCode) != ''">
					<promotionCode>
						<xsl:value-of select="v1:promotionCode"/>
					</promotionCode>
				</xsl:if>
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
				<xsl:if test="normalize-space(v1:financialAccountNumber) != ''">
					<financialAccountNumber>
						<xsl:value-of select="v1:financialAccountNumber"/>
					</financialAccountNumber>
				</xsl:if>
				<xsl:apply-templates select="v1:subscriberContact"/>
				<xsl:apply-templates select="v1:networkResource"
					mode="lineOfService-networkResource"/>
				<xsl:apply-templates select="v1:lineOfServiceStatus"/>
				<xsl:if test="normalize-space(v1:primaryLineIndicator) != ''">
					<primaryLineIndicator>
						<xsl:value-of select="v1:primaryLineIndicator"/>
					</primaryLineIndicator>
				</xsl:if>
				<xsl:if test="normalize-space(v1:lineAlias) != ''">
					<lineAlias>
						<xsl:value-of select="v1:lineAlias"/>
					</lineAlias>
				</xsl:if>
				<xsl:if test="normalize-space(v1:lineSequence) != ''">
					<lineSequence>
						<xsl:value-of select="v1:lineSequence"/>
					</lineSequence>
				</xsl:if>
				<xsl:apply-templates select="v1:assignedProduct"/>
				<xsl:apply-templates select="v1:effectivePeriod"/>
				<xsl:apply-templates select="v1:memberLineOfService"/>
				<xsl:apply-templates select="v1:preferredLanguage"/>
				<xsl:apply-templates select="v1:specificationGroup"/>
				<xsl:apply-templates select="v1:privacyProfile"
					mode="accountHolderAddress-privacyProfile"/>
			</lineOfService>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:memberLineOfService">
		<xsl:if test="normalize-space(.) != ''">
			<memberLineOfService>
				<xsl:if test="normalize-space(v1:primaryLineIndicator) != ''">
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
		<xsl:if test="normalize-space(.) != ''">
			<lineOfServiceStatus>
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:reasonCode"/>
			</lineOfServiceStatus>
			<!--xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if-->
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:subscriberContact">
		<xsl:if test="normalize-space(.) != ''">
			<subscriberContact>
				<xsl:apply-templates select="v1:addressCommunication" mode="addressCommunicationsubscriberContact"/>
			</subscriberContact>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:addressCommunication" mode="addressCommunicationsubscriberContact">
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
				<xsl:apply-templates select="v1:privacyProfile"/>
				<xsl:apply-templates select="v1:uiAddedIndicator"/>				
				<xsl:apply-templates select="v1:address"/>
				<xsl:apply-templates select="v1:usageContext"	mode="addressCommunication-usageContext"/>
			</addressCommunication>

			<addressCommunication>
				<xsl:value-of select="$pARRAY"/>
			</addressCommunication>

		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:usageContext" mode="addressCommunication-usageContext">
		<xsl:if test="normalize-space(.) != ''">
			<usageContext>
				<xsl:apply-templates select="node()"/>
			</usageContext>
			<!--xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if-->
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:privacyProfile">
		<xsl:if test="normalize-space(.) != ''">
			<privacyProfile>
				<xsl:apply-templates select="v1:optOut"/>
			</privacyProfile>
			<!--xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if-->
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
				<xsl:if test="normalize-space(v1:imei) != ''">
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

	<xsl:template match="v1:resourceSpecification">
		<xsl:if test="normalize-space(.) != '' or @name">
			<resourceSpecification>
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:specificationValue"/>
			</resourceSpecification>
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

				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:if test="normalize-space(v1:imei) != ''">
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

	<xsl:template match="v1:sim" mode="networkResource-sim">
		<xsl:if test="normalize-space(.) != ''">
			<sim>
				<xsl:if test="normalize-space(v1:simNumber) != ''">
					<simNumber>
						<xsl:value-of select="v1:simNumber"/>
					</simNumber>
				</xsl:if>
				<xsl:if test="normalize-space(v1:imsi) != ''">
					<imsi>
						<xsl:value-of select="v1:imsi"/>
					</imsi>
				</xsl:if>
				<xsl:if test="normalize-space(v1:simType) != ''">
					<simType>
						<xsl:value-of select="v1:simType"/>
					</simType>
				</xsl:if>
				<xsl:if test="normalize-space(v1:virtualSim) != ''">
					<virtualSim>
						<xsl:value-of select="v1:virtualSim"/>
					</virtualSim>
				</xsl:if>
				<xsl:if test="normalize-space(v1:embeddedSIMIndicator) != ''">
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
				<xsl:apply-templates select="v1:msisdn"/>
				<xsl:apply-templates select="v1:portIndicator"/>
				<xsl:apply-templates select="v1:portReason"/>
			</mobileNumber>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:mobileNumber" mode="networkMobile">
		<xsl:if test="normalize-space(.) != ''">
			<mobileNumber>
				<xsl:apply-templates select="v1:msisdn"/>
				<xsl:apply-templates select="v1:portIndicator"/>
				<xsl:apply-templates select="v1:portReason"/>
			</mobileNumber>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:sim">
		<xsl:if test="normalize-space(.) != ''">
			<sim>
				<xsl:if test="normalize-space(v1:simNumber) != ''">
					<simNumber>
						<xsl:value-of select="v1:simNumber"/>
					</simNumber>
				</xsl:if>
				<xsl:if test="normalize-space(v1:imsi) != ''">
					<imsi>
						<xsl:value-of select="v1:imsi"/>
					</imsi>
				</xsl:if>
				<xsl:if test="normalize-space(v1:simType) != ''">
					<simType>
						<xsl:value-of select="v1:simType"/>
					</simType>
				</xsl:if>
				<xsl:if test="normalize-space(v1:virtualSim) != ''">
					<virtualSim>
						<xsl:value-of select="v1:virtualSim"/>
					</virtualSim>
				</xsl:if>
			</sim>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:assignedProduct">
		<xsl:if test="normalize-space(.) != '' or @actionCode">
			<assignedProduct>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="v1:key"/>
				<xsl:apply-templates select="v1:productOffering"/>
				<xsl:apply-templates select="v1:effectivePeriod"
					mode="assignedProduct-effectivePeriod"/>
				<xsl:if test="normalize-space(v1:customerOwnedIndicator) != ''">
					<customerOwnedIndicator>
						<xsl:value-of select="v1:customerOwnedIndicator"/>
					</customerOwnedIndicator>
				</xsl:if>
				<xsl:apply-templates select="v1:warranty"/>
				<xsl:apply-templates select="v1:eligibilityEvaluation"/>
			</assignedProduct>
			<!--<xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if>-->
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:eligibilityEvaluation">
		<xsl:if test="normalize-space(.) != ''">
			<eligibilityEvaluation>
				<xsl:apply-templates select="v1:overrideIndicator"/>
			</eligibilityEvaluation>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:overrideIndicator">
		<xsl:if test="normalize-space(.) != ''">
			<overrideIndicator>
				<xsl:apply-templates select="@name | node()"/>
			</overrideIndicator>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:effectivePeriod" mode="assignedProduct-effectivePeriod">
		<xsl:if test="normalize-space(.) != ''">
			<effectivePeriod>
				<xsl:if test="normalize-space(v1:startTime) != ''">
					<startTime>
						<xsl:value-of select="v1:startTime"/>
					</startTime>
				</xsl:if>
				<xsl:if test="normalize-space(v1:endTime) != ''">
					<endTime>
						<xsl:value-of select="v1:endTime"/>
					</endTime>
				</xsl:if>
				<xsl:if test="normalize-space(v1:usageContext) != ''">
					<usageContext>
						<xsl:value-of select="v1:usageContext"/>
					</usageContext>
				</xsl:if>
			</effectivePeriod>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:warranty">
		<xsl:if test="normalize-space(.) != ''">
			<warranty>
				<xsl:apply-templates select="v1:warrantyExpirationDate"/>
			</warranty>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:productOfferingPrice" mode="productOfferingPriceofferingPrice">
		<xsl:if test="normalize-space(.) != ''">
			<productOfferingPrice>
				<xsl:if test="normalize-space(v1:name) != ''">
					<name>
						<xsl:value-of select="v1:name"/>
					</name>
				</xsl:if>
				<xsl:if test="normalize-space(v1:productChargeType) != ''">
					<productChargeType>
						<xsl:value-of select="v1:productChargeType"/>
					</productChargeType>
				</xsl:if>
				<xsl:if test="normalize-space(v1:productChargeIncurredType) != ''">
					<productChargeIncurredType>
						<xsl:value-of select="v1:productChargeIncurredType"/>
					</productChargeIncurredType>
				</xsl:if>
				<xsl:apply-templates select="v1:basisAmount"/>
				<xsl:apply-templates select="v1:amount"/>
				<xsl:if test="normalize-space(v1:oneTimeCharge) != ''">
					<oneTimeCharge>
						<xsl:value-of select="v1:oneTimeCharge"/>
					</oneTimeCharge>
				</xsl:if>
				<xsl:if test="normalize-space(v1:recurringFeeFrequency) != ''">
					<recurringFeeFrequency>
						<xsl:value-of select="v1:recurringFeeFrequency"/>
					</recurringFeeFrequency>
				</xsl:if>
				<xsl:if test="normalize-space(v1:taxInclusiveIndicator) != ''">
					<taxInclusiveIndicator>
						<xsl:value-of select="v1:taxInclusiveIndicator"/>
					</taxInclusiveIndicator>
				</xsl:if>
				<xsl:apply-templates select="v1:specificationValue"/>
			</productOfferingPrice>
		</xsl:if>
	</xsl:template>



	<xsl:template match="v1:effectivePeriod | v1:promotionEffectivePeriod">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="{local-name()}">
				<xsl:if test="normalize-space(v1:startTime) != ''">
					<startTime>
						<xsl:value-of select="v1:startTime"/>
					</startTime>
				</xsl:if>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:sim" mode="simnetworkResource">
		<xsl:if test="normalize-space(.) != ''">
			<sim>
				<xsl:if test="normalize-space(v1:simNumber) != ''">
					<simNumber>
						<xsl:value-of select="v1:simNumber"/>
					</simNumber>
				</xsl:if>
				<xsl:if test="normalize-space(v1:imsi) != ''">
					<imsi>
						<xsl:value-of select="v1:imsi"/>
					</imsi>
				</xsl:if>
			</sim>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:mobileNumber">
		<xsl:if test="normalize-space(.) != ''">
			<mobileNumber>
				<xsl:if test="normalize-space(v1:msisdn) != ''">
					<msisdn>
						<xsl:value-of select="v1:msisdn"/>
					</msisdn>
				</xsl:if>
				<xsl:if test="normalize-space(v1:portIndicator) != ''">
					<portIndicator>
						<xsl:value-of select="v1:portIndicator"/>
					</portIndicator>
				</xsl:if>
				<xsl:if test="normalize-space(v1:portReason) != ''">
					<portReason>
						<xsl:value-of select="v1:portReason"/>
					</portReason>
				</xsl:if>
			</mobileNumber>
		</xsl:if>
	</xsl:template>

	<xsl:template
		match="
			v1:amount | v1:totalAmount | v1:totalTaxAmount | v1:basisAmount | v1:overrideThresholdAmount | v1:overrideAmount | v1:extendedAmount
			| v1:totalChargeAmount | v1:totalDiscountAmount | v1:totalFeeAmount
			| v1:totalDueNowAmount | v1:requestAmount | v1:authorizationAmount | v1:totalCurrentRecurringAmount
			| v1:totalSoftGoodRecurringDueNowAmount | v1:totalSoftGoodOneTimeDueNowAmount
			| v1:totalHardGoodDueNowAmount | v1:totalHardGoodDueNowAmount
			| v1:totalSoftGoodDueNowAmount | v1:totalExtendedAmount
			| v1:totalDeltaRecurringDueAmount | v1:totalRefundAmountDueLater
			| v1:totalRefundAmountDueNow | v1:finalRefundAmountDueNow | v1:totalDuePayNowAmount | v1:totalDueMonthlyAmount">
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



	<xsl:template match="v1:paymentLine">
		<xsl:if test="normalize-space(.) != ''">
			<paymentLine>
				<!--<xsl:apply-templates select="@*"/>-->
				<xsl:apply-templates select="v1:financialAccountNumber"/>
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
				<xsl:value-of select="v1:status"/>
			</status>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:tokenization">
		<xsl:if test="normalize-space(.) != ''">
			<tokenization>
				<xsl:if test="normalize-space(v1:encryptionTarget) != ''">
					<encryptionTarget>
						<xsl:value-of select="v1:encryptionTarget"/>
					</encryptionTarget>
				</xsl:if>
				<xsl:if test="normalize-space(v1:encryptedContent) != ''">
					<encryptedContent>
						<xsl:value-of select="v1:encryptedContent"/>
					</encryptedContent>
				</xsl:if>
			</tokenization>
		</xsl:if>
	</xsl:template>

	<!--<xsl:template match="v1:bankPayment">
		<xsl:if test="normalize-space(.) != ''">
			<bankPayment>
				<xsl:apply-templates select="v1:payFromBankAccount"/>
				<xsl:apply-templates select="v1:check"/>
				<xsl:apply-templates select="v1:chargeAccountNumberIndicator"/>
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
	</xsl:template>-->

	<!--<xsl:template match="v1:payFromBankAccount">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<payFromBankAccount>
			
				<xsl:apply-templates select="v1:accountNumber"/>
				<xsl:apply-templates select="v1:bank"/>
			</payFromBankAccount>
				</xsl:if>
	</xsl:template>-->

	<!--<xsl:template match="v1:name" mode="bankName">
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

	<xsl:template match="v1:payFromParty">
		<xsl:if test="normalize-space(.) != ''">
			<payFromParty>
				<xsl:apply-templates select="v1:securityProfile"/>
			</payFromParty>
			<!--xsl:if test="not(contains($acceptType, 'xml'))">
				<xsl:element name="{local-name()}">
					<xsl:value-of select="$pARRAY"/>
				</xsl:element>
			</xsl:if-->
		</xsl:if>
	</xsl:template>

	<!--	<xsl:template match="v1:securityProfile">
		<xsl:if test="normalize-space(.) != ''">
			<securityProfile>
				<xsl:if test="normalize-space(v1:msisdn) != ''">
					<msisdn>
						<xsl:value-of select="v1:msisdn"/>
					</msisdn>
				</xsl:if>
			</securityProfile>
		</xsl:if>
	</xsl:template>-->

	<xsl:template match="v1:voucherRedemption">
		<xsl:if test="normalize-space(.) != ''">
			<voucherRedemption>
				<xsl:if test="normalize-space(v1:serialNumber) != ''">
					<serialNumber>
						<xsl:value-of select="v1:serialNumber"/>
					</serialNumber>
				</xsl:if>
				<xsl:if test="normalize-space(v1:issuerId) != ''">
					<issuerId>
						<xsl:value-of select="v1:issuerId"/>
					</issuerId>
				</xsl:if>
				<xsl:if test="normalize-space(v1:PIN) != ''">
					<PIN>
						<xsl:value-of select="v1:PIN"/>
					</PIN>
				</xsl:if>
				<xsl:if test="normalize-space(v1:voucherRedemptionType) != ''">
					<voucherRedemptionType>
						<xsl:value-of select="v1:voucherRedemptionType"/>
					</voucherRedemptionType>
				</xsl:if>
			</voucherRedemption>
		</xsl:if>
	</xsl:template>
	<xsl:template match="v1:creditCardPayment">
		<xsl:if test="normalize-space(.) != ''">
			<creditCardPayment>
				<!--xsl:apply-templates select="v1:authorizationId"/-->
				<xsl:apply-templates select="v1:chargeAmount"/>
				<xsl:apply-templates select="v1:creditCard"/>
			</creditCardPayment>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:chargeAmount">
		<xsl:if test="normalize-space(.) != '' or @currencyCode">
			<chargeAmount>
				<xsl:attribute name="currencyCode">
					<xsl:value-of select="if (@currencyCode != '')
						then  @currencyCode else 'USD'"/>
				</xsl:attribute>
				<xsl:value-of select="concat($pINTEGER, ., $pINTEGER)"/>
			</chargeAmount>
		</xsl:if>
	</xsl:template>


	<xsl:template match="v1:creditCard">
		<xsl:if test="normalize-space(.) != ''">
			<creditCard>
				<xsl:if test="normalize-space(v1:typeCode) != ''">
					<typeCode>
						<xsl:value-of select="v1:typeCode"/>
					</typeCode>
				</xsl:if>
				<xsl:apply-templates select="v1:cardNumber"/>					
				
				<xsl:if test="normalize-space(v1:cardHolderName) != ''">
					<cardHolderName>
						<xsl:value-of select="v1:cardHolderName"/>
					</cardHolderName>
				</xsl:if>
				<xsl:if test="normalize-space(v1:expirationMonthYear) != ''">
					<expirationMonthYear>
						<xsl:value-of select="v1:expirationMonthYear"/>
					</expirationMonthYear>
				</xsl:if>
				<xsl:apply-templates select="v1:cardHolderBillingAddress"/>
			</creditCard>

		</xsl:if>
	</xsl:template>



	<!--xsl:template match="v1:cardHolderAddress">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:addressFormatType"/>
				<xsl:apply-templates select="v1:addressLine1"/>
				<xsl:apply-templates select="v1:addressLine2"/>
				<xsl:apply-templates select="v1:cityName"/>
				<xsl:apply-templates select="v1:stateName"/>
				<xsl:apply-templates select="v1:countryCode"/>
				<xsl:apply-templates select="v1:postalCode"/>
				<xsl:apply-templates select="v1:postalCodeExtension"/>
				<xsl:apply-templates select="v1:key"/>
			</xsl:element>
		</xsl:if>
	</xsl:template-->

	<xsl:template match="v1:cardHolderBillingAddress | v1:cardHolderAddress">
		<xsl:if test="normalize-space(.) != ''">
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
		<xsl:if test="normalize-space(.) != ''">
			<debitCardPayment>
				<!--xsl:apply-templates select="v1:authorizationId"/-->
				<xsl:apply-templates select="v1:chargeAmount"/>
				<xsl:apply-templates select="v1:debitCard"/>
			</debitCardPayment>
		</xsl:if>
	</xsl:template>

	<xsl:template match="v1:debitCard">
		<xsl:if test="normalize-space(.) != ''">
			<debitCard>
				<xsl:if test="normalize-space(v1:typeCode) != ''">
					<typeCode>
						<xsl:value-of select="v1:typeCode"/>
					</typeCode>
				</xsl:if>
				<xsl:apply-templates select="v1:cardNumber"/>
				<xsl:if test="normalize-space(v1:cardHolderName) != ''">
					<cardHolderName>
						<xsl:value-of select="v1:cardHolderName"/>
					</cardHolderName>
				</xsl:if>
				<xsl:if test="normalize-space(v1:expirationMonthYear) != ''">
					<expirationMonthYear>
						<xsl:value-of select="v1:expirationMonthYear"/>
					</expirationMonthYear>
				</xsl:if>
				<xsl:apply-templates select="v1:cardHolderAddress"/>
				<!--xsl:apply-templates select="v1:cardHolderFirstName"/>
				<xsl:apply-templates select="v1:cardHolderLastName"/>
				<xsl:apply-templates select="v1:cardTypeIndicator"/>
				<xsl:apply-templates select="v1:chargeAccountNumberIndicator"/>
				<xsl:apply-templates select="v1:PIN"/-->
			</debitCard>
		</xsl:if>
	</xsl:template>
	<!--xsl:template match="v1:cardHolderAddress">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="{local-name()}">
				<xsl:apply-templates select="v1:addressFormatType"/>
				<xsl:apply-templates select="v1:addressLine1"/>
				<xsl:apply-templates select="v1:addressLine2"/>
				<xsl:apply-templates select="v1:cityName"/>
				<xsl:apply-templates select="v1:stateCode"/>
				<xsl:apply-templates select="v1:countryCode"/>
				<xsl:apply-templates select="v1:postalCode"/>
				<xsl:apply-templates select="v1:postalCodeExtension"/>
			</xsl:element>
		</xsl:if>
	</xsl:template-->

	<xsl:template match="v1:trackData">
		<xsl:if test="normalize-space(.) != ''">
			<trackData>
				<xsl:if test="normalize-space(v1:track1Data) != ''">
					<track1Data>
						<xsl:value-of select="v1:track1Data"/>
					</track1Data>
				</xsl:if>
				<xsl:if test="normalize-space(v1:track2Data) != ''">
					<track2Data>
						<xsl:value-of select="v1:track2Data"/>
					</track2Data>
				</xsl:if>
			</trackData>
		</xsl:if>
	</xsl:template>

	<xsl:template match="@* | node()">
		<xsl:copy>
			<xsl:apply-templates select="@* | node()"/>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
