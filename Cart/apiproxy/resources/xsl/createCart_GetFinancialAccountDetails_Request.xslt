<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" exclude-result-prefixes="xsl pfx5 saxon" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:pfx5="http://services.tmobile.com/CustomerManagement/FinancialAccountDetailsWSIL/V1" xmlns:saxon="http://saxon.sf.net/">
   <xsl:param name="serviceTransactionId"/>
   <xsl:param name="userId"/>
   <xsl:param name="interactionId"/>
   <xsl:param name="sessionId"/>
   <xsl:param name="activityId"/>
   <xsl:param name="channelId"/>
   <xsl:param name="applicationId"/>
   <xsl:param name="applicationUserId"/>
   <xsl:param name="senderId"/>
   <xsl:param name="workflowId"/>
   <xsl:param name="storeId"/>
   <xsl:param name="timestamp"/>
   <xsl:param name="dealerCode"/>
   <xsl:param name="scope"/>
   <xsl:param name="masterDealerCode"/>
   <xsl:param name="systemId"/>
   <xsl:param name="userCompanyId"/>
   <xsl:param name="customerCompanyId"/>
   <xsl:param name="servicePartnerId"/>
   <xsl:param name="contextId"/>
   <xsl:param name="id"/>
   <xsl:param name="transactionType"/>
   <xsl:param name="customerId"/>
   <xsl:param name="financialAccountNumber"/>
   <xsl:param name="lineOfServiceId"/>
   <xsl:param name="ABFEntitlements"/>
   <xsl:param name="MSISDN"/>   
   <xsl:variable name="capibaseprefix">base</xsl:variable>
   <xsl:variable name="capibase">http://services.tmobile.com/base</xsl:variable>
   <xsl:template match="/">
      <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
         <soapenv:Header/>
         <soapenv:Body>
            <pfx5:getFinancialAccountDetailsRequest>
               <xsl:if test="$serviceTransactionId">
                  <xsl:attribute name="serviceTransactionId">
                     <xsl:value-of select="$serviceTransactionId"/>
                  </xsl:attribute>
               </xsl:if>
               <base:header xmlns:base="http://services.tmobile.com/base">
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
                     
                     <xsl:if test="$ABFEntitlements">
                        <xsl:variable name="entitlementStr" select="replace(replace($ABFEntitlements,'TO_BE_REPLACED_BASE_PREFIX',$capibaseprefix),'TO_BE_REPLACED_BASE_NAMESPACE',$capibase)"></xsl:variable>
                        <xsl:copy-of select="saxon:parse($entitlementStr)" />
                     </xsl:if>
                  </base:sender>
                  <xsl:if test="(string-length($systemId)>0) or (string-length($userId)>0) or (string-length($transactionType)>0) or (string-length($userCompanyId)>0) or (string-length($customerCompanyId)>0) or (string-length($servicePartnerId)>0)">
                     <base:target>
                        <xsl:if test="(string-length($systemId)>0) or (string-length($userId)>0)">
                           <base:targetSystemId>
                              <base:systemId>
                                 <xsl:value-of select="$systemId"/>
                              </base:systemId>
                              <base:userId>
                                 <xsl:value-of select="$userId"/>
                              </base:userId>
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
                  <xsl:if test="(string-length($id)>0) or (string-length($contextId)>0)">
                     <base:providerId>
                        <xsl:if test="$id">
                           <base:id>
                              <xsl:value-of select="$id"/>
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
               <pfx5:MSISDN>
                  <xsl:value-of select="$MSISDN"/>
               </pfx5:MSISDN>
            </pfx5:getFinancialAccountDetailsRequest>
         </soapenv:Body>
      </soapenv:Envelope>
   </xsl:template>
</xsl:stylesheet>