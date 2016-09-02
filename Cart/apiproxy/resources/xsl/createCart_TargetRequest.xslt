<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:v1="http://services.tmobile.com/OrderManagement/CartWSIL/V1"
	xmlns:base="http://services.tmobile.com/base" xmlns:saxon="http://saxon.sf.net/"
	xmlns:ent="http://services.tmobile.com/SecurityManagement/UserSecurityEnterprise/V1"
	exclude-result-prefixes="saxon" version="2.0">


	<xsl:output method="xml" indent="no" encoding="ISO-8859-1" version="1.0"
		omit-xml-declaration="yes"/>

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
	<xsl:param name="channelCode"/>
	<xsl:param name="subChannelCode"/>
	<xsl:param name="category"/>

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
	<xsl:param name="customerId"/>
	<xsl:param name="financialAccountNumber"/>

	<xsl:param name="app_channelCode"/>
	<xsl:param name="app_subChannelCode"/>
	<xsl:param name="app_category"/>
	<xsl:param name="tokenScope"/>


	<xsl:variable name="orderType" as="xs:string">
		<xsl:value-of select="/cart/orderType"/>
	</xsl:variable>
	
	<xsl:variable name="custFinActionCode" as="xs:string">
		<xsl:value-of select="/cart/billTo/customerAccount/financialAccount/@actionCode"/>
	</xsl:variable>
	
		
	<!--<xsl:variable name="capientitlementprefix">v1</xsl:variable>
                <xsl:variable name="capientitlementns"
                                >http://services.tmobile.com/OrderManagement/CartWSIL/V1</xsl:variable>-->

	<xsl:variable name="capibaseprefix">base</xsl:variable>
	<xsl:variable name="capibase">http://services.tmobile.com/base</xsl:variable>

	<xsl:template match="/">
		<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
			<soapenv:Header/>
			<soapenv:Body>
				<v1:updateCartRequest
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
                                                                                                                                <xsl:variable name="entitlementStr" select="replace(replace(replace(replace($ABFEntitlements,'TO_BE_REPLACED_PREFIX',$capientitlementprefix),'TO_BE_REPLACED_NAMESPACE',$capientitlementns),'TO_BE_REPLACED_BASE_NAMESPACE',$capibase),'TO_BE_REPLACED_BASE_PREFIX',$capibaseprefix)"></xsl:variable>
                                                                                                                                <xsl:copy-of select="saxon:parse($entitlementStr)"/>
                                                                                                                </xsl:if>-->

							<xsl:if test="$ABFEntitlements">
								<xsl:variable name="entitlementStr"
									select="replace(replace($ABFEntitlements, 'TO_BE_REPLACED_BASE_PREFIX', $capibaseprefix), 'TO_BE_REPLACED_BASE_NAMESPACE', $capibase)"/>
								<xsl:copy-of select="saxon:parse($entitlementStr)"/>
							</xsl:if>


							<xsl:if test="$supervisorEntitlementsVar1">
								<base:entitlements>
									<xsl:for-each
										select="saxon:parse($supervisorEntitlementsVar1)//ent:entitlement">
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
									<base:userId>
										<xsl:value-of select="$supervisorId1"/>
									</base:userId>
								</base:entitlements>
							</xsl:if>

							<xsl:if
								test="$supervisorEntitlementsVar2 and $supervisorId2 != $supervisorId1">
								<base:entitlements>
									<xsl:for-each
										select="saxon:parse($supervisorEntitlementsVar2)//ent:entitlement">
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
									<base:userId>
										<xsl:value-of select="$supervisorId2"/>
									</base:userId>
								</base:entitlements>
							</xsl:if>
							<xsl:if
								test="$supervisorEntitlementsVar3 and $supervisorId3 != $supervisorId2 and $supervisorId3 != $supervisorId1">
								<base:entitlements>
									<xsl:for-each
										select="saxon:parse($supervisorEntitlementsVar2)//ent:entitlement">
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
									<base:userId>
										<xsl:value-of select="$supervisorId3"/>
									</base:userId>
								</base:entitlements>
							</xsl:if>
							<xsl:if
								test="$supervisorEntitlementsVar4 and $supervisorId4 != $supervisorId3 and $supervisorId4 != $supervisorId2 and $supervisorId4 != $supervisorId1">
								<base:entitlements>
									<xsl:for-each
										select="saxon:parse($supervisorEntitlementsVar2)//ent:entitlement">
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
									<base:userId>
										<xsl:value-of select="$supervisorId4"/>
									</base:userId>
								</base:entitlements>
							</xsl:if>
							<xsl:if
								test="$supervisorEntitlementsVar5 and $supervisorId5 != $supervisorId4 and $supervisorId5 != $supervisorId3 and $supervisorId5 != $supervisorId2 and $supervisorId5 != $supervisorId1">
								<base:entitlements>
									<xsl:for-each
										select="saxon:parse($supervisorEntitlementsVar2)//ent:entitlement">
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
									<base:userId>
										<xsl:value-of select="$supervisorId5"/>
									</base:userId>
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

					<!--xsl:apply-templates select="//searchContext"/-->
					<xsl:apply-templates select="cart"/>
					<!--xsl:apply-templates select="//port"/-->

				</v1:updateCartRequest>
			</soapenv:Body>
		</soapenv:Envelope>
	</xsl:template>

	<!-- Cart child Elements -->
	<xsl:template match="cart">

		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@cartId != ''">
					<xsl:attribute name="cartId">
						<xsl:value-of select="@cartId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@actionCode != ''">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="totalTaxAmount"/>
				<xsl:apply-templates select="extendedAmount"/>
				<xsl:apply-templates select="orderLocation"/>
				<xsl:apply-templates select="orderTime"/>
				<xsl:apply-templates select="status"/>
				<xsl:apply-templates select="reason"/>
				<xsl:apply-templates select="orderType"/>
				<xsl:choose>
					<xsl:when test="$channelCode != '' or $subChannelCode != '' or $category != ''">
						<v1:salesChannel>
							<xsl:if test="$channelCode != ''">
								<v1:salesChannelCode>
									<xsl:value-of select="$channelCode"/>
								</v1:salesChannelCode>
							</xsl:if>
							<xsl:if test="$subChannelCode != ''">
								<v1:salesSubChannelCode>
									<xsl:value-of select="$subChannelCode"/>
								</v1:salesSubChannelCode>
							</xsl:if>
							<xsl:if test="$category != ''">
								<v1:subChannelCategory>
									<xsl:value-of select="$category"/>
								</v1:subChannelCategory>
							</xsl:if>
						</v1:salesChannel>
					</xsl:when>
					<xsl:when test="salesChannel">
						<xsl:apply-templates select="salesChannel"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if
							test="$app_channelCode != '' or $app_subChannelCode != '' or $app_category != ''">
							<v1:salesChannel>
								<xsl:if test="$app_channelCode != ''">
									<v1:salesChannelCode>
										<xsl:value-of select="$app_channelCode"/>
									</v1:salesChannelCode>
								</xsl:if>
								<xsl:if test="$app_subChannelCode != ''">
									<v1:salesSubChannelCode>
										<xsl:value-of select="$app_subChannelCode"/>
									</v1:salesSubChannelCode>
								</xsl:if>
								<xsl:if test="$app_category != ''">
									<v1:subChannelCategory>
										<xsl:value-of select="$app_category"/>
									</v1:subChannelCategory>
								</xsl:if>
							</v1:salesChannel>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:apply-templates select="businessUnitName"/>
				<xsl:choose>
					<xsl:when test="salesperson">
						<xsl:apply-templates select="salesperson"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="$tokenScope = 'assisted'">
							<v1:salesperson>
								<v1:userName>
									<xsl:value-of select="$applicationUserId"/>
								</v1:userName>
							</v1:salesperson>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:apply-templates select="cartSpecification"/>
				<xsl:apply-templates select="backOrderAllowedIndicator"/>
				<xsl:apply-templates select="ipAddress"/>
				<xsl:apply-templates select="deviceFingerPrintId"/>
				<xsl:apply-templates select="termsAndConditionsDisposition"/>
				<xsl:apply-templates select="currentRecurringChargeAmount"/>
				<xsl:apply-templates select="totalRecurringDueAmount"/>
				<xsl:apply-templates select="totalDueAmount"/>
				<xsl:apply-templates select="originalOrderId"/>
				<xsl:apply-templates select="modeOfExchange"/>
				<xsl:apply-templates select="relatedOrder"/>
				<!--xsl:apply-templates select="reasonDescription"/-->
				<xsl:apply-templates select="fraudCheckRequired"/>
				<xsl:apply-templates select="isInFlightOrder"/>
				<xsl:apply-templates select="totalDuePayNowAmount"/>
				<xsl:apply-templates select="shipping"/>
				<xsl:choose>
					<xsl:when test="cartItem[1]/transactionType = 'REFILL'">
						<xsl:choose>
							<xsl:when test="billTo">
								<xsl:apply-templates select="billTo"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:choose>
									<xsl:when test="$orderType = 'ACTIVATION'">
										<v1:billTo>
											<v1:customerAccount>
												<v1:specificationGroup>
													<v1:specificationValue>
														<xsl:attribute name="name" select="'specialTreatment'"/>
														<xsl:value-of select="'None'"/>
													</v1:specificationValue>
												</v1:specificationGroup>
												<v1:idVerificationIndicator>
													<xsl:value-of select="'false'"/>
												</v1:idVerificationIndicator>
												<v1:financialAccount>
													<v1:programMembership>
														<v1:programCode>
															<xsl:value-of select="'BAASSISPRG'"/>
														</v1:programCode>
														<v1:description>
															<xsl:value-of select="'None'"/>
														</v1:description>
													</v1:programMembership>
													<v1:specialTreatment>
														<v1:treatmentType>
															<xsl:value-of select="'None'"/>
														</v1:treatmentType>
													</v1:specialTreatment>
													<v1:customerGroup>
														<xsl:value-of select="'Consumer'"/>
													</v1:customerGroup>
												</v1:financialAccount>
											</v1:customerAccount>
											<v1:customer>
												<xsl:if test="$customerId">
													<xsl:attribute name="customerId" select="$customerId"/>
												</xsl:if>
												<v1:customerGroup>
													<xsl:value-of select="'Consumer'"/>
												</v1:customerGroup>
											</v1:customer>
										</v1:billTo>
									</xsl:when>
									<xsl:when test="$customerId">
										<v1:billTo>
											<v1:customer>
												<xsl:attribute name="customerId" select="$customerId"/>
											</v1:customer>
										</v1:billTo>
									</xsl:when>
								</xsl:choose>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="billTo"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:apply-templates select="cartItem"/>
				<xsl:apply-templates select="charge"/>
				<xsl:apply-templates select="deduction"/>
				<xsl:apply-templates select="tax"/>
				<xsl:apply-templates select="freightCharge"/>
				<xsl:apply-templates select="payment"/>
				<xsl:apply-templates select="addressList"/>
				<xsl:apply-templates select="cartSummary"/>
				<!--xsl:apply-templates select="searchContext"/-->
				<xsl:apply-templates select="validationMessage"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="cartSummary">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="financialAccountId"/>
				<xsl:apply-templates select="lineOfServiceId"/>
				<xsl:apply-templates select="summaryScope"/>
				<xsl:apply-templates select="totalDueAmount"/>
				<xsl:apply-templates select="totalRecurringDueAmount"/>
				<xsl:apply-templates select="charge" mode="cartSummary"/>
				<xsl:apply-templates select="deduction" mode="cartSummary"/>
				<xsl:apply-templates select="tax" mode="cartSummary"/>
				<xsl:apply-templates select="calculationType"/>
				<xsl:apply-templates select="totalCurrentRecurringAmount"/>
				<xsl:apply-templates select="totalDeltaRecurringDueAmount"/>
				<xsl:apply-templates select="totalExtendedAmount"/>
				<xsl:apply-templates select="totalSoftGoodDueNowAmount"/>
				<xsl:apply-templates select="totalHardGoodDueNowAmount"/>
				<xsl:apply-templates select="totalSoftGoodOneTimeDueNowAmount"/>
				<xsl:apply-templates select="totalSoftGoodRecurringDueNowAmount"/>
				<xsl:apply-templates select="totalTaxAmount"/>
				<xsl:apply-templates select="totalFeeAmount"/>
				<xsl:apply-templates select="rootParentId"/>
				<xsl:apply-templates select="totalRefundAmountDueLater"/>
				<xsl:apply-templates select="totalRefundAmountDueNow"/>
				<xsl:apply-templates select="finalRefundAmountDueNow"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="searchContext">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@name != ''">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="specificationValue"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="trackData">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="track1Data"/>
				<xsl:apply-templates select="track2Data"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="validationMessage">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="messageType"/>
				<xsl:apply-templates select="messageCode"/>
				<xsl:apply-templates select="messageText"/>
				<xsl:apply-templates select="messageSource"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="freightCharge">
		<xsl:if test="current() != '' or count(@*)">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@chargeId">
					<xsl:attribute name="chargeId">
						<xsl:value-of select="@chargeId"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:apply-templates select="amount"/>
				<xsl:apply-templates select="chargeCode"/>
				<xsl:apply-templates select="waiverIndicator"/>
				<xsl:apply-templates select="waiverReason"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="tax">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="amount"/>
				<xsl:apply-templates select="description"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="tax" mode="cartSummary">
		<xsl:if test="current() != ''">
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

	<xsl:template match="relatedCart">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="cartId"/>
				<xsl:apply-templates select="orderRelationshipType"/>
				<xsl:apply-templates select="cartStatus"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="relatedOrder">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="orderId"/>
				<xsl:apply-templates select="relationshipType"/>
				<!--xsl:apply-templates select="orderStatus"/-->
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="fraudCheckStatus">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="name"/>
				<xsl:apply-templates select="reasonCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="termsAndConditionsDisposition">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="acceptanceIndicator"/>
				<xsl:apply-templates select="acceptanceTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="salesperson">
		<xsl:element name="v1:{local-name()} ">
			<xsl:choose>
				<xsl:when test="$tokenScope = 'assisted'">
					<v1:userName>
						<xsl:value-of select="$applicationUserId"/>
					</v1:userName>
				</xsl:when>
				<xsl:otherwise>
					<xsl:apply-templates select="userName"/>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates select="personName" mode="cart-salesPerson"/>
			</xsl:element>
	</xsl:template>


	<!-- create cart -->
	<xsl:template match="orderLocation">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@id != ''">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="location"/>
				<xsl:apply-templates select="tillNumber"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="location">
		<xsl:if test="@id != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@id"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template
		match="totalSoftGoodRecurringDueNowAmount | totalSoftGoodOneTimeDueNowAmount | totalHardGoodDueNowAmount | finalRefundAmountDueNow | totalSoftGoodDueNowAmount | totalRefundAmountDueNow | totalExtendedAmount | totalDeltaRecurringDueAmount | totalCurrentRecurringAmount | chargeAmount | requestAmount | totalRefundAmountDueLater | authorizationAmount | basisAmount | amount | currentRecurringChargeAmount | totalTaxAmount | extendedAmount | totalRecurringDueAmount | totalDueAmount | totalDueMonthlyAmount | totalDueNowAmount | totalFeeAmount | totalDiscountAmount | totalChargeAmount">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@currencyCode != ''">
					<xsl:attribute name="currencyCode">
						<xsl:value-of select="@currencyCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="orderStatus | cartStatus | verificationStatus | cartScheduleStatus">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@statusCode != ''">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="lineOfServiceStatus">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@statusCode != ''">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="reasonCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart -->

	<xsl:template match="salesChannel">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="salesChannelCode"/>
				<xsl:apply-templates select="salesSubChannelCode"/>
				<xsl:apply-templates select="subChannelCategory"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="payment">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<!--xsl:if test="@paymentId !=''">
                                                                                <xsl:attribute name="paymentId">
                                                                                                <xsl:value-of select="@paymentId"/>
                                                                                </xsl:attribute>
                                                                </xsl:if-->
				<xsl:if test="@actionCode != ''">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="status"/>
				<xsl:apply-templates select="authorizationAmount"/>
				<xsl:apply-templates select="requestAmount"/>
				<xsl:apply-templates select="paymentMethodCode"/>
				<xsl:apply-templates select="payeeParty"/>
				<xsl:apply-templates select="bankPayment"/>
				<xsl:apply-templates select="voucherRedemption"/>
				<xsl:apply-templates select="creditCardPayment" mode="payment"/>
				<xsl:apply-templates select="debitCardPayment" mode="payment"/>
				<xsl:apply-templates select="transactionType"/>
				<xsl:apply-templates select="specificationGroup"/>
				<!--xsl:apply-templates select="authorizationChannel"/>
                                                                <xsl:apply-templates select="pointOfSaleReceiptNumber"/>
                                                                <xsl:apply-templates select="receivedPaymentId"/>
                                                                <xsl:apply-templates select="receiptMethodCode"/>
                                                                <xsl:apply-templates select="cardPresentIndicator"/>
                                                                <xsl:apply-templates select="storePaymentMethodIndicator"/>
                                                                <xsl:apply-templates select="isTemporyToken"/>
                                                                <xsl:apply-templates select="settlementIndicator"/>
                                                                <xsl:apply-templates select="termsAndConditionsDisposition"/>
                                                                <xsl:apply-templates select="terminalEntryCapability"/>
                                                                <xsl:apply-templates select="terminalType"/>
                                                                <xsl:apply-templates select="terminalEntryMode"/>
                                                                <xsl:apply-templates select="cardCaptureCapability"/>
                                                                <xsl:apply-templates select="posConditionCode"/>
                                                                <xsl:apply-templates select="posId"/>
                                                                <xsl:apply-templates select="paymentTransactionType"/>
                                                                <xsl:apply-templates select="retailPinlessFlag"/>
                                                                <xsl:apply-templates select="trackData"/>
                                                                <xsl:apply-templates select="electronicAuthenticationCapability"/-->
				<xsl:apply-templates select="tokenization"/>
				<!--xsl:apply-templates select="terminalID"/-->
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="payeeParty">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="personName" mode="payeeParty-personName"/>
				<xsl:apply-templates select="addressCommunication"
					mode="addressCommunication-payeeParty"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="personName" mode="payeeParty-personName">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="firstName"/>
				<xsl:apply-templates select="middleName"/>
				<xsl:apply-templates select="familyName"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="addressCommunication" mode="addressCommunication-payeeParty">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="usageContext"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="tokenization">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="encryptionTarget"/>
				<xsl:apply-templates select="encryptedContent"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="debitCardPayment">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="authorizationId"/>
				<xsl:apply-templates select="chargeAmount"/>
				<xsl:apply-templates select="debitCard"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="debitCardPayment" mode="payment">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="chargeAmount"/>
				<xsl:apply-templates select="debitCard"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="creditCardPayment" mode="payment">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="chargeAmount"/>
				<xsl:apply-templates select="creditCard" mode="payment"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="creditCardPayment">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="authorizationId"/>
				<xsl:apply-templates select="chargeAmount"/>
				<xsl:apply-templates select="creditCard"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="debitCard" mode="payment">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="typeCode"/>
				<xsl:apply-templates select="cardNumber"/>
				<xsl:apply-templates select="cardHolderName"/>
				<xsl:apply-templates select="expirationMonthYear"/>
				<xsl:apply-templates select="cardHolderAddress" mode="payment"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--xsl:template match="debitCard">
                                <xsl:if test="current()!=''">
                                                <xsl:element name="v1:{local-name()} ">
                                                                <xsl:apply-templates select="typeCode"/>
                                                                <xsl:apply-templates select="cardNumber"/>
                                                                <xsl:apply-templates select="cardHolderName"/>
                                                                <xsl:apply-templates select="expirationMonthYear"/>
                                                                <xsl:apply-templates select="cardHolderAddress"/>
                                                                <xsl:apply-templates select="cardHolderFirstName"/>
                                                                <xsl:apply-templates select="cardHolderLastName"/>
                                                                <xsl:apply-templates select="cardTypeIndicator"/>
                                                                <xsl:apply-templates select="chargeAccountNumberIndicator"/>
                                                                <xsl:apply-templates select="PIN"/>
                                                </xsl:element>
                                </xsl:if>
                </xsl:template-->

	<xsl:template match="creditCard" mode="payment">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="typeCode"/>
				<xsl:apply-templates select="cardNumber"/>
				<xsl:apply-templates select="cardHolderName"/>
				<xsl:apply-templates select="expirationMonthYear"/>
				<xsl:apply-templates select="cardHolderBillingAddress" mode="payment"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--xsl:template match="creditCard">
                                <xsl:if test="current()!=''">
                                                <xsl:element name="v1:{local-name()} ">
                                                                <xsl:apply-templates select="typeCode"/>
                                                                <xsl:apply-templates select="cardNumber"/>
                                                                <xsl:apply-templates select="cardHolderName"/>
                                                                <xsl:apply-templates select="expirationMonthYear"/>
                                                                <xsl:apply-templates select="cardHolderAddress"/>
                                                                <xsl:apply-templates select="cardHolderFirstName"/>
                                                                <xsl:apply-templates select="cardHolderLastName"/>
                                                                <xsl:apply-templates select="cardTypeIndicator"/>
                                                                <xsl:apply-templates select="chargeAccountNumberIndicator"/>
                                                                <xsl:apply-templates select="cardHolderBillingAddress"/>
                                                                <xsl:apply-templates select="securityCode"/>
                                                </xsl:element>
                                </xsl:if>
                </xsl:template-->

	<xsl:template match="cardHolderBillingAddress" mode="payment">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="postalCode"/>
				<xsl:apply-templates select="postalCodeExtension"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="cardHolderAddress" mode="payment">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="postalCode"/>
				<xsl:apply-templates select="postalCodeExtension"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="paymentLine">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="financialAccountNumber"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="bankPayment">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="payFromBankAccount"/>
				<!--xsl:apply-templates select="check"/-->
				<xsl:apply-templates select="chargeAccountNumberIndicator"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--xsl:template match="check">
                                <xsl:if test="current()!=''">
                                                <xsl:element name="v1:{local-name()} ">
                                                                <xsl:apply-templates select="accountNumber"/>
                                                                <xsl:apply-templates select="routingNumber"/>
                                                                <xsl:apply-templates select="checkNumber"/>
                                                </xsl:element>
                                </xsl:if>
                </xsl:template-->

	<xsl:template match="payFromBankAccount">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="name"/>
				<xsl:apply-templates select="accountNumber"/>
				<xsl:apply-templates select="bankAccountHolder"/>
				<xsl:apply-templates select="bank"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="bank">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="swiftCode"/>
				<xsl:apply-templates select="routingNumber"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<!--xsl:template match="payFromParty">
                                <xsl:if test="current()!=''">
                                                <xsl:element name="v1:{local-name()} ">
                                                                <xsl:apply-templates select="securityProfile"/>
                                                </xsl:element>
                                </xsl:if>
                </xsl:template>

                <xsl:template match="securityProfile">
                                <xsl:if test="current()!='' or count(@*)>0">
                                                <xsl:element name="v1:{local-name()} ">
                                                                <xsl:apply-templates select="msisdn"/>
                                                </xsl:element>
                                </xsl:if>
                </xsl:template-->

	<!-- create cart-->
	<!--xsl:template match="payFromParty">
                                <xsl:if test="current()!=''">
                                                <xsl:element name="v1:{local-name()} ">
                                                                <xsl:apply-templates select="securityProfile" mode="payment"/>
                                                </xsl:element>
                                </xsl:if>
                </xsl:template-->

	<!-- create cart-->
	<xsl:template match="voucherRedemption">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="serialNumber"/>
				<xsl:apply-templates select="issuerId"/>
				<xsl:apply-templates select="PIN"/>
				<xsl:apply-templates select="voucherRedemptionType"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="promotion" mode="cart">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="promotionCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="promotionEffectivePeriod">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="startTime"/>
				<xsl:apply-templates select="endTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="shipping">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="freightCarrier"/>
				<xsl:apply-templates select="promisedDeliveryTime"/>
				<xsl:apply-templates select="shipTo"/>
				<xsl:apply-templates select="note"/>
				<xsl:apply-templates select="serviceLevelCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="note">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@language != ''">
					<xsl:attribute name="language">
						<xsl:value-of select="@language"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="entryTime"/>
				<xsl:apply-templates select="noteType"/>
				<xsl:apply-templates select="content"/>
				<xsl:apply-templates select="author"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="shipTo">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="personName" mode="shipTo"/>
				<xsl:apply-templates select="addressCommunication"
					mode="addressCommunication-shipTo"/>
				<xsl:apply-templates select="phoneCommunication" mode="shipping-shipTo"/>
				<xsl:apply-templates select="emailCommunication" mode="shipping-shipTo"/>
				<xsl:apply-templates select="preferredLanguage"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="description">
		<xsl:if test="current() != '' or count(@*)">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@* | node()"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="effectivePeriod">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="startTime"/>
				<xsl:apply-templates select="endTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="effectivePeriod" mode="lineOfService">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="startTime"/>
				<xsl:apply-templates select="endTime"/>
				<xsl:apply-templates select="usageContext"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="effectivePeriod" mode="cartItem">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="startTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="billTo">
		<xsl:if test="not(empty(.))">
			<xsl:element name="v1:{local-name()} ">
				<xsl:choose>
					<xsl:when test="$orderType = 'ACTIVATION' or $custFinActionCode ='ADD'">
						<xsl:choose>
							<xsl:when test="customerAccount">
								<xsl:apply-templates select="customerAccount"/>
							</xsl:when>
							<xsl:otherwise>
								<v1:customerAccount>
									<v1:specificationGroup>
										<v1:specificationValue>
											<xsl:attribute name="name" select="'specialTreatment'"/>
											<xsl:value-of select="'None'"/>
										</v1:specificationValue>
									</v1:specificationGroup>
									<v1:idVerificationIndicator>
										<xsl:value-of select="'false'"/>
									</v1:idVerificationIndicator>
									<v1:financialAccount>
										<xsl:if test="$orderType = 'ACTIVATION' and (customer/party/person/addressCommunication/usageContext | customer/party/person/addressCommunication/@id)">
											<v1:billingArrangement>
												<v1:billingContact>
													<v1:addressCommunication>
														<xsl:if test="customer/party/person/addressCommunication/@id">
															<xsl:attribute name="id" select="customer/party/person/addressCommunication/@id"/>
														</xsl:if>
														<xsl:if test="customer/party/person/addressCommunication/usageContext">
															<v1:usageContext>
																<xsl:value-of select="customer/party/person/addressCommunication/usageContext/node()"/>
															</v1:usageContext>
														</xsl:if>
													</v1:addressCommunication>
												</v1:billingContact>
											</v1:billingArrangement>
										</xsl:if>
										<v1:programMembership>
											<v1:programCode>
												<xsl:value-of select="'BAASSISPRG'"/>
											</v1:programCode>
											<v1:description>
												<xsl:value-of select="'None'"/>
											</v1:description>
										</v1:programMembership>
										<v1:specialTreatment>
											<v1:treatmentType>
												<xsl:value-of select="'None'"/>
											</v1:treatmentType>
										</v1:specialTreatment>
										<v1:customerGroup>
											<xsl:value-of select="'Consumer'"/>
										</v1:customerGroup>
									</v1:financialAccount>
								</v1:customerAccount>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="customerAccount"/>
					</xsl:otherwise>
				</xsl:choose>

				<xsl:choose>
					<xsl:when test="customer">
						<xsl:apply-templates select="customer"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="$customerId">
								<v1:customer>
									<xsl:attribute name="customerId">
										<xsl:value-of select="$customerId"/>
									</xsl:attribute>
									<xsl:if test="$orderType = 'ACTIVATION' or $custFinActionCode ='ADD'">
										<v1:customerGroup>
											<xsl:value-of select="'Consumer'"/>
										</v1:customerGroup>
									</xsl:if>
								</v1:customer>
							</xsl:when>
							<xsl:when test="$orderType = 'ACTIVATION' or $custFinActionCode ='ADD'">
								<v1:customer>
									<v1:customerGroup>
										<xsl:value-of select="'Consumer'"/>
									</v1:customerGroup>
								</v1:customer>
							</xsl:when>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart -->
	<xsl:template match="customerAccount">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@customerAccountId != ''">
					<xsl:attribute name="customerAccountId">
						<xsl:value-of select="@customerAccountId"/>
					</xsl:attribute>
				</xsl:if>
				<!--xsl:apply-templates select="accountClassification"/>
                                                                <xsl:apply-templates select="businessUnit"/-->
				<xsl:apply-templates select="programMembership"/>
				<xsl:choose>
					<xsl:when test="$orderType = 'ACTIVATION' or $custFinActionCode ='ADD'">
						<xsl:choose>
							<xsl:when test="specificationGroup">
								<xsl:apply-templates select="specificationGroup" mode="activation"/>
							</xsl:when>
							<xsl:otherwise>
								<v1:specificationGroup>
									<v1:specificationValue>
										<xsl:attribute name="name" select="'specialTreatment'"/>
										<xsl:value-of select="'None'"/>
									</v1:specificationValue>
								</v1:specificationGroup>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="specificationGroup"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:apply-templates select="paymentProfile"/>
				<xsl:apply-templates select="preferredLanguage"/>
				<xsl:choose>
					<xsl:when test="$orderType = 'ACTIVATION' or $custFinActionCode ='ADD'">
						<v1:idVerificationIndicator>
							<xsl:value-of select="'None'"/>
						</v1:idVerificationIndicator>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="idVerificationIndicator"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:apply-templates select="corporateAffiliationProgram"/>
				<xsl:apply-templates select="strategicAccountIndicator"/>
				<xsl:choose>
					<xsl:when test="$orderType = 'ACTIVATION' or $custFinActionCode ='ADD'">
						<xsl:choose>
							<xsl:when test="financialAccount">
								<xsl:apply-templates select="financialAccount"/>
							</xsl:when>
							<xsl:otherwise>
								<v1:financialAccount>
									<xsl:if test="$orderType = 'ACTIVATION' and (../../billTo/customer/party/person/addressCommunication/usageContext | ../../billTo/customer/party/person/addressCommunication/@id)">
										<v1:billingArrangement>
											<v1:billingContact>
												<v1:addressCommunication>
													<xsl:if test="../../billTo/customer/party/person/addressCommunication/@id">
														<xsl:attribute name="id" select="../../billTo/customer/party/person/addressCommunication/@id"/>
													</xsl:if>
													<xsl:if test="../../billTo/customer/party/person/addressCommunication/usageContext">
														<v1:usageContext>
															<xsl:value-of select="../../billTo/customer/party/person/addressCommunication/usageContext/node()"/>
														</v1:usageContext>
													</xsl:if>
												</v1:addressCommunication>
											</v1:billingContact>
										</v1:billingArrangement>
									</xsl:if>
									<v1:programMembership>
										<v1:programCode>
											<xsl:value-of select="'BAASSISPRG'"/>
										</v1:programCode>
										<v1:description>
											<xsl:value-of select="'None'"/>
										</v1:description>
									</v1:programMembership>
									<v1:specialTreatment>
										<v1:treatmentType>
											<xsl:value-of select="'None'"/>
										</v1:treatmentType>
									</v1:specialTreatment>
									<v1:customerGroup>
										<xsl:value-of select="'Consumer'"/>
									</v1:customerGroup>
								</v1:financialAccount>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="financialAccount"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="financialAccount">
		<xsl:if test="current() != '' or @actionCode != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode != ''">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="financialAccountNumber"/>
				<xsl:apply-templates select="billingMethod"/>
				<xsl:apply-templates select="status"/>
				<xsl:apply-templates select="billCycle"/>
				<xsl:choose>
					<xsl:when test="$orderType = 'ACTIVATION' or $custFinActionCode ='ADD'">
						<xsl:choose>
							<xsl:when test="billingArrangement">
								<xsl:apply-templates select="billingArrangement"/>
							</xsl:when>
							<xsl:when
								test="$orderType = 'ACTIVATION' and (../../../billTo/customer/party/person/addressCommunication/usageContext | ../../../billTo/customer/party/person/addressCommunication/@id)">
								<v1:billingArrangement>
									<v1:billingContact>
										<v1:addressCommunication>
											<xsl:if test="../../../billTo/customer/party/person/addressCommunication/@id">
												<xsl:attribute name="id" select="../../../billTo/customer/party/person/addressCommunication/@id"/>
											</xsl:if>
											<xsl:if test="../../../billTo/customer/party/person/addressCommunication/usageContext">
												<v1:usageContext>
													<xsl:value-of select="../../../billTo/customer/party/person/addressCommunication/usageContext/node()"/>
												</v1:usageContext>
											</xsl:if>
										</v1:addressCommunication>
									</v1:billingContact>
								</v1:billingArrangement>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="billingArrangement"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:apply-templates select="accountBalanceSummaryGroup"/>
				<xsl:apply-templates select="accountContact"/>
				<xsl:apply-templates select="specificationGroup"/>
				<xsl:apply-templates select="paymentProfile"/>
				<xsl:choose>
					<xsl:when test="$orderType = 'ACTIVATION' or $custFinActionCode ='ADD'">
						<v1:programMembership>
							<v1:programCode>
								<xsl:value-of select="'BAASSISPRG'"/>
							</v1:programCode>
							<v1:description>
								<xsl:value-of select="'None'"/>
							</v1:description>
						</v1:programMembership>
						<v1:specialTreatment>
							<v1:treatmentType>
								<xsl:value-of select="'None'"/>
							</v1:treatmentType>
						</v1:specialTreatment>
						<v1:customerGroup>
							<xsl:value-of select="'Consumer'"/>
						</v1:customerGroup>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="programMembership"/>
						<xsl:apply-templates select="specialTreatment"/>
						<xsl:apply-templates select="customerGroup"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="accountBalanceSummaryGroup">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="balanceSummary"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="balanceSummary">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="amount"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="billingArrangement">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:choose>
					<xsl:when test="$orderType = 'ACTIVATION'">
						<xsl:choose>
							<xsl:when test="billingContact">
								<xsl:apply-templates select="billingContact"/>
							</xsl:when>
							<xsl:when
								test="../../../../billTo/customer/party/person/addressCommunication/usageContext | ../../../../billTo/customer/party/person/addressCommunication/@id">
								<v1:billingContact>
									<v1:addressCommunication>
										<xsl:if test="../../../../billTo/customer/party/person/addressCommunication/@id">
											<xsl:attribute name="id" select="../../../../billTo/customer/party/person/addressCommunication/@id"/>
										</xsl:if>
										<xsl:if test="../../../../billTo/customer/party/person/addressCommunication/usageContext">
											<v1:usageContext>
												<xsl:value-of select="../../../../billTo/customer/party/person/addressCommunication/usageContext/node()"/>
											</v1:usageContext>
										</xsl:if>
									</v1:addressCommunication>
								</v1:billingContact>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="billingContact"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="billingContact">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:choose>
					<xsl:when test="$orderType = 'ACTIVATION'">
						<xsl:choose>
							<xsl:when test="addressCommunication">
								<xsl:apply-templates select="addressCommunication"
									mode="financialAccount-billingArragement"/>
							</xsl:when>
							<xsl:when test="../../../../../billTo/customer/party/person/addressCommunication/usageContext | ../../../../../billTo/customer/party/person/addressCommunication/@id">
								<v1:addressCommunication>
									<xsl:if test="../../../../../billTo/customer/party/person/addressCommunication/@id">
										<xsl:attribute name="id" select="../../../../../billTo/customer/party/person/addressCommunication/@id"/>
									</xsl:if>
									<xsl:if test="../../../../../billTo/customer/party/person/addressCommunication/usageContext">
										<v1:usageContext>
											<xsl:value-of select="../../../../../billTo/customer/party/person/addressCommunication/usageContext/node()"/>
										</v1:usageContext>
									</xsl:if>
								</v1:addressCommunication>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="addressCommunication"
							mode="financialAccount-billingArragement"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="specialTreatment">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="treatmentType"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="accountContact">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="addressCommunication"
					mode="financialAccount-accountContact"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="addressCommunication" mode="financialAccount-accountContact">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode != ''">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@id != ''">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="privacyProfile"/>
				<xsl:apply-templates select="address" mode="key"/>
				<xsl:apply-templates select="usageContext"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="privacyProfile">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="optOut"/>
				<xsl:apply-templates select="activityType"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="accountBalanceSummaryGroup">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="balanceSummary"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="balanceSummary">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="amount"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="addressCommunication" mode="LOS">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode != ''">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@id != ''">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="privacyProfile"/>
				<xsl:apply-templates select="address" mode="key"/>
				<xsl:apply-templates select="usageContext"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="addressCommunication" mode="financialAccount-billingArragement">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:choose>
					<xsl:when test="$orderType = 'ACTIVATION'">
						<xsl:choose>
							<xsl:when test="../../../../../../billTo/customer/party/person/addressCommunication/usageContext | ../../../../../../billTo/customer/party/person/addressCommunication/@id">
								<xsl:if test="../../../../../../billTo/customer/party/person/addressCommunication/@id">
									<xsl:attribute name="id" select="../../../../../../billTo/customer/party/person/addressCommunication/@id"/>
								</xsl:if>
								<xsl:apply-templates select="address" mode="key"/>
								<xsl:if test="../../../../../../billTo/customer/party/person/addressCommunication/usageContext">
									<v1:usageContext>
										<xsl:value-of select="../../../../../../billTo/customer/party/person/addressCommunication/usageContext/node()"/>
									</v1:usageContext>
								</xsl:if>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="@actionCode != ''">
							<xsl:attribute name="actionCode">
								<xsl:value-of select="@actionCode"/>
							</xsl:attribute>
						</xsl:if>
						<xsl:if test="@id != ''">
							<xsl:attribute name="id">
								<xsl:value-of select="@id"/>
							</xsl:attribute>
						</xsl:if>
						<xsl:apply-templates select="address" mode="key"/>
						<xsl:apply-templates select="usageContext"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="address" mode="key">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="key"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="billCycle">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode != ''">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@billCycleId != ''">
					<xsl:attribute name="billCycleId">
						<xsl:value-of select="@billCycleId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="dayOfMonth"/>
				<xsl:apply-templates select="frequencyCode"/>

			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="status">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@statusCode != ''">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="reasonCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="paymentProfile">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="paymentTerm"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="programMembership">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="programCode"/>
				<xsl:apply-templates select="description"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="accountHolder">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="party" mode="party-accountHolder"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="party" mode="party-accountHolder">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@*"/>
				<!--xsl:apply-templates select="organization"/-->
				<xsl:apply-templates select="person" mode="person-party-accountHolder"/>
				<!--xsl:apply-templates select="partyRelationship"/-->
			</xsl:element>
		</xsl:if>
	</xsl:template>



	<xsl:template match="nationalIdentityDocument">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="nationalIdentityDocumentIdentifier"/>
				<xsl:apply-templates select="issuingCountryCode"/>
				<xsl:apply-templates select="typeCode"/>
				<xsl:apply-templates select="primaryIndicator"/>
				<xsl:apply-templates select="taxIDIndicator"/>
				<xsl:apply-templates select="issuedDate"/>
				<xsl:apply-templates select="expirationDate"/>
				<xsl:apply-templates select="issuingAuthority"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="personName" mode="shipTo">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="firstName"/>
				<xsl:apply-templates select="middleName"/>
				<xsl:apply-templates select="familyName"/>
				<xsl:apply-templates select="aliasName"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="personName" mode="cart-salesPerson">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="firstName"/>
				<xsl:apply-templates select="familyName"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="addressCommunication" mode="addressList">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="address" mode="addressList"/>
				<xsl:apply-templates select="usageContext"/>
				<xsl:apply-templates select="communicationStatus"/>
				<xsl:apply-templates select="specialInstruction"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart -->
	<xsl:template match="communicationStatus">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@*"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart -->
	<xsl:template match="addressCommunication" mode="addressCommunication-shipTo">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
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

				<xsl:apply-templates select="preference"/>
				<xsl:apply-templates select="usageContext"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="preference">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="preferred"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="key">
		<xsl:if test="current() != '' or @domainName != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@domainName != ''">
					<xsl:attribute name="domainName">
						<xsl:value-of select="@domainName"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="keyName"/>
				<xsl:apply-templates select="keyValue"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="cardHolderAddress | cardHolderBillingAddress" mode="payment">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="postalCode"/>
				<xsl:apply-templates select="postalCodeExtension"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="cardHolderAddress | cardHolderBillingAddress">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="addressFormatType"/>
				<xsl:apply-templates select="addressLine1"/>
				<xsl:apply-templates select="addressLine2"/>
				<xsl:apply-templates select="cityName"/>
				<xsl:apply-templates select="stateName"/>
				<xsl:apply-templates select="stateCode"/>
				<xsl:apply-templates select="countryCode"/>
				<xsl:apply-templates select="postalCode"/>
				<xsl:apply-templates select="postalCodeExtension"/>
				<xsl:apply-templates select="key"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="address" mode="addressList">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="addressFormatType"/>
				<xsl:apply-templates select="addressLine1"/>
				<xsl:apply-templates select="addressLine2"/>
				<xsl:apply-templates select="addressLine3"/>
				<xsl:apply-templates select="cityName"/>
				<xsl:apply-templates select="stateName"/>
				<xsl:apply-templates select="stateCode"/>
				<xsl:apply-templates select="provinceName"/>
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
				<!--xsl:apply-templates select="building"/>
                                                                <xsl:apply-templates select="floor"/>
                                                                <xsl:apply-templates select="area"/-->
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


	<xsl:template match="address">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="addressFormatType"/>
				<xsl:apply-templates select="addressLine1"/>
				<xsl:apply-templates select="addressLine2"/>
				<xsl:apply-templates select="addressLine3"/>
				<xsl:apply-templates select="cityName"/>
				<xsl:apply-templates select="stateCode"/>
				<xsl:apply-templates select="provinceName"/>
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
				<xsl:apply-templates select="building"/>
				<xsl:apply-templates select="floor"/>
				<xsl:apply-templates select="area"/>
				<xsl:apply-templates select="ruralRoute"/>
				<xsl:apply-templates select="countrySubDivisionID"/>
				<xsl:apply-templates select="citySubDivisionName"/>
				<xsl:apply-templates select="timeZone"/>
				<xsl:apply-templates select="houseNumber"/>
				<xsl:apply-templates select="streetName"/>
				<xsl:apply-templates select="streetSuffix"/>
				<xsl:apply-templates select="trailingDirection"/>
				<xsl:apply-templates select="unitType"/>
				<xsl:apply-templates select="unitNumber"/>
				<xsl:apply-templates select="streetDirection"/>
				<xsl:apply-templates select="houseNumberSuffix"/>
				<xsl:apply-templates select="urbanization"/>
				<xsl:apply-templates select="deliveryPointCode"/>
				<xsl:apply-templates select="confidenceLevel"/>
				<xsl:apply-templates select="carrierRoute"/>
				<xsl:apply-templates select="overrideIndicator"/>
				<xsl:apply-templates select="postOfficeBox"/>
				<xsl:apply-templates select="matchIndicator"/>

			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="geoCodeID">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@usageContext">
					<xsl:attribute name="usageContext">
						<xsl:value-of select="@usageContext"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@referenceLayer">
					<xsl:attribute name="referenceLayer">
						<xsl:value-of select="@referenceLayer"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@manualIndicator">
					<xsl:attribute name="manualIndicator">
						<xsl:value-of select="@manualIndicator"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
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

	<!-- create cart-->
	<xsl:template match="phoneCommunication">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="phoneType"/>
				<xsl:apply-templates select="phoneNumber"/>
				<xsl:apply-templates select="countryDialingCode"/>
				<xsl:apply-templates select="areaCode"/>
				<xsl:apply-templates select="localNumber"/>
				<xsl:apply-templates select="phoneExtension"/>

			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="phoneCommunication" mode="shipping-shipTo">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">

				<xsl:apply-templates select="phoneType"/>
				<xsl:apply-templates select="phoneNumber"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="emailCommunication" mode="shipping-shipTo">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="emailAddress"/>
				<xsl:apply-templates select="emailFormat"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="emailCommunication">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="preference"/>
				<xsl:apply-templates select="emailAddress"/>
				<xsl:apply-templates select="usageContext"/>

			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="driversLicense">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="legislationAuthorityCode"/>
				<xsl:apply-templates select="issuingAuthority"/>
				<xsl:apply-templates select="issuingCountryCode"/>
				<xsl:apply-templates select="suspendedIndicator"/>
				<xsl:apply-templates select="suspendedFromDate"/>
				<xsl:apply-templates select="issuingLocation"/>
				<xsl:apply-templates select="comment"/>
				<xsl:apply-templates select="issuePeriod"/>
				<xsl:apply-templates select="driversLicenseClass"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="issuePeriod">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="startTime"/>
				<xsl:apply-templates select="endTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--xsl:template match="driversLicense">
                                <xsl:if test="current()!='' or count(@*)>0">
                                                <xsl:element name="v1:{local-name()} ">
                                                                <xsl:apply-templates select="@*"/>
                                                                <xsl:apply-templates select="legislationAuthorityCode"/>
                                                                <xsl:apply-templates select="issuingAuthority"/>
                                                                <xsl:apply-templates select="issuingCountryCode"/>
                                                                <xsl:apply-templates select="suspendedIndicator"/>
                                                                <xsl:apply-templates select="suspendedFromDate"/>
                                                                <xsl:apply-templates select="issuingLocation"/>
                                                                <xsl:apply-templates select="comment"/>
                                                                <xsl:apply-templates select="issuePeriod"/>
                                                                <xsl:apply-templates select="driversLicenseClass"/>
                                                                <xsl:apply-templates select="personName"/>
                                                                <xsl:apply-templates select="address"/>
                                                                <xsl:apply-templates select="birthDate"/>
                                                </xsl:element>
                                </xsl:if>
                </xsl:template-->

	<!-- create cart -->
	<xsl:template match="citizenship">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="countryCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="cartSpecification">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@name"/>
				<xsl:apply-templates select="specificationValue"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="specificationGroup | organizationSpecification">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@id"/>
				<xsl:apply-templates select="specificationValue"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="specificationGroup" mode="activation">
		<xsl:element name="v1:{local-name()} ">
			<xsl:apply-templates select="@id"/>
			<xsl:apply-templates select="specificationValue[@name !='specialTreatment']" />
				<xsl:choose>
					<xsl:when test="specificationValue[@name ='specialTreatment']">
						<xsl:apply-templates select="specificationValue[@name ='specialTreatment']" mode="activation"/>
					</xsl:when>
					<xsl:otherwise>
						<v1:specificationValue>
							<xsl:attribute name="name" select="'specialTreatment'"/>
							<xsl:value-of select="'None'"/>
						</v1:specificationValue>
					</xsl:otherwise>
				</xsl:choose>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="specificationValue">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@* | node()"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="specificationValue" mode="activation">
		<xsl:element name="v1:{local-name()} ">
			<xsl:apply-templates select="@*"/>
			<xsl:value-of select="'None'"/>
		</xsl:element>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="securityProfile">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="pin"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="securityProfile" mode="party-securityProfile">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="userName"/>
				<xsl:apply-templates select="pin"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<!--xsl:template match="securityProfile" mode="payment">
                                <xsl:if test="current()!='' or count(@*)>0">
                                                <xsl:element name="v1:{local-name()} ">
                                                                <xsl:apply-templates select="@*"/>
                                                                <xsl:apply-templates select="msisdn"/>
                                                </xsl:element>
                                </xsl:if>
                </xsl:template-->

	<!-- CartItem childElements -->

	<xsl:template match="cartItem">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">

				<xsl:if test="@actionCode != ''">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@cartItemId != ''">
					<xsl:attribute name="cartItemId">
						<xsl:value-of select="@cartItemId"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:apply-templates select="overridePriceAllowedIndicator"/>
				<xsl:apply-templates select="quantity"/>
				<xsl:apply-templates select="cartItemStatus"/>
				<xsl:apply-templates select="parentCartItemId"/>
				<xsl:apply-templates select="rootParentCartItemId"/>
				<xsl:apply-templates select="effectivePeriod" mode="cartItem"/>
				<xsl:apply-templates select="productOffering"/>
				<xsl:apply-templates select="assignedProduct" mode="cartItem"/>
				<xsl:apply-templates select="cartSchedule"/>
				<xsl:apply-templates select="specificationGroup"/>
				<xsl:apply-templates select="promotion" mode="cartItem"/>
				<xsl:apply-templates select="lineOfService"/>
				<xsl:apply-templates select="relatedCartItemId"/>
				<xsl:apply-templates select="networkResource"/>
				<xsl:if test="transactionType != 'REFILL'">
					<xsl:apply-templates select="transactionType"/>
				</xsl:if>
				<xsl:apply-templates select="inventoryStatus"/>
				<xsl:apply-templates select="deviceConditionQuestions"/>
				<xsl:apply-templates select="originalOrderLineId"/>
				<xsl:apply-templates select="deviceDiagnostics"/>
				<xsl:apply-templates select="reasonCode"/>
				<xsl:apply-templates select="returnAuthorizationType"/>
				<xsl:apply-templates select="revisionReason"/>
				<xsl:apply-templates select="priceChangedIndicator"/>
				<xsl:choose>
					<xsl:when test="transactionType = 'REFILL'">
						<xsl:choose>
							<xsl:when test="financialAccount">
								<xsl:apply-templates select="financialAccount" mode="cartItem"/>
							</xsl:when>
							<xsl:when test="$financialAccountNumber">
								<v1:financialAccount>
									<v1:financialAccountNumber>
										<xsl:value-of select="$financialAccountNumber"/>
									</v1:financialAccountNumber>
								</v1:financialAccount>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="financialAccount" mode="cartItem"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:apply-templates select="backendChangedIndicator"/>
				<xsl:apply-templates select="extendedAmount"/>
				<xsl:apply-templates select="transactionSubType"/>
				<xsl:apply-templates select="totalChargeAmount"/>
				<xsl:apply-templates select="totalDiscountAmount"/>
				<xsl:apply-templates select="totalFeeAmount"/>
				<xsl:apply-templates select="totalTaxAmount"/>
				<xsl:apply-templates select="totalDueNowAmount"/>
				<xsl:apply-templates select="totalDueMonthlyAmount"/>
				<xsl:apply-templates select="totalAmount"/>
				<xsl:apply-templates select="port"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="financialAccount" mode="cartItem">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="financialAccountNumber"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="deviceConditionQuestions">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="verificationQuestion"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="verificationQuestion">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="questionText"/>
				<xsl:apply-templates select="verificationAnswer"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="verificationAnswer">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="answerText"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="inventoryStatus">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="estimatedAvailable"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="estimatedAvailable">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="startDate"/>
				<xsl:apply-templates select="endDate"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="port">
		<xsl:if test="current() != '' or count(@*) > 0">
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
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="addressCommunication" mode="port-personProfile"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="addressCommunication" mode="port-personProfile">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="address" mode="port-personProfile"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="address" mode="port-personProfile">
		<xsl:if test="current() != '' or count(@*) > 0">
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

	<xsl:template match="cartSchedule">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@cartScheduleId">
					<xsl:attribute name="cartScheduleId">
						<xsl:value-of select="@cartScheduleId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="description"/>
				<xsl:apply-templates select="cartScheduleStatus"/>
				<xsl:apply-templates select="cartScheduleCharge"/>
				<xsl:apply-templates select="cartScheduleDeduction"/>
				<xsl:apply-templates select="cartScheduleTax"/>
				<xsl:apply-templates select="calculationType"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="cartScheduleTax">
		<xsl:if test="current() != '' or count(@*) > 0">
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

	<xsl:template match="cartScheduleDeduction">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="amount"/>
				<xsl:apply-templates select="reason"/>
				<xsl:apply-templates select="effectivePeriod"/>
				<xsl:apply-templates select="description"/>
				<xsl:apply-templates select="recurringFrequency"/>
				<xsl:apply-templates select="promotion" mode="promotion-cartScheduleDeuction"/>
				<xsl:apply-templates select="chargeCode"/>
				<xsl:apply-templates select="productOfferingPriceId"/>
				<xsl:apply-templates select="specificationValue"/>
				<xsl:apply-templates select="realizationMethod"/>
				<xsl:apply-templates select="proratedIndicator"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="promotion" mode="promotion-cartScheduleDeuction">
		<xsl:if test="current() != '' or count(@*) > 0">
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

	<xsl:template match="cartScheduleCharge">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="typeCode"/>
				<xsl:apply-templates select="chargeFrequencyCode"/>
				<xsl:apply-templates select="basisAmount"/>
				<xsl:apply-templates select="amount"/>
				<xsl:apply-templates select="reason"/>
				<xsl:apply-templates select="effectivePeriod"/>
				<xsl:apply-templates select="description"/>
				<xsl:apply-templates select="chargeCode"/>
				<xsl:apply-templates select="waiverIndicator"/>
				<xsl:apply-templates select="waiverReason"/>
				<xsl:apply-templates select="manuallyAddedCharge"/>
				<xsl:apply-templates select="productOffering" mode="cartScheduleCharge"/>
				<xsl:apply-templates select="feeOverrideAllowed"/>
				<xsl:apply-templates select="overrideThresholdPercent"/>
				<xsl:apply-templates select="overrideThresholdAmount"/>
				<xsl:apply-templates select="supervisorID"/>
				<xsl:apply-templates select="overrideAmount"/>
				<xsl:apply-templates select="overrideReason"/>
				<xsl:apply-templates select="productOfferingPriceId"/>
				<xsl:apply-templates select="proratedIndicator"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="productOffering" mode="cartScheduleCharge">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@productOfferingId != ''">
					<xsl:attribute name="productOfferingId">
						<xsl:value-of select="@productOfferingId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--<xsl:template match="cartScheduleCharge">
                                <xsl:if test="current()!='' or count(@*)>0">
                                                <xsl:element name="v1:{local-name()} ">
                                                                <xsl:apply-templates select="typeCode"/>
                                                                <xsl:apply-templates select="amount"/>
                                                                <xsl:apply-templates select="description"/>
                                                                <xsl:apply-templates select="waiverIndicator"/>
                                                                <xsl:apply-templates select="waiverReason"/>
                                                </xsl:element>
                                </xsl:if>
                </xsl:template>-->

	<!-- create cart-->
	<xsl:template match="cartItemStatus">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@statusCode != ''">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="name"/>
				<xsl:apply-templates select="description"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="lineOfService">
		<xsl:if test="current() != '' or count(@*) > 0">
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
				<xsl:apply-templates select="lineOfServiceStatus"/>
				<xsl:apply-templates select="primaryLineIndicator"/>
				<xsl:apply-templates select="lineAlias"/>
				<xsl:apply-templates select="lineSequence"/>
				<xsl:apply-templates select="assignedProduct"/>
				<xsl:apply-templates select="preferredLanguage"/>
				<xsl:apply-templates select="effectivePeriod"/>
				<xsl:apply-templates select="memberLineOfService"/>
				<xsl:apply-templates select="specificationGroup"/>
				<xsl:apply-templates select="privacyProfile" mode="privacyProfile_lineOfservice"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="privacyProfile" mode="privacyProfile_lineOfservice">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="optOut"/>
				<xsl:apply-templates select="activityType"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="memberLineOfService">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="primaryLineIndicator"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="assignedProduct" mode="cartItem">
		<xsl:if test="current() != '' or count(//@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="productOffering" mode="cartItem"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="assignedProduct">
		<xsl:if test="current() != '' or count(//@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="key"/>
				<xsl:apply-templates select="productOffering" mode="lineOfService"/>
				<xsl:apply-templates select="effectivePeriod" mode="lineOfService"/>
				<xsl:apply-templates select="customerOwnedIndicator"/>
				<xsl:apply-templates select="serialNumber"/>
				<xsl:apply-templates select="eligibilityEvaluation"/>
				<xsl:apply-templates select="warranty"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="warranty">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="warrantyExpirationDate"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="eligibilityEvaluation">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="overrideIndicator"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="description | shortDescription" mode="productOffering-description">
		<xsl:if test="current() != '' or count(@*)">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@* | node()"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="productOffering" mode="lineOfService">
		<xsl:if test="current() != '' or @productOfferingId != '' or count(//@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@productOfferingId"/>
				<xsl:apply-templates select="name"/>
				<xsl:apply-templates select="shortName"/>
				<xsl:apply-templates select="displayName"/>
				<xsl:apply-templates select="description" mode="productOffering-description"/>
				<xsl:apply-templates select="shortDescription" mode="productOffering-description"/>
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
				<xsl:apply-templates select="specificationGroup"
					mode="productOffering-specificationGroup"/>
				<xsl:apply-templates select="offeringPrice"/>
				<xsl:apply-templates select="orderBehavior"/>
				<xsl:apply-templates select="image"/>
				<xsl:apply-templates select="marketingMessage"/>
				<xsl:apply-templates select="equipmentCharacteristics"/>
				<xsl:apply-templates select="serviceCharacteristics"/>
				<xsl:apply-templates select="offeringVariant"/>
				<xsl:apply-templates select="productSpecification" mode="lineOfService"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="productSpecification" mode="lineOfService">
		<xsl:if test="current() != '' or count(@*) > 0">
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

	<xsl:template match="subscriberContact">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="addressCommunication" mode="LOS"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="productOffering" mode="cartItem">
		<xsl:if test="current() != '' or @productOfferingId != ''or count(//@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@productOfferingId"/>
				<xsl:apply-templates select="name"/>
				<xsl:apply-templates select="shortName"/>
				<xsl:apply-templates select="displayName"/>
				<xsl:apply-templates select="description" mode="productOffering-description"/>
				<xsl:apply-templates select="shortDescription" mode="productOffering-description"/>
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
				<xsl:apply-templates select="specificationGroup"
					mode="productOffering-specificationGroup"/>
				<xsl:apply-templates select="offeringPrice"/>

				<xsl:apply-templates select="image"/>
				<xsl:apply-templates select="marketingMessage"/>
				<xsl:apply-templates select="equipmentCharacteristics"/>
				<xsl:apply-templates select="serviceCharacteristics"/>
				<xsl:apply-templates select="offeringVariant"/>
				<xsl:apply-templates select="productOfferingComponent"/>
				<xsl:apply-templates select="productSpecification"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="productOffering" mode="charge">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="keyword"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	<!-- create cart-->
	<xsl:template match="productOffering">
		<xsl:if test="current() != '' or @productOfferingId != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@productOfferingId"/>
				<xsl:apply-templates select="name"/>
				<xsl:apply-templates select="shortName"/>
				<xsl:apply-templates select="displayName"/>
				<xsl:apply-templates select="description" mode="productOffering-description"/>
				<xsl:apply-templates select="shortDescription" mode="productOffering-description"/>
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
				<xsl:apply-templates select="specificationGroup"
					mode="productOffering-specificationGroup"/>
				<xsl:apply-templates select="offeringPrice"/>
				<xsl:apply-templates select="orderBehavior" mode="cartItem"/>
				<xsl:apply-templates select="image"/>
				<xsl:apply-templates select="marketingMessage"/>
				<xsl:apply-templates select="equipmentCharacteristics"/>
				<xsl:apply-templates select="serviceCharacteristics"/>
				<xsl:apply-templates select="offeringVariant"/>
				<xsl:apply-templates select="productOfferingComponent"/>
				<xsl:apply-templates select="productSpecification"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="includedServiceCapacity">
		<xsl:if test="current() != ''">
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
		match="backDateAllowedIndicator | futureDateAllowedIndicator | backDateVisibleIndicator | futureDateVisibleIndicator | billableThirdPartyServiceIndicator | prorateAllowedIndicator | prorateVisibleIndicator">
		<xsl:if test="current() != '' or count(@*) > 0">
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

	<xsl:template match="serviceCharacteristics">
		<xsl:if test="current() != ''">
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
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="model"/>
				<xsl:apply-templates select="manufacturer"/>
				<xsl:apply-templates select="color"/>
				<xsl:apply-templates select="memory"/>
				<xsl:apply-templates select="tacCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="marketingMessage">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="salesChannelCode"/>
				<xsl:apply-templates select="relativeSize"/>
				<xsl:apply-templates select="messagePart"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="messagePart">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="code"/>
				<xsl:apply-templates select="messageText"/>
				<xsl:apply-templates select="messageSequence"/>

			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="messageText">
		<xsl:if test="current() != '' or count(@*) > 0">
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
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="classificationCode"/>
				<xsl:apply-templates select="nameValue"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="keyword">
		<xsl:if test="@name != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@name"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="productOfferingComponent">
		<xsl:if test="not(empty(.))">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@offeringComponentId">
					<xsl:attribute name="offeringComponentId">
						<xsl:value-of select="@offeringComponentId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="offeringVariant" mode="productOfferingComponent-offeringVariant"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="productOfferingComponent">
		<xsl:if test="not(empty(.))">
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
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="offeringVariant" mode="productOfferingComponent-offeringVariant">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="sku"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="offeringVariant">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="sku"/>
				<xsl:apply-templates select="specificationGroup"
					mode="productOffering-specificationGroup"/>
				<xsl:apply-templates select="offeringVariantPrice"/>
				<xsl:apply-templates select="productCondition"/>
				<xsl:apply-templates select="color"/>
				<xsl:apply-templates select="memory"/>
				<xsl:apply-templates select="tacCode"/>
				<xsl:apply-templates select="orderBehavior" mode="cartItem"/>

			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="offeringVariantPrice">
		<xsl:if test="current() != '' or count(@*) > 0">
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
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="URI"/>
				<xsl:apply-templates select="sku"/>
				<xsl:apply-templates select="imageDimensions"/>
				<xsl:apply-templates select="displayPurpose"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="orderBehavior">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="preOrderAllowedIndicator"/>
				<xsl:apply-templates select="preOrderAvailableTime"/>
				<xsl:apply-templates select="saleStartTime"/>
				<xsl:apply-templates select="saleEndTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="orderBehavior" mode="cartItem">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="preOrderAllowedIndicator"/>
				<xsl:apply-templates select="preOrderAvailableTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->


	<xsl:template match="promotion" mode="cartItem">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
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
				<xsl:apply-templates select="promotionName"/>
				<xsl:apply-templates select="promotionCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="eligibilityCriteria">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="postalCodeCriteria"/>
				<xsl:apply-templates select="countyCriteria"/>
				<xsl:apply-templates select="stateCriteria"/>
				<xsl:apply-templates select="countryCriteria"/>
				<xsl:apply-templates select="billingTypeCriteria"/>
				<xsl:apply-templates select="eligibleAccountTypeCriteria"/>
				<xsl:apply-templates select="channelCriteria"/>
				<xsl:apply-templates select="creditWorthinessCriteria"/>
				<xsl:apply-templates select="cityCriteria"/>
				<xsl:apply-templates select="storeCriteria"/>
				<xsl:apply-templates select="programCode"/>
				<xsl:apply-templates select="accountClassification"/>
				<xsl:apply-templates select="customerGroup"/>
				<xsl:apply-templates select="marketCode"/>
				<xsl:apply-templates select="specificationGroup"/>
				<xsl:apply-templates select="tacCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="specificationGroup" mode="productOffering-specificationGroup">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@name"/>
				<xsl:apply-templates select="specificationValue"
					mode="organizationSpecification-specificationValue"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="specificationGroup">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="specificationValue"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="specificationValue" mode="organizationSpecification-specificationValue">
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

	<!--  now added -->

	<xsl:template match="specificationValue" mode="productOffering-specificationGroup">
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

	<!-- offering price -->
	<xsl:template match="offeringPrice">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">

				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="name"/>
				<xsl:apply-templates select="productOfferingPrice"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- createcart-->
	<xsl:template match="productOfferingPrice">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="name"/>
				<xsl:apply-templates select="productChargeType"/>
				<xsl:apply-templates select="productChargeIncurredType"/>
				<xsl:apply-templates select="basisAmount"/>
				<xsl:apply-templates select="amount"/>
				<xsl:apply-templates select="oneTimeCharge"/>
				<xsl:apply-templates select="taxInclusiveIndicator"/>
				<xsl:apply-templates select="specificationValue"
					mode="productOffering-specificationGroup"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="productSpecification">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode != ''">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@productSpecificationId != ''">
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

	<xsl:template match="additionalSpecification">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="specificationValue"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="networkResource">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<!--xsl:apply-templates select="@*"/-->
				<xsl:if test="@actionCode != ''">
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
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@name"/>
				<xsl:apply-templates select="specificationValue"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="sim">
		<xsl:if test="current() != '' or count(@*) > 0">
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
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="msisdn"/>
				<xsl:apply-templates select="portIndicator"/>
				<xsl:apply-templates select="portReason"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="charge">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode != ''">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="typeCode"/>
				<xsl:apply-templates select="chargeFrequencyCode"/>
				<xsl:apply-templates select="amount"/>
				<xsl:apply-templates select="description"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="charge" mode="cartSummary">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode != ''">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="typeCode"/>
				<xsl:apply-templates select="chargeFrequencyCode"/>
				<xsl:apply-templates select="amount"/>
				<xsl:apply-templates select="description"/>
				<xsl:apply-templates select="chargeCode"/>
				<xsl:apply-templates select="productOffering"/>
				<xsl:apply-templates select="productOfferingPriceId"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- create cart-->
	<xsl:template match="deduction">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode != ''">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="amount"/>
				<xsl:apply-templates select="description"/>
				<xsl:apply-templates select="recurringFrequency"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="deduction" mode="cartSummary">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode != ''">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="amount"/>
				<xsl:apply-templates select="description"/>
				<xsl:apply-templates select="recurringFrequency"/>
				<xsl:apply-templates select="promotion"/>
				<xsl:apply-templates select="chargeCode"/>
				<xsl:apply-templates select="productOfferingPriceId"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="addressList">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@id != ''">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="addressCommunication" mode="addressList"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="customer">
		<xsl:if test="current() != '' or @actionCode != '' or @customerId != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="$customerId or @customerId">
					<xsl:attribute name="customerId">
						<xsl:choose>
							<xsl:when test="$customerId">
								<xsl:value-of select="$customerId"/>
							</xsl:when>
							<xsl:when test="@customerId">
								<xsl:value-of select="@customerId"/>
							</xsl:when>
						</xsl:choose>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="@actionCode"/>
				<xsl:apply-templates select="key"/>
				<xsl:apply-templates select="customerType"/>
				<xsl:apply-templates select="status"/>
				<xsl:apply-templates select="party" mode="party-customer"/>
				<xsl:choose>
					<xsl:when test="$orderType = 'ACTIVATION' or $custFinActionCode ='ADD'">
						<v1:customerGroup>
							<xsl:value-of select="'Consumer'"/>
						</v1:customerGroup>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="customerGroup"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="party" mode="party-customer">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="organization"/>
				<xsl:apply-templates select="person"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="person">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="personName" mode="shipTo"/>
				<xsl:apply-templates select="ssn"/>
				<xsl:apply-templates select="preferredLanguage"/>
				<xsl:apply-templates select="addressCommunication" mode="party-person"/>
				<xsl:apply-templates select="birthDate"/>
				<xsl:apply-templates select="phoneCommunication"/>
				<xsl:apply-templates select="emailCommunication"/>
				<xsl:apply-templates select="driversLicense"/>
				<xsl:apply-templates select="nationalIdentityDocument"/>
				<xsl:apply-templates select="citizenship"/>
				<xsl:apply-templates select="passport"/>
				<xsl:apply-templates select="visa"/>
				<xsl:apply-templates select="gender"/>
				<xsl:apply-templates select="maritalStatus"/>
				<xsl:apply-templates select="activeDutyMilitary"/>
				<xsl:apply-templates select="securityProfile" mode="party-securityProfile"/>
				<xsl:apply-templates select="identityDocumentVerification"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="identityDocumentVerification">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="identityDocumentType"/>
				<xsl:apply-templates select="validPeriod"/>
				<xsl:apply-templates select="verificationEvent"/>
				<xsl:apply-templates select="verificationStatus"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="verificationEvent">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="creationContext"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="creationContext">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="userName"/>
				<xsl:apply-templates select="eventTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="validPeriod">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="startDate"/>
				<xsl:apply-templates select="endDate"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="passport">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="passportNumber"/>
				<xsl:apply-templates select="typeCode"/>
				<xsl:apply-templates select="issuedDate"/>
				<xsl:apply-templates select="expirationDate"/>
				<xsl:apply-templates select="issuingCountryCode"/>
				<xsl:apply-templates select="issuingStateCode"/>
				<xsl:apply-templates select="issuingLocation"/>
				<xsl:apply-templates select="issuingAuthority"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="visa">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="numberID"/>
				<xsl:apply-templates select="typeCode"/>
				<xsl:apply-templates select="classificationCode"/>
				<xsl:apply-templates select="issuingCountryCode"/>
				<xsl:apply-templates select="legislationCode"/>
				<xsl:apply-templates select="validIndicator"/>
				<xsl:apply-templates select="profession"/>
				<xsl:apply-templates select="issuedDate"/>
				<xsl:apply-templates select="expirationDate"/>
				<xsl:apply-templates select="entryDate"/>
				<xsl:apply-templates select="status" mode="visa"/>
				<xsl:apply-templates select="issuingLocation"/>
				<xsl:apply-templates select="issuingAuthority"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="status" mode="visa">
		<xsl:element name="v1:{local-name()} ">
			<xsl:if test="@statusCode">
				<xsl:attribute name="statusCode" select="@statusCode"/>
			</xsl:if>
		</xsl:element>
	</xsl:template>
	<!--nowAADED-->

	<xsl:template match="addressCommunication" mode="party-person">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
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
				<xsl:apply-templates select="address" mode="party-person-address"/>
				<xsl:apply-templates select="usageContext"/>

			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="address" mode="party-person-address">
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
				<xsl:apply-templates select="building"/>
				<xsl:apply-templates select="floor"/>
				<xsl:apply-templates select="area"/>
				<xsl:apply-templates select="ruralRoute"/>
				<xsl:apply-templates select="countrySubDivisionID"/>
				<xsl:apply-templates select="citySubDivisionName"/>
				<xsl:apply-templates select="timeZone"/>
				<xsl:apply-templates select="houseNumber"/>
				<xsl:apply-templates select="streetName"/>
				<xsl:apply-templates select="streetSuffix"/>
				<xsl:apply-templates select="trailingDirection"/>
				<xsl:apply-templates select="unitType"/>
				<xsl:apply-templates select="unitNumber"/>
				<xsl:apply-templates select="streetDirection"/>
				<xsl:apply-templates select="houseNumberSuffix"/>
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

	<xsl:template match="preferredLanguage">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@usageContext != ''">
					<xsl:attribute name="usageContext">
						<xsl:value-of select="@usageContext"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="ssn | cardNumber">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@maskingType != ''">
					<xsl:attribute name="maskingType">
						<xsl:value-of select="@maskingType"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="organization">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="fullName"/>
				<xsl:apply-templates select="shortName"/>
				<xsl:apply-templates select="legalName"/>
				<xsl:apply-templates select="organizationSpecification"/>
				<xsl:apply-templates select="sicCode"/>
				<xsl:apply-templates select="organizationEmploymentStatistics"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="organizationEmploymentStatistics">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="totalEmployment"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="totalEmployment">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="employeeCount"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="person" mode="person-party-accountHolder">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="addressCommunication"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="addressCommunication">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@*"/>
				<!--xsl:apply-templates select="privacyProfile"/-->
				<!--xsl:apply-templates select="address" mode="address-addressCommunication-person"/-->
				<xsl:apply-templates select="usageContext"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="chargeAmount">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@currencyCode != ''">
					<xsl:attribute name="currencyCode">
						<xsl:value-of select="@currencyCode"/>
					</xsl:attribute>
				</xsl:if>
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