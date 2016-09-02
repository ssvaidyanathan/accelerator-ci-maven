<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:v1="http://services.tmobile.com/OrderManagement/CartWSIL/V1"
	xmlns:ent="http://services.tmobile.com/SecurityManagement/UserSecurityEnterprise/V1"
	xmlns:base="http://services.tmobile.com/base" version="2.0" xmlns:saxon="http://saxon.sf.net/"
	exclude-result-prefixes="saxon ent">


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
	<xsl:param name="cartId"/>
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

	<xsl:param name="channelCode"/>
	<xsl:param name="subChannelCode"/>
	<xsl:param name="category"/>

	<xsl:param name="app_channelCode"/>
	<xsl:param name="app_subChannelCode"/>
	<xsl:param name="app_category"/>
	<xsl:param name="tokenScope"/>

	<xsl:variable name="orderType">
		<xsl:value-of select="//cart/orderType"/>
	</xsl:variable>
	

	<!--<xsl:variable name="capientitlementprefix">v1</xsl:variable>
	<xsl:variable name="capientitlementns">http://services.tmobile.com/OrderManagement/CartWSIL/V1</xsl:variable>-->

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
								<xsl:variable name="entitlementStr"  select="replace(replace(replace(replace($ABFEntitlements,'TO_BE_REPLACED_PREFIX',$capientitlementprefix),'TO_BE_REPLACED_NAMESPACE',$capientitlementns),'TO_BE_REPLACED_BASE_NAMESPACE',$capibase),'TO_BE_REPLACED_BASE_PREFIX',$capibaseprefix)"/>
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

					<xsl:apply-templates select="cart"/>

				</v1:updateCartRequest>
			</soapenv:Body>
		</soapenv:Envelope>
	</xsl:template>

	<!-- CD3D.1 -->
	<xsl:template match="cart">

		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="$cartId">
					<xsl:attribute name="cartId">
						<xsl:value-of select="$cartId"/>
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
						<xsl:if	test="$app_channelCode != '' or $app_subChannelCode != '' or $app_category != ''">
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
				<xsl:apply-templates select="billTo"/>
				<xsl:apply-templates select="cartItem"/>
				<xsl:apply-templates select="charge"/>
				<xsl:apply-templates select="deduction"/>
				<xsl:apply-templates select="tax" mode="tax-cartItem"/>
				<xsl:apply-templates select="freightCharge"/>
				<xsl:apply-templates select="payment"/>
				<xsl:apply-templates select="addressList"/>
				<xsl:apply-templates select="cartSummary"/>
				<xsl:apply-templates select="searchContext"/>
				<xsl:apply-templates select="validationMessage"/>

			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="orderLocation">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="location"/>
				<xsl:apply-templates select="tillNumber"/>
				<!--xsl:apply-templates select="dealerCode"/-->
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="location">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- CD3D1 -->
	<xsl:template match="port">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:port">
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
				<xsl:apply-templates select="oldVirtualServiceProviderName"/>
				<xsl:apply-templates select="oldVirtualServiceProviderId"/>
				<xsl:apply-templates select="personProfile"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="personProfile">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="addressCommunication" mode="port-personProfile"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="addressCommunication" mode="port-personProfile">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="address" mode="port-personProfile"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="address" mode="port-personProfile">
		<xsl:if test="normalize-space(.) != ''">
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

	<!-- update cart-->
	<xsl:template match="searchContext">
		<xsl:if test="current() != '' or count(@*) > 0">

			<xsl:if test="specificationValue/@name = 'getEligibleOffers'">
				<xsl:element name="v1:getEligibleOffers">
					<xsl:value-of select="specificationValue[@name = 'getEligibleOffers']"/>
				</xsl:element>
			</xsl:if>

			<xsl:if test="specificationValue/@name = 'searchContext'">

				<xsl:element name="v1:searchContext">
					<xsl:apply-templates select="specificationValue[@name = 'searchContext']"/>
				</xsl:element>
			</xsl:if>



			<xsl:if test="specificationValue/@name = 'eipFlag'">
				<xsl:element name="v1:eipFlag">
					<xsl:value-of select="specificationValue[@name = 'eipFlag']"/>
				</xsl:element>
			</xsl:if>

		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="cartSummary">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="financialAccountId"/>
				<xsl:apply-templates select="lineOfServiceId"/>
				<xsl:apply-templates select="summaryScope"/>
				<xsl:apply-templates select="totalDueAmount"/>
				<xsl:apply-templates select="totalRecurringDueAmount"/>
				<xsl:apply-templates select="charge"/>
				<xsl:apply-templates select="deduction"/>
				<xsl:apply-templates select="tax"/>
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


	<!--CD3D1-->
	<xsl:template match="status">
		<xsl:if test="@statusCode != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@statusCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="salesChannel">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="salesChannelCode"/>
				<xsl:apply-templates select="salesSubChannelCode"/>
				<xsl:apply-templates select="subChannelCategory"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
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
			<xsl:apply-templates select="personName" mode="personName-salesperson"/>
		</xsl:element>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="personName" mode="personName-salesperson">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="firstName"/>
				<xsl:apply-templates select="familyName"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="cartSpecification">
		<xsl:if test="current() != '' or count(@*) > 0">
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

	<!--CD3D1-->
	<xsl:template match="specificationValue">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@name | node()"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="termsAndConditionsDisposition">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="acceptanceIndicator"/>
				<xsl:apply-templates select="acceptanceTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="relatedOrder">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="orderId"/>
				<xsl:apply-templates select="relationshipType"/>
				<xsl:apply-templates select="orderStatus"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="orderStatus">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@statusCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<!--CD3D1-->
	<xsl:template match="shipping">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="freightCarrier"/>
				<xsl:apply-templates select="promisedDeliveryTime"/>
				<xsl:apply-templates select="shipTo"/>
				<xsl:apply-templates select="note"/>
				<xsl:apply-templates select="serviceLevelCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="note">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@language"/>
				<xsl:apply-templates select="entryTime"/>
				<xsl:apply-templates select="noteType"/>
				<xsl:apply-templates select="content"/>
				<xsl:apply-templates select="author"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="shipTo">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
			    <xsl:apply-templates select="personName" mode="shipTo"/>
				<xsl:apply-templates select="addressCommunication"
					mode="addressCommunication-shipTo"/>
				<xsl:apply-templates select="phoneCommunication" mode="phoneCommunication-shipTo"/>
				<xsl:apply-templates select="emailCommunication" mode="emailCommunication-shipTo"/>
				<xsl:apply-templates select="preferredLanguage"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="phoneCommunication" mode="phoneCommunication-shipTo">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="phoneType"/>
				<xsl:apply-templates select="phoneNumber"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="emailCommunication" mode="emailCommunication-shipTo">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="emailAddress"/>
				<xsl:apply-templates select="emailFormat"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="description">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@languageCode | @usageContext | node()"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="effectivePeriod" mode="effectivePeriod-cartScheduleDeduction">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="startTime"/>
				<xsl:apply-templates select="endTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="effectivePeriod" mode="effectivePeriod-cartScheduleCharge">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="startTime"/>
				<xsl:apply-templates select="endTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="effectivePeriod" mode="effectivePeriod-productOffering-assignedProduct">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="startTime"/>
				<xsl:apply-templates select="endTime"/>
				<xsl:apply-templates select="usageContext"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="effectivePeriod" mode="cartItem-effectivePeriod">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="startTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="billTo">
		<xsl:if test="not(empty(.))">
			<xsl:element name="v1:{local-name()} ">
				<xsl:choose>
					<xsl:when test="$orderType = 'ACTIVATION'">
						<xsl:choose>
							<xsl:when test="customerAccount">
								<xsl:apply-templates select="customerAccount"/>
							</xsl:when>
							<xsl:when test="//billTo/customer/party/person/addressCommunication/usageContext | //billTo/customer/party/person/addressCommunication/@id | //billTo/customer/customerGroup">
								<v1:customerAccount>
									<v1:financialAccount>
										<v1:billingArrangement>
											<v1:billingContact>
												<v1:addressCommunication>
													<xsl:if test="//billTo/customer/party/person/addressCommunication/@id">
														<xsl:attribute name="id" select="//billTo/customer/party/person/addressCommunication/@id"/>
													</xsl:if>
													<xsl:if test="//billTo/customer/party/person/addressCommunication/usageContext">
														<v1:usageContext>
															<xsl:value-of select="//billTo/customer/party/person/addressCommunication/usageContext/node()"/>
														</v1:usageContext>
													</xsl:if>
												</v1:addressCommunication>
											</v1:billingContact>
										</v1:billingArrangement>
										<xsl:if test="//billTo/customer/customerGroup">
											<v1:customerGroup>
												<xsl:value-of select="//billTo/customer/customerGroup/node()"/>
											</v1:customerGroup>
										</xsl:if>
									</v1:financialAccount>
								</v1:customerAccount>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="customerAccount"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:apply-templates select="customer"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="customerAccount">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<!--xsl:apply-templates select="customerAccountNumber"/-->
				<xsl:if test="@customerAccountId">
					<xsl:attribute name="customerAccountId">
						<xsl:value-of select="@customerAccountId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="accountClassification"/>
				<xsl:apply-templates select="businessUnit"/>
				<xsl:apply-templates select="programMembership"/>
				<xsl:apply-templates select="specificationGroup"/>
				<!--xsl:apply-templates select="accountHolder"/-->
				<xsl:apply-templates select="paymentProfile"/>
				<xsl:apply-templates select="idVerificationIndicator"/>
				<xsl:apply-templates select="corporateAffiliationProgram"/>
				<xsl:apply-templates select="strategicAccountIndicator"/>
				<xsl:choose>
					<xsl:when test="$orderType = 'ACTIVATION'">
						<xsl:choose>
							<xsl:when test="financialAccount">
								<xsl:apply-templates select="financialAccount"/>
							</xsl:when>
							<xsl:when test="//billTo/customer/party/person/addressCommunication/usageContext | //billTo/customer/party/person/addressCommunication/@id | //billTo/customer/customerGroup">
								<v1:financialAccount>
									<v1:billingArrangement>
										<v1:billingContact>
											<v1:addressCommunication>
												<xsl:if test="//billTo/customer/party/person/addressCommunication/@id">
													<xsl:attribute name="id" select="//billTo/customer/party/person/addressCommunication/@id"/>
												</xsl:if>
												<xsl:if test="//billTo/customer/party/person/addressCommunication/usageContext">
													<v1:usageContext>
														<xsl:value-of select="//billTo/customer/party/person/addressCommunication/usageContext/node()"/>
													</v1:usageContext>
												</xsl:if>
											</v1:addressCommunication>
										</v1:billingContact>
									</v1:billingArrangement>
									<xsl:if test="//billTo/customer/customerGroup">
										<v1:customerGroup>
											<xsl:value-of select="//billTo/customer/customerGroup/node()"/>
										</v1:customerGroup>
									</xsl:if>
								</v1:financialAccount>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="financialAccount"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="programMembership">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="programCode"/>
				<xsl:apply-templates select="description"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="financialAccount">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="financialAccountNumber"/>
				<xsl:apply-templates select="billingMethod"/>
				<xsl:apply-templates select="status" mode="status-financialAccount"/>
				<xsl:apply-templates select="billCycle"/>
				<xsl:choose>
					<xsl:when test="$orderType = 'ACTIVATION'">
						<xsl:choose>
							<xsl:when test="billingArrangement">
								<xsl:apply-templates select="billingArrangement"/>
							</xsl:when>
							<xsl:when test="//billTo/customer/party/person/addressCommunication/usageContext | //billTo/customer/party/person/addressCommunication/@id">
								<v1:billingArrangement>
									<v1:billingContact>
										<v1:addressCommunication>
											<xsl:if test="//billTo/customer/party/person/addressCommunication/@id">
												<xsl:attribute name="id" select="//billTo/customer/party/person/addressCommunication/@id"/>
											</xsl:if>
											<xsl:if test="//billTo/customer/party/person/addressCommunication/usageContext">
												<v1:usageContext>
													<xsl:value-of select="//billTo/customer/party/person/addressCommunication/usageContext/node()"/>
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
				<xsl:apply-templates select="programMembership"/>
				<xsl:apply-templates select="specialTreatment"/>
				<xsl:apply-templates select="customerGroup"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="specialTreatment">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="treatmentType"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="accountBalanceSummaryGroup">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="balanceSummary"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="balanceSummary">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="amount"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="accountContact">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="addressCommunication"
					mode="accountContact-addressCommunication"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="addressCommunication" mode="accountContact-addressCommunication">
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
				<xsl:apply-templates select="privacyProfile"
					mode="addressCommunication-privacyProfile"/>
				<xsl:apply-templates select="address"/>
				<xsl:apply-templates select="usageContext"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="privacyProfile" mode="addressCommunication-privacyProfile">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="optOut"/>
				<xsl:apply-templates select="activityType"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="status" mode="status-financialAccount">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="reasonCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<!-- AddedIndicator -->

	<xsl:template match="billCycle">

		<xsl:if
			test="(normalize-space(.) != '' or count(.//@*) != 0) and lower-case(normalize-space((uiAddedIndicator))) = 'true'">

			<xsl:element name="v1:{local-name()} ">

				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@billCycleId">
					<xsl:attribute name="billCycleId">
						<xsl:value-of select="@billCycleId"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:apply-templates select="dayOfMonth"/>
				<xsl:apply-templates select="frequencyCode"/>
				<!--xsl:apply-templates select="AddedIndicator"/-->

			</xsl:element>
		</xsl:if>

	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="paymentProfile">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="paymentTerm"/>
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
							<xsl:when test="//billTo/customer/party/person/addressCommunication/usageContext | //billTo/customer/party/person/addressCommunication/@id">
								<v1:billingContact>
									<v1:addressCommunication>
										<xsl:if test="//billTo/customer/party/person/addressCommunication/@id">
											<xsl:attribute name="id" select="//billTo/customer/party/person/addressCommunication/@id"/>
										</xsl:if>
										<xsl:if test="//billTo/customer/party/person/addressCommunication/usageContext">
											<v1:usageContext>
												<xsl:value-of select="//billTo/customer/party/person/addressCommunication/usageContext/node()"/>
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
								<xsl:apply-templates select="addressCommunication" mode="financialAccount-billingArragement"/>
							</xsl:when>
							<xsl:when test="//billTo/customer/party/person/addressCommunication/usageContext | //billTo/customer/party/person/addressCommunication/@id">
								<v1:addressCommunication>
									<xsl:if test="//billTo/customer/party/person/addressCommunication/@id">
										<xsl:attribute name="id" select="//billTo/customer/party/person/addressCommunication/@id"/>
									</xsl:if>
									<xsl:if test="//billTo/customer/party/person/addressCommunication/usageContext">
										<v1:usageContext>
											<xsl:value-of select="//billTo/customer/party/person/addressCommunication/usageContext/node()"/>
										</v1:usageContext>
									</xsl:if>
								</v1:addressCommunication>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="addressCommunication" mode="addressCommunication-billingContact"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="addressCommunication" mode="addressCommunication-billingContact">
		<xsl:if
			test="(normalize-space(.) != '' or count(.//@*) != 0) and lower-case(normalize-space((uiAddedIndicator))) = 'true'">
			<xsl:element name="v1:{local-name()} ">
				<xsl:choose>
					<xsl:when test="$orderType = 'ACTIVATION'">
						<xsl:choose>
							<xsl:when test="//billTo/customer/party/person/addressCommunication/usageContext | //billTo/customer/party/person/addressCommunication/@id">
								<xsl:if test="//billTo/customer/party/person/addressCommunication/@id">
									<xsl:attribute name="id" select="//billTo/customer/party/person/addressCommunication/@id"/>
								</xsl:if>
								<xsl:apply-templates select="uiAddedIndicator"/>
								<xsl:apply-templates select="address" mode="addressCommunication-address"/>
								<xsl:if test="//billTo/customer/party/person/addressCommunication/usageContext">
									<v1:usageContext>
										<xsl:value-of select="//billTo/customer/party/person/addressCommunication/usageContext/node()"/>
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
						<xsl:apply-templates select="uiAddedIndicator"/>
						<xsl:apply-templates select="address" mode="addressCommunication-address"/>
						<xsl:apply-templates select="usageContext"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="address" mode="addressCommunication-address">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="key"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<!--CD3D1-->
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

	<!--CD3D1-->
	<xsl:template match="organizationEmploymentStatistics">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="totalEmployment"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="totalEmployment">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="employeeCount"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="organizationSpecification">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="specificationValue"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="person">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
			    <xsl:apply-templates select="personName" mode="shipTo"/>
				<xsl:apply-templates select="ssn"/>
				<xsl:apply-templates select="preferredLanguage"/>
				<xsl:apply-templates select="addressCommunication"
					mode="addressCommunication-person-party-customer"/>
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
				<xsl:apply-templates select="securityProfile"/>
				<xsl:apply-templates select="identityDocumentVerification"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
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

	<!--CD3D1-->
	<xsl:template match="verificationStatus">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="verificationEvent">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="creationContext"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="creationContext">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="userName"/>
				<xsl:apply-templates select="eventTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="validPeriod">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="startDate"/>
				<xsl:apply-templates select="endDate"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="preferredLanguage">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@usageContext">
					<xsl:attribute name="usageContext">
						<xsl:value-of select="@usageContext"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="ssn | cardNumber">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@maskingType">
					<xsl:attribute name="maskingType">
						<xsl:value-of select="@maskingType"/>
					</xsl:attribute>
				</xsl:if>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
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

	<!--CD3D1-->
	<xsl:template match="addressCommunication" mode="addressCommunication-person-party-customer">



		<xsl:if
			test="(normalize-space(.) != '' or count(.//@*) != 0) and lower-case(normalize-space((uiAddedIndicator))) = 'true'">

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
				<!--xsl:apply-templates select="address"/-->
				<xsl:apply-templates select="uiAddedIndicator"/>
				<xsl:apply-templates select="usageContext"/>
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

	<!--CD3D1-->
    <xsl:template match="personName" mode="shipTo">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="firstName"/>
				<xsl:apply-templates select="middleName"/>
				<xsl:apply-templates select="familyName"/>
				<xsl:apply-templates select="aliasName"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="addressCommunication" mode="addressList">
		<xsl:if test="current() != '' or count(@*) > 0">
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
		<xsl:if test="current() != '' or count(@*) > 0">
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

	<!--CD3D1-->
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

	<!--CD3D1-->
	<xsl:template match="preference">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="preferred"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<!--CD3D1-->
	<xsl:template match="key" mode="key-address-addressCommunication-subscriberContact">
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

	<!--CD3D1 -->
	<xsl:template match="address">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">

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
				<xsl:apply-templates select="observesDaylightSavingsIndicator"/>
				<xsl:apply-templates select="matchIndicator"/>

			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="geographicCoordinates">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="latitude"/>
				<xsl:apply-templates select="longitude"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="geoCodeID">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="v1:{local-name()}">
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
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="phoneCommunication">

		<xsl:if
			test="(normalize-space(.) != '' or count(.//@*) != 0)">
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

	<!--CD3D1-->
	<xsl:template match="emailCommunication">
		<xsl:if test="normalize-space(.) != ''">
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

	<!--CD3D1-->
	<xsl:template match="citizenship">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="countryCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<!--CD3D1-->
	<xsl:template match="specificationGroup">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@name | specificationValue"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- CD3D1-->
	<xsl:template match="specificationValue">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@name | node()"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<!--CD3D1-->
	<xsl:template match="securityProfile">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="userName"/>
				<xsl:apply-templates select="pin"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<!--CD3D1-->
	<xsl:template match="cartItem">

		<xsl:if
			test="(normalize-space(.) != '' or count(.//@*) != 0) and lower-case(normalize-space((uiAddedIndicator))) = 'true'">

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
				<!--xsl:apply-templates select="AddedIndicator"/-->
				<xsl:apply-templates select="overridePriceAllowedIndicator"/>
				<xsl:apply-templates select="quantity"/>
				<xsl:apply-templates select="cartItemStatus"/>
				<xsl:apply-templates select="parentCartItemId"/>
				<xsl:apply-templates select="rootParentCartItemId"/>
				<xsl:apply-templates select="effectivePeriod" mode="cartItem-effectivePeriod"/>
				<xsl:apply-templates select="productOffering"/>
				<xsl:apply-templates select="assignedProduct"/>
				<xsl:apply-templates select="cartSchedule"/>
				<xsl:apply-templates select="specificationGroup"/>
				<xsl:apply-templates select="promotion" mode="cartItem-promotion"/>
				<xsl:apply-templates select="lineOfService"/>
				<xsl:apply-templates select="relatedCartItemId"/>
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
				<xsl:apply-templates select="financialAccount" mode="financialAccount-cartItem"/>
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

	<!-- CD3D1 -->
	<xsl:template match="financialAccount" mode="financialAccount-cartItem">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="financialAccountNumber"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="deviceConditionQuestions">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()}">
				<xsl:apply-templates select="verificationQuestion"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="verificationQuestion">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()}">
				<xsl:apply-templates select="questionText"/>
				<xsl:apply-templates select="verificationAnswer"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="verificationAnswer">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()}">
				<xsl:apply-templates select="answerText"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="quantity">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@measurementUnit | node()"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
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

	<!-- CD3D1 -->
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
				<xsl:apply-templates select="effectivePeriod" mode="effectivePeriod-cartScheduleCharge"/>
				<xsl:apply-templates select="description"/>
				<xsl:apply-templates select="chargeCode"/>
				<xsl:apply-templates select="waiverIndicator"/>
				<xsl:apply-templates select="waiverReason"/>
				<xsl:apply-templates select="manuallyAddedCharge"/>
				<xsl:apply-templates select="productOffering"
					mode="cartScheduleCharge-productOffering"/>
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

	<xsl:template match="feeOverrideAllowed">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@name | node()"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- CD3D1 -->
	<xsl:template match="productOffering" mode="cartScheduleCharge-productOffering">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@productOfferingId">
					<xsl:attribute name="productOfferingId">
						<xsl:value-of select="@productOfferingId"/>
					</xsl:attribute>
				</xsl:if>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- CD3D1 -->
	<xsl:template match="cartScheduleStatus">
		<xsl:if test="current() != '' or count(@*) > 0">
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

	<!--CD3D1-->
	<xsl:template match="cartScheduleDeduction">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:if test="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="amount"/>
				<xsl:apply-templates select="reason"/>
				<xsl:apply-templates select="effectivePeriod" mode="effectivePeriod-cartScheduleDeduction"/>
				<xsl:apply-templates select="description"/>
				<xsl:apply-templates select="recurringFrequency"/>
				<xsl:apply-templates select="promotion" mode="promotion-cartScheduleDeduction"/>
				<xsl:apply-templates select="chargeCode"/>
				<xsl:apply-templates select="productOfferingPriceId"/>
				<xsl:apply-templates select="specificationValue"/>
				<xsl:apply-templates select="realizationMethod"/>
				<xsl:apply-templates select="proratedIndicator"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
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

	<!--CD3D1-->
	<xsl:template match="promotion" mode="promotion-cartScheduleDeduction">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@promotionId"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>




	<!--CD3D1-->
	<xsl:template match="cartItemStatus">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="name"/>
				<xsl:apply-templates select="description" mode="description-cartItemStatus"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="description" mode="description-cartItemStatus">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@usageContext">
					<xsl:attribute name="usageContext">
						<xsl:value-of select="@usageContext"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- CD3D1 -->
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
				<xsl:apply-templates select="networkResource" mode="networkResource-lineOfService"/>
				<!--xsl:apply-templates select="pin"/-->
				<xsl:apply-templates select="lineOfServiceStatus"/>
				<xsl:apply-templates select="primaryLineIndicator"/>
				<xsl:apply-templates select="lineAlias"/>
				<xsl:apply-templates select="lineSequence"/>
				<xsl:apply-templates select="assignedProduct"/>
				<xsl:apply-templates select="preferredLanguage"/>
				<xsl:apply-templates select="effectivePeriod" mode="cartItem-effectivePeriod"/>
				<xsl:apply-templates select="memberLineOfService"/>
				<xsl:apply-templates select="specificationGroup"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- CD3D1 -->
	<xsl:template match="memberLineOfService">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="primaryLineIndicator"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- CD3D1 -->
	<xsl:template match="assignedProduct">
		<xsl:if test="current() != '' or count(//@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="key"/>
				<xsl:apply-templates select="productOffering"/>
				<xsl:apply-templates select="effectivePeriod"
					mode="effectivePeriod-productOffering-assignedProduct"/>
				<xsl:apply-templates select="customerOwnedIndicator"/>
				<xsl:apply-templates select="eligibilityEvaluation"/>
				<xsl:apply-templates select="warranty"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- CD3D1-->
	<xsl:template match="eligibilityEvaluation">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="overrideIndicator"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- CD3D1-->
	<!--xsl:template match="overrideIndicator">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="node()"/>
			</xsl:element>
		</xsl:if>
	</xsl:template-->

	<!-- CD3D1-->
	<xsl:template match="warranty">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="warrantyExpirationDate"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- CD3D.1 -->
	<xsl:template match="lineOfServiceStatus">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@statusCode"/>
				<xsl:apply-templates select="reasonCode"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="subscriberContact">

		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="addressCommunication"
					mode="addressCommunication-subscriberContact"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>



	<!-- CD3D1 -->
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

	<!-- CD3D1 -->
	<xsl:template
		match="backDateAllowedIndicator | futureDateAllowedIndicator | backDateVisibleIndicator | futureDateVisibleIndicator  | billableThirdPartyServiceIndicator | prorateAllowedIndicator | prorateVisibleIndicator | overrideIndicator">
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
	
	<!-- CD3D1 -->
	<xsl:template match="unlimitedIndicator">
		<xsl:if test="normalize-space(.) != '' or @name">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="unlimitedIndicator"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- CD3D1 -->
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



	<!-- CD3D1 -->
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

	<!-- CD3D1 -->
	<xsl:template match="marketingMessage">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="salesChannelCode"/>
				<xsl:apply-templates select="relativeSize"/>
				<xsl:apply-templates select="messagePart"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- CD3D1 -->
	<xsl:template match="messagePart">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="code"/>
				<xsl:apply-templates select="messageText"/>
				<xsl:apply-templates select="messageSequence"/>

			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- CD3D1 -->
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

	<!-- CD3D1 -->
	<xsl:template match="keyword">
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

	<!-- CD3D1 -->
	<xsl:template match="offeringClassification">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="classificationCode"/>
				<xsl:apply-templates select="nameValue"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- CD3D1-->
	<xsl:template match="description" mode="productOffering-description">
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

	<!-- CD3D1-->
	<xsl:template match="shortDescription" mode="productOffering-shortDescription">
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

	<!--CD3D1-->
	<xsl:template match="productOffering">
		<xsl:if test="current() != '' or count(//@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@productOfferingId">
					<xsl:attribute name="productOfferingId">
						<xsl:value-of select="@productOfferingId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="name"/>
				<xsl:apply-templates select="shortName"/>
				<xsl:apply-templates select="displayName"/>
				<xsl:apply-templates select="description" mode="productOffering-description"/>
				<xsl:apply-templates select="shortDescription"
					mode="productOffering-shortDescription"/>
				<xsl:apply-templates select="longDescription"/>
				<xsl:apply-templates select="alternateDescription"/>
				<xsl:apply-templates select="keyword"/>
				<xsl:apply-templates select="offerType"/>
				<xsl:apply-templates select="offerSubType"/>
				<xsl:apply-templates select="offerLevel"/>
				<!--xsl:apply-templates select="offeringStatus"/-->
				<xsl:apply-templates select="offeringClassification"/>
				<xsl:apply-templates select="businessUnit"/>
				<xsl:apply-templates select="productType"/>
				<xsl:apply-templates select="productSubType"/>
				<xsl:apply-templates select="key"/>
				<xsl:apply-templates select="specificationGroup"/>
				<xsl:apply-templates select="offeringPrice"/>
				<xsl:apply-templates select="orderBehavior" mode="orderBehavior-productOffering"/>
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


	<!--CD3D1-->
	<xsl:template match="productOfferingComponent">
		<xsl:if test="current() != '' or count(@*) > 0">
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
	
	<!-- PKG 2.1 -->
	<xsl:template match="offeringVariant" mode="productOfferingComponent-offeringVariant">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="sku"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="longDescription">
		<xsl:if test="current() != '' or count(@*) > 0">
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

	<!--CD3D1-->
	<xsl:template match="alternateDescription">
		<xsl:if test="current() != '' or count(@*) > 0">
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

	<!-- CD3D1 -->
	<xsl:template match="offeringVariant">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="sku"/>
				<xsl:apply-templates select="specificationGroup"/>
				<xsl:apply-templates select="offeringVariantPrice"/>
				<xsl:apply-templates select="productCondition"/>
				<xsl:apply-templates select="color"/>
				<xsl:apply-templates select="memory"/>
				<xsl:apply-templates select="tacCode"/>
				<xsl:apply-templates select="orderBehavior" mode="productOffering-orderBehavior"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1 -->
	<xsl:template match="orderBehavior" mode="productOffering-orderBehavior">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="preOrderAllowedIndicator"/>
				<xsl:apply-templates select="preOrderAvailableTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
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

	<!--CD3D1-->
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

	<!--CD3D1-->
	<xsl:template match="orderBehavior" mode="orderBehavior-productOffering">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="preOrderAllowedIndicator"/>
				<xsl:apply-templates select="preOrderAvailableTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="preOrderAllowedIndicator">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@name | node()"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="orderBehavior">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="preOrderAllowedIndicator"/>
				<xsl:apply-templates select="preOrderAvailableTime"/>
				<xsl:apply-templates select="saleStartTime"/>
				<xsl:apply-templates select="saleEndTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="promotion" mode="cartItem-promotion">
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


	<!--CD3D1-->
	<xsl:template match="offeringPrice">
		<xsl:if test="current() != '' or count(@*) > 0">
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

	<!--CD3D1 -->
	<xsl:template match="productOfferingPrice">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="name"/>
				<xsl:apply-templates select="productChargeType"/>
				<xsl:apply-templates select="productChargeIncurredType"/>
				<xsl:apply-templates select="basisAmount"/>
				<xsl:apply-templates select="amount"/>
				<xsl:apply-templates select="oneTimeCharge"/>
				<!--xsl:apply-templates select="recurringFeeFrequency"/-->
				<xsl:apply-templates select="taxInclusiveIndicator"/>
				<xsl:apply-templates select="specificationValue"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template
		match="
			amount | basisAmount | overrideThresholdAmount |
			overrideAmount | extendedAmount | totalChargeAmount | totalDiscountAmount |
			totalTaxAmount | totalDueNowAmount | totalDueMonthlyAmount |
			requestAmount | currentRecurringChargeAmount |
			totalRecurringDueAmount | totalDueAmount | totalCurrentRecurringAmount |
			totalDeltaRecurringDueAmount | totalFeeAmount | totalSoftGoodDueNowAmount |
			totalSoftGoodOneTimeDueNowAmount | totalSoftGoodRecurringDueNowAmount |
			totalAmount | totalExtendedAmount | totalHardGoodDueNowAmount |
			totalRefundAmountDueLater | totalRefundAmountDueNow | finalRefundAmountDueNow |
			chargeAmount">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@currencyCode | node()"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1 -->
	<xsl:template match="productspecification">
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

	<!--CD3D.1-->
	<xsl:template match="additionalSpecification">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="specificationValue" mode="specificationValue-additionalSpecification"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="specificationValue"  mode="specificationValue-additionalSpecification">
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

	<!--CD3D.1-->
	<xsl:template match="networkResource">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="imei"/>
				<xsl:apply-templates select="sim" mode="cartItem-networkResource-sim"/>
				<xsl:apply-templates select="mobileNumber" mode="networkResource-cartItem"/>
				<xsl:apply-templates select="resourceSpecification"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<!--CD3D1-->
	<xsl:template match="mobileNumber" mode="networkResource-cartItem">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="msisdn"/>
				<xsl:apply-templates select="portIndicator"/>
				<xsl:apply-templates select="portReason"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D.1-->
	<xsl:template match="sim" mode="cartItem-networkResource-sim">
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

	<!--CD3D1-->
	<xsl:template match="networkResource" mode="networkResource-lineOfService">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@actionCode"/>
				<xsl:apply-templates select="imei"/>
				<xsl:apply-templates select="sim"/>
				<xsl:apply-templates select="mobileNumber"
					mode="mobileNumber-networkResource-lineOfService"/>
				<xsl:apply-templates select="resourceSpecification"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="resourceSpecification">
		<xsl:if test="current() != '' or @name != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@name"/>
				<xsl:apply-templates select="specificationValue"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="sim">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="imsi"/>
				<xsl:apply-templates select="simNumber"/>
				<xsl:apply-templates select="simType"/>
				<xsl:apply-templates select="virtualSim"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	
	<!--CD3D1-->
	<xsl:template match="mobileNumber" mode="mobileNumber-networkResource-lineOfService">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="msisdn"/>
				<xsl:apply-templates select="portIndicator"/>
				<xsl:apply-templates select="portReason"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<!--CD3D1 -->
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

	<!--CD3D1 -->
	<xsl:template match="estimatedAvailable">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<!--xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if-->
				<xsl:apply-templates select="startDate"/>
				<xsl:apply-templates select="endDate"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- CD3D1 -->
	<xsl:template match="charge">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@actionCode"/>
				<xsl:apply-templates select="typeCode"/>
				<xsl:apply-templates select="chargeFrequencyCode"/>
				<xsl:apply-templates select="amount"/>
				<xsl:apply-templates select="description"/>
				<xsl:apply-templates select="chargeCode"/>
				<xsl:apply-templates select="productOffering" mode="productOffering-cartSummary"/>
				<xsl:apply-templates select="productOfferingPriceId"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="productOffering" mode="productOffering-cartSummary">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="keyword" mode="keyword-cartSummary"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="keyword" mode="keyword-cartSummary">
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
	<!-- CD3D1 -->
	<xsl:template match="charge" mode="charge-cartItem">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="typeCode"/>
				<xsl:apply-templates select="chargeFrequencyCode"/>
				<xsl:apply-templates select="amount"/>
				<xsl:apply-templates select="description"/>
				<xsl:apply-templates select="chargeCode"/>
				<xsl:apply-templates select="productOfferingPriceId"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- CD3D1 -->
	<xsl:template match="deduction">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@actionCode"/>
				<xsl:apply-templates select="amount"/>
				<xsl:apply-templates select="description"/>
				<xsl:apply-templates select="recurringFrequency"/>
				<xsl:apply-templates select="promotion"/>
				<xsl:apply-templates select="chargeCode"/>
				<xsl:apply-templates select="productOfferingPriceId"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="promotion">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@promotionId">
					<xsl:attribute name="promotionId">
						<xsl:value-of select="@promotionId"/>
					</xsl:attribute>
				</xsl:if>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- CD3D1 -->
	<xsl:template match="deduction" mode="deduction-cartItem">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">

				<xsl:apply-templates select="amount"/>
				<xsl:apply-templates select="description"/>
				<xsl:apply-templates select="recurringFrequency"/>

			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- CD3D1 -->
	<xsl:template match="tax">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">

				<xsl:apply-templates select="@id"/>
				<xsl:apply-templates select="code"/>
				<xsl:apply-templates select="taxJurisdiction"/>
				<xsl:apply-templates select="amount"/>
				<xsl:apply-templates select="typeCode"/>
				<xsl:apply-templates select="description"/>
				<xsl:apply-templates select="taxRate"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- CD3D1 -->
	<xsl:template match="tax" mode="tax-cartItem">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:apply-templates select="amount"/>
				<xsl:apply-templates select="description"/>

			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- CD3D1 -->
	<xsl:template match="payment">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="status"/>
				<xsl:apply-templates select="authorizationAmount"/>
				<xsl:apply-templates select="requestAmount"/>
				<xsl:apply-templates select="paymentMethodCode"/>
				<xsl:apply-templates select="payeeParty"/>
				<xsl:apply-templates select="voucherRedemption"/>
				<xsl:apply-templates select="bankPayment"/>
				<xsl:apply-templates select="creditCardPayment"/>
				<xsl:apply-templates select="debitCardPayment"/>
				<xsl:apply-templates select="transactionType"/>
				<xsl:apply-templates select="specificationGroup"/>
				<xsl:apply-templates select="tokenization"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="tokenization">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="encryptionTarget"/>
				<xsl:apply-templates select="encryptedContent"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="bankPayment">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="payFromBankAccount"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="payFromBankAccount">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="accountNumber"/>
			    <xsl:apply-templates select="bankAccountHolder"/>
				<xsl:apply-templates select="bank"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
    
    <xsl:template match="bankAccountHolder">
        <xsl:if test="normalize-space(.) != ''">
            <xsl:element name="v1:{local-name()} ">
                <xsl:apply-templates select="person" mode="person-bankPayment"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
	
    <xsl:template match="person" mode="person-bankPayment">
        <xsl:if test="normalize-space(.) != ''">
            <xsl:element name="v1:{local-name()} ">
                <xsl:apply-templates select="personName" mode="person-bankPayment"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="personName" mode="person-bankPayment">
        <xsl:if test="current() != '' or count(@*) > 0">
            <xsl:element name="v1:{local-name()} ">
                <xsl:apply-templates select="firstName"/>
                <xsl:apply-templates select="familyName"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
	<xsl:template match="bank">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="routingNumber"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="creditCardPayment">
		<xsl:if test="normalize-space(.)!= ''">
			<xsl:element name="v1:{local-name()} ">
			    <xsl:apply-templates select="chargeAmount"/>
				<xsl:apply-templates select="creditCard"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="creditCard">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="v1:{local-name()}">
				<xsl:apply-templates select="typeCode"/>
				<xsl:apply-templates select="cardNumber"/>
				<xsl:apply-templates select="cardHolderName"/>
				<xsl:apply-templates select="expirationMonthYear"/>
				<xsl:apply-templates select="cardHolderBillingAddress"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="cardHolderBillingAddress | cardHolderAddress">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="v1:{local-name()}">
				<xsl:apply-templates select="postalCode"/>
				<xsl:apply-templates select="postalCodeExtension"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="debitCardPayment">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="v1:{local-name()}">
			    <xsl:apply-templates select="chargeAmount"/>
				<xsl:apply-templates select="debitCard"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="debitCard">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="v1:{local-name()}">
				<xsl:apply-templates select="typeCode"/>
				<xsl:apply-templates select="cardNumber"/>
				<xsl:apply-templates select="cardHolderName"/>
				<xsl:apply-templates select="expirationMonthYear"/>
				<xsl:apply-templates select="cardHolderAddress"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="payeeParty">
		<xsl:if test="current() != '' or count(@*) > 0">
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

	<!--CD3D1 -->
	<xsl:template match="voucherRedemption">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="serialNumber"/>
				<xsl:apply-templates select="issuerId"/>
				<xsl:apply-templates select="PIN"/>
				<xsl:apply-templates select="voucherRedemptionType"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<!--CD3D1-->
	<xsl:template match="payFromParty">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="securityProfile" mode="securityProfile-payment"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="securityProfile" mode="securityProfile-payment">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="msisdn"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="freightCharge">
		<xsl:if test="current() != '' or count(@*) > 0">
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

	<!-- CD3D1-->
	<xsl:template match="addressList">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="addressCommunication" mode="addressList"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="customer">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@customerId">
					<xsl:attribute name="customerId">
						<xsl:value-of select="@customerId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="key"/>
				<xsl:apply-templates select="customerType"/>
				<xsl:apply-templates select="status"/>
				<xsl:apply-templates select="party" mode="party-customer"/>
				<xsl:if test="$orderType = 'ACTIVATION'">
					<xsl:apply-templates select="customerGroup"/>
				</xsl:if>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
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

	<!-- CD3D1-->
	<xsl:template match="party" mode="party-customer">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="organization"/>
				<xsl:apply-templates select="person"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="addressCommunication" mode="addressCommunication-subscriberContact">
		<xsl:if
			test="(normalize-space(.) != '' or count(.//@*) != 0) and lower-case(normalize-space((uiAddedIndicator))) = 'true'">
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
				<xsl:apply-templates select="privacyProfile"
					mode="privacyProfile-addressCommunication-subscriberContact"/>
				<xsl:apply-templates select="address"
					mode="address-addressCommunication-subscriberContact"/>
				<xsl:apply-templates select="usageContext"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!--CD3D1-->
	<xsl:template match="privacyProfile"
		mode="privacyProfile-addressCommunication-subscriberContact">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="optOut"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- CD3D1-->
	<xsl:template match="address" mode="address-addressCommunication-subscriberContact">
		<xsl:if test="current() != '' or count(@*) > 0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="key"
					mode="key-address-addressCommunication-subscriberContact"/>
				<xsl:apply-templates select="usageContext"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<!-- CD3D1-->
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