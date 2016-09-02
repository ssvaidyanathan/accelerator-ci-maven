<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:v1="http://services.tmobile.com/OrderManagement/CartWSIL/V1"
    xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:base="http://services.tmobile.com/base" exclude-result-prefixes="v1 base soapenv">
    
    <xsl:param name="acceptType"/>
    <xsl:param name="pARRAY" select="'~ARRAY~'"/>
    <xsl:param name="pINTEGER" select="'~INT~'"/>
    <xsl:param name="pBOOLEAN" select="'~INT~'"/>
    <xsl:param name="cartItemId"/>

    <xsl:output method="xml" indent="no" encoding="UTF-8" version="1.0" omit-xml-declaration="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/">
        <xsl:variable name="varResponse" select="soapenv:Envelope/soapenv:Body/v1:getCartDetailsResponse"/>
        <xsl:apply-templates select="$varResponse/v1:cart"/>
    </xsl:template>

    <xsl:template
        match="v1:usageContext |v1:simType |  v1:specialInstruction | v1:productType | v1:productSubType">
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

    <xsl:template match="v1:cart">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:cartItem"/>
                <!--xsl:apply-templates select="v1:cartItem[@cartItemId = $cartItemId]"/-->
                <xsl:apply-templates select="v1:addressList"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:cartItem">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">


                <!-- <xsl:apply-templates select="@*"/>-->
                <xsl:if test="@cartItemId">
                    <xsl:attribute name="cartItemId">
                        <xsl:value-of select="@cartItemId"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:if test="@actionCode">
                    <xsl:attribute name="actionCode">
                        <xsl:value-of select="@actionCode"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="v1:overridePriceAllowedIndicator"/>
                <xsl:apply-templates select="v1:quantity"/>
                <!-- <xsl:apply-templates select="v1:currencyCode"/>-->
                <xsl:apply-templates select="v1:cartItemStatus"/>
                <xsl:apply-templates select="v1:parentCartItemId"/>
                <xsl:apply-templates select="v1:rootParentCartItemId"/>
                <xsl:apply-templates select="v1:effectivePeriod" mode="cartItem-effectivePeriod"/>
                <xsl:apply-templates select="v1:productOffering"/>
                <xsl:apply-templates select="v1:assignedProduct" mode="assignedProduct-cartItem"/>
                <xsl:apply-templates select="v1:cartSchedule"/>
                <xsl:apply-templates select="v1:specificationGroup"/>
                <xsl:apply-templates select="v1:promotion" mode="cartItem-promotion"/>
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
                <xsl:apply-templates select="v1:financialAccount"/>
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
            <!--  <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>-->
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:port">
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
                <xsl:apply-templates select="v1:personProfile" mode="personProfile-addressCommunication"/>    
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:personProfile" mode="personProfile-addressCommunication">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:addressCommunication" mode="personProfile-addressCommunication"/>
            </xsl:element>		
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:addressCommunication" mode="personProfile-addressCommunication">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:address" mode="personProfile-addressCommunication"/>
            </xsl:element>		
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:address" mode="personProfile-addressCommunication">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:addressLine1"/>
                <xsl:apply-templates select="v1:addressLine2"/>
                <xsl:apply-templates select="v1:cityName"/>
                <xsl:apply-templates select="v1:stateCode"/>
                <xsl:apply-templates select="v1:countryCode"/>
                <xsl:apply-templates select="v1:postalCode"/>
            </xsl:element>		
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:deviceConditionQuestions">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:verificationQuestion"/>
            </xsl:element>
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

    <xsl:template match="v1:financialAccount">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:financialAccountNumber"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:inventoryStatus">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">

                <xsl:if test="@statusCode">
                    <xsl:attribute name="statusCode">
                        <xsl:value-of select="@statusCode"/>
                    </xsl:attribute>
                </xsl:if>

                <xsl:apply-templates select="v1:estimatedAvailable"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:estimatedAvailable">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:startDate"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:promotion" mode="cartItem-promotion">
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

                <xsl:apply-templates select="v1:promotionName"/>
                <xsl:apply-templates select="v1:promotionCode"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>


    <xsl:template match="v1:effectivePeriod" mode="cartItem-effectivePeriod">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:startTime"/>
                <!--   <xsl:apply-templates select="v1:endTime"/>
                <xsl:apply-templates select="v1:usageContext"/> -->
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:effectivePeriod" mode="effectivePeriod-assignedProduct">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:startTime"/>
                <xsl:apply-templates select="v1:endTime"/>
                <xsl:apply-templates select="v1:usageContext"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:effectivePeriod" mode="lineOfService-effectivePeriod">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:startTime"/>
                <xsl:apply-templates select="v1:endTime"/>
            </xsl:element>
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
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">

                <xsl:if test="@currencyCode">
                    <xsl:attribute name="currencyCode">
                        <xsl:value-of select="if (@currencyCode != '')
                            then  @currencyCode else 'USD'"/>
                    </xsl:attribute>
                </xsl:if>

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

    <xsl:template match="v1:cartItemStatus">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="@statusCode"/>
                <xsl:apply-templates select="v1:description" mode="description-cartItemStatus"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:description" mode="description-cartItemStatus">
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

    <xsl:template match="v1:effectivePeriod | v1:promotionEffectivePeriod">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:startTime"/>
                <xsl:apply-templates select="v1:endTime"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
   
    
    <xsl:template match="v1:productOffering"  mode="cartScheduleCharge-productOffering">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                
                <!-- <xsl:apply-templates select="@*"/>-->
                
                <xsl:if test="@productOfferingId">
                    <xsl:attribute name="productOfferingId">
                        <xsl:value-of select="@productOfferingId"/>
                    </xsl:attribute>
                </xsl:if>
                
                </xsl:element>
        </xsl:if>
    </xsl:template>
    
   
    
    <xsl:template match="v1:productOffering">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">

                <!-- <xsl:apply-templates select="@*"/>-->

                <xsl:if test="@productOfferingId">
                    <xsl:attribute name="productOfferingId">
                        <xsl:value-of select="@productOfferingId"/>
                    </xsl:attribute>
                </xsl:if>

                <xsl:apply-templates select="v1:name"/>
                <xsl:apply-templates select="v1:shortName"/>
                <xsl:apply-templates select="v1:displayName"/>
                <xsl:apply-templates select="v1:description" mode="description-productOffering"/>
                <xsl:apply-templates select="v1:shortDescription"  mode="shortDescription-productOffering"/>
                <xsl:apply-templates select="v1:keyword" mode="productOffering-keyword"/>
                <xsl:apply-templates select="v1:longDescription"/>
                <xsl:apply-templates select="v1:alternateDescription"/>
                <xsl:apply-templates select="v1:offerType"/>
                <xsl:apply-templates select="v1:offerSubType"/>
                <xsl:apply-templates select="v1:offerLevel"/>
                <!--xsl:apply-templates select="v1:offeringStatus"/-->
                <xsl:apply-templates select="v1:offeringClassification"/>
                <xsl:apply-templates select="v1:businessUnit"/>
                <xsl:apply-templates select="v1:specificationGroup"/>
                <xsl:apply-templates select="v1:offeringPrice"/>
                <xsl:apply-templates select="v1:orderBehavior" mode="productOffering-orderBehavior"/>
                <xsl:apply-templates select="v1:image"/>
                <xsl:apply-templates select="v1:marketingMessage"/>
                <xsl:apply-templates select="v1:equipmentCharacteristics"/>
                <xsl:apply-templates select="v1:serviceCharacteristics"/>
                <xsl:apply-templates select="v1:productType"/>
                <xsl:apply-templates select="v1:productSubType"/>
                <xsl:apply-templates select="v1:key" mode="key-productOffering"/>
                <xsl:apply-templates select="v1:offeringVariant"/>
                <xsl:apply-templates select="v1:productOfferingComponent"/>
                <xsl:apply-templates select="v1:productSpecification"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:productOfferingComponent">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <!-- default value -->
                <xsl:if test="@offeringComponentId">
                    <xsl:attribute name="offeringComponentId">
                        <xsl:value-of select="@offeringComponentId"/>
                    </xsl:attribute>
                </xsl:if>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    


    <xsl:template match="v1:serviceCharacteristics">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <!-- default value -->
                <xsl:apply-templates select="v1:backDateAllowedIndicator"/>
                <xsl:apply-templates select="v1:futureDateAllowedIndicator"/>
                <xsl:apply-templates select="v1:backDateVisibleIndicator"/>
                <xsl:apply-templates select="v1:futureDateVisibleIndicator"/>
                <xsl:apply-templates select="v1:includedServiceCapacity"/>
                <xsl:apply-templates select="v1:billEffectiveCode"/>
                <xsl:apply-templates select="v1:billableThirdPartyServiceIndicator"/>
                <xsl:apply-templates select="v1:prorateAllowedIndicator"/>
                <xsl:apply-templates select="v1:prorateVisibleIndicator"/>
                <xsl:apply-templates select="v1:duration"/>
            </xsl:element>
            <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>
        </xsl:if>
    </xsl:template>



    <xsl:template match="v1:prorateVisibleIndicator">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="@name|node()"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:prorateAllowedIndicator">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="@name|node()"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:billableThirdPartyServiceIndicator">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="@name|node()"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:includedServiceCapacity">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:capacityType"/>
                <xsl:apply-templates select="v1:capacitySubType"/>
                <xsl:apply-templates select="v1:unlimitedIndicator"/>
                <xsl:apply-templates select="v1:size"/>
                <xsl:apply-templates select="v1:measurementUnit"/>
            </xsl:element>
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
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="@name|node()"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>



    <xsl:template match="v1:backDateAllowedIndicator">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="@name|node()"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:futureDateAllowedIndicator">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="@name|node()"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:futureDateVisibleIndicator">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="@name|node()"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:backDateVisibleIndicator">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="@name|node()"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:equipmentCharacteristics">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:model"/>
                <xsl:apply-templates select="v1:manufacturer"/>
                <xsl:apply-templates select="v1:color"/>
                <xsl:apply-templates select="v1:memory"/>
                <xsl:apply-templates select="v1:tacCode"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:tacCode">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="node()"/>
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
            <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>
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

    <xsl:template match="v1:keyword">
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

    <xsl:template match="v1:description | v1:messageText">
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
                <xsl:value-of select="."/>
            </xsl:element>
            <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:description" mode="description-productOffering">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
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
            </xsl:element>
            <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:shortdescription">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:if test="@languageCode">
                    <xsl:attribute name="languageCode">
                        <xsl:value-of select="@languageCode"/>
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

    <xsl:template match="v1:shortDescription" mode="shortDescription-productOffering">
        <xsl:if test="normalize-space(.) != '' or @salesChannelCode or @usageContext or @languageCode">
            <xsl:element name="{local-name()}">
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
            </xsl:element>
            <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:longDescription | v1:alternateDescription">
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

    <xsl:template match="v1:offeringStatus">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">

                <!-- <xsl:apply-templates select="@*"/>-->

                <xsl:if test="@statusCode">
                    <xsl:attribute name="statusCode">
                        <xsl:value-of select="@statusCode"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="v1:effectivePeriod"/>
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
    
    <xsl:template match="v1:specificationGroup" mode="lineOfService-specificationGroup">
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

    <xsl:template match="v1:offeringPrice">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">

                <!--  <xsl:apply-templates select="@*"/>-->

                <xsl:if test="@priceListLineId">
                    <xsl:attribute name="priceListLineId">
                        <xsl:value-of select="@priceListLineId"/>
                    </xsl:attribute>
                </xsl:if>

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
                <xsl:apply-templates select="v1:basisAmount"/>
                <xsl:apply-templates select="v1:amount"/>
                <xsl:apply-templates select="v1:oneTimeCharge"/>
                <xsl:apply-templates select="v1:recurringFeeFrequency"/>
                <xsl:apply-templates select="v1:taxInclusiveIndicator"/>
                <xsl:apply-templates select="v1:specificationValue"/>
            </xsl:element>
            <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>
        </xsl:if>
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
    
    <xsl:template match="v1:preOrderAvailableTime" mode="orderBehavior-preOrderAvailableTime">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:if test="@name">
                    <xsl:attribute name="name">
                        <xsl:value-of select="@name"/>
                    </xsl:attribute>
                </xsl:if>
            </xsl:element>
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

    <xsl:template match="v1:image">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:URI"/>
                <xsl:apply-templates select="v1:sku" mode="image-sku"/>
                <xsl:apply-templates select="v1:imageDimensions"/>
                <xsl:apply-templates select="v1:displayPurpose"/>
            </xsl:element>
            <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:sku" mode="image-sku">
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

    <xsl:template match="v1:offeringVariant">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:sku" mode="sku-offeringVariant"/>
                <xsl:apply-templates select="v1:specificationGroup"/>
                <xsl:apply-templates select="v1:offeringVariantPrice"/>
                <xsl:apply-templates select="v1:productCondition"/>
                <xsl:apply-templates select="v1:color"/>
                <xsl:apply-templates select="v1:memory"/>
                <xsl:apply-templates select="v1:tacCode"/>
                <xsl:apply-templates select="v1:orderBehavior" mode="orderBehavior-offeringVariant"/>

            </xsl:element>
            <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:orderBehavior" mode="orderBehavior-offeringVariant">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <!--Change Start-->
                <xsl:apply-templates select="v1:preOrderAllowedIndicator"/>
                <xsl:apply-templates select="v1:preOrderAvailableTime"/>
                <!--Change End-->
            </xsl:element>
            <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    <xsl:template match="v1:orderBehavior" mode="productOffering-orderBehavior">
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

    <xsl:template match="v1:sku" mode="sku-offeringVariant">
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
            <!--   <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>-->
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
                <xsl:apply-templates select="v1:keyword" mode="ps"/>
                <xsl:apply-templates select="v1:additionalSpecification"/>
                <xsl:apply-templates select="v1:productType" mode="ps"/>
                <xsl:apply-templates select="v1:productSubType" mode="ps"/>
                <xsl:apply-templates select="v1:sku" mode="ps"/>
            </xsl:element>
        </xsl:if>
        <!--   <xsl:if test="not(contains($acceptType, 'xml'))">
            <xsl:element name="{local-name()}">
                <xsl:value-of select="$pARRAY"/>
            </xsl:element>
        </xsl:if>-->
    </xsl:template>

    <xsl:template match="v1:additionalSpecification">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:specificationValue"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:keyword" mode="ps">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:if test="@name">
                    <xsl:attribute name="name">
                        <xsl:value-of select="@name"/>
                    </xsl:attribute>
                </xsl:if>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:keyword" mode="productOffering-keyword">
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

    <xsl:template match="v1:productType" mode="ps">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="node()"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:productSubType" mode="ps">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="node()"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:sku" mode="ps">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="node()"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>


    <xsl:template match="v1:cartSchedule">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">

                <xsl:if test="@cartScheduleId">
                    <xsl:attribute name="cartScheduleId">
                        <xsl:value-of select="@cartScheduleId"/>
                    </xsl:attribute>
                </xsl:if>
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

    <xsl:template match="v1:cartScheduleTax">
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
                <xsl:apply-templates select="v1:description" mode="cartScheduleTax-description"/>
                <xsl:apply-templates select="v1:taxRate" mode="cartScheduleTax-taxRate"/>

            </xsl:element>
            <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:description" mode="cartScheduleTax-description">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:taxRate" mode="cartScheduleTax-taxRate">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:value-of select="."/>
            </xsl:element>
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
                <xsl:if test="@deductionId">
                    <xsl:attribute name="deductionId">
                        <xsl:value-of select="@deductionId"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="v1:amount"/>
                <xsl:apply-templates select="v1:reason"/>
                <xsl:apply-templates select="v1:effectivePeriod" mode="effectivePeriod-cartScheduleDeduction"/>
                <xsl:apply-templates select="v1:description"/>
                <xsl:apply-templates select="v1:recurringFrequency"/>
                <xsl:apply-templates select="v1:promotion" mode="cartScheduleDeduction-promotion"/>
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

    <xsl:template match="v1:promotion" mode="cartScheduleDeduction-promotion">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:if test="@promotionId">
                    <xsl:attribute name="promotionId">
                        <xsl:value-of select="@promotionId"/>
                    </xsl:attribute>
                </xsl:if>
            </xsl:element>
        </xsl:if>
    </xsl:template>


    <xsl:template match="v1:cartScheduleStatus">
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

    <xsl:template match="v1:cartScheduleCharge">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">

                <xsl:if test="@actionCode">
                    <xsl:attribute name="actionCode">
                        <xsl:value-of select="@actionCode"/>
                    </xsl:attribute>
                </xsl:if>

                <!-- <xsl:apply-templates select="@*"/>-->

                <xsl:apply-templates select="v1:typeCode"/>
                <xsl:apply-templates select="v1:chargeFrequencyCode"/>
                <xsl:apply-templates select="v1:basisAmount"/>
                <xsl:apply-templates select="v1:amount"/>
                <xsl:apply-templates select="v1:reason"/>
                <xsl:apply-templates select="v1:effectivePeriod" mode="effectivePeriod-cartScheduleCharge"/>
                <xsl:apply-templates select="v1:description"/>
                <xsl:apply-templates select="v1:chargeCode"/>
                <xsl:apply-templates select="v1:waiverIndicator"/>
                <xsl:apply-templates select="v1:waiverReason"/>
                <xsl:apply-templates select="v1:manuallyAddedCharge"/>
                <xsl:apply-templates select="v1:productOffering" mode="cartScheduleCharge-productOffering"/>
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
    
    <xsl:template match="v1:effectivePeriod" mode="effectivePeriod-cartScheduleCharge">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:startTime"/>
                <xsl:apply-templates select="v1:endTime"/>				
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:effectivePeriod" mode="effectivePeriod-cartScheduleDeduction">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:startTime"/>
                <xsl:apply-templates select="v1:endTime"/>				
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:feeOverrideAllowed">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:if test="@name">
                    <xsl:attribute name="name">
                        <xsl:value-of select="@name"/>
                    </xsl:attribute>
                </xsl:if>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:overrideThresholdAmount | v1:overrideAmount">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:if test="@currencyCode">
                    <xsl:attribute name="currencyCode">
                        <xsl:value-of select="if (@currencyCode != '')
                            then  @currencyCode else 'USD'"/>
                    </xsl:attribute>
                </xsl:if>
                
                <xsl:choose>
                    <xsl:when test="not(contains($acceptType, 'xml'))">
                        <xsl:value-of select="concat($pINTEGER,.,$pINTEGER)" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="node()" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:promotion">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <!-- <xsl:apply-templates select="@*"/>-->
                <xsl:if test="@promotionId">
                    <xsl:attribute name="promotionId">
                        <xsl:value-of select="@promotionId"/>
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

    <xsl:template match="v1:lineOfService">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">

                <!-- <xsl:apply-templates select="@*"/>-->

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

                <xsl:apply-templates select="v1:financialAccountNumber"/>
                <xsl:apply-templates select="v1:subscriberContact"/>
				<xsl:apply-templates select="v1:networkResource" mode="lineOfService-networkResource"/>      
				<!--xsl:apply-templates select="v1:pin"/-->
                <xsl:apply-templates select="v1:lineOfServiceStatus"/>
                <xsl:apply-templates select="v1:primaryLineIndicator"/>
                <xsl:apply-templates select="v1:lineAlias"/>
                <xsl:apply-templates select="v1:lineSequence"/>
                <xsl:apply-templates select="v1:assignedProduct"/>
                <xsl:apply-templates select="v1:effectivePeriod" mode="lineOfService-effectivePeriod"/>
                <xsl:apply-templates select="v1:memberLineOfService"/>
                <xsl:apply-templates select="v1:specificationGroup" mode="lineOfService-specificationGroup"/>
                <xsl:apply-templates select="v1:privacyProfile" mode="lineOfService" />
            </xsl:element>
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
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">

                <xsl:if test="@actionCode">
                    <xsl:attribute name="actionCode">
                        <xsl:value-of select="@actionCode"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="v1:key" mode="key-assignedProduct"/>
                <xsl:apply-templates select="v1:productOffering"/>
                <xsl:apply-templates select="v1:effectivePeriod" mode="effectivePeriod-assignedProduct"/>
                <xsl:apply-templates select="v1:customerOwnedIndicator"/>
                <xsl:apply-templates select="v1:eligibilityEvaluation"/>
                <xsl:apply-templates select="v1:warranty"/>
            </xsl:element>
            <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:assignedProduct" mode="assignedProduct-cartItem">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                
                <xsl:if test="@actionCode">
                    <xsl:attribute name="actionCode">
                        <xsl:value-of select="@actionCode"/>
                    </xsl:attribute>
                </xsl:if>   
                <xsl:apply-templates select="v1:productOffering"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:key" mode="key-assignedProduct">
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

    <xsl:template match="v1:key" mode="key-productOffering">
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

    <xsl:template match="v1:memberLineOfService">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:primaryLineIndicator"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:warranty">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:warrantyExpirationDate"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:eligibilityEvaluation">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:overrideIndicator"
                    mode="eligibilityEvaluation-overrideIndicator"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:overrideIndicator" mode="eligibilityEvaluation-overrideIndicator">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:if test="@name">
                    <xsl:attribute name="name">
                        <xsl:value-of select="@name"/>
                    </xsl:attribute>
                </xsl:if>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:lineOfServiceStatus">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="@statusCode"/>
                <xsl:apply-templates select="v1:reasonCode"/>
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
                <xsl:apply-templates select="v1:sim" mode="networkResource-sim"/>
                <xsl:apply-templates select="v1:mobileNumber"/>
                <xsl:apply-templates select="v1:resourceSpecification"/>
            </xsl:element>
            <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:resourceSpecification">
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


    <xsl:template match="v1:sim" mode="networkResource-sim">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:simNumber"/>
                <xsl:apply-templates select="v1:imsi"/>
                <xsl:apply-templates select="v1:simType"/>
                <xsl:apply-templates select="v1:virtualSim"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:subscriberContact">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <!--<xsl:apply-templates select="@*"/>-->
                <xsl:apply-templates select="v1:personName"/>
                <xsl:apply-templates select="v1:addressCommunication"/>
            </xsl:element>
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

                <xsl:apply-templates select="v1:privacyProfile"/>
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

    <xsl:template match="v1:privacyProfile">
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

    <xsl:template match="v1:address">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:key" mode="address"/>
            </xsl:element>
            <!-- <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>-->
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:key" mode="address">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:keyName"/>
                <xsl:apply-templates select="v1:keyValue"/>
            </xsl:element>           
        </xsl:if>
    </xsl:template>
    

    <xsl:template match="v1:key">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="@*"/>
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

    <xsl:template match="v1:networkResource">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:if test="@actionCode">
                    <xsl:attribute name="actionCode">
                        <xsl:value-of select="@actionCode"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="v1:imei"/>
                <xsl:apply-templates select="v1:sim"/>
                <xsl:apply-templates select="v1:mobileNumber"/>
                <xsl:apply-templates select="v1:resourceSpecification"/>
            </xsl:element>
            <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:sim">
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

    <xsl:template match="v1:mobileNumber">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:msisdn"/>
                <xsl:apply-templates select="v1:portIndicator"/>
                <xsl:apply-templates select="v1:portReason"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:addressList">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:addressCommunication" mode="addressList"/>
                <xsl:apply-templates select="v1:specialInstruction"/>
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

                <xsl:apply-templates select="v1:address" mode="addressList"/>
                <xsl:apply-templates select="v1:usageContext"/>
                <xsl:apply-templates select="v1:communicationStatus" mode="v1:addressCommunication"/>
                <xsl:apply-templates select="v1:specialInstruction"/>
            </xsl:element>
            <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>
        </xsl:if>
    </xsl:template>


    <xsl:template match="v1:communicationStatus" mode="v1:addressCommunication">
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
            </xsl:element>
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
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:key" mode="addressList">
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

    <xsl:template match="v1:geographicCoordinates">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:latitude"/>
                <xsl:apply-templates select="v1:longitude"/>
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

    <xsl:template
        match="v1:size|v1:taxRate|v1:overrideThresholdPercent|v1:quantity|v1:measurementUnit">
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
    
    <xsl:template
        match="v1:extendedAmount |v1:totalChargeAmount|v1:totalDiscountAmount|v1:totalFeeAmount|v1:totalTaxAmount|v1:totalDueNowAmount|v1:totalDueMonthlyAmount">
        <xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
            <xsl:element name="{local-name()}">
                <xsl:if test="@currencyCode">
                    <xsl:attribute name="currencyCode">
                        <xsl:value-of select="if (@currencyCode != '')
                            then  @currencyCode else 'USD'"/>
                    </xsl:attribute>
                <xsl:choose>
                    <xsl:when test="not(contains($acceptType, 'xml'))">
                        <xsl:value-of select="concat($pINTEGER,.,$pINTEGER)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="."/>
                    </xsl:otherwise>
                </xsl:choose>
                </xsl:if>
            </xsl:element>
        </xsl:if>
        </xsl:template>

    <xsl:template match="v1:oneTimeCharge">
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