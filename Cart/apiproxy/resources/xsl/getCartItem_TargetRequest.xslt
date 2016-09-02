<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xml="http://www.w3.org/XML/1998/namespace"
    xmlns:saxon="http://saxon.sf.net/" exclude-result-prefixes="saxon" >

    <xsl:param name="senderId"/>
    <xsl:param name="channelId"/>
    <xsl:param name="applicationId"/>
    <xsl:param name="applicationUserId"/>
    <xsl:param name="scope"/>
    <xsl:param name="userId"/>
    <xsl:param name="sessionId"/>
    <xsl:param name="workflowId"/>
    <xsl:param name="activityId"/>
    <xsl:param name="timestamp"/>
    <xsl:param name="storeId"/>
    <xsl:param name="dealerCode"/>
    <xsl:param name="cartid"/>
    <xsl:param name="interactionId"/>
    <xsl:param name="serviceTransactionId"/>
    <xsl:param name="masterDealerCode"/>
    <xsl:param name="systemId"/>
    <xsl:param name="userCompanyId"/>
    <xsl:param name="customerCompanyId"/>
    <xsl:param name="servicePartnerId"/>
    <xsl:param name="transactionType"/>
    <xsl:param name="providerId"/>
    <xsl:param name="contextId"/>
    
    <xsl:param name="ABFEntitlements"/>
    
    <!--<xsl:variable name="capientitlementprefix">v1</xsl:variable>
    <xsl:variable name="capientitlementns">http://services.tmobile.com/OrderManagement/CartWSIL/V1</xsl:variable>-->
    
    <xsl:variable name="capibaseprefix">base</xsl:variable>
	<xsl:variable name="capibase">http://services.tmobile.com/base</xsl:variable>

    <xsl:template match="/">
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
            <soapenv:Header/>
            <soapenv:Body>
                <v1:getCartDetailsRequest
                    xmlns:v1="http://services.tmobile.com/OrderManagement/CartWSIL/V1"
                    xmlns:base="http://services.tmobile.com/base" version="1">
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
								<xsl:variable name="entitlementStr"  select="replace(replace(replace(replace($ABFEntitlements,'TO_BE_REPLACED_PREFIX',$capientitlementprefix),'TO_BE_REPLACED_NAMESPACE',$capientitlementns),'TO_BE_REPLACED_BASE_NAMESPACE',$capibase),'TO_BE_REPLACED_BASE_PREFIX',$capibaseprefix)"/>
								<xsl:copy-of select="saxon:parse($entitlementStr)"/>
							</xsl:if>-->
							
                            <xsl:if test="$ABFEntitlements">
                                <xsl:variable name="entitlementStr" select="replace(replace($ABFEntitlements,'TO_BE_REPLACED_BASE_PREFIX',$capibaseprefix),'TO_BE_REPLACED_BASE_NAMESPACE',$capibase)"></xsl:variable>
                                <xsl:copy-of select="saxon:parse($entitlementStr)" />
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
                    <xsl:if test="string-length($cartid) > 0">
                        <v1:cartId>
                            <xsl:value-of select="$cartid"/>
                        </v1:cartId>
                    </xsl:if>
                </v1:getCartDetailsRequest>
            </soapenv:Body>
        </soapenv:Envelope>
    </xsl:template>
</xsl:stylesheet>
