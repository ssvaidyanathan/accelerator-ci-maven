<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:base="http://services.tmobile.com/base"
	xmlns:v1="http://services.tmobile.com/SecurityManagement/UserSecurityEnterprise/V1">
	<xsl:output method="xml" indent="yes" encoding="UTF-8" version="1.0" omit-xml-declaration="yes"/>
	<xsl:strip-space elements="*"/>

	<xsl:param name="senderid"/>
	<xsl:param name="channelid"/>
	<xsl:param name="applicationid"/>
	<xsl:param name="applicationUserid"/>
	<xsl:param name="sessionid"/>
	<xsl:param name="workflowid"/>
	<xsl:param name="activityid"/>
	<xsl:param name="timestamp"/>
	<xsl:param name="storeId"/>
	<xsl:param name="dealerCode"/>
	<xsl:param name="scope"/>
	<xsl:param name="interactionid"/>
	<xsl:param name="id"/>
	<xsl:param name="portRequestid"/>
	<xsl:param name="serviceTransactionId"/>
	<xsl:param name="masterDealerCode"/>
	<xsl:param name="systemid"/>
	<xsl:param name="userId"/>
	<xsl:param name="userCompanyId"/>
	<xsl:param name="customerCompanyId"/>
	<xsl:param name="servicePartnerId"/>
	<xsl:param name="transactionType"/>
	<xsl:param name="contextId"/>
	<xsl:param name="providerId"/>
	<xsl:param name="exclude"/>
	<xsl:param name="authcustomerid"/>
	<xsl:param name="authfinancialaccountid"/>
	<xsl:param name="authlineofserviceid"/>
	
	

	<xsl:template match="/">
		<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
			<soapenv:Header/>
			<soapenv:Body>
				<xsl:if test="string-length($applicationUserid) gt 0">
					<v1:getUserEntitlementsRequest>
						<xsl:attribute name="serviceTransactionId">
							<xsl:value-of select="$serviceTransactionId"/>
						</xsl:attribute>
						<base:header>
							<base:sender>
								<base:senderId>
									<xsl:value-of select="$senderid"/>
								</base:senderId>
								<base:channelId>
									<xsl:value-of select="$channelid"/>
								</base:channelId>
								<base:applicationId>
									<xsl:value-of select="$applicationid"/>
								</base:applicationId>
								<base:applicationUserId>
									<xsl:value-of select="$applicationUserid"/>
								</base:applicationUserId>
								<base:sessionId>
									<xsl:value-of select="$sessionid"/>
								</base:sessionId>
								<base:workflowId>
									<xsl:value-of select="$workflowid"/>
								</base:workflowId>
								<base:activityId>
									<xsl:value-of select="$activityid"/>
								</base:activityId>
								<base:timestamp>
									<xsl:value-of select="current-dateTime()"/>
								</base:timestamp>
								<base:storeId>
									<xsl:value-of select="$storeId"/>
								</base:storeId>
								<base:dealerCode>
									<xsl:value-of select="$dealerCode"/>
								</base:dealerCode>
								<base:scope>
									<xsl:value-of select="$scope"/>
								</base:scope>

								<xsl:if test="$interactionid">
									<base:interactionId>
										<xsl:value-of select="$interactionid"/>
									</base:interactionId>
								</xsl:if>

								<xsl:if test="$masterDealerCode">
									<base:masterDealerCode>
										<xsl:value-of select="$masterDealerCode"/>
									</base:masterDealerCode>
								</xsl:if>
							</base:sender>

							<xsl:if
								test="$systemid or $userId or $userCompanyId or $customerCompanyId or $servicePartnerId or $transactionType">
								<base:target>
									<xsl:if test="$systemid or $userId">
										<base:targetSystemId>
											<xsl:if test="$systemid">
												<base:systemId>
												<xsl:value-of select="$systemid"/>
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
						<v1:userName><xsl:value-of select="$applicationUserid"/></v1:userName>
						<xsl:if test="/entitlementsDetails/dealerCode or entitlementsDetails/masterDealerCode">
							<v1:dealerInfo>
								<xsl:if test="/entitlementsDetails/storeId">
									<xsl:attribute name="id">
										<xsl:value-of select="/entitlementsDetails/storeId"/>
									</xsl:attribute>
								</xsl:if>
								<xsl:if test="/entitlementsDetails/dealerCode">
									<v1:dealerCode>
										<xsl:value-of select="/entitlementsDetails/dealerCode"/>
									</v1:dealerCode>
								</xsl:if>
								<xsl:if test="/entitlementsDetails/masterDealerCode">
									<v1:masterDealerCode>
										<xsl:value-of select="/entitlementsDetails/masterDealerCode"/>
									</v1:masterDealerCode>
								</xsl:if>
							</v1:dealerInfo>
						</xsl:if>
					</v1:getUserEntitlementsRequest>
				</xsl:if>
				
				<xsl:if test="string-length($authcustomerid) gt 0">
					<v1:getCustomerEntitlementsRequest>
						<xsl:attribute name="serviceTransactionId">
							<xsl:value-of select="$serviceTransactionId"/>
						</xsl:attribute>
						<base:header>
							<base:sender>
								<base:senderId>
									<xsl:value-of select="$senderid"/>
								</base:senderId>
								<base:channelId>
									<xsl:value-of select="$channelid"/>
								</base:channelId>
								<base:applicationId>
									<xsl:value-of select="$applicationid"/>
								</base:applicationId>
								<base:applicationUserId>
									<xsl:value-of select="$applicationUserid"/>
								</base:applicationUserId>
								<base:sessionId>
									<xsl:value-of select="$sessionid"/>
								</base:sessionId>
								<base:workflowId>
									<xsl:value-of select="$workflowid"/>
								</base:workflowId>
								<base:activityId>
									<xsl:value-of select="$activityid"/>
								</base:activityId>
								<base:timestamp>
									<xsl:value-of select="current-dateTime()"/>
								</base:timestamp>
								<base:storeId>
									<xsl:value-of select="$storeId"/>
								</base:storeId>
								<base:dealerCode>
									<xsl:value-of select="$dealerCode"/>
								</base:dealerCode>
								<base:scope>
									<xsl:value-of select="$scope"/>
								</base:scope>
								
								<xsl:if test="$interactionid">
									<base:interactionId>
										<xsl:value-of select="$interactionid"/>
									</base:interactionId>
								</xsl:if>
								
								<xsl:if test="$masterDealerCode">
									<base:masterDealerCode>
										<xsl:value-of select="$masterDealerCode"/>
									</base:masterDealerCode>
								</xsl:if>
							</base:sender>
							
							<xsl:if
								test="$systemid or $userId or $userCompanyId or $customerCompanyId or $servicePartnerId or $transactionType">
								<base:target>
									<xsl:if test="$systemid or $userId">
										<base:targetSystemId>
											<xsl:if test="$systemid">
												<base:systemId>
													<xsl:value-of select="$systemid"/>
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
						<v1:customerId>
							<xsl:value-of select="$authcustomerid"/>
						</v1:customerId>
						<v1:financialAccountNumber>
							<xsl:value-of select="$authfinancialaccountid"/>
						</v1:financialAccountNumber>
						<xsl:for-each select="/entitlementsDetails/securityProfile/lineOfService/networkResource">
							<xsl:if test="/entitlementsDetails/securityProfile/lineOfService/networkResource/mobileNumber/msisdn">
								<v1:MSISDN>
									<xsl:value-of select="/entitlementsDetails/securityProfile/lineOfService/networkResource/mobileNumber/msisdn"/>
								</v1:MSISDN>
							</xsl:if>
						</xsl:for-each>
					</v1:getCustomerEntitlementsRequest>
				</xsl:if>
				

			</soapenv:Body>
		</soapenv:Envelope>
	</xsl:template>
</xsl:stylesheet>
