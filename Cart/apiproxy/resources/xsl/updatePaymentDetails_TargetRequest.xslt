<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:v1="http://services.tmobile.com/OrderManagement/OrderCheckoutEnterprise/V1.0"
    xmlns:base="http://service.tmobile.com/base" version="2.0" xmlns:saxon="http://saxon.sf.net/"
    exclude-result-prefixes="saxon">

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
    <xsl:param name="storeId"/>
    <xsl:param name="dealerCode"/>
    <xsl:param name="scope"/>
    <xsl:param name="masterDealerCode"/>
    <xsl:param name="interactionId"/>
    <xsl:param name="serviceTransactionId"/>
    <xsl:param name="systemId"/>
    <xsl:param name="userId"/>
    <xsl:param name="userCompanyId"/>
    <xsl:param name="customerCompanyId"/>
    <xsl:param name="servicePartnerId"/>
    <xsl:param name="transactionType"/>
    <xsl:param name="providerId"/>
    <xsl:param name="contextId"/>
    <xsl:param name="actionCode"/>
    <xsl:param name="isMobile"/>
    <!-- <xsl:param name="ABFEntitlements"/> -->

    <xsl:variable name="capientitlementprefix">v1</xsl:variable>
    <xsl:variable name="capientitlementns"
        >http://services.tmobile.com/OrderManagement/OrderCheckoutEnterprise/V1.0</xsl:variable>
    
    <xsl:variable name="capibaseprefix">base</xsl:variable>
    <xsl:variable name="capibase">http://service.tmobile.com/base</xsl:variable>


    <xsl:template match="/">
        <xsl:variable name="requestElement">
            <xsl:choose>
                <xsl:when
                    test="$actionCode = 'UPDATE_ORDER' or $actionCode = 'INFLIGHT_SHIPUPDATE' or $actionCode = 'INFLIGHT_PAYUPDATE' or $actionCode = 'INFLIGHT_SHIPPAYUPDATE'">
                    <xsl:text>v1:updateOrderCheckoutRequest</xsl:text>
                </xsl:when>
                <xsl:when test="$actionCode = 'CREATE_ORDER' or $actionCode = 'SUSPEND_AND_CREATE' ">
                    <xsl:text>v1:createOrderCheckoutRequest</xsl:text>
                </xsl:when>
                <!--  <xsl:when test="$actionCode = 'CREATE' or $actionCode = 'ADD' ">
                    <xsl:text>v1:createOrderCheckoutRequest</xsl:text>
                </xsl:when>-->
            </xsl:choose>
        </xsl:variable>
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
            <soapenv:Header/>
            <soapenv:Body>
                <xsl:element name="{$requestElement}">
                    <xsl:attribute name="serviceTransactionId">
                        <xsl:value-of select="$serviceTransactionId"/>
                    </xsl:attribute>
                    <base:header>
                        <base:sender>
                            <base:senderId>
                                <xsl:value-of select="$senderId"/>
                            </base:senderId>
                            <base:channelId>
                                <xsl:value-of select="$channelId"/>
                            </base:channelId>
                            <base:applicationId>
                                <xsl:value-of select="$applicationId"/>
                            </base:applicationId>
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
                            
                          <!-- <xsl:if test="$ABFEntitlements">
                                <xsl:variable name="entitlementStr"
                                    select="replace(replace(replace(replace($ABFEntitlements,'TO_BE_REPLACED_PREFIX',$capientitlementprefix),'TO_BE_REPLACED_NAMESPACE',$capientitlementns),'TO_BE_REPLACED_BASE_NAMESPACE',$capibase),'TO_BE_REPLACED_BASE_PREFIX',$capibaseprefix)"/>
                                <xsl:copy-of select="saxon:parse($entitlementStr)"/>
                            </xsl:if> -->
                            
                            <!-- <xsl:if test="$ABFEntitlements">
                                <xsl:variable name="entitlementStr" select="replace(replace($ABFEntitlements,'TO_BE_REPLACED_BASE_PREFIX',$capibaseprefix),'TO_BE_REPLACED_BASE_NAMESPACE',$capibase)"></xsl:variable>
                                <xsl:copy-of select="saxon:parse($entitlementStr)" />
                            </xsl:if>-->
                            
                            
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
                    <xsl:apply-templates select="//cart"/>
                    <v1:context>
                        <xsl:value-of select="//Context"/>
                    </v1:context>
                </xsl:element>
            </soapenv:Body>
        </soapenv:Envelope>
    </xsl:template>
    <xsl:template match="cart">
        <v1:order>
            <xsl:apply-templates select="@actionCode"/>
            <xsl:apply-templates select="orderTime"/>
        	<xsl:if test="payment/specificationGroup/specificationValue/@name = 'tillNumber' and  $actionCode = 'CREATE_ORDER'">
        		<v1:orderLocation>
        			<v1:tillNumber>
        				<xsl:value-of select="'tillNumber'"/>
        			</v1:tillNumber>
        		</v1:orderLocation>
        	</xsl:if>
            <xsl:apply-templates select="termsAndConditionsDisposition"/>
            <xsl:apply-templates select="fraudCheckResponseIndicator"/>
            <xsl:apply-templates select="payment"/>
            <xsl:element name="v1:cartId">
                <xsl:value-of select="@cartId"/>
            </xsl:element>
        </v1:order>
    </xsl:template>
    <xsl:template match="termsAndConditionsDisposition">
        <xsl:if test="current()!='' or count(@*)&gt;0">
            <xsl:element name="v1:{local-name()} ">
                <xsl:apply-templates select="acceptanceIndicator"/>
                <xsl:apply-templates select="acceptanceTime"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    <xsl:template match="payment">
        <xsl:if test="current()!='' or count(@*)&gt;0">
            <xsl:element name="v1:orderPayment">
                <xsl:attribute name="paymentId">
                    <xsl:value-of select="@paymentId"/>
                </xsl:attribute>                
                <xsl:if test="@actionCode != ''">
	                <xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="requestAmount"/>
                <xsl:apply-templates select="paymentMethodCode"/>
                <xsl:apply-templates select="bankPayment"/>
                <xsl:apply-templates select="paymentAttachment"/>
                <xsl:apply-templates select="creditCardPayment"/>
                <xsl:apply-templates select="debitCardPayment"/>
                <xsl:choose>
                    <xsl:when test="contains($channelId,'RETAIL')">
                        <v1:paymentChannelCode>
                            <xsl:value-of select="if (lower-case($isMobile) = 't' or lower-case($isMobile) = 'true') 
                                then 'MPOS' else 'RPOS'"/>
                        </v1:paymentChannelCode>
                    </xsl:when>
                    <xsl:otherwise>
                        <v1:paymentChannelCode>
                            <xsl:value-of select="$channelId"/>
                        </v1:paymentChannelCode>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:apply-templates select="specificationGroup"/>
                <xsl:apply-templates select="receivedPaymentId"/>
                <xsl:apply-templates select="receiptMethodCode"/>
                <xsl:apply-templates select="cardPresentIndicator"/>
                <xsl:apply-templates select="storePaymentMethodIndicator"/>
                <xsl:apply-templates select="settlementIndicator"/>
                <xsl:apply-templates select="terminalEntryCapability"/>
                <xsl:choose>
                    <xsl:when test="contains($channelId,'RETAIL')">
                        <v1:terminalType>
                            <xsl:value-of select="if (lower-case($isMobile) = 't' or lower-case($isMobile) = 'true') 
                                then 'MPOS' else 'POS'"/>
                        </v1:terminalType>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates select="terminalType"/>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:apply-templates select="terminalEntryMode"/>
                <xsl:apply-templates select="posConditionCode"/>
                <xsl:apply-templates select="posId"/>
                <xsl:apply-templates select="trackData"/>
                <xsl:apply-templates select="electronicAuthenticationCapability"/>
                <xsl:apply-templates select="tokenization"/>
                <xsl:apply-templates select="terminalID"/>
                <xsl:apply-templates select="isStoredPaymentMethodIndicator"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="paymentAttachment">
        <xsl:if test="current()!='' or count(@*)&gt;0">
            <xsl:element name="v1:{local-name()} ">
                <xsl:apply-templates select="embeddedData"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tokenization">
        <xsl:if test="current()!='' or count(@*)&gt;0">
            <xsl:element name="v1:{local-name()} ">
                <xsl:apply-templates select="encryptionTarget"/>
                <xsl:apply-templates select="encryptedContent"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    <xsl:template match="trackData">
        <xsl:if test="current()!='' or count(@*)&gt;0">
            <xsl:element name="v1:{local-name()} ">
                <xsl:apply-templates select="track1Data"/>
                <xsl:apply-templates select="track2Data"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    <xsl:template match="bankPayment">
        <xsl:if test="current()!='' or count(@*)&gt;0">
            <xsl:element name="v1:{local-name()} ">
                <xsl:apply-templates select="chargeAmount"/>
                <xsl:apply-templates select="payFromBankAccount"/>
                <xsl:apply-templates select="check"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="payFromBankAccount">
        <xsl:if test="current()!='' or count(@*)&gt;0">
            <xsl:element name="v1:{local-name()} ">
                <xsl:apply-templates select="name"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="check">
        <xsl:if test="current()!='' or count(@*)&gt;0">
            <xsl:element name="v1:{local-name()} ">
                <xsl:apply-templates select="accountNumber"/>
                <xsl:apply-templates select="routingNumber"/>
                <xsl:apply-templates select="checkNumber"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    <xsl:template match="creditCardPayment">
        <xsl:if test="current()!='' or count(@*)&gt;0">
            <xsl:element name="v1:{local-name()} ">
                <xsl:apply-templates select="authorizationId"/>
                <xsl:apply-templates select="chargeAmount"/>
                <xsl:apply-templates select="creditCard"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    <xsl:template match="creditCard">
        <xsl:if test="current()!='' or count(@*)&gt;0">
            <xsl:element name="v1:{local-name()} ">
                <xsl:apply-templates select="typeCode"/>
                <xsl:apply-templates select="cardNumber"/>
                <xsl:apply-templates select="cardHolderName"/>
                <xsl:apply-templates select="expirationMonthYear"/>
                <xsl:apply-templates select="cardHolderFirstName"/>
                <xsl:apply-templates select="cardHolderLastName"/>
                <xsl:apply-templates select="cardTypeIndicator"/>
                <xsl:apply-templates select="cardHolderBillingAddress"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    <xsl:template match="cardHolderBillingAddress">
        <xsl:if test="current()!='' or count(@*)&gt;0">
            <xsl:element name="v1:{local-name()} ">
                <xsl:apply-templates select="addressFormatType"/>
                <xsl:apply-templates select="addressLine1"/>
                <xsl:apply-templates select="addressLine2"/>
                <xsl:apply-templates select="cityName"/>
                <xsl:apply-templates select="stateCode"/>
                <xsl:apply-templates select="countryCode"/>
                <xsl:apply-templates select="postalCode"/>
                <xsl:apply-templates select="postalCodeExtension"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    <xsl:template match="debitCardPayment">
        <xsl:if test="current()!='' or count(@*)&gt;0">
            <xsl:element name="v1:{local-name()} ">
                <xsl:apply-templates select="chargeAmount"/>
                <xsl:apply-templates select="debitCard"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    <xsl:template match="debitCard">
        <xsl:if test="current()!='' or count(@*)&gt;0">
            <xsl:element name="v1:{local-name()} ">
                <xsl:apply-templates select="typeCode"/>
                <xsl:apply-templates select="cardNumber"/>
                <xsl:apply-templates select="cardHolderName"/>
                <xsl:apply-templates select="expirationMonthYear"/>
                <xsl:apply-templates select="cardHolderAddress"/>
                <xsl:apply-templates select="cardHolderFirstName"/>
                <xsl:apply-templates select="cardHolderLastName"/>
                <xsl:apply-templates select="PIN"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    <xsl:template match="cardHolderAddress">
        <xsl:if test="current()!='' or count(@*)&gt;0">
            <xsl:element name="v1:{local-name()} ">
                <xsl:apply-templates select="addressFormatType"/>
                <xsl:apply-templates select="addressLine1"/>
                <xsl:apply-templates select="addressLine2"/>
                <xsl:apply-templates select="cityName"/>
                <xsl:apply-templates select="stateCode"/>
                <xsl:apply-templates select="countryCode"/>
                <xsl:apply-templates select="postalCode"/>
                <xsl:apply-templates select="postalCodeExtension"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    <xsl:template match="chargeAmount">
        <xsl:if test="current()!='' or count(@*)>0">
            <xsl:element name="v1:{local-name()} ">
                <xsl:if test="@currencyCode !=''">
                    <xsl:attribute name="currencyCode">
                        <xsl:value-of select="@currencyCode"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="."/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    <xsl:template match="specificationGroup">
        <xsl:if test="current() != ''">
            <xsl:element name="v1:{local-name()} ">
                <xsl:apply-templates select="@name"/>
                <xsl:apply-templates select="specificationValue"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>    
    <xsl:template match="specificationValue">
        <xsl:if test="current() != '' or count(@*)">       
          <xsl:element name="v1:{local-name()} ">
              <xsl:if test="@name != ''">
                  <xsl:attribute name="name">
                      <xsl:value-of select="@name"/>
                  </xsl:attribute>
              </xsl:if>
              <xsl:value-of select="."/>
          </xsl:element>
        </xsl:if>
    </xsl:template>
   
    <xsl:template match="@*|node()">
        <xsl:choose>
            <xsl:when test=". instance of element()">
                <xsl:if test=".!=''">
                    <xsl:element name="v1:{local-name()} ">
                        <xsl:apply-templates select="@*|node()"/>
                    </xsl:element>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy>
                    <xsl:apply-templates select="@*|node()"/>
                </xsl:copy>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
