<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:v1="http://services.tmobile.com/OrderManagement/CartWSIL/V1"
    xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:base="http://services.tmobile.com/base"
    version="2.0" exclude-result-prefixes="v1 base xs soapenv">
   
     <xsl:param name="cartItemId"/>
   
    <xsl:output method="xml" indent="no" encoding="UTF-8" version="1.0" omit-xml-declaration="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/">
        <xsl:variable name="varResponse" select="soapenv:Envelope/soapenv:Body/v1:getCartDetailsResponse"/>
        <xsl:apply-templates select="$varResponse/v1:cart"/>       
    </xsl:template>


    <xsl:template match="v1:cart">
        <xsl:if test="normalize-space(.) != ''">
            <cart>
                <xsl:choose>
                    <xsl:when
                        test="normalize-space($cartItemId) = 'list' or string-length(normalize-space($cartItemId)) = 0">
                        <xsl:apply-templates select="v1:cartItem"/>
                        <xsl:apply-templates select="v1:addressList"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:variable name="cartItemList" select="tokenize($cartItemId, '\,')"/>
                        <xsl:for-each select="$cartItemList">
                            <xsl:apply-templates select="v1:cartItem[@cartItemId = $cartItemList]"/>
                            <xsl:apply-templates select="v1:addressList"/>
                        </xsl:for-each>
                    </xsl:otherwise>
                </xsl:choose>
            </cart>
        </xsl:if>
    </xsl:template>


    <xsl:template
        match="v1:description | v1:simType | v1:specialInstruction | v1:shortDescription | v1:alternateDescription | v1:productType | v1:productSubType | v1:personName | v1:displayPurpose | v1:virtualSim | v1:relatedCartItemId">
        <xsl:if test="normalize-space(.) != ''">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="@* | node()"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:specificationValue">
        <xsl:if test="normalize-space(.) != '' or @name">
            <specificationValue>
                <xsl:if test="@name!=''">
                    <xsl:attribute name="name">
                        <xsl:value-of select="@name"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="."/>
            </specificationValue>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:shortDescription">
        <xsl:if test="normalize-space(.) != '' or @languageCode">
            <shortDescription>
                <xsl:if test="@languageCode!=''">
                    <xsl:attribute name="languageCode">
                        <xsl:value-of select="@languageCode"/>
                    </xsl:attribute>
                </xsl:if>
               </shortDescription>
        </xsl:if>
    </xsl:template>

    
    <xsl:template match="v1:cartItem">
        <xsl:if test="normalize-space(.) != '' or @cartItemId or @actionCode">
            <cartItem>
                <xsl:if test="@cartItemId!=''">
                    <xsl:attribute name="cartItemId">
                        <xsl:value-of select="@cartItemId"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@actionCode!=''">
                    <xsl:attribute name="actionCode">
                        <xsl:value-of select="@actionCode"/>
                    </xsl:attribute>
                </xsl:if>
                <!--<xsl:apply-templates select="@*" />-->
                <xsl:if test="normalize-space(v1:overridePriceAllowedIndicator) != ''">
                    <overridePriceAllowedIndicator>
                        <xsl:value-of select="v1:overridePriceAllowedIndicator"/>
                    </overridePriceAllowedIndicator>
                </xsl:if>
                <xsl:apply-templates select="v1:quantity"/>
                <!--<xsl:apply-templates select="v1:currencyCode" />-->
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
                <xsl:apply-templates select="v1:assignedProduct" mode="assignedProduct-cartItem"/>
                <xsl:apply-templates select="v1:cartSchedule"/>
                <xsl:apply-templates select="v1:specificationGroup"/>
                <xsl:apply-templates select="v1:promotion" mode="cartItem-promotion"/>
                <xsl:apply-templates select="v1:relatedCartItemId"/>
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
                <xsl:apply-templates select="v1:financialAccount"/>
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
        </xsl:if>
    </xsl:template>

    <!-- Duplicate template -->
    <!--xsl:template match="v1:effectivePeriod" mode="cartItem-effectivePeriod">
        <xsl:if test="normalize-space(.) != ''">
            <effectivePeriod>
                <xsl:apply-templates select="v1:startTime"/>
                <xsl:apply-templates select="v1:endTime"/>
                <xsl:apply-templates select="v1:usageContext"/>
            </effectivePeriod>
        </xsl:if>
    </xsl:template-->

    <xsl:template match="v1:port">
        <xsl:if test="normalize-space(.) != '' or @actionCode">
            <port>
                <xsl:if test="@actionCode!=''">
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
                <xsl:apply-templates select="v1:personProfile"
                    mode="personProfile-addressCommunication"/>
            </port>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:personProfile" mode="personProfile-addressCommunication">
        <xsl:if test="normalize-space(.) != ''">
            <personProfile>
                <xsl:apply-templates select="v1:addressCommunication"
                    mode="personProfile-addressCommunication"/>
            </personProfile>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:addressCommunication" mode="personProfile-addressCommunication">
        <xsl:if test="normalize-space(.) != ''">
            <addressCommunication>
                <xsl:apply-templates select="v1:address" mode="personProfile-addressCommunication"/>
            </addressCommunication>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:deviceConditionQuestions">
        <xsl:if test="normalize-space(.) != ''">
            <deviceConditionQuestions>
                <xsl:apply-templates select="v1:verificationQuestion"/>
            </deviceConditionQuestions>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:address" mode="personProfile-addressCommunication">
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

    <xsl:template match="v1:verificationQuestion">
        <xsl:if test="normalize-space(.) != ''">
            <verificationQuestion>
                <xsl:if test="normalize-space(v1:questionText)!=''">
                    <questionText>
                        <xsl:value-of select="v1:questionText"/>
                    </questionText>
                </xsl:if>
                <xsl:apply-templates select="v1:verificationAnswer"/>
            </verificationQuestion>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:verificationAnswer">
        <xsl:if test="normalize-space(.) != ''">
            <verificationAnswer>
                <xsl:if test="normalize-space(v1:answerText)!=''">
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

                <xsl:if test="@statusCode!=''">
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
            </estimatedAvailable>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:promotion" mode="cartItem-promotion">
        <xsl:if test="normalize-space(.) != '' or @actionCode or @promotionId">
            <promotion>
                <xsl:if test="@actionCode !=''">
                    <xsl:attribute name="actionCode">
                        <xsl:value-of select="@actionCode"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@promotionId !=''">
                    <xsl:attribute name="promotionId">
                        <xsl:value-of select="@promotionId"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="normalize-space(v1:promotionName)!=''">
                    <promotionName>
                        <xsl:value-of select="v1:promotionName"/>
                    </promotionName>
                </xsl:if>
                <xsl:if test="normalize-space(v1:promotionCode)!=''">
                    <promotionCode>
                        <xsl:value-of select="v1:promotionCode"/>
                    </promotionCode>
                </xsl:if>
            </promotion>
        </xsl:if>
    </xsl:template>
   
    <xsl:template match="v1:effectivePeriod" mode="cartItem-effectivePeriod">
        <xsl:if test="normalize-space(.) != ''">
            <effectivePeriod>
                <xsl:if test="normalize-space(v1:startTime)!=''">
                    <startTime>
                        <xsl:value-of select="v1:startTime"/>
                    </startTime>
                </xsl:if>
            </effectivePeriod>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:effectivePeriod" mode="effectivePeriod-assignedProduct">
        <xsl:if test="normalize-space(.) != ''">
            <effectivePeriod>
                <xsl:if test="normalize-space(v1:startTime)!=''">
                    <startTime>
                        <xsl:value-of select="v1:startTime"/>
                    </startTime>
                </xsl:if>
                <xsl:if test="normalize-space(v1:endTime)!=''">
                    <endTime>
                        <xsl:value-of select="v1:endTime"/>
                    </endTime>
                </xsl:if>
                <xsl:if test="normalize-space(v1:usageContext)!=''">
                    <usageContext>
                        <xsl:value-of select="v1:usageContext"/>
                    </usageContext>
                </xsl:if>
            </effectivePeriod>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:effectivePeriod" mode="lineOfService-effectivePeriod">
        <xsl:if test="normalize-space(.) != ''">
            <effectivePeriod>
                <xsl:if test="normalize-space(v1:startTime)!=''">
                    <startTime>
                        <xsl:value-of select="v1:startTime"/>
                    </startTime>
                </xsl:if>
                <xsl:if test="normalize-space(v1:endTime)!=''">
                    <endTime>
                        <xsl:value-of select="v1:endTime"/>
                    </endTime>
                </xsl:if>
            </effectivePeriod>
        </xsl:if>
    </xsl:template>

    <!--  <xsl:template match="v1:quantity">
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

    <xsl:template match="v1:amount | v1:basisAmount | v1:totalAmount">
        <xsl:if test="normalize-space(.) != '' or @currencyCode">
            <xsl:element name="{local-name()}">
                <xsl:attribute name="currencyCode">
                    <xsl:value-of select="if (@currencyCode != '')
                        then  @currencyCode else 'USD'"/>
                </xsl:attribute>
                <xsl:value-of select="."/>               
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:cartItemStatus">
        <xsl:if test="normalize-space(.) != ''">
            <cartItemStatus>
                <xsl:if test="@statusCode">
                    <xsl:attribute name="statusCode">
                        <xsl:value-of select="@statusCode"/>
                    </xsl:attribute>
                </xsl:if>                
                <xsl:apply-templates select="v1:description" mode="description-cartItemStatus"/>
            </cartItemStatus>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:description" mode="description-cartItemStatus">
        <xsl:if test="normalize-space(.) != '' or @usageContext">
            <description>
                <xsl:if test="@usageContext!=''">
                    <xsl:attribute name="usageContext">
                        <xsl:value-of select="@usageContext"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="."/>
            </description>
        </xsl:if>
    </xsl:template>



    <xsl:template match="v1:effectivePeriod | v1:promotionEffectivePeriod">
        <xsl:if test="normalize-space(.) != ''">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:startTime"/>
                <xsl:apply-templates select="v1:endTime"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>


    <xsl:template match="v1:productOffering" mode="cartScheduleCharge-productOffering">
        <xsl:if test="normalize-space(.) != '' or @productOfferingId">
            <productOffering>

                <!-- <xsl:apply-templates select="@*"/>-->

                <xsl:if test="@productOfferingId!=''">
                    <xsl:attribute name="productOfferingId">
                        <xsl:value-of select="@productOfferingId"/>
                    </xsl:attribute>
                </xsl:if>

            </productOffering>
        </xsl:if>
    </xsl:template>



    <xsl:template match="v1:productOffering">
        <xsl:if test="normalize-space(.) != '' or @productOfferingId">
            <productOffering>
                <!-- <xsl:apply-templates select="@*"/>-->
                <xsl:if test="@productOfferingId!=''">
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
                <xsl:apply-templates select="v1:description" mode="description-productOffering"/>
                <xsl:apply-templates select="v1:shortDescription"
                    mode="shortDescription-productOffering"/>
                
                <xsl:apply-templates select="v1:longDescription" mode="productOffering"/>
                <xsl:apply-templates select="v1:alternateDescription" mode="productOffering"/>
                <xsl:apply-templates select="v1:keyword" mode="productOffering-keyword"/>
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
                <!--xsl:apply-templates select="v1:offeringStatus"/-->
                <xsl:apply-templates select="v1:offeringClassification"/>
                <xsl:if test="normalize-space(v1:businessUnit) != ''">
                    <businessUnit>
                        <xsl:value-of select="v1:businessUnit"/>
                    </businessUnit>
                </xsl:if>
                <xsl:apply-templates select="v1:productType"/>
                <xsl:apply-templates select="v1:productSubType"/>
                <xsl:apply-templates select="v1:key" mode="key-productOffering"/>
                <xsl:apply-templates select="v1:specificationGroup"/>
                <xsl:apply-templates select="v1:offeringPrice"/>
                <xsl:apply-templates select="v1:orderBehavior" mode="productOffering-orderBehavior"/>
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
                <!-- default value -->
                <xsl:if test="@offeringComponentId!=''">
                    <xsl:attribute name="offeringComponentId">
                        <xsl:value-of select="@offeringComponentId"/>
                    </xsl:attribute>
                </xsl:if>
            </productOfferingComponent>
        </xsl:if>
    </xsl:template>



    <xsl:template match="v1:serviceCharacteristics">
        <xsl:if test="normalize-space(.) != ''">
            <serviceCharacteristics>
                <!-- default value -->
                <xsl:apply-templates select="v1:backDateAllowedIndicator"/>
                <xsl:apply-templates select="v1:futureDateAllowedIndicator"/>
                <xsl:apply-templates select="v1:backDateVisibleIndicator"/>
                <xsl:apply-templates select="v1:futureDateVisibleIndicator"/>
                <xsl:apply-templates select="v1:includedServiceCapacity" mode="serviceCharacteristics"/>
                <xsl:apply-templates select="v1:billEffectiveCode"/>
                <xsl:apply-templates select="v1:billableThirdPartyServiceIndicator"/>
                <xsl:apply-templates select="v1:prorateAllowedIndicator"/>
                <xsl:apply-templates select="v1:prorateVisibleIndicator"/>
                <xsl:apply-templates select="v1:duration"/>
            </serviceCharacteristics>
        </xsl:if>
    </xsl:template>



    <xsl:template match="v1:prorateVisibleIndicator">
        <xsl:if test="normalize-space(.) != ''">
            <prorateVisibleIndicator>
                <xsl:apply-templates select="@name|node()"/>
            </prorateVisibleIndicator>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:prorateAllowedIndicator">
        <xsl:if test="normalize-space(.) != ''">
            <prorateAllowedIndicator>
                <xsl:apply-templates select="@name|node()"/>
            </prorateAllowedIndicator>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:billableThirdPartyServiceIndicator">
        <xsl:if test="normalize-space(.) != ''">
            <billableThirdPartyServiceIndicator>
                <xsl:apply-templates select="@name|node()"/>
            </billableThirdPartyServiceIndicator>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:includedServiceCapacity" mode="serviceCharacteristics">
        <xsl:if test="normalize-space(.) != ''">
            <includedServiceCapacity>
                <xsl:apply-templates select="v1:capacityType"/>
                <xsl:apply-templates select="v1:capacitySubType"/>
                <xsl:apply-templates select="v1:unlimitedIndicator"/>
                <xsl:apply-templates select="v1:size"/>
                <xsl:apply-templates select="v1:measurementUnit"/>
            </includedServiceCapacity>
        </xsl:if>
    </xsl:template>

    <!--  <xsl:template match="v1:measurementUnit">
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

    <xsl:template match="v1:unlimitedIndicator">
        <xsl:if test="normalize-space(.) != ''">
            <unlimitedIndicator>
                <xsl:apply-templates select="@name|node()"/>
            </unlimitedIndicator>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:includedServiceCapacity">
        <xsl:if test="normalize-space(.) != ''">
            <includedServiceCapacity>
                <xsl:apply-templates select="node()"/>
            </includedServiceCapacity>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:backDateAllowedIndicator">
        <xsl:if test="normalize-space(.) != ''">
            <backDateAllowedIndicator>
                <xsl:apply-templates select="@name|node()"/>
            </backDateAllowedIndicator>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:futureDateAllowedIndicator">
        <xsl:if test="normalize-space(.) != ''">
            <futureDateAllowedIndicator>
                <xsl:apply-templates select="@name|node()"/>
            </futureDateAllowedIndicator>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:futureDateVisibleIndicator">
        <xsl:if test="normalize-space(.) != ''">
            <futureDateVisibleIndicator>
                <xsl:apply-templates select="@name|node()"/>
            </futureDateVisibleIndicator>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:backDateVisibleIndicator">
        <xsl:if test="normalize-space(.) != ''">
            <backDateVisibleIndicator>
                <xsl:apply-templates select="@name|node()"/>
            </backDateVisibleIndicator>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:equipmentCharacteristics">
        <xsl:if test="normalize-space(.) != ''">
            <equipmentCharacteristics>
                <xsl:apply-templates select="v1:model"/>
                <xsl:apply-templates select="v1:manufacturer"/>
                <xsl:apply-templates select="v1:color"/>
                <xsl:apply-templates select="v1:memory"/>
                <xsl:apply-templates select="v1:tacCode"/>
            </equipmentCharacteristics>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:tacCode">
        <xsl:if test="normalize-space(.) != ''">
            <tacCode>
                <xsl:apply-templates select="node()"/>
            </tacCode>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:marketingMessage">
        <xsl:if test="normalize-space(.) != ''">
            <marketingMessage>
                <xsl:apply-templates select="v1:salesChannelCode"/>
                <xsl:apply-templates select="v1:relativeSize"/>
                <xsl:apply-templates select="v1:messagePart"/>
            </marketingMessage>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:messagePart">
        <xsl:if test="normalize-space(.) != ''">
            <messagePart>
                <xsl:apply-templates select="v1:code"/>
                <xsl:apply-templates select="v1:messageText"/>
                <xsl:apply-templates select="v1:messageSequence"/>
            </messagePart>
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
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:keyword">
        <xsl:if test="normalize-space(.) != '' or @name">
            <keyword>
                <xsl:if test="normalize-space(.) != '' or @name">
                    <xsl:attribute name="name">
                        <xsl:value-of select="@name"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="."/>
            </keyword>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:description | v1:messageText">
        <xsl:if test="normalize-space(.) != '' or @languageCode or @usageContext">
            <xsl:element name="{local-name()}">
                <xsl:if test="@languageCode!=''">
                    <xsl:attribute name="languageCode">
                        <xsl:value-of select="@languageCode"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@usageContext!=''">
                    <xsl:attribute name="usageContext">
                        <xsl:value-of select="@usageContext"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:description" mode="description-productOffering">
        <xsl:if
            test="normalize-space(.) != '' or @salesChannelCode or @usageContext or @languageCode">
            <description>
                <xsl:if test="@salesChannelCode!=''">
                    <xsl:attribute name="salesChannelCode">
                        <xsl:value-of select="@salesChannelCode"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@usageContext!=''">
                    <xsl:attribute name="usageContext">
                        <xsl:value-of select="@usageContext"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@languageCode!=''">
                    <xsl:attribute name="languageCode">
                        <xsl:value-of select="@languageCode"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="."/>
            </description>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:shortdescription">
        <xsl:if test="normalize-space(.) != '' or @languageCode">
            <shortdescription>
                <xsl:if test="@languageCode!=''">
                    <xsl:attribute name="languageCode">
                        <xsl:value-of select="@languageCode"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="."/>
            </shortdescription>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:shortDescription" mode="shortDescription-productOffering">
        <xsl:if
            test="normalize-space(.) != '' or @salesChannelCode or @usageContext or @languageCode">
            <shortDescription>
                <xsl:if test="@salesChannelCode!=''">
                    <xsl:attribute name="salesChannelCode">
                        <xsl:value-of select="@salesChannelCode"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@usageContext!=''">
                    <xsl:attribute name="usageContext">
                        <xsl:value-of select="@usageContext"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@languageCode!=''">
                    <xsl:attribute name="languageCode">
                        <xsl:value-of select="@languageCode"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="."/>
            </shortDescription>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:longDescription | v1:alternateDescription" mode="productOffering">
        <xsl:if test="normalize-space(.) != ''">
            <xsl:element name="{local-name()}">
                <xsl:if test="normalize-space(v1:descriptionCode) != ''">
                    <descriptionCode>
                        <xsl:value-of select="v1:descriptionCode"/>
                    </descriptionCode>
                </xsl:if>
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
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:offeringStatus">
        <xsl:if test="normalize-space(.) != '' or @statusCode">
            <offeringStatus>
                <!-- <xsl:apply-templates select="@*"/>-->
                <xsl:if test="@statusCode!=''">
                    <xsl:attribute name="statusCode">
                        <xsl:value-of select="@statusCode"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="v1:effectivePeriod"/>
            </offeringStatus>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:specificationGroup">
        <xsl:if test="normalize-space(.) != '' or @name">
            <specificationGroup>
                <xsl:if test="@name!=''">
                    <xsl:attribute name="name">
                        <xsl:value-of select="@name"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="v1:specificationValue"/>
            </specificationGroup>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:specificationGroup" mode="lineOfService-specificationGroup">
        <xsl:if test="normalize-space(.) != ''">
            <specificationGroup>
                <xsl:apply-templates select="v1:specificationValue" mode="lineOfService-specificationGroup"/>
            </specificationGroup>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:specificationValue" mode="lineOfService-specificationGroup">
        <xsl:if test="normalize-space(.) != '' or @name">
            <specificationValue>
                <xsl:if test="@name!=''">
                    <xsl:attribute name="name">
                        <xsl:value-of select="@name"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="."/>
            </specificationValue>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:offeringPrice">
        <xsl:if test="normalize-space(.) != '' or @priceListLineId">
            <offeringPrice>
               <xsl:if test="@priceListLineId!=''">
                    <xsl:attribute name="priceListLineId">
                        <xsl:value-of select="@priceListLineId"/>
                    </xsl:attribute>
                </xsl:if>

                <xsl:apply-templates select="v1:name"/>
                <xsl:apply-templates select="v1:productOfferingPrice"/>
            </offeringPrice>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:productOfferingPrice">
        <xsl:if test="normalize-space(.) != ''">
            <productOfferingPrice>
                <xsl:apply-templates select="v1:name"/>
                <xsl:apply-templates select="v1:productChargeType"/>
                <xsl:apply-templates select="v1:productChargeIncurredType"/>
                <xsl:apply-templates select="v1:basisAmount"/>
                <xsl:apply-templates select="v1:amount"/>
                <xsl:apply-templates select="v1:oneTimeCharge"/>
                <xsl:apply-templates select="v1:recurringFeeFrequency"/>
                <xsl:apply-templates select="v1:taxInclusiveIndicator"/>
                <xsl:apply-templates select="v1:specificationValue"/>
            </productOfferingPrice>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:orderBehavior">
        <xsl:if test="normalize-space(.) != ''">
            <orderBehavior>
                <xsl:apply-templates select="v1:preOrderAllowedIndicator"/>
                <xsl:apply-templates select="v1:preOrderAvailableTime"/>
                <xsl:apply-templates select="v1:saleStartTime"/>
                <xsl:apply-templates select="v1:saleEndTime"/>
            </orderBehavior>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:preOrderAvailableTime" mode="orderBehavior-preOrderAvailableTime">
        <xsl:if test="normalize-space(.) != '' or @name">
            <preOrderAvailableTime>
                <xsl:if test="@name!=''">
                    <xsl:attribute name="name">
                        <xsl:value-of select="@name"/>
                    </xsl:attribute>
                </xsl:if>
            </preOrderAvailableTime>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:preOrderAllowedIndicator">
        <xsl:if test="normalize-space(.) != '' or @name">
            <preOrderAllowedIndicator>
                <xsl:if test="@name!=''">
                    <xsl:attribute name="name">
                        <xsl:value-of select="@name"/>
                    </xsl:attribute>
                </xsl:if>
            </preOrderAllowedIndicator>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:image">
        <xsl:if test="normalize-space(.) != ''">
            <image>
                <xsl:apply-templates select="v1:URI"/>
                <xsl:apply-templates select="v1:sku" mode="image-sku"/>
                <xsl:apply-templates select="v1:imageDimensions"/>
                <xsl:apply-templates select="v1:displayPurpose"/>
            </image>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:sku" mode="image-sku">
        <xsl:if test="normalize-space(.) != ''">
            <sku>
                <xsl:value-of select="."/>
            </sku>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:offeringVariant">
        <xsl:if test="normalize-space(.) != ''">
            <offeringVariant>
                <xsl:apply-templates select="v1:sku" mode="sku-offeringVariant"/>
                <xsl:apply-templates select="v1:specificationGroup"/>
                <xsl:apply-templates select="v1:offeringVariantPrice"/>
                <xsl:apply-templates select="v1:productCondition"/>
                <xsl:apply-templates select="v1:color"/>
                <xsl:apply-templates select="v1:memory"/>
                <xsl:apply-templates select="v1:tacCode"/>
                <xsl:apply-templates select="v1:orderBehavior" mode="orderBehavior-offeringVariant"/>

            </offeringVariant>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:orderBehavior" mode="orderBehavior-offeringVariant">
        <xsl:if test="normalize-space(.) != ''">
            <orderBehavior>
                <xsl:apply-templates select="v1:preOrderAllowedIndicator"/>
                <xsl:apply-templates select="v1:preOrderAvailableTime"/>
            </orderBehavior>
        </xsl:if>
    </xsl:template>
    <xsl:template match="v1:orderBehavior" mode="productOffering-orderBehavior">
        <xsl:if test="normalize-space(.) != ''">
            <orderBehavior>
                <xsl:apply-templates select="v1:preOrderAllowedIndicator"/>
                <xsl:apply-templates select="v1:preOrderAvailableTime"/>
            </orderBehavior>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:sku" mode="sku-offeringVariant">
        <xsl:if test="normalize-space(.) != ''">
            <sku>
                <xsl:value-of select="."/>
            </sku>
        </xsl:if>
    </xsl:template>


    <xsl:template match="v1:offeringVariantPrice">
        <xsl:if test="normalize-space(.) != '' or @priceListLineId">
            <offeringVariantPrice>
                <xsl:if test="@priceListLineId!=''">
                    <xsl:attribute name="priceListLineId">
                        <xsl:value-of select="@priceListLineId"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="v1:name"/>
            </offeringVariantPrice>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:productSpecification">
        <xsl:if test="normalize-space(.) != '' or @actionCode or @productSpecificationId">
            <productSpecification>

                <xsl:if test="@actionCode!=''">
                    <xsl:attribute name="actionCode">
                        <xsl:value-of select="@actionCode"/>
                    </xsl:attribute>
                </xsl:if>

                <xsl:if test="@productSpecificationId!=''">
                    <xsl:attribute name="productSpecificationId">
                        <xsl:value-of select="@productSpecificationId"/>
                    </xsl:attribute>
                </xsl:if>

                <xsl:apply-templates select="v1:name"/>
                <xsl:apply-templates select="v1:keyword" mode="ps"/>
                <xsl:apply-templates select="v1:productType" mode="ps"/>
                <xsl:apply-templates select="v1:productSubType" mode="ps"/>
                <xsl:apply-templates select="v1:additionalSpecification"/>
               
                <xsl:apply-templates select="v1:sku" mode="ps"/>
            </productSpecification>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:additionalSpecification">
        <xsl:if test="normalize-space(.) != ''">
            <additionalSpecification>
                <xsl:apply-templates select="v1:specificationValue"/>
            </additionalSpecification>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:keyword" mode="ps">
        <xsl:if test="normalize-space(.) != '' or @name">
            <keyword>
                <xsl:if test="@name!= ''">
                    <xsl:attribute name="name">
                        <xsl:value-of select="@name"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="."/>
            </keyword>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:keyword" mode="productOffering-keyword">
        <xsl:if test="normalize-space(.) != '' or @name">
            <keyword>
                <xsl:if test="@name!=''">
                    <xsl:attribute name="name">
                        <xsl:value-of select="@name"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="."/>
            </keyword>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:productType" mode="ps">
        <xsl:if test="normalize-space(.) != ''">
            <productType>
                <xsl:apply-templates select="node()"/>
            </productType>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:productSubType" mode="ps">
        <xsl:if test="normalize-space(.) != ''">
            <productSubType>
                <xsl:apply-templates select="node()"/>
            </productSubType>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:sku" mode="ps">
        <xsl:if test="normalize-space(.) != ''">
            <sku>
                <xsl:apply-templates select="node()"/>
            </sku>
        </xsl:if>
    </xsl:template>


    <xsl:template match="v1:cartSchedule">
        <xsl:if test="normalize-space(.) != '' or @cartScheduleId">
            <cartSchedule>
                <xsl:if test="@cartScheduleId!=''">
                    <xsl:attribute name="cartScheduleId">
                        <xsl:value-of select="@cartScheduleId"/>
                    </xsl:attribute>
                </xsl:if>              
                <xsl:if test="v1:description">
                    <description>
                        <xsl:value-of select="v1:description"/>
                    </description>
                </xsl:if>
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
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:cartScheduleTax">
        <xsl:if test="normalize-space(.) != '' or @id">
            <cartScheduleTax>
                <xsl:if test="@id!=''">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                </xsl:if>

                <xsl:apply-templates select="v1:code"/>
                <xsl:apply-templates select="v1:taxJurisdiction"/>
                <xsl:apply-templates select="v1:amount"/>
                <xsl:apply-templates select="v1:typeCode"/>
                <xsl:apply-templates select="v1:description" mode="cartScheduleTax-description"/>
                <xsl:apply-templates select="v1:taxRate" mode="cartScheduleTax-taxRate"/>
            </cartScheduleTax>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:description" mode="cartScheduleTax-description">
        <xsl:if test="normalize-space(.) != ''">
            <description>
                <xsl:value-of select="."/>
            </description>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:taxRate" mode="cartScheduleTax-taxRate">
        <xsl:if test="normalize-space(.) != ''">
            <taxRate>
                <xsl:value-of select="."/>
            </taxRate>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:cartScheduleDeduction">
        <xsl:if test="normalize-space(.) != '' or @actionCode or @deductionId">
            <cartScheduleDeduction>
                <xsl:if test="@actionCode!= ''">
                    <xsl:attribute name="actionCode">
                        <xsl:value-of select="@actionCode"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@deductionId!= ''">
                    <xsl:attribute name="deductionId">
                        <xsl:value-of select="@deductionId"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="v1:amount"/>
                <xsl:apply-templates select="v1:reason"/>
                <xsl:apply-templates select="v1:effectivePeriod"
                    mode="effectivePeriod-cartScheduleDeduction"/>
                <xsl:apply-templates select="v1:proratedIndicator"/>
                <xsl:if test="normalize-space(v1:description) != ''">
                    <description>
                        <xsl:value-of select="v1:description"/>
                    </description>
                </xsl:if>  
                <xsl:apply-templates select="v1:recurringFrequency"/>
                <xsl:apply-templates select="v1:promotion" mode="cartScheduleDeduction-promotion"/>
                <xsl:apply-templates select="v1:chargeCode"/>
                <xsl:apply-templates select="v1:productOfferingPriceId"/>
                <xsl:apply-templates select="v1:specificationValue"/>
                <xsl:apply-templates select="v1:realizationMethod"/>
                

            </cartScheduleDeduction>

        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:effectivePeriod" mode="effectivePeriod-cartScheduleDeduction">
        <xsl:if test="normalize-space(.) != ''">
            <effectivePeriod>
                <xsl:apply-templates select="v1:startTime"/>
                <xsl:apply-templates select="v1:endTime"/>
            </effectivePeriod>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:promotion" mode="cartScheduleDeduction-promotion">
        <xsl:if test="normalize-space(.) != '' or @promotionId">
            <promotion>
                <xsl:if test="@promotionId!=''">
                    <xsl:attribute name="promotionId">
                        <xsl:value-of select="@promotionId"/>
                    </xsl:attribute>
                </xsl:if>
            </promotion>
        </xsl:if>
    </xsl:template>


    <xsl:template match="v1:cartScheduleStatus">
        <xsl:if test="normalize-space(.) != '' or @statusCode">
            <cartScheduleStatus>
                <xsl:if test="@statusCode!=''">
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

                <xsl:if test="@actionCode!=''">
                    <xsl:attribute name="actionCode">
                        <xsl:value-of select="@actionCode"/>
                    </xsl:attribute>
                </xsl:if>
            

                <xsl:apply-templates select="v1:typeCode"/>
                <xsl:apply-templates select="v1:chargeFrequencyCode"/>
                <xsl:apply-templates select="v1:basisAmount"/>
                <xsl:apply-templates select="v1:amount"/>
                <xsl:apply-templates select="v1:reason"/>
                <xsl:apply-templates select="v1:effectivePeriod"
                    mode="effectivePeriod-cartScheduleCharge"/>  
                <xsl:apply-templates select="v1:proratedIndicator"/>
                <xsl:if test="normalize-space(v1:description) != ''">
                    <description>
                        <xsl:value-of select="v1:description"/>
                    </description>
                </xsl:if>                
                <xsl:apply-templates select="v1:chargeCode"/>
                <xsl:apply-templates select="v1:waiverIndicator"/>
                <xsl:apply-templates select="v1:waiverReason"/>
                <xsl:apply-templates select="v1:manuallyAddedCharge"/>
                <xsl:apply-templates select="v1:productOffering"
                    mode="cartScheduleCharge-productOffering"/>
                <xsl:apply-templates select="v1:feeOverrideAllowed"/>
                <xsl:apply-templates select="v1:overrideThresholdPercent"/>
                <xsl:apply-templates select="v1:overrideThresholdAmount"/>
                <xsl:apply-templates select="v1:supervisorID"/>
                <xsl:apply-templates select="v1:overrideAmount"/>
                <xsl:apply-templates select="v1:overrideReason"/>
                <xsl:apply-templates select="v1:productOfferingPriceId"/>
              
            </cartScheduleCharge>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:effectivePeriod" mode="effectivePeriod-cartScheduleCharge">
        <xsl:if test="normalize-space(.) != ''">
            <effectivePeriod>
                <xsl:apply-templates select="v1:startTime"/>
                <xsl:apply-templates select="v1:endTime"/>
            </effectivePeriod>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:feeOverrideAllowed">
        <xsl:if test="normalize-space(.) != '' or @name">
            <feeOverrideAllowed>
                <xsl:if test="@name!=''">
                    <xsl:attribute name="name">
                        <xsl:value-of select="@name"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="."/>
            </feeOverrideAllowed>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:overrideThresholdAmount | v1:overrideAmount">
        <xsl:if test="normalize-space(.) != '' or @currencyCode">
            <xsl:element name="{local-name()}">
                <xsl:attribute name="currencyCode">
                    <xsl:value-of select="if (@currencyCode != '')
                        then  @currencyCode else 'USD'"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:promotion">
        <xsl:if test="normalize-space(.) != '' or @promotionId">
            <promotion>               
                <xsl:if test="@promotionId!=''">
                    <xsl:attribute name="promotionId">
                        <xsl:value-of select="@promotionId"/>
                    </xsl:attribute>
                </xsl:if>
            </promotion>
        </xsl:if>
    </xsl:template>



    <xsl:template match="v1:lineOfService">
        <xsl:if test="normalize-space(.) != '' or @lineOfServiceId or @actionCode">
            <lineOfService>
                <xsl:if test="@lineOfServiceId!=''">
                    <xsl:attribute name="lineOfServiceId">
                        <xsl:value-of select="@lineOfServiceId"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@actionCode!=''">
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
                <!--xsl:apply-templates select="v1:pin"/-->
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
                <xsl:apply-templates select="v1:lineSequence"/>
                <xsl:apply-templates select="v1:assignedProduct"/>
                <xsl:apply-templates select="v1:effectivePeriod"
                    mode="lineOfService-effectivePeriod"/>
                <xsl:apply-templates select="v1:memberLineOfService"/>
                <xsl:apply-templates select="v1:specificationGroup"
                    mode="lineOfService-specificationGroup"/>
                <xsl:apply-templates select="v1:privacyProfile" mode="lineOfService" />
            </lineOfService>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:privacyProfile" mode="lineOfService">
        <xsl:if test="normalize-space(.) !=''">
            <privacyProfile>
                <xsl:if test="normalize-space(v1:optOut) !=''">
                    <optOut>
                        <xsl:value-of select="v1:optOut"/>
                    </optOut>
                </xsl:if>
                <xsl:if test="normalize-space(v1:activityType) !=''">
                    <activityType>
                        <xsl:value-of select="v1:activityType"/>
                    </activityType>
                </xsl:if>
            </privacyProfile>           
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:assignedProduct">
        <xsl:if test="normalize-space(.) != '' or @actionCode">
            <assignedProduct>
                <xsl:if test="@actionCode!=''">
                    <xsl:attribute name="actionCode">
                        <xsl:value-of select="@actionCode"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="v1:key" mode="key-assignedProduct"/>
                <xsl:apply-templates select="v1:productOffering"/>
                <xsl:apply-templates select="v1:effectivePeriod"
                    mode="effectivePeriod-assignedProduct"/>
                <xsl:if test="normalize-space(v1:customerOwnedIndicator) != ''">
                    <customerOwnedIndicator>
                        <xsl:value-of select="v1:customerOwnedIndicator"/>
                    </customerOwnedIndicator>
                </xsl:if>
                <xsl:apply-templates select="v1:eligibilityEvaluation"/>
                <xsl:apply-templates select="v1:warranty"/>
            </assignedProduct>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:assignedProduct" mode="assignedProduct-cartItem">
        <xsl:if test="normalize-space(.) != '' or @actionCode">
            <assignedProduct>
                <xsl:if test="@actionCode!=''">
                    <xsl:attribute name="actionCode">
                        <xsl:value-of select="@actionCode"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="v1:productOffering"/>
            </assignedProduct>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:key" mode="key-assignedProduct">
        <xsl:if test="normalize-space(.) != '' or @domainName">
            <key>
                <xsl:if test="@domainName!=''">
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

    <xsl:template match="v1:key" mode="key-productOffering">
        <xsl:if test="normalize-space(.) != '' or @domainName">
            <key>
                <xsl:if test="@domainName!=''">
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

    <xsl:template match="v1:memberLineOfService">
        <xsl:if test="normalize-space(.) != ''">
            <memberLineOfService>
                <xsl:if test="normalize-space(v1:primaryLineIndicator)!=''">
                    <primaryLineIndicator>
                        <xsl:value-of select="v1:primaryLineIndicator"/>
                    </primaryLineIndicator>
                </xsl:if>
            </memberLineOfService>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:warranty">
        <xsl:if test="normalize-space(.) != ''">
            <warranty>
                <xsl:if test="normalize-space(v1:warrantyExpirationDate)!=''">
                    <warrantyExpirationDate>
                        <xsl:value-of select="v1:warrantyExpirationDate"/>
                    </warrantyExpirationDate>
                </xsl:if>
            </warranty>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:eligibilityEvaluation">
        <xsl:if test="normalize-space(.) != ''">
            <eligibilityEvaluation>
                <xsl:apply-templates select="v1:overrideIndicator"
                    mode="eligibilityEvaluation-overrideIndicator"/>
            </eligibilityEvaluation>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:overrideIndicator" mode="eligibilityEvaluation-overrideIndicator">
        <xsl:if test="normalize-space(.) != '' or @name">
            <overrideIndicator>
                <xsl:if test="@name!=''">
                    <xsl:attribute name="name">
                        <xsl:value-of select="@name"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="."/>                    
            </overrideIndicator>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:lineOfServiceStatus">
        <xsl:if test="normalize-space(.) != ''">
            <lineOfServiceStatus>                
                <xsl:if test="@statusCode!=''">
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


    <xsl:template match="v1:networkResource" mode="lineOfService-networkResource">
        <xsl:if test="normalize-space(.) != '' or @actionCode">
            <networkResource>
                <xsl:if test="@actionCode!=''">
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
                <xsl:apply-templates select="v1:mobileNumber"/>
                <xsl:apply-templates select="v1:resourceSpecification"/>
            </networkResource>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:resourceSpecification">
        <xsl:if test="normalize-space(.) != '' or @name">
            <resourceSpecification>
                <xsl:if test="@name!= ''">
                    <xsl:attribute name="name">
                        <xsl:value-of select="@name"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="v1:specificationValue"/>
            </resourceSpecification>
        </xsl:if>
    </xsl:template>


    <xsl:template match="v1:sim" mode="networkResource-sim">
        <xsl:if test="normalize-space(.) != ''">
            <sim>
                <xsl:if test="normalize-space(v1:simNumber)!=''">
                    <simNumber>
                        <xsl:value-of select="v1:simNumber"/>
                    </simNumber>
                </xsl:if>
                <xsl:if test="normalize-space(v1:imsi)!=''">
                    <imsi>
                        <xsl:value-of select="v1:imsi"/>
                    </imsi>
                </xsl:if>
                <xsl:apply-templates select="v1:simType"/>
                <xsl:apply-templates select="v1:virtualSim"/>
            </sim>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:subscriberContact">
        <xsl:if test="normalize-space(.) != ''">
            <subscriberContact>
                <xsl:apply-templates select="v1:personName"/>
                <xsl:apply-templates select="v1:addressCommunication"/>
            </subscriberContact>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:addressCommunication">
        <xsl:if test="normalize-space(.) != '' or @id or @actionCode">
            <addressCommunication>
                <xsl:if test="@id!=''">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@actionCode!=''">
                    <xsl:attribute name="actionCode">
                        <xsl:value-of select="@actionCode"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="v1:privacyProfile"/>
                <xsl:apply-templates select="v1:address"/>
                <xsl:if test="normalize-space(v1:usageContext)!=''">
                    <usageContext>
                        <xsl:value-of select="v1:usageContext"/>
                    </usageContext>
                </xsl:if>
            </addressCommunication>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:privacyProfile">
        <xsl:if test="normalize-space(.) != ''">
            <privacyProfile>
                <xsl:if test="normalize-space(v1:optOut) != ''">
                    <optOut>
                        <xsl:value-of select="v1:optOut"/>
                    </optOut>
                </xsl:if>
            </privacyProfile>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:address">
        <xsl:if test="normalize-space(.) != ''">
            <address>
                <xsl:apply-templates select="v1:key"/>               
            </address>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:key">
        <xsl:if test="normalize-space(.) != '' or @domainName">
            <key>
                <xsl:if test="@domainName!=''">
                    <xsl:attribute name="domainName">
                        <xsl:value-of select="@domainName"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="v1:keyName"/>
                <xsl:apply-templates select="v1:keyValue"/>
            </key>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:networkResource">
        <xsl:if test="normalize-space(.) != '' or @actionCode">
            <networkResource>
                <xsl:if test="@actionCode!=''">
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
                <xsl:apply-templates select="v1:mobileNumber"/>
                <xsl:apply-templates select="v1:resourceSpecification"/>
            </networkResource>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:sim">
        <xsl:if test="normalize-space(.) != ''">
            <sim>
                <xsl:if test="normalize-space(v1:simNumber)!=''">
                    <simNumber>
                        <xsl:value-of select="v1:simNumber"/>
                    </simNumber>
                </xsl:if>
                <xsl:if test="normalize-space(v1:imsi)!=''">
                    <imsi>
                        <xsl:value-of select="v1:imsi"/>
                    </imsi>
                </xsl:if>
                <xsl:apply-templates select="v1:simType"/>
                <xsl:apply-templates select="v1:virtualSim"/>
                <xsl:if test="normalize-space(v1:embeddedSIMIndicator)!=''">
                    <embeddedSIMIndicator>
                        <xsl:value-of select="v1:embeddedSIMIndicator"/>
                    </embeddedSIMIndicator>
                </xsl:if>
            </sim>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:mobileNumber">
        <xsl:if test="normalize-space(.) != ''">
            <mobileNumber>
                <xsl:if test="normalize-space(v1:msisdn)!=''">
                    <msisdn>
                        <xsl:value-of select="v1:msisdn"/>
                    </msisdn>
                </xsl:if>
                <xsl:if test="normalize-space(v1:portIndicator)!=''">
                    <portIndicator>
                        <xsl:value-of select="v1:portIndicator"/>
                    </portIndicator>
                </xsl:if>
                <xsl:if test="normalize-space(v1:portReason)!=''">
                    <portReason>
                        <xsl:value-of select="v1:portReason"/>
                    </portReason>
                </xsl:if>
            </mobileNumber>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:addressList">
        <xsl:if test="normalize-space(.) != ''">
            <addressList>
                <xsl:apply-templates select="v1:addressCommunication" mode="addressList"/>
                <xsl:apply-templates select="v1:specialInstruction"/>
            </addressList>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:addressCommunication" mode="addressList">
        <xsl:if test="normalize-space(.) != '' or @id">
            <addressCommunication>
                <xsl:if test="@id!=''">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                </xsl:if>

                <xsl:apply-templates select="v1:address" mode="addressList"/>
                <xsl:apply-templates select="v1:usageContext"/>
                <xsl:apply-templates select="v1:communicationStatus" mode="v1:addressCommunication"/>
                <xsl:apply-templates select="v1:specialInstruction"/>
            </addressCommunication>
        </xsl:if>
    </xsl:template>


    <xsl:template match="v1:communicationStatus" mode="v1:addressCommunication">
        <xsl:if test="normalize-space(.) != '' or @subStatusCode or @statusCode">
            <communicationStatus>
                <xsl:if test="@subStatusCode!=''">
                    <xsl:attribute name="subStatusCode">
                        <xsl:value-of select="@subStatusCode"/>
                    </xsl:attribute>
                </xsl:if>

                <xsl:if test="@statusCode!=''">
                    <xsl:attribute name="statusCode">
                        <xsl:value-of select="@statusCode"/>
                    </xsl:attribute>
                </xsl:if>
            </communicationStatus>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:address" mode="addressList">
        <xsl:if test="normalize-space(.) != ''">
            <address>
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
                <xsl:apply-templates select="v1:key" mode="addressList"/>
                <xsl:apply-templates select="v1:residentialIndicator"/>
                <xsl:apply-templates select="v1:building"/>
                <xsl:apply-templates select="v1:floor"/>
                <xsl:apply-templates select="v1:area"/>
                <xsl:apply-templates select="v1:timeZone"/>
                <xsl:apply-templates select="v1:ruralRoute"/>
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
                <xsl:apply-templates select="v1:postOfficeBox"/>
                <xsl:apply-templates select="v1:observesDaylightSavingsIndicator"/>
                <xsl:apply-templates select="v1:matchIndicator"/>
            </address>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:key" mode="addressList">
        <xsl:if test="normalize-space(.) != '' or @domainName">
            <key>
                <xsl:if test="@domainName!=''">
                    <xsl:attribute name="domainName">
                        <xsl:value-of select="@domainName"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="v1:keyName"/>
                <xsl:apply-templates select="v1:keyValue"/>
            </key>
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

    <xsl:template match="v1:geoCodeID">
        <xsl:if
            test="normalize-space(.) != '' or @manualIndicator or @referenceLayer or @usageContext">
            <geoCodeID>
                <xsl:if test="@manualIndicator!=''">
                    <xsl:attribute name="manualIndicator">
                        <xsl:value-of select="@manualIndicator"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@referenceLayer!=''">
                    <xsl:attribute name="referenceLayer">
                        <xsl:value-of select="@referenceLayer"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@usageContext!=''">
                    <xsl:attribute name="usageContext">
                        <xsl:value-of select="@usageContext"/>
                    </xsl:attribute>
                </xsl:if>
            </geoCodeID>
        </xsl:if>
    </xsl:template>

    <xsl:template
        match="v1:size | v1:taxRate | v1:overrideThresholdPercent | v1:quantity | v1:measurementUnit">
        <xsl:if test="normalize-space(.) != ''">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="@*"/>
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template
        match="v1:extendedAmount | v1:totalChargeAmount | v1:totalDiscountAmount | v1:totalFeeAmount | v1:totalTaxAmount | v1:totalDueNowAmount | v1:totalDueMonthlyAmount">
        <xsl:if test="normalize-space(.) != '' or @currencyCode">
            <xsl:element name="{local-name()}">
                <xsl:attribute name="currencyCode">
                    <xsl:value-of select="if (@currencyCode != '')
                        then  @currencyCode else 'USD'"/>
                </xsl:attribute>
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:oneTimeCharge">
        <xsl:if test="normalize-space(.) != ''">
            <oneTimeCharge>
                <xsl:value-of select="."/>
            </oneTimeCharge>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:*">
        <xsl:if test="normalize-space(.) != ''">
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
