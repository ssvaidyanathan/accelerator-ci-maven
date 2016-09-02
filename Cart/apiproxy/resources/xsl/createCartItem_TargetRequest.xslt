<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:v1="http://services.tmobile.com/OrderManagement/CartWSIL/V1"
	xmlns:ent="http://services.tmobile.com/SecurityManagement/UserSecurityEnterprise/V1"
	xmlns:saxon="http://saxon.sf.net/" exclude-result-prefixes="saxon ent" version="2.0">

	<xsl:output method="xml" indent="yes" encoding="UTF-8" version="1.0" omit-xml-declaration="yes"/>	
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
	<xsl:param name="supervisorEntitlementsVar1"/>
	<xsl:param name="supervisorEntitlementsVar2"/>
	<xsl:param name="supervisorEntitlementsVar3"/>
	<xsl:param name="supervisorEntitlementsVar4"/>
	<xsl:param name="supervisorEntitlementsVar5"/>
	<xsl:param name="supervisorId1"/>
	<xsl:param name="supervisorId2"/>
	<xsl:param name="supervisorId3"/>
	<xsl:param name="supervisorId4"/>
	<xsl:param name="supervisorId5"/>
	
	<!--<xsl:variable name="capientitlementprefix">v1</xsl:variable>
	<xsl:variable name="capientitlementns">http://services.tmobile.com/OrderManagement/CartWSIL/V1</xsl:variable>>-->
	
	<xsl:variable name="capibaseprefix">base</xsl:variable>
	<xsl:variable name="capibase">http://services.tmobile.com/base</xsl:variable>
	<xsl:strip-space elements="*"/>


	<xsl:template match="/">
		<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
			<soapenv:Header/>
			<soapenv:Body>
				<v1:updateCartRequest version="1" xmlns:base="http://services.tmobile.com/base">
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
								<base:dealerCode>
									<xsl:value-of select="$scope"/>
								</base:dealerCode>
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
								<xsl:variable name="entitlementStr" select="replace(replace(replace(replace($ABFEntitlements,'TO_BE_REPLACED_PREFIX',$capientitlementprefix),'TO_BE_REPLACED_NAMESPACE',$capientitlementns),'TO_BE_REPLACED_BASE_NAMESPACE',$capibase),'TO_BE_REPLACED_BASE_PREFIX',$capibaseprefix)"/>
								<xsl:copy-of select="saxon:parse($entitlementStr)"/>
							</xsl:if>-->
							
							<xsl:if test="$ABFEntitlements">
								<xsl:variable name="entitlementStr" select="replace(replace($ABFEntitlements,'TO_BE_REPLACED_BASE_PREFIX',$capibaseprefix),'TO_BE_REPLACED_BASE_NAMESPACE',$capibase)"></xsl:variable>
								<xsl:copy-of select="saxon:parse($entitlementStr)" />
							</xsl:if>
							
							<xsl:if test="$supervisorEntitlementsVar1">
								<base:entitlements>
									<xsl:for-each select="saxon:parse($supervisorEntitlementsVar1)//ent:entitlement">
										<base:entitlement>
											<base:resourceName>
												<xsl:value-of select="./ent:resourceName"/>
											</base:resourceName>
											<base:actionName>
												<xsl:value-of select="./ent:actionName"/>
											</base:actionName>
											<base:isAccessAllowed>
												<xsl:value-of select="./ent:isAccessAllowed"/>
											</base:isAccessAllowed>
											<xsl:for-each select="./ent:responseAttribute">
												<base:responseAttribute>
													<xsl:copy-of select="./@*"/>
												</base:responseAttribute>
											</xsl:for-each>
										</base:entitlement>
									</xsl:for-each>
									<base:userId><xsl:value-of select="$supervisorId1"/></base:userId>
								</base:entitlements>
							</xsl:if>
							
							<xsl:if test="$supervisorEntitlementsVar2 and $supervisorId2 != $supervisorId1">
								<base:entitlements>
									<xsl:for-each select="saxon:parse($supervisorEntitlementsVar2)//ent:entitlement">
										<base:entitlement>
											<base:resourceName>
												<xsl:value-of select="./ent:resourceName"/>
											</base:resourceName>
											<base:actionName>
												<xsl:value-of select="./ent:actionName"/>
											</base:actionName>
											<base:isAccessAllowed>
												<xsl:value-of select="./ent:isAccessAllowed"/>
											</base:isAccessAllowed>
											<xsl:for-each select="./ent:responseAttribute">
												<base:responseAttribute>
													<xsl:copy-of select="./@*"/>
												</base:responseAttribute>
											</xsl:for-each>
										</base:entitlement>
									</xsl:for-each>
									<base:userId><xsl:value-of select="$supervisorId2"/></base:userId>
								</base:entitlements>
							</xsl:if>
							<xsl:if test="$supervisorEntitlementsVar3 and $supervisorId3 != $supervisorId2 and $supervisorId3 != $supervisorId1">
								<base:entitlements>
									<xsl:for-each select="saxon:parse($supervisorEntitlementsVar2)//ent:entitlement">
										<base:entitlement>
											<base:resourceName>
												<xsl:value-of select="./ent:resourceName"/>
											</base:resourceName>
											<base:actionName>
												<xsl:value-of select="./ent:actionName"/>
											</base:actionName>
											<base:isAccessAllowed>
												<xsl:value-of select="./ent:isAccessAllowed"/>
											</base:isAccessAllowed>
											<xsl:for-each select="./ent:responseAttribute">
												<base:responseAttribute>
													<xsl:copy-of select="./@*"/>
												</base:responseAttribute>
											</xsl:for-each>
										</base:entitlement>
									</xsl:for-each>
									<base:userId><xsl:value-of select="$supervisorId3"/></base:userId>
								</base:entitlements>
							</xsl:if>
							<xsl:if test="$supervisorEntitlementsVar4 and $supervisorId4 != $supervisorId3 and $supervisorId4 != $supervisorId2 and $supervisorId4 != $supervisorId1" >
								<base:entitlements>
									<xsl:for-each select="saxon:parse($supervisorEntitlementsVar2)//ent:entitlement">
										<base:entitlement>
											<base:resourceName>
												<xsl:value-of select="./ent:resourceName"/>
											</base:resourceName>
											<base:actionName>
												<xsl:value-of select="./ent:actionName"/>
											</base:actionName>
											<base:isAccessAllowed>
												<xsl:value-of select="./ent:isAccessAllowed"/>
											</base:isAccessAllowed>
											<xsl:for-each select="./ent:responseAttribute">
												<base:responseAttribute>
													<xsl:copy-of select="./@*"/>
												</base:responseAttribute>
											</xsl:for-each>
										</base:entitlement>
									</xsl:for-each>
									<base:userId><xsl:value-of select="$supervisorId4"/></base:userId>
								</base:entitlements>
							</xsl:if>
							<xsl:if test="$supervisorEntitlementsVar5 and $supervisorId5 != $supervisorId4 and $supervisorId5 != $supervisorId3 and $supervisorId5 != $supervisorId2 and $supervisorId5 != $supervisorId1" >
								<base:entitlements>
									<xsl:for-each select="saxon:parse($supervisorEntitlementsVar2)//ent:entitlement">
										<base:entitlement>
											<base:resourceName>
												<xsl:value-of select="./ent:resourceName"/>
											</base:resourceName>
											<base:actionName>
												<xsl:value-of select="./ent:actionName"/>
											</base:actionName>
											<base:isAccessAllowed>
												<xsl:value-of select="./ent:isAccessAllowed"/>
											</base:isAccessAllowed>
											<xsl:for-each select="./ent:responseAttribute">
												<base:responseAttribute>
													<xsl:copy-of select="./@*"/>
												</base:responseAttribute>
											</xsl:for-each>
										</base:entitlement>
									</xsl:for-each>
									<base:userId><xsl:value-of select="$supervisorId5"/></base:userId>
								</base:entitlements>			
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

	<!-- Cart child Elements -->
	<xsl:template match="cart">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@cartId">
					<xsl:attribute name="cartId">
						<xsl:value-of select="@cartId"/>
					</xsl:attribute>
				</xsl:if>				
                <xsl:apply-templates select="orderType"/>
				<xsl:apply-templates select="cartItem"/>
				<xsl:apply-templates select="addressList"/>
				<xsl:apply-templates select="validationMessage"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- cartItem -->
	<xsl:template match="cartItem">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@cartItemId">
					<xsl:attribute name="cartItemId">
						<xsl:value-of select="@cartItemId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="overridePriceAllowedIndicator"/>
				<xsl:apply-templates select="quantity"/>
				<!--xsl:apply-templates select="cartItemStatus"/-->
				<xsl:apply-templates select="rootParentCartItemId"/>
				<xsl:apply-templates select="effectivePeriod" mode="startTime"/>
				<xsl:apply-templates select="productOffering"/>
                <xsl:apply-templates select="assignedProduct"/>
				<xsl:apply-templates select="cartSchedule"/>
				<xsl:apply-templates select="specificationGroup"/>
				<xsl:apply-templates select="promotion"/>
				<xsl:apply-templates select="relatedCartItemId"/>
				<xsl:apply-templates select="lineOfService"/>
				<xsl:apply-templates select="networkResource"/>
				<xsl:apply-templates select="transactionType"/>
				<xsl:apply-templates select="inventoryStatus"/>
				<xsl:apply-templates select="deviceConditionQuestions"/>
				<xsl:apply-templates select="originalOrderLineId"/>
				<xsl:apply-templates select="deviceDiagnostics"/>
				<xsl:apply-templates select="reasonCode"/>
				<xsl:apply-templates select="returnAuthorizationType"/>
				<xsl:apply-templates select="revisionReason"/>
				<xsl:apply-templates select="priceChangedIndicator"/>
				<xsl:apply-templates select="financialAccount"/>
				<!-- xsl:apply-templates select="backendChangedIndicator"/ -->
				<xsl:apply-templates select="port"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- cartItem -->
	<xsl:template match="port">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="MSISDN"/>
				<xsl:apply-templates select="donorBillingSystem"/>
				<xsl:apply-templates select="donorAccountNumber"/>
				<xsl:apply-templates select="donorAccountPassword"/>
				<xsl:apply-templates select="oldServiceProvider"/>
				<xsl:apply-templates select="portDueTime"/>
				<xsl:apply-templates select="portRequestedTime"/>
				<xsl:apply-templates select="oldServiceProviderName"/>
				<xsl:apply-templates select="oldVirtualServiceProviderId"/>
				<xsl:apply-templates select="personProfile"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="personProfile">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="addressCommunication"  mode="port-personProfile"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="addressCommunication" mode="port-personProfile">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="address"  mode="port-personProfile"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>	
	
	<xsl:template match="address"  mode="port-personProfile">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="addressLine1"/>
				<xsl:apply-templates select="addressLine2"/>
				<xsl:apply-templates select="cityName"/>
				<xsl:apply-templates select="stateCode"/>
				<xsl:apply-templates select="countryCode"/>
				<xsl:apply-templates select="postalCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- cartItem -->
	<xsl:template match="financialAccount">
		<xsl:if test="current()!=''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="financialAccountNumber"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- cartItem -->
	<xsl:template match="deviceConditionQuestions">
		<xsl:if test="current()!=''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="verificationQuestion"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- cartItem -->
	<xsl:template match="verificationQuestion">
		<xsl:if test="current()!=''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="questionText"/>
				<xsl:apply-templates select="verificationAnswer"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- cartItem -->
	<xsl:template match="verificationAnswer">
		<xsl:if test="current()!=''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="answerText"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<!-- cartItem -->
	<xsl:template match="quantity">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@measurementUnit">
					<xsl:attribute name="measurementUnit">
						<xsl:value-of select="@measurementUnit"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- cartItem -->
	<xsl:template match="cartItemStatus|cartScheduleStatus">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- cartItem -->
	<xsl:template match="inventoryStatus">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="estimatedAvailable"/>
				<!--Need conformation-->
				<!--xsl:apply-templates select="estimatedAvailableDate"/-->
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="estimatedAvailable">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="startDate"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>



	<!-- create cart-->
	<xsl:template match="productOffering">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@productOfferingId">
					<xsl:attribute name="productOfferingId">
						<xsl:value-of select="@productOfferingId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="name"/>
				<xsl:apply-templates select="shortName"/>
				<xsl:apply-templates select="displayName"/>
				<xsl:apply-templates select="description" mode="productOffering-desc"/>
				<xsl:apply-templates select="shortDescription" mode="productOffering-shortDesc"/>
				<xsl:apply-templates select="longDescription"/>
				<xsl:apply-templates select="alternateDescription"/>
               	<xsl:apply-templates select="keyword" mode="productOffering-keyword"/>
				<xsl:apply-templates select="offerType"/>
				<xsl:apply-templates select="offerSubType"/>
				<xsl:apply-templates select="offerLevel"/>
				<xsl:apply-templates select="offeringClassification"/>
				<xsl:apply-templates select="businessUnit"/>
				<xsl:apply-templates select="productType"/>
				<xsl:apply-templates select="productSubType"/>
				<xsl:apply-templates select="key"/>
				<xsl:apply-templates select="specificationGroup"/>
				<xsl:apply-templates select="offeringPrice" mode="LOS"/>
				<xsl:apply-templates select="orderBehavior"/>
				<xsl:apply-templates select="image"/>
				<xsl:apply-templates select="marketingMessage"/>
				<xsl:apply-templates select="equipmentCharacteristics"/>
				<xsl:apply-templates select="serviceCharacteristics"/>
				<!-- xsl:apply-templates select="productType"/ -->
				<!-- xsl:apply-templates select="productSubType"/ -->
				<xsl:apply-templates select="offeringVariant"/>
                <xsl:apply-templates select="productOfferingComponent"/>
				<xsl:apply-templates select="productSpecification"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="productOffering" mode="LOS">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@productOfferingId">
					<xsl:attribute name="productOfferingId">
						<xsl:value-of select="@productOfferingId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="name"/>
				<xsl:apply-templates select="shortName"/>
				<xsl:apply-templates select="displayName"/>
				<xsl:apply-templates select="description" mode="productOffering-desc"/>
				<xsl:apply-templates select="shortDescription" mode="productOffering-shortDesc"/>
				<xsl:apply-templates select="longDescription"/>
				<xsl:apply-templates select="alternateDescription"/>
				<xsl:apply-templates select="keyword"/>
				<xsl:apply-templates select="offerType"/>
				<xsl:apply-templates select="offerSubType"/>
				<xsl:apply-templates select="offerLevel"/>
				<xsl:apply-templates select="offeringClassification"/>
				<xsl:apply-templates select="businessUnit"/>
				<xsl:apply-templates select="productType"/>
				<xsl:apply-templates select="productSubType"/>
				<xsl:apply-templates select="key"/>
				<xsl:apply-templates select="specificationGroup"/>
				<xsl:apply-templates select="offeringPrice"/>
				<xsl:apply-templates select="orderBehavior" mode="LOS"/>
				<xsl:apply-templates select="image"/>
				<xsl:apply-templates select="marketingMessage"/>
				<xsl:apply-templates select="equipmentCharacteristics"/>
				<xsl:apply-templates select="serviceCharacteristics"/>
				<xsl:apply-templates select="offeringVariant"/>
				<xsl:apply-templates select="productOfferingComponent"/>
				<xsl:apply-templates select="productSpecification" mode="LOS"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="serviceCharacteristics">
		<xsl:if test="current()!=''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="backDateAllowedIndicator"/>
				<xsl:apply-templates select="futureDateAllowedIndicator"/>
				<xsl:apply-templates select="backDateVisibleIndicator"/>
				<xsl:apply-templates select="futureDateVisibleIndicator"/>
				<xsl:apply-templates select="includedServiceCapacity"/>
				<xsl:apply-templates select="billEffectiveCode"/>
				<xsl:apply-templates select="billableThirdPartyServiceIndicator"/>
				<xsl:apply-templates select="prorateAllowedIndicator"/>
				<xsl:apply-templates select="prorateVisibleIndicator"/>
				<xsl:apply-templates select="duration"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="equipmentCharacteristics">
		<xsl:if test="current()!=''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="model"/>
				<xsl:apply-templates select="manufacturer"/>
				<xsl:apply-templates select="color"/>
				<xsl:apply-templates select="memory"/>
				<xsl:apply-templates select="tacCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="includedServiceCapacity">
		<xsl:if test="current()!=''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="capacityType"/>
				<xsl:apply-templates select="capacitySubType"/>
				<xsl:apply-templates select="unlimitedIndicator"/>
				<xsl:apply-templates select="size"/>
				<xsl:apply-templates select="measurementUnit"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template
		match="feeOverrideAllowed|prorateVisibleIndicator|prorateAllowedIndicator|billableThirdPartyServiceIndicator|unlimitedIndicator|backDateAllowedIndicator|futureDateAllowedIndicator|backDateVisibleIndicator|futureDateVisibleIndicator">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="marketingMessage">
		<xsl:if test="current()!=''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="salesChannelCode"/>
				<xsl:apply-templates select="relativeSize"/>
				<xsl:apply-templates select="messagePart"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="messagePart">
		<xsl:if test="current()!=''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="code"/>
				<xsl:apply-templates select="messageText"/>
				<xsl:apply-templates select="messageSequence"/>

			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="messageText">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@languageCode">
					<xsl:attribute name="languageCode">
						<xsl:value-of select="@languageCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="offeringClassification">
		<xsl:if test="current()!=''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="classificationCode"/>
				<xsl:apply-templates select="nameValue"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- cartItem -->
	<xsl:template match="longDescription|alternateDescription">
		<xsl:if test="current()!=''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="descriptionCode"/>
				<xsl:apply-templates select="salesChannelCode"/>
				<xsl:apply-templates select="languageCode"/>
				<xsl:apply-templates select="relativeSize"/>
				<xsl:apply-templates select="contentType"/>
				<xsl:apply-templates select="descriptionText"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- cartItem -->
	<xsl:template match="offeringStatus">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="effectivePeriod"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- cartItem -->
	<xsl:template match="specificationGroup">
		<xsl:if test="current()!='' or @name">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="specificationValue"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- cartItem -->
	<xsl:template match="specificationValue">
		<xsl:if test="current()!='' or @name">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="productOfferingComponent">
		<xsl:if test="current()!='' or @offeringComponentId">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@offeringComponentId">
					<xsl:attribute name="offeringComponentId">
						<xsl:value-of select="@offeringComponentId"/>
					</xsl:attribute>
				</xsl:if>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="description" mode="productOffering-desc">
		<xsl:if test="not(empty(.))">
			<xsl:element name="v1:{local-name()} ">
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
		</xsl:if>
	</xsl:template>

	<xsl:template match="shortDescription" mode="productOffering-shortDesc">
		<xsl:if test="not(empty(.))">
			<xsl:element name="v1:{local-name()} ">
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
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="effectivePeriod">
		<xsl:if test="not(empty(.))">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="startTime"/>
				<xsl:apply-templates select="endTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="effectivePeriod" mode="startTime">
		<xsl:if test="not(empty(.))">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="startTime"/>
				<xsl:apply-templates select="endTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="effectivePeriod" mode="LOS_AssignedProduct_EffectivePeriod">
		<xsl:if test="not(empty(.))">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="startTime"/>
				<xsl:apply-templates select="endTime"/>
				<xsl:apply-templates select="usageContext"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="addressCommunication" mode="addressList">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
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

	<!-- create cart -->
	<xsl:template match="communicationStatus">
		<xsl:if test="current()!='' or count(@*)>0">
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
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart -->
	<xsl:template match="addressCommunication">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
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
				<xsl:apply-templates select="privacyProfile"/>
				<xsl:apply-templates select="address" mode="LOS"/>
				<xsl:apply-templates select="usageContext"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="address" mode="LOS">
		<xsl:if test="current()!=''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="key"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="privacyProfile">
		<xsl:if test="current()!=''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="optOut"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="key">
		<xsl:if test="current()!='' or count(@*)>0">
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
		<xsl:if test="current()!=''">
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
				<xsl:apply-templates select="building"/>
				<xsl:apply-templates select="floor"/>
				<xsl:apply-templates select="area"/>
				<xsl:apply-templates select="ruralRoute"/>
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
				<xsl:apply-templates select="postOfficeBox"/>
				<xsl:apply-templates select="observesDaylightSavingsIndicator"/>
				<xsl:apply-templates select="matchIndicator"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="geoCodeID">
		<xsl:if test="current()!='' or count(@*)>0">
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

	<xsl:template match="geographicCoordinates">
		<xsl:if test="current()!=''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="latitude"/>
				<xsl:apply-templates select="longitude"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="cartSchedule">
		<xsl:if test="current()!=''">
			<xsl:element name="v1:{local-name()} ">
				<!--xsl:if test="@cartScheduleId">
					<xsl:attribute name="cartScheduleId">
						<xsl:value-of select="@cartScheduleId"/>
					</xsl:attribute>
				</xsl:if-->
				<!--xsl:apply-templates select="description"/-->
				<xsl:apply-templates select="cartScheduleStatus"/>
				<xsl:apply-templates select="cartScheduleCharge"/>
				<!--xsl:apply-templates select="cartScheduleDeduction"/>
				<xsl:apply-templates select="cartScheduleTax"/-->
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="cartScheduleTax">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="code"/>
				<xsl:apply-templates select="taxJurisdiction"/>
				<xsl:apply-templates select="amount"/>
				<xsl:apply-templates select="typeCode"/>
				<xsl:apply-templates select="description"/>
				<xsl:apply-templates select="taxRate"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="cartScheduleCharge">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="typeCode"/>
				<xsl:apply-templates select="chargeFrequencyCode"/>
				<xsl:apply-templates select="amount"/>
				<xsl:apply-templates select="reason"/>
				<xsl:apply-templates select="effectivePeriod" mode="effectivePeriod-cartScheduleCharge"/>
				<xsl:apply-templates select="description" mode="description-cartScheduleCharge"/>
				<xsl:apply-templates select="chargeCode"/>
				<xsl:apply-templates select="waiverIndicator"/>
				<xsl:apply-templates select="waiverReason"/>
				<xsl:apply-templates select="manuallyAddedCharge"/>
				<!--xsl:apply-templates select="feeOverrideAllowed"/>
				<xsl:apply-templates select="overrideThresholdPercent"/>
				<xsl:apply-templates select="overrideThresholdAmount"/-->
				<xsl:apply-templates select="supervisorID"/>
				<xsl:apply-templates select="overrideAmount"/>
				<xsl:apply-templates select="overrideReason"/>
				<xsl:apply-templates select="productOfferingPriceId"/>
				<xsl:apply-templates select="proratedIndicator"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="effectivePeriod" mode="effectivePeriod-cartScheduleCharge">
		<xsl:if test="not(empty(.))">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="startTime"/>
				<xsl:apply-templates select="endTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="description" mode="description-cartScheduleCharge">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@usageContext !=''">
					<xsl:attribute name="usageContext">
						<xsl:value-of select="@usageContext"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="cartScheduleDeduction">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="amount"/>
				<xsl:apply-templates select="reason"/>
				<xsl:apply-templates select="description"/>
				<xsl:apply-templates select="recurringFrequency"/>
				<xsl:apply-templates select="promotion" mode="cartScheduleDeduction_promotion"/>
				<xsl:apply-templates select="chargeCode"/>
				<xsl:apply-templates select="productOfferingPriceId"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="promotion" mode="cartScheduleDeduction_promotion">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@promotionId">
					<xsl:attribute name="promotionId">
						<xsl:value-of select="@promotionId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="lineOfService">
		<xsl:if test="current()!='' or @lineOfServiceId or @actionCode">
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
                		<xsl:apply-templates select="networkResource"/>
				<!--xsl:apply-templates select="pin"/>
				<xsl:apply-templates select="lineOfServiceStatus"/-->
				<xsl:apply-templates select="primaryLineIndicator"/>
				<xsl:apply-templates select="lineAlias"/>
				<xsl:apply-templates select="lineSequence"/>
				<xsl:apply-templates select="assignedProduct"/>
				<xsl:apply-templates select="effectivePeriod"/>
				<xsl:apply-templates select="memberLineOfService"/>                		
                <xsl:apply-templates select="preferredLanguage"/>
				<xsl:apply-templates select="specificationGroup"/>
				<xsl:apply-templates select="privacyProfile" mode="lineOfService" />
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="privacyProfile" mode="lineOfService">
		<xsl:if test="normalize-space(.) !=''">
			<v1:privacyProfile>
				<xsl:if test="normalize-space(optOut) !=''">
					<v1:optOut>
						<xsl:value-of select="optOut"/>
					</v1:optOut>
				</xsl:if>
				<xsl:if test="normalize-space(activityType) !=''">
					<v1:activityType>
						<xsl:value-of select="activityType"/>
					</v1:activityType>
				</xsl:if>
			</v1:privacyProfile>           
		</xsl:if>
	</xsl:template>
	
	<!-- R1.6.4 -->	
	<xsl:template match="preferredLanguage">
        <xsl:if test="current() != '' or @usageContext != ''">
        	<xsl:element name="v1:{local-name()} ">
                <xsl:if test="@usageContext">
                    <xsl:attribute name="usageContext" select="@usageContext"/>
                </xsl:if>  
        		<xsl:value-of select="."/>
        	</xsl:element>
        </xsl:if>
    </xsl:template>

	<xsl:template match="memberLineOfService">
		<xsl:if test="current()!=''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="primaryLineIndicator"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="assignedProduct">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="productOffering" mode="LOS"/>
				<xsl:apply-templates select="effectivePeriod"
					mode="LOS_AssignedProduct_EffectivePeriod"/>
				<xsl:apply-templates select="customerOwnedIndicator"/>
				<xsl:apply-templates select="eligibilityEvaluation"/>
				<xsl:apply-templates select="warranty"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="eligibilityEvaluation">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="overrideIndicator"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="overrideIndicator">
		<xsl:if test="current()!='' or @name">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="warranty">
		<xsl:if test="current()!=''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="warrantyExpirationDate"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="lineOfServiceStatus">
		<xsl:if test="current()!=''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="reasonCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="subscriberContact">
		<xsl:if test="current()!=''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="personName"/>
				<xsl:apply-templates select="addressCommunication"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- cartItem -->
	<xsl:template match="offeringVariant">
		<xsl:if test="current()!=''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="sku"/>
				<xsl:apply-templates select="specificationGroup"/>
				<xsl:apply-templates select="offeringVariantPrice"/>
				<xsl:apply-templates select="productCondition"/>
				<xsl:apply-templates select="color"/>
				<xsl:apply-templates select="memory"/>
				<xsl:apply-templates select="tacCode"/>
				<xsl:apply-templates select="orderBehavior" mode="LOS"/>

			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- cartItem -->
	<xsl:template match="offeringVariantPrice">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@priceListLineId">
					<xsl:attribute name="priceListLineId">
						<xsl:value-of select="@priceListLineId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="name"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="image">
		<xsl:if test="current()!=''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="URI"/>
				<xsl:apply-templates select="sku"/>
				<xsl:apply-templates select="imageDimensions"/>
				<xsl:apply-templates select="displayPurpose"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="orderBehavior" mode="LOS">
		<xsl:if test="current()!=''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="preOrderAllowedIndicator"/>
				<xsl:apply-templates select="preOrderAvailableTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- cartItem -->
	<xsl:template match="orderBehavior">
		<xsl:if test="current()!=''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="preOrderAllowedIndicator"/>
				<xsl:apply-templates select="preOrderAvailableTime"/>
				<xsl:apply-templates select="saleStartTime"/>
				<xsl:apply-templates select="saleEndTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="preOrderAllowedIndicator" mode="LOS">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="preOrderAllowedIndicator">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="promotion">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<!--xsl:if test="@promotionId">
					<xsl:attribute name="promotionId">
						<xsl:value-of select="@promotionId"/>
					</xsl:attribute>
				</xsl:if-->
				<!--xsl:apply-templates select="promotionName"/-->
				<xsl:apply-templates select="promotionCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<!-- cartItem -->
	<xsl:template match="offeringPrice">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@priceListLineId">
					<xsl:attribute name="priceListLineId">
						<xsl:value-of select="@priceListLineId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="name"/>
				<xsl:apply-templates select="productOfferingPrice"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="offeringPrice" mode="LOS">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@priceListLineId">
					<xsl:attribute name="priceListLineId">
						<xsl:value-of select="@priceListLineId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="name"/>
				<xsl:apply-templates select="productOfferingPrice" mode="LOS"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="productOfferingPrice">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="name"/>
				<xsl:apply-templates select="productChargeType"/>
				<xsl:apply-templates select="productChargeIncurredType"/>
				<xsl:apply-templates select="basisAmount"/>
				<xsl:apply-templates select="amount"/>
				<xsl:apply-templates select="oneTimeCharge"/>
				<xsl:apply-templates select="recurringFeeFrequency"/>
				<xsl:apply-templates select="taxInclusiveIndicator"/>
				<xsl:apply-templates select="specificationValue"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- cartItem -->
	<xsl:template match="productOfferingPrice" mode="LOS">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="name"/>
				<xsl:apply-templates select="productChargeType"/>
				<xsl:apply-templates select="productChargeIncurredType"/>
				<xsl:apply-templates select="amount"/>
				<xsl:apply-templates select="oneTimeCharge"/>
				<!--xsl:apply-templates select="recurringFeeFrequency"/-->
				<xsl:apply-templates select="taxInclusiveIndicator"/>
				<xsl:apply-templates select="specificationValue"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

    <xsl:template match="amount|overrideAmount|overrideThresholdAmount|basisAmount">
        <xsl:if test="current()!='' or count(@*)>0">
            <xsl:element name="v1:{local-name()} ">
                <xsl:if test="@currencyCode">
                    <xsl:attribute name="currencyCode">
                        <xsl:value-of select="@currencyCode"/>
                    </xsl:attribute>
                </xsl:if>
            	<xsl:value-of select="."/>
            </xsl:element>
          
        </xsl:if>
    </xsl:template>

	<xsl:template match="productSpecification">
		<xsl:if test="current()!='' or @actionCode or @productSpecificationId">
			<xsl:element name="v1:{local-name()} ">
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
				<xsl:apply-templates select="name"/>
				<xsl:apply-templates select="keyword"/>
				<xsl:apply-templates select="productType"/>
				<xsl:apply-templates select="productSubType"/>
                		<xsl:apply-templates select="additionalSpecification"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="productSpecification" mode="LOS">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
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
				<xsl:apply-templates select="name"/>
				<xsl:apply-templates select="keyword"/>
				<xsl:apply-templates select="productType"/>
				<xsl:apply-templates select="productSubType"/>
				<xsl:apply-templates select="additionalSpecification"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="keyword">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
    <xsl:template match="keyword" mode="productOffering-keyword">
        <xsl:if test="current()!='' or count(@*)>0">
            <xsl:element name="v1:{local-name()} ">
                <xsl:if test="@name">
                    <xsl:attribute name="name">
                        <xsl:value-of select="@name"/>
                    </xsl:attribute>
                </xsl:if>
            	<xsl:value-of select="."/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

	<xsl:template match="additionalSpecification">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="specificationValue"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="networkResource">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="imei"/>
				<xsl:apply-templates select="sim"/>
				<xsl:apply-templates select="mobileNumber"/>
				<xsl:apply-templates select="resourceSpecification"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<!-- R1.6.4 -->	
	<xsl:template match="resourceSpecification">
        <xsl:if test="current() != '' or @name != ''">
        	<xsl:element name="v1:{local-name()} ">
                <xsl:if test="@name">
                    <xsl:attribute name="name" select="@name"/>
                </xsl:if>
                <xsl:apply-templates select="specificationValue"
                    mode="resourseSpecification-specificationValue"/>                
        	</xsl:element>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="specificationValue" mode="resourseSpecification-specificationValue">
        <xsl:if test="node() != ''">
        	<xsl:element name="v1:{local-name()} ">
                <xsl:value-of select="."/>
        	</xsl:element>
        </xsl:if>
    </xsl:template>

	<xsl:template match="sim">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="imsi"/>
				<xsl:apply-templates select="simNumber"/>
				<xsl:apply-templates select="simType"/>
				<xsl:apply-templates select="virtualSim"/>
				<xsl:apply-templates select="embeddedSIMIndicator"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="mobileNumber">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="msisdn"/>
				<xsl:apply-templates select="portIndicator"/>
				<xsl:apply-templates select="portReason"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="addressList">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="addressCommunication" mode="addressList"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- CD 1.6.4-->
	<xsl:template match="validationMessage">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="messageType"/>
				<xsl:apply-templates select="messageCode"/>
				<xsl:apply-templates select="messageText"/>
				<xsl:apply-templates select="messageSource"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="@*|node()">
		<xsl:choose>
			<xsl:when test=". instance of element()">
				<xsl:if test="current()!='' or count(@*)>0">
					<xsl:element name="{concat('v1:',local-name())}">
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