<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:v1="http://services.tmobile.com/OrderManagement/CartWSIL/V1"
	xmlns:saxon="http://saxon.sf.net/" exclude-result-prefixes="saxon">
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

	<xsl:param name="cartId"/>
	<xsl:param name="saveActionCode" select="'SAVE'"/>
	<xsl:param name="reviewActionCode" select="'REVIEW'"/>
	<xsl:param name="cancelActionCode" select="'REMOVE'"/>
	<xsl:param name="checkoutActionCode" select="'CHECKOUT'"/>
	<xsl:param name="ABFEntitlements"/>
	
	<!--<xsl:variable name="capientitlementprefix">v1</xsl:variable>
	<xsl:variable name="capientitlementns">http://services.tmobile.com/OrderManagement/CartWSIL/V1</xsl:variable>-->
	
	<xsl:variable name="capibaseprefix">base</xsl:variable>
	<xsl:variable name="capibase">http://services.tmobile.com/base</xsl:variable>

	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="no"
		omit-xml-declaration="yes"/>
	
	<xsl:template match="/">
		<xsl:variable name="statusCode" select="/status/cart/status/@statusCode"/>
				
		<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
			<soapenv:Header/>
			<soapenv:Body>
				<v1:updateCartRequest xmlns:base="http://services.tmobile.com/base" version="1">
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
					
					<xsl:element name="v1:cart">
						<xsl:attribute name="actionCode">
							<xsl:if test="$statusCode='Saved'">
								<xsl:value-of select="$saveActionCode"/>
							</xsl:if>
							<xsl:if test="$statusCode='Reviewed'">
								<xsl:value-of select="$reviewActionCode"/>
							</xsl:if>
							<xsl:if test="$statusCode='Cancelled'">
								<xsl:value-of select="$cancelActionCode"/>
							</xsl:if>
							<xsl:if test="$statusCode='CheckedOut'">
								<xsl:value-of select="$checkoutActionCode"/>
							</xsl:if>							
						</xsl:attribute>
						<xsl:attribute name="cartId">
							<xsl:value-of select="$cartId"/>
						</xsl:attribute>
						
						<xsl:element name="v1:status">
							<xsl:attribute name="statusCode">
								<xsl:value-of select="$statusCode"/>
							</xsl:attribute>
						</xsl:element>
					</xsl:element>
					
				</v1:updateCartRequest>
			</soapenv:Body>
		</soapenv:Envelope>
	</xsl:template>
	
</xsl:stylesheet>
