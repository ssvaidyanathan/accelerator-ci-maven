<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:v1="http://services.tmobile.com/OrderManagement/CartWSIL/V1"
    xmlns:base="http://services.tmobile.com/base" xmlns:saxon="http://saxon.sf.net/"
    exclude-result-prefixes="saxon" version="2.0">

    <xsl:output method="xml" indent="yes" encoding="ISO-8859-1" version="1.0"
        omit-xml-declaration="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:param name="senderId"/>
    <xsl:param name="channelId"/>
    <xsl:param name="applicationId"/>
    <xsl:param name="applicationUserId"/>
    <xsl:param name="sessionId"/>
    <xsl:param name="workflowId"/>
    <xsl:param name="activityId"/>
    <xsl:param name="timestamp"/>
    <xsl:param name="storeId"/>
    <xsl:param name="dealerCode"/>
    <xsl:param name="systemId"/>
    <xsl:param name="userId"/>
    <xsl:param name="masterDealerCode"/>
    <xsl:param name="interactionId"/>
    <xsl:param name="serviceTransactionId"/>
    <xsl:param name="scope"/>
    <xsl:param name="userCompanyId"/>
    <xsl:param name="customerCompanyId"/>
    <xsl:param name="servicePartnerId"/>
    <xsl:param name="transactionType"/>
    <xsl:param name="providerId"/>
    <xsl:param name="contextId"/>

    <xsl:param name="ABFEntitlements"/>

    <!-- <xsl:variable name="capientitlementprefix">v1</xsl:variable>
    <xsl:variable name="capientitlementns">http://services.tmobile.com/OrderManagement/CartWSIL/V1</xsl:variable>-->

    <xsl:variable name="capibaseprefix">base</xsl:variable>
    <xsl:variable name="capibase">http://services.tmobile.com/base</xsl:variable>


    <xsl:template match="/">
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
            <soapenv:Header/>
            <soapenv:Body>
                <v1:updateCartRequest version="1">
                    <xsl:attribute name="serviceTransactionId">
                        <xsl:value-of select="$serviceTransactionId"/>
                    </xsl:attribute>
                    <base:header>
                        <base:sender>
                            <xsl:if test="$senderId">
                                <base:senderId>
                                    <xsl:value-of select="$senderId"/>
                                </base:senderId>
                            </xsl:if>
                            <xsl:if test="$channelId">
                                <base:channelId>
                                    <xsl:value-of select="$channelId"/>
                                </base:channelId>
                            </xsl:if>
                            <xsl:if test="$applicationId">
                                <base:applicationId>
                                    <xsl:value-of select="$applicationId"/>
                                </base:applicationId>
                            </xsl:if>
                            <xsl:if test="$applicationUserId">
                                <base:applicationUserId>
                                    <xsl:value-of select="$applicationUserId"/>
                                </base:applicationUserId>
                            </xsl:if>
                            <xsl:if test="$sessionId">
                                <base:sessionId>
                                    <xsl:value-of select="$sessionId"/>
                                </base:sessionId>
                            </xsl:if>
                            <xsl:if test="$workflowId">
                                <base:workflowId>
                                    <xsl:value-of select="$workflowId"/>
                                </base:workflowId>
                            </xsl:if>
                            <xsl:if test="$activityId">
                                <base:activityId>
                                    <xsl:value-of select="$activityId"/>
                                </base:activityId>
                            </xsl:if>
                            <base:timestamp>
                                <xsl:value-of select="current-dateTime()"/>
                            </base:timestamp>
                            <xsl:if test="$storeId">
                                <base:storeId>
                                    <xsl:value-of select="$storeId"/>
                                </base:storeId>
                            </xsl:if>
                            <xsl:if test="$dealerCode">
                                <base:dealerCode>
                                    <xsl:value-of select="$dealerCode"/>
                                </base:dealerCode>
                            </xsl:if>
                            <xsl:if test="$scope">
                                <base:scope>
                                    <xsl:value-of select="$scope"/>
                                </base:scope>
                            </xsl:if>
                            <xsl:if test="$interactionId">
                                <base:interactionId>
                                    <xsl:value-of select="$interactionId"/>
                                </base:interactionId>
                            </xsl:if>
                            <xsl:if test="$masterDealerCode">
                                <base:masterDealerCode>
                                    <xsl:value-of select="$masterDealerCode"/>
                                </base:masterDealerCode>
                            </xsl:if>

                            <!--<xsl:if test="$ABFEntitlements">
                                <xsl:variable name="entitlementStr" select="replace(replace($ABFEntitlements,'TO_BE_REPLACED_PREFIX',$capientitlementprefix),'TO_BE_REPLACED_NAMESPACE',$capientitlementns)"></xsl:variable>
                                <xsl:copy-of select="saxon:parse($entitlementStr)/base:entitlements"/>
                            </xsl:if>-->

                            <xsl:if test="$ABFEntitlements">
                                <xsl:variable name="entitlementStr"
                                    select="replace(replace($ABFEntitlements, 'TO_BE_REPLACED_BASE_PREFIX', $capibaseprefix), 'TO_BE_REPLACED_BASE_NAMESPACE', $capibase)"/>
                                <xsl:copy-of select="saxon:parse($entitlementStr)"/>
                            </xsl:if>

                        </base:sender>

                        <xsl:if
                            test="$systemId or $userId or $userCompanyId or $customerCompanyId or $servicePartnerId or $transactionType">
                            <base:target>
                                <xsl:if test="$systemId or $userId">
                                    <base:targetSystemId>
                                        <xsl:if test="$systemId">
                                            <base:systemId>
                                                <xsl:value-of select="$systemId"/>
                                            </base:systemId>
                                        </xsl:if>
                                        <xsl:if test="$userId">
                                            <base:userId>
                                                <xsl:value-of select="$userId"/>
                                            </base:userId>
                                        </xsl:if>
                                    </base:targetSystemId>
                                </xsl:if>
                                <xsl:if test="$userCompanyId">
                                    <base:userCompanyId>
                                        <xsl:value-of select="$userCompanyId"/>
                                    </base:userCompanyId>
                                </xsl:if>
                                <xsl:if test="$customerCompanyId">
                                    <base:customerCompanyId>
                                        <xsl:value-of select="$customerCompanyId"/>
                                    </base:customerCompanyId>
                                </xsl:if>
                                <xsl:if test="$servicePartnerId">
                                    <base:servicePartnerId>
                                        <xsl:value-of select="$servicePartnerId"/>
                                    </base:servicePartnerId>
                                </xsl:if>
                                <xsl:if test="$transactionType">
                                    <base:transactionType>
                                        <xsl:value-of select="$transactionType"/>
                                    </base:transactionType>
                                </xsl:if>
                            </base:target>
                        </xsl:if>

                        <xsl:if test="$providerId or $contextId">
                            <base:providerId>
                                <xsl:if test="$providerId">
                                    <base:id>
                                        <xsl:value-of select="$providerId"/>
                                    </base:id>
                                </xsl:if>
                                <xsl:if test="$contextId">
                                    <base:contextId>
                                        <xsl:value-of select="$contextId"/>
                                    </base:contextId>
                                </xsl:if>
                            </base:providerId>
                        </xsl:if>
                    </base:header>
                    <xsl:apply-templates select="cart"/>
                </v1:updateCartRequest>
            </soapenv:Body>
        </soapenv:Envelope>
    </xsl:template>

    <xsl:template match="cart">
        <xsl:element name="v1:{local-name()}">
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
            <xsl:apply-templates select="cartItem"/>
            <xsl:apply-templates select="addressList"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="cartItem">
        <xsl:if test="current() != '' or @actionCode != ''">
            <xsl:element name="v1:{local-name()} ">
                <xsl:if test="@actionCode">
                    <xsl:attribute name="actionCode">
                        <xsl:value-of select="@actionCode"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="lineOfService"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="lineOfService">
        <xsl:if test="current() != '' or @actionCode != '' or @lineOfServiceId != ''">
            <xsl:element name="v1:{local-name()} ">
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
                <xsl:apply-templates select="financialAccountNumber"/>
                <xsl:apply-templates select="subscriberContact"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="subscriberContact">
        <xsl:if test="current() != ''">
            <xsl:element name="v1:{local-name()} ">
                <xsl:apply-templates select="addressCommunication"
                    mode="subscriberContact_addressCommunication"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="addressCommunication" mode="subscriberContact_addressCommunication">
        <xsl:if
            test="(normalize-space(.) != '' or count(.//@*) != 0) and lower-case(normalize-space((uiAddedIndicator))) = 'true'">
            <xsl:element name="v1:{local-name()}">
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
                <xsl:apply-templates select="privacyProfile"/>
                <xsl:apply-templates select="address" mode="addressCommunication_address"/>
                <xsl:apply-templates select="usageContext"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="addressCommunication">
        <xsl:if test="current() != '' or @id != ''">
            <xsl:element name="v1:{local-name()}">
                <xsl:if test="@id">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="address"/>
                <xsl:apply-templates select="usageContext"/>
                <xsl:apply-templates select="communicationStatus"/>
                <xsl:apply-templates select="specialInstruction"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="address" mode="addressCommunication_address">
        <xsl:element name="v1:{local-name()} ">
            <xsl:apply-templates select="key" mode="addressCommunication_key"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="key" mode="addressCommunication_key">
        <xsl:if test="current() != '' or count(@*) > 0">
            <xsl:element name="v1:{local-name()} ">
                <xsl:if test="@domainName">
                    <xsl:attribute name="domainName">
                        <xsl:value-of select="@domainName"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="keyName"/>
                <xsl:apply-templates select="keyValue"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="privacyProfile">
        <xsl:if test="current() != ''">
            <xsl:element name="v1:{local-name()} ">
                <xsl:apply-templates select="optOut"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="communicationStatus">
        <xsl:if test="current() != ''">
            <xsl:element name="v1:{local-name()} ">
                <xsl:if test="@statusCode">
                    <xsl:attribute name="statusCode">
                        <xsl:value-of select="@statusCode"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@subStatusCode">
                    <xsl:attribute name="subStatusCode">
                        <xsl:value-of select="@subStatusCode"/>
                    </xsl:attribute>
                </xsl:if>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="addressList">
        <xsl:if test="current() != ''">
            <xsl:element name="v1:{local-name()} ">
                <xsl:apply-templates select="addressCommunication"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="key">
        <xsl:if test="current() != '' or count(@*) > 0">
            <xsl:element name="v1:{local-name()} ">
                <xsl:if test="@domainName">
                    <xsl:attribute name="domainName">
                        <xsl:value-of select="@domainName"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="keyName"/>
                <xsl:apply-templates select="keyValue"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="address">
        <xsl:if test="current() != ''">
            <xsl:element name="v1:{local-name()} ">
                <xsl:apply-templates select="addressFormatType"/>
                <xsl:apply-templates select="addressLine1"/>
                <xsl:apply-templates select="addressLine2"/>
                <xsl:apply-templates select="addressLine3"/>
                <xsl:apply-templates select="cityName"/>
                <xsl:apply-templates select="stateName"/>
                <xsl:apply-templates select="stateCode"/>
                <xsl:apply-templates select="countyName"/>
                <xsl:apply-templates select="countryCode"/>
                <xsl:apply-templates select="attentionOf"/>
                <xsl:apply-templates select="careOf"/>
                <xsl:apply-templates select="postalCode"/>
                <xsl:apply-templates select="postalCodeExtension"/>
                <xsl:apply-templates select="geoCodeID"/>
                <xsl:apply-templates select="uncertaintyIndicator"/>
                <xsl:apply-templates select="inCityLimitIndicator"/>
                <xsl:apply-templates select="geographicCoordinates"/>
                <xsl:apply-templates select="key"/>
                <xsl:apply-templates select="residentialIndicator"/>
                <xsl:apply-templates select="timeZone"/>
                <xsl:apply-templates select="houseNumber"/>
                <xsl:apply-templates select="streetName"/>
                <xsl:apply-templates select="streetSuffix"/>
                <xsl:apply-templates select="trailingDirection"/>
                <xsl:apply-templates select="unitType"/>
                <xsl:apply-templates select="unitNumber"/>
                <xsl:apply-templates select="streetDirection"/>
                <xsl:apply-templates select="urbanization"/>
                <xsl:apply-templates select="deliveryPointCode"/>
                <xsl:apply-templates select="confidenceLevel"/>
                <xsl:apply-templates select="carrierRoute"/>
                <xsl:apply-templates select="overrideIndicator"/>
                <xsl:apply-templates select="observesDaylightSavingsIndicator"/>
                <xsl:apply-templates select="matchIndicator"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="geographicCoordinates">
        <xsl:if test="current() != ''">
            <xsl:element name="v1:{local-name()} ">
                <xsl:apply-templates select="latitude"/>
                <xsl:apply-templates select="longitude"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="geoCodeID">
        <xsl:if test="current() != '' or count(@*) > 0">
            <xsl:element name="v1:{local-name()} ">
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
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="@* | node()">
        <xsl:choose>
            <xsl:when test=". instance of element()">
                <xsl:if test="current() != '' or count(@*) > 0">
                    <xsl:element name="{concat('v1:',local-name())}">
                        <xsl:apply-templates select="@* | node()"/>
                    </xsl:element>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@* | node()"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
