<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:v1="http://services.tmobile.com/OrderManagement/CartWSIL/V1"
	xmlns:base="http://services.tmobile.com/base"
	xmlns:ent="http://services.tmobile.com/SecurityManagement/UserSecurityEnterprise/V1"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:saxon="http://saxon.sf.net/" version="2.0">


	<xsl:output method="xml" indent="no" encoding="ISO-8859-1" version="1.0"
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
	<xsl:variable name="capientitlementns">http://services.tmobile.com/OrderManagement/CartWSIL/V1</xsl:variable>-->

	<xsl:variable name="capibaseprefix" select="'base'" as="xs:string"/>
	<xsl:variable name="capibase" select="'http://services.tmobile.com/base'" as="xs:string"/>

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
								<xsl:variable name="entitlementStr" select="replace(replace($ABFEntitlements,'TO_BE_REPLACED_PREFIX',$capientitlementprefix),'TO_BE_REPLACED_NAMESPACE',$capientitlementns)"></xsl:variable>
								<xsl:copy-of select="saxon:parse($entitlementStr)/base:entitlements"/>
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
					<xsl:apply-templates select="/cart"/>
				</v1:updateCartRequest>
			</soapenv:Body>
		</soapenv:Envelope>
	</xsl:template>


	<!-- Cart child Elements -->
	<xsl:template match="cart">
		<xsl:if test="current() != '' or @cartId != '' or @actionCode != ''">
			<v1:cart>
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
				<xsl:apply-templates select="orderLocation"/>
				<xsl:if test="reason">
					<v1:reason>
						<xsl:value-of select="reason"/>
					</v1:reason>
				</xsl:if>
				<v1:orderType>
					<xsl:value-of select="orderType"/>
				</v1:orderType>

				<xsl:if test="normalize-space(businessUnitName) != ''">
					<v1:businessUnitName>
						<xsl:value-of select="businessUnitName"/>
					</v1:businessUnitName>
				</xsl:if>

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
				<!--xsl:apply-templates select="promotion"/-->
				<xsl:apply-templates select="cartSpecification"/>
				<xsl:if test="backOrderAllowedIndicator">
					<v1:backOrderAllowedIndicator>
						<xsl:value-of select="backOrderAllowedIndicator"/>
					</v1:backOrderAllowedIndicator>
				</xsl:if>
				<xsl:if test="ipAddress">
					<v1:ipAddress>
						<xsl:value-of select="ipAddress"/>
					</v1:ipAddress>
				</xsl:if>
				<xsl:if test="deviceFingerPrintId">
					<v1:deviceFingerPrintId>
						<xsl:value-of select="deviceFingerPrintId"/>
					</v1:deviceFingerPrintId>
				</xsl:if>
				<xsl:apply-templates select="termsAndConditionsDisposition"/>
				<xsl:if test="originalOrderId">
					<v1:originalOrderId>
						<xsl:value-of select="originalOrderId"/>
					</v1:originalOrderId>
				</xsl:if>

				<xsl:if test="modeOfExchange">
					<v1:modeOfExchange>
						<xsl:value-of select="modeOfExchange"/>
					</v1:modeOfExchange>
				</xsl:if>

				<xsl:apply-templates select="relatedOrder"/>

				<xsl:apply-templates select="shipping"/>
				<xsl:choose>
					<xsl:when test="billTo">
						<xsl:apply-templates select="billTo"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="$orderType = 'ACTIVATION'">
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
									<v1:customerGroup>Consumer</v1:customerGroup>
								</v1:customer>
							</v1:billTo>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:apply-templates select="cartItem"/>
				<xsl:apply-templates select="charge"/>
				<xsl:apply-templates select="freightCharge"/>
				<xsl:apply-templates select="payment"/>
				<xsl:apply-templates select="addressList"/>
			</v1:cart>
		</xsl:if>
	</xsl:template>

	<xsl:template match="cartSpecification">
		<xsl:if test="current() != '' or @name != ''">
			<v1:cartSpecification>
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="specificationValue" mode="cartSpecification"/>
			</v1:cartSpecification>
		</xsl:if>
	</xsl:template>

	<xsl:template match="specificationValue" mode="cartSpecification">
		<xsl:if test="current() != '' or @name != ''">
			<v1:specificationValue>
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</v1:specificationValue>
		</xsl:if>
	</xsl:template>

	<xsl:template match="specificationGroup" mode="activation">
		<xsl:element name="v1:{local-name()} ">
			<xsl:apply-templates select="@id"/>
			<xsl:apply-templates select="specificationValue[@name != 'specialTreatment']"/>
			<xsl:choose>
				<xsl:when test="specificationValue[@name = 'specialTreatment']">
					<xsl:apply-templates select="specificationValue[@name = 'specialTreatment']"
						mode="activation"/>
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

	<xsl:template match="specificationValue" mode="activation">
		<xsl:element name="v1:{local-name()} ">
			<xsl:apply-templates select="@*"/>
			<xsl:value-of select="'None'"/>
		</xsl:element>
	</xsl:template>

	<xsl:template match="addressList">
		<xsl:if test="current() != ''">
			<v1:addressList>
				<xsl:apply-templates select="addressCommunication" mode="addressList"/>
			</v1:addressList>
		</xsl:if>
	</xsl:template>

	<xsl:template match="addressCommunication" mode="addressList">
		<xsl:if test="current() != '' or @id != ''">
			<v1:addressCommunication>
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="address"/>
				<xsl:if test="normalize-space(usageContext) != ''">
					<v1:usageContext>
						<xsl:value-of select="usageContext"/>
					</v1:usageContext>
				</xsl:if>
				<xsl:apply-templates select="communicationStatus"/>
				<xsl:if test="specialInstruction">
					<v1:specialInstruction>
						<xsl:value-of select="specialInstruction"/>
					</v1:specialInstruction>
				</xsl:if>
			</v1:addressCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="communicationStatus">
		<xsl:if test="current() != '' or @subStatusCode != '' or @statusCode != ''">
			<v1:communicationStatus>
				<xsl:if test="@subStatusCode">
					<xsl:attribute name="subStatusCode">
						<xsl:value-of select="@subStatusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@statusCode != ''">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</v1:communicationStatus>
		</xsl:if>
	</xsl:template>

	<xsl:template match="payment">
		<xsl:if test="current() != '' or @actionCode != ''">
			<v1:payment>
				<xsl:if test="@actionCode != ''">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="requestAmount"/>
				<xsl:if test="paymentMethodCode">
					<v1:paymentMethodCode>
						<xsl:value-of select="paymentMethodCode"/>
					</v1:paymentMethodCode>
				</xsl:if>

				<xsl:apply-templates select="payFromParty"/>
				<xsl:apply-templates select="voucherRedemption"/>
				<xsl:apply-templates select="bankPayment"/>
				<xsl:apply-templates select="creditCardPayment"/>
				<xsl:apply-templates select="debitCardPayment"/>
				<xsl:apply-templates select="transactionType"/>
			</v1:payment>
		</xsl:if>
	</xsl:template>

	<xsl:template match="bankPayment">
		<xsl:if test="current() != ''">
			<v1:bankPayment>
				<xsl:apply-templates select="payFromBankAccount"/>
			</v1:bankPayment>
		</xsl:if>
	</xsl:template>

	<xsl:template match="payFromBankAccount">
		<xsl:if test="current() != ''">
			<v1:payFromBankAccount>

				<xsl:if test="name">
					<v1:name>
						<xsl:value-of select="name"/>
					</v1:name>
				</xsl:if>

				<xsl:if test="accountNumber">
					<v1:accountNumber>
						<xsl:value-of select="accountNumber"/>
					</v1:accountNumber>
				</xsl:if>
				<xsl:apply-templates select="bankAccountHolder"/>
				<xsl:apply-templates select="bank"/>
			</v1:payFromBankAccount>
		</xsl:if>
	</xsl:template>

	<xsl:template match="bank">
		<xsl:if test="normalize-space(.) != ''">
			<v1:bank>
				<xsl:if test="swiftCode">
					<v1:swiftCode>
						<xsl:value-of select="swiftCode"/>
					</v1:swiftCode>
				</xsl:if>
				<xsl:if test="routingNumber">
					<v1:routingNumber>
						<xsl:value-of select="routingNumber"/>
					</v1:routingNumber>
				</xsl:if>
			</v1:bank>
		</xsl:if>
	</xsl:template>

	<xsl:template match="bankAccountHolder">
		<xsl:if test="current() != ''">
			<v1:bankAccountHolder>
				<xsl:apply-templates select="person" mode="bankAccountHolder"/>
			</v1:bankAccountHolder>
		</xsl:if>
	</xsl:template>

	<xsl:template match="person" mode="bankAccountHolder">
		<xsl:if test="current() != ''">
			<v1:person>
				<xsl:apply-templates select="personName"/>
			</v1:person>
		</xsl:if>
	</xsl:template>

	<xsl:template match="personName">
		<xsl:if test="current() != ''">
			<v1:personName>
				<xsl:if test="familyName">
					<v1:familyName>
						<xsl:value-of select="familyName"/>
					</v1:familyName>
				</xsl:if>
			</v1:personName>
		</xsl:if>
	</xsl:template>

	<xsl:template match="creditCardPayment">
		<xsl:if test="current() != ''">
			<v1:creditCardPayment>
				<xsl:apply-templates select="chargeAmount"/>
				<xsl:apply-templates select="creditCard"/>
			</v1:creditCardPayment>
		</xsl:if>
	</xsl:template>


	<xsl:template match="creditCard">
		<xsl:if test="current() != ''">
			<v1:creditCard>
				<xsl:if test="typeCode">
					<v1:typeCode>
						<xsl:value-of select="typeCode"/>
					</v1:typeCode>
				</xsl:if>
				<xsl:apply-templates select="cardNumber"/>

				<xsl:if test="cardHolderName">
					<v1:cardHolderName>
						<xsl:value-of select="cardHolderName"/>
					</v1:cardHolderName>
				</xsl:if>
				<xsl:if test="expirationMonthYear">
					<v1:expirationMonthYear>
						<xsl:value-of select="expirationMonthYear"/>
					</v1:expirationMonthYear>
				</xsl:if>
				<xsl:apply-templates select="cardHolderBillingAddress"/>
			</v1:creditCard>
		</xsl:if>
	</xsl:template>

	<xsl:template match="cardNumber">
		<xsl:if test="current() != '' or @maskingType != ''">
			<v1:cardNumber>
				<xsl:if test="@maskingType">
					<xsl:attribute name="maskingType">
						<xsl:value-of select="@maskingType"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</v1:cardNumber>
		</xsl:if>
	</xsl:template>

	<xsl:template match="cardHolderBillingAddress | cardHolderAddress">
		<xsl:if test="normalize-space(.) != ''">
			<xsl:element name="v1:{local-name()}">
				<xsl:if test="postalCode">
					<v1:postalCode>
						<xsl:value-of select="postalCode"/>
					</v1:postalCode>
				</xsl:if>
				<xsl:if test="postalCodeExtension">
					<v1:postalCodeExtension>
						<xsl:value-of select="postalCodeExtension"/>
					</v1:postalCodeExtension>
				</xsl:if>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="debitCardPayment">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<v1:debitCardPayment>
				<xsl:apply-templates select="chargeAmount"/>
				<xsl:apply-templates select="debitCard"/>
			</v1:debitCardPayment>
		</xsl:if>
	</xsl:template>

	<xsl:template match="debitCard">
		<xsl:if test="normalize-space(.) != '' or count(.//@*) != 0">
			<xsl:element name="v1:{local-name()}">
				<xsl:if test="typeCode">
					<v1:typeCode>
						<xsl:value-of select="typeCode"/>
					</v1:typeCode>
				</xsl:if>
				<xsl:apply-templates select="cardNumber"/>
				<xsl:if test="cardHolderName">
					<v1:cardHolderName>
						<xsl:value-of select="cardHolderName"/>
					</v1:cardHolderName>
				</xsl:if>
				<xsl:apply-templates select="expirationMonthYear"/>
				<xsl:apply-templates select="cardHolderAddress"/>
			</xsl:element>
		</xsl:if>
	</xsl:template>


	<xsl:template match="relatedOrder">
		<xsl:if test="current() != ''">
			<v1:relatedOrder>
				<xsl:if test="orderId">
					<v1:orderId>
						<xsl:value-of select="orderId"/>
					</v1:orderId>
				</xsl:if>

				<xsl:if test="relationshipType">
					<v1:relationshipType>
						<xsl:value-of select="relationshipType"/>
					</v1:relationshipType>
				</xsl:if>
			</v1:relatedOrder>
		</xsl:if>
	</xsl:template>

	<xsl:template match="voucherRedemption">
		<xsl:if test="current() != ''">
			<v1:voucherRedemption>
				<xsl:if test="serialNumber">
					<v1:serialNumber>
						<xsl:value-of select="serialNumber"/>
					</v1:serialNumber>
				</xsl:if>
				<xsl:if test="issuerId">
					<v1:issuerId>
						<xsl:value-of select="issuerId"/>
					</v1:issuerId>
				</xsl:if>
				<xsl:if test="PIN">
					<v1:PIN>
						<xsl:value-of select="PIN"/>
					</v1:PIN>
				</xsl:if>
				<xsl:if test="voucherRedemptionType">
					<v1:voucherRedemptionType>
						<xsl:value-of select="voucherRedemptionType"/>
					</v1:voucherRedemptionType>
				</xsl:if>
			</v1:voucherRedemption>
		</xsl:if>
	</xsl:template>

	<xsl:template match="payFromParty">
		<xsl:if test="current() != ''">
			<v1:payFromParty>
				<xsl:apply-templates select="securityProfile" mode="payFromParty"/>
			</v1:payFromParty>
		</xsl:if>
	</xsl:template>

	<xsl:template match="securityProfile" mode="payFromParty">
		<xsl:if test="current() != ''">
			<v1:securityProfile>
				<xsl:if test="normalize-space(msisdn) != ''">
					<v1:msisdn>
						<xsl:value-of select="msisdn"/>
					</v1:msisdn>
				</xsl:if>
			</v1:securityProfile>
		</xsl:if>
	</xsl:template>

	<xsl:template match="freightCharge">
		<xsl:if test="current() != '' or @chargeId != ''">
			<v1:freightCharge>
				<xsl:if test="@chargeId != ''">
					<xsl:attribute name="chargeId">
						<xsl:value-of select="@chargeId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="amount"/>
				<xsl:if test="chargeCode">
					<v1:chargeCode>
						<xsl:value-of select="chargeCode"/>
					</v1:chargeCode>
				</xsl:if>
				<xsl:if test="waiverIndicator">
					<v1:waiverIndicator>
						<xsl:value-of select="waiverIndicator"/>
					</v1:waiverIndicator>
				</xsl:if>
				<xsl:if test="waiverReason">
					<v1:waiverReason>
						<xsl:value-of select="waiverReason"/>
					</v1:waiverReason>
				</xsl:if>
			</v1:freightCharge>
		</xsl:if>
	</xsl:template>

	<xsl:template match="charge">
		<xsl:if test="current() != '' or @actionCode != ''">
			<v1:charge>
				<xsl:if test="@actionCode != ''">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:if test="chargeFrequencyCode">
					<v1:chargeFrequencyCode>
						<xsl:value-of select="chargeFrequencyCode"/>
					</v1:chargeFrequencyCode>
				</xsl:if>
				<xsl:apply-templates select="amount"/>

				<xsl:if test="description">
					<v1:description>
						<xsl:value-of select="description"/>
					</v1:description>
				</xsl:if>
			</v1:charge>
		</xsl:if>
	</xsl:template>

	<xsl:template match="amount | chargeAmount | requestAmount">
		<xsl:if test="current() != '' or @currencyCode != ''">
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

	<xsl:template match="orderLocation">
		<xsl:if test="current() != '' or @id != ''">
			<v1:orderLocation>
				<xsl:if test="@id != ''">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="location"/>
				<!--xsl:apply-templates select="dealerCode"/-->
				<xsl:if test="normalize-space(tillNumber) != ''">
					<v1:tillNumber>
						<xsl:value-of select="tillNumber"/>
					</v1:tillNumber>
				</xsl:if>
			</v1:orderLocation>
		</xsl:if>
	</xsl:template>

	<xsl:template match="location">
		<xsl:if test="current() != '' or @id != ''">
			<v1:location>
				<xsl:if test="@id != ''">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</v1:location>
		</xsl:if>
	</xsl:template>

	<xsl:template match="salesChannel">
		<xsl:if test="not(empty(.))">
			<v1:salesChannel>
				<xsl:apply-templates select="salesChannelCode"/>
				<xsl:apply-templates select="salesSubChannelCode"/>
				<xsl:apply-templates select="subChannelCategory"/>
			</v1:salesChannel>
		</xsl:if>
	</xsl:template>

	<xsl:template match="salesperson">
		<v1:salesperson>
			<xsl:choose>
				<xsl:when test="$tokenScope = 'assisted'">
					<v1:userName>
						<xsl:value-of select="$applicationUserId"/>
					</v1:userName>
				</xsl:when>
				<xsl:otherwise>
					<xsl:if test="userName">
						<v1:userName>
							<xsl:value-of select="userName"/>
						</v1:userName>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:apply-templates select="personName" mode="salesperson"/>
		</v1:salesperson>
	</xsl:template>

	<xsl:template match="personName" mode="salesperson">
		<xsl:if test="normalize-space(.) != ''">
			<v1:personName>
				<xsl:if test="firstName">
					<v1:firstName>
						<xsl:value-of select="firstName"/>
					</v1:firstName>
				</xsl:if>
				<xsl:if test="familyName">
					<v1:familyName>
						<xsl:value-of select="familyName"/>
					</v1:familyName>
				</xsl:if>
			</v1:personName>
		</xsl:if>
	</xsl:template>

	<xsl:template match="promotion">
		<xsl:if test="normalize-space(.) != ''">
			<v1:promotion>
				<xsl:if test="promotionCode">
					<v1:promotionCode>
						<xsl:value-of select="promotionCode"/>
					</v1:promotionCode>
				</xsl:if>
			</v1:promotion>
		</xsl:if>
	</xsl:template>

	<xsl:template match="termsAndConditionsDisposition">
		<xsl:if test="normalize-space(.) != ''">
			<v1:termsAndConditionsDisposition>
				<xsl:if test="acceptanceIndicator">
					<v1:acceptanceIndicator>
						<xsl:value-of select="acceptanceIndicator"/>
					</v1:acceptanceIndicator>
				</xsl:if>

				<xsl:if test="acceptanceTime">
					<v1:acceptanceTime>
						<xsl:value-of select="acceptanceTime"/>
					</v1:acceptanceTime>
				</xsl:if>
			</v1:termsAndConditionsDisposition>
		</xsl:if>
	</xsl:template>

	<xsl:template match="shipping">
		<xsl:if test="not(empty(.))">
			<v1:shipping>
				<xsl:if test="freightCarrier">
					<v1:freightCarrier>
						<xsl:value-of select="freightCarrier"/>
					</v1:freightCarrier>
				</xsl:if>
				<xsl:if test="promisedDeliveryTime">
					<v1:promisedDeliveryTime>
						<xsl:value-of select="promisedDeliveryTime"/>
					</v1:promisedDeliveryTime>
				</xsl:if>
				<xsl:apply-templates select="shipTo"/>
				<xsl:apply-templates select="note"/>
				<xsl:if test="normalize-space(serviceLevelCode) != ''">
					<v1:serviceLevelCode>
						<xsl:value-of select="serviceLevelCode"/>
					</v1:serviceLevelCode>
				</xsl:if>
			</v1:shipping>
		</xsl:if>
	</xsl:template>

	<xsl:template match="note">
		<xsl:if test="current() != '' or @language != ''">
			<v1:note>
				<xsl:if test="@language != ''">
					<xsl:attribute name="language">
						<xsl:value-of select="@language"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="normalize-space(entryTime) != ''">
					<v1:entryTime>
						<xsl:value-of select="entryTime"/>
					</v1:entryTime>
				</xsl:if>

				<xsl:if test="normalize-space(noteType) != ''">
					<v1:noteType>
						<xsl:value-of select="noteType"/>
					</v1:noteType>
				</xsl:if>
				<xsl:if test="normalize-space(content) != ''">
					<v1:content>
						<xsl:value-of select="content"/>
					</v1:content>
				</xsl:if>
				<xsl:if test="normalize-space(author) != ''">
					<v1:author>
						<xsl:value-of select="author"/>
					</v1:author>
				</xsl:if>
			</v1:note>
		</xsl:if>
	</xsl:template>


	<xsl:template match="shipTo">
		<xsl:if test="not(empty(.))">
			<v1:shipTo>
				<xsl:apply-templates select="personName" mode="shipTo-personName"/>
				<xsl:apply-templates select="addressCommunication"/>
				<xsl:apply-templates select="phoneCommunication"/>
				<xsl:apply-templates select="emailCommunication"/>
				<xsl:if test="normalize-space(preferredLanguage) != ''">
					<v1:preferredLanguage>
						<xsl:value-of select="preferredLanguage"/>
					</v1:preferredLanguage>
				</xsl:if>
			</v1:shipTo>
		</xsl:if>
	</xsl:template>

	<xsl:template match="personName" mode="shipTo-personName">
		<xsl:if test="not(empty(.))">
			<v1:personName>
				<xsl:if test="firstName">
					<v1:firstName>
						<xsl:value-of select="firstName"/>
					</v1:firstName>
				</xsl:if>
				<xsl:if test="middleName">
					<v1:middleName>
						<xsl:value-of select="middleName"/>
					</v1:middleName>
				</xsl:if>
				<xsl:if test="familyName">
					<v1:familyName>
						<xsl:value-of select="familyName"/>
					</v1:familyName>
				</xsl:if>
				<xsl:if test="aliasName">
					<v1:aliasName>
						<xsl:value-of select="aliasName"/>
					</v1:aliasName>
				</xsl:if>
			</v1:personName>
		</xsl:if>
	</xsl:template>

	<xsl:template match="addressCommunication">
		<xsl:if test="current() != '' or @actionCode != '' or @id != ''">
			<v1:addressCommunication>
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

				<xsl:if test="normalize-space(preference) != ''">
					<v1:preference>
						<xsl:if test="preference/preferred">
							<v1:preferred>
								<xsl:value-of select="preference/preferred"/>
							</v1:preferred>
						</xsl:if>
					</v1:preference>
				</xsl:if>
				<xsl:if test="normalize-space(usageContext) != ''">
					<v1:usageContext>
						<xsl:value-of select="usageContext"/>
					</v1:usageContext>
				</xsl:if>
			</v1:addressCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="phoneCommunication">
		<xsl:if test="not(empty(.))">
			<v1:phoneCommunication>
				<xsl:if test="normalize-space(phoneType) != ''">
					<v1:phoneType>
						<xsl:value-of select="phoneType"/>
					</v1:phoneType>
				</xsl:if>
				<xsl:if test="normalize-space(phoneNumber) != ''">
					<v1:phoneNumber>
						<xsl:value-of select="phoneNumber"/>
					</v1:phoneNumber>
				</xsl:if>
			</v1:phoneCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="emailCommunication">
		<xsl:if test="not(empty(.))">
			<v1:emailCommunication>
				<xsl:if test="normalize-space(emailAddress) != ''">
					<v1:emailAddress>
						<xsl:value-of select="emailAddress"/>
					</v1:emailAddress>
				</xsl:if>
				<xsl:if test="normalize-space(emailFormat) != ''">
					<v1:emailFormat>
						<xsl:value-of select="emailFormat"/>
					</v1:emailFormat>
				</xsl:if>
			</v1:emailCommunication>
		</xsl:if>
	</xsl:template>



	<xsl:template match="billTo">
		<xsl:if test="not(empty(.))">
			<xsl:element name="v1:{local-name()} ">
				<xsl:choose>
					<xsl:when test="$orderType = 'ACTIVATION' or $custFinActionCode = 'ADD'">
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
										<xsl:if
											test="$orderType = 'ACTIVATION' and (customer/party/person/addressCommunication/usageContext | customer/party/person/addressCommunication/@id)">
											<v1:billingArrangement>
												<v1:billingContact>
												<v1:addressCommunication>
												<xsl:if
												test="customer/party/person/addressCommunication/@id">
												<xsl:attribute name="id"
												select="customer/party/person/addressCommunication/@id"
												/>
												</xsl:if>
												<xsl:if
												test="customer/party/person/addressCommunication/usageContext">
												<v1:usageContext>
												<xsl:value-of
												select="customer/party/person/addressCommunication/usageContext/node()"
												/>
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
					<xsl:when test="$orderType = 'ACTIVATION' or $custFinActionCode = 'ADD'">
						<v1:customer>
							<v1:customerGroup>
								<xsl:value-of select="'Consumer'"/>
							</v1:customerGroup>
						</v1:customer>
					</xsl:when>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
	</xsl:template>



	<xsl:template match="customerAccount">
		<xsl:if test="current() != ''">
			<v1:customerAccount>
				<!--xsl:apply-templates select="customerAccountNumber"/-->

				<xsl:if test="normalize-space(accountClassification) != ''">
					<v1:accountClassification>
						<xsl:value-of select="accountClassification"/>
					</v1:accountClassification>
				</xsl:if>
				<xsl:if test="normalize-space(businessUnit) != ''">
					<v1:businessUnit>
						<xsl:value-of select="businessUnit"/>
					</v1:businessUnit>
				</xsl:if>
				<xsl:apply-templates select="programMembership"/>

				<xsl:choose>
					<xsl:when test="$orderType = 'ACTIVATION' or $custFinActionCode = 'ADD'">
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
				<!-- Account Holder not present in WSIL -->
				<!--xsl:apply-templates select="accountHolder"/-->
				<xsl:apply-templates select="paymentProfile"/>
				<xsl:choose>
					<xsl:when test="$orderType = 'ACTIVATION' or $custFinActionCode = 'ADD'">
						<v1:idVerificationIndicator>
							<xsl:value-of select="'None'"/>
						</v1:idVerificationIndicator>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="idVerificationIndicator"/>
					</xsl:otherwise>
				</xsl:choose>
				<xsl:if test="normalize-space(corporateAffiliationProgram) != ''">
					<v1:corporateAffiliationProgram>
						<xsl:value-of select="corporateAffiliationProgram"/>
					</v1:corporateAffiliationProgram>
				</xsl:if>
				<xsl:if test="normalize-space(strategicAccountIndicator) != ''">
					<v1:strategicAccountIndicator>
						<xsl:value-of select="strategicAccountIndicator"/>
					</v1:strategicAccountIndicator>
				</xsl:if>
				<xsl:choose>
					<xsl:when test="$orderType = 'ACTIVATION' or $custFinActionCode = 'ADD'">
						<xsl:choose>
							<xsl:when test="financialAccount">
								<xsl:apply-templates select="financialAccount"
									mode="billTo-CustomerAccount"/>
							</xsl:when>
							<xsl:otherwise>
								<v1:financialAccount>
									<xsl:if
										test="$orderType = 'ACTIVATION' and (../../billTo/customer/party/person/addressCommunication/usageContext | ../../billTo/customer/party/person/addressCommunication/@id)">
										<v1:billingArrangement>
											<v1:billingContact>
												<v1:addressCommunication>
												<xsl:if
												test="../../billTo/customer/party/person/addressCommunication/@id">
												<xsl:attribute name="id"
												select="../../billTo/customer/party/person/addressCommunication/@id"
												/>
												</xsl:if>
												<xsl:if
												test="../../billTo/customer/party/person/addressCommunication/usageContext">
												<v1:usageContext>
												<xsl:value-of
												select="../../billTo/customer/party/person/addressCommunication/usageContext/node()"
												/>
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
						<xsl:apply-templates select="financialAccount" mode="billTo-CustomerAccount"
						/>
					</xsl:otherwise>
				</xsl:choose>
			</v1:customerAccount>
		</xsl:if>
	</xsl:template>

	<xsl:template match="programMembership">
		<xsl:if test="current() != ''">
			<v1:programMembership>
				<xsl:if test="normalize-space(programCode) != ''">
					<v1:programCode>
						<xsl:value-of select="programCode"/>
					</v1:programCode>
				</xsl:if>
				<xsl:if test="normalize-space(description) != ''">
					<v1:description>
						<xsl:value-of select="description"/>
					</v1:description>
				</xsl:if>
			</v1:programMembership>
		</xsl:if>
	</xsl:template>

	<xsl:template match="specialTreatment">
		<xsl:if test="current() != ''">
			<v1:specialTreatment>
				<xsl:if test="normalize-space(treatmentType) != ''">
					<v1:treatmentType>
						<xsl:value-of select="treatmentType"/>
					</v1:treatmentType>
				</xsl:if>
			</v1:specialTreatment>
		</xsl:if>
	</xsl:template>


	<xsl:template
		match="description | idVerificationIndicator | strategicAccountIndicator | specificationValue | activeDutyMilitary | overridePriceAllowedIndicator | taxInclusiveIndicator">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:value-of select="."/>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="accountHolder">
		<xsl:if test="current() != ''">
			<v1:accountHolder>
				<xsl:apply-templates select="party"/>
			</v1:accountHolder>
		</xsl:if>
	</xsl:template>

	<xsl:template match="party">
		<xsl:if test="current() != ''">
			<v1:party>
				<xsl:apply-templates select="organization"/>
				<xsl:apply-templates select="person"/>
			</v1:party>
		</xsl:if>
	</xsl:template>

	<xsl:template match="organization">
		<xsl:if test="current() != ''">
			<v1:organization>
				<xsl:apply-templates select="sicCode"/>
			</v1:organization>
		</xsl:if>
	</xsl:template>

	<xsl:template match="person">
		<xsl:if test="current() != ''">
			<v1:person>
				<xsl:apply-templates select="addressCommunication"
					mode="person-addressCommunication"/>
			</v1:person>
		</xsl:if>
	</xsl:template>

	<xsl:template match="address">
		<xsl:if test="current() != ''">
			<v1:address>
				<xsl:if test="addressFormatType">
					<v1:addressFormatType>
						<xsl:value-of select="addressFormatType"/>
					</v1:addressFormatType>
				</xsl:if>

				<xsl:if test="addressLine1">
					<v1:addressLine1>
						<xsl:value-of select="addressLine1"/>
					</v1:addressLine1>
				</xsl:if>

				<xsl:if test="addressLine2">
					<v1:addressLine2>
						<xsl:value-of select="addressLine2"/>
					</v1:addressLine2>
				</xsl:if>
				<xsl:if test="addressLine3">
					<v1:addressLine3>
						<xsl:value-of select="addressLine3"/>
					</v1:addressLine3>
				</xsl:if>

				<xsl:if test="cityName">
					<v1:cityName>
						<xsl:value-of select="cityName"/>
					</v1:cityName>
				</xsl:if>

				<xsl:if test="normalize-space(stateCode) != ''">
					<v1:stateCode>
						<xsl:value-of select="stateCode"/>
					</v1:stateCode>
				</xsl:if>

				<xsl:if test="normalize-space(countyName) != ''">
					<v1:countyName>
						<xsl:value-of select="countyName"/>
					</v1:countyName>
				</xsl:if>
				<xsl:if test="normalize-space(countryCode) != ''">
					<v1:countryCode>
						<xsl:value-of select="countryCode"/>
					</v1:countryCode>
				</xsl:if>
				<xsl:if test="normalize-space(attentionOf) != ''">
					<v1:attentionOf>
						<xsl:value-of select="attentionOf"/>
					</v1:attentionOf>
				</xsl:if>

				<xsl:if test="normalize-space(careOf) != ''">
					<v1:careOf>
						<xsl:value-of select="careOf"/>
					</v1:careOf>
				</xsl:if>

				<xsl:if test="normalize-space(postalCode) != ''">
					<v1:postalCode>
						<xsl:value-of select="postalCode"/>
					</v1:postalCode>
				</xsl:if>
				<xsl:if test="normalize-space(postalCodeExtension) != ''">
					<v1:postalCodeExtension>
						<xsl:value-of select="postalCodeExtension"/>
					</v1:postalCodeExtension>
				</xsl:if>

				<xsl:apply-templates select="geoCodeID"/>
				<xsl:if test="normalize-space(uncertaintyIndicator) != ''">
					<v1:uncertaintyIndicator>
						<xsl:value-of select="uncertaintyIndicator"/>
					</v1:uncertaintyIndicator>
				</xsl:if>

				<xsl:if test="normalize-space(inCityLimitIndicator) != ''">
					<v1:inCityLimitIndicator>
						<xsl:value-of select="inCityLimitIndicator"/>
					</v1:inCityLimitIndicator>
				</xsl:if>
				<xsl:apply-templates select="geographicCoordinates"/>
				<xsl:apply-templates select="key"/>
				<!-- xsl:apply-templates select="building"/-->
				<!--xsl:apply-templates select="floor"/-->
				<!--xsl:apply-templates select="area"/-->
				<!-- xsl:apply-templates select="ruralRoute"/-->

				<xsl:if test="normalize-space(timeZone) != ''">
					<v1:timeZone>
						<xsl:value-of select="timeZone"/>
					</v1:timeZone>
				</xsl:if>

				<xsl:if test="normalize-space(houseNumber) != ''">
					<v1:houseNumber>
						<xsl:value-of select="houseNumber"/>
					</v1:houseNumber>
				</xsl:if>
				<xsl:if test="normalize-space(streetName) != ''">
					<v1:streetName>
						<xsl:value-of select="streetName"/>
					</v1:streetName>
				</xsl:if>

				<xsl:if test="normalize-space(streetSuffix) != ''">
					<v1:streetSuffix>
						<xsl:value-of select="streetSuffix"/>
					</v1:streetSuffix>
				</xsl:if>

				<xsl:if test="normalize-space(trailingDirection) != ''">
					<v1:trailingDirection>
						<xsl:value-of select="trailingDirection"/>
					</v1:trailingDirection>
				</xsl:if>
				<xsl:if test="normalize-space(unitType) != ''">
					<v1:unitType>
						<xsl:value-of select="unitType"/>
					</v1:unitType>
				</xsl:if>

				<xsl:if test="normalize-space(unitNumber) != ''">
					<v1:unitNumber>
						<xsl:value-of select="unitNumber"/>
					</v1:unitNumber>
				</xsl:if>

				<xsl:if test="normalize-space(streetDirection) != ''">
					<v1:streetDirection>
						<xsl:value-of select="streetDirection"/>
					</v1:streetDirection>
				</xsl:if>
				<xsl:if test="normalize-space(urbanization) != ''">
					<v1:urbanization>
						<xsl:value-of select="urbanization"/>
					</v1:urbanization>
				</xsl:if>

				<xsl:if test="normalize-space(deliveryPointCode) != ''">
					<v1:deliveryPointCode>
						<xsl:value-of select="deliveryPointCode"/>
					</v1:deliveryPointCode>
				</xsl:if>

				<xsl:if test="normalize-space(confidenceLevel) != ''">
					<v1:confidenceLevel>
						<xsl:value-of select="confidenceLevel"/>
					</v1:confidenceLevel>
				</xsl:if>
				<xsl:if test="normalize-space(carrierRoute) != ''">
					<v1:carrierRoute>
						<xsl:value-of select="carrierRoute"/>
					</v1:carrierRoute>
				</xsl:if>
				<xsl:if test="normalize-space(overrideIndicator) != ''">
					<v1:overrideIndicator>
						<xsl:value-of select="overrideIndicator"/>
					</v1:overrideIndicator>
				</xsl:if>
				<xsl:if test="normalize-space(observesDaylightSavingsIndicator) != ''">
					<v1:observesDaylightSavingsIndicator>
						<xsl:value-of select="observesDaylightSavingsIndicator"/>
					</v1:observesDaylightSavingsIndicator>
				</xsl:if>
				<xsl:if test="normalize-space(matchIndicator) != ''">
					<v1:matchIndicator>
						<xsl:value-of select="matchIndicator"/>
					</v1:matchIndicator>
				</xsl:if>
			</v1:address>
		</xsl:if>
	</xsl:template>

	<xsl:template match="geoCodeID">
		<xsl:if
			test="current() != '' or @manualIndicator != '' or @referenceLayer != '' or @usageContext != ''">
			<v1:geoCodeID>
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
			</v1:geoCodeID>
		</xsl:if>
	</xsl:template>

	<xsl:template match="geographicCoordinates">
		<xsl:if test="current() != ''">
			<v1:geographicCoordinates>
				<xsl:if test="latitude">
					<v1:latitude>
						<xsl:value-of select="latitude"/>
					</v1:latitude>
				</xsl:if>

				<xsl:if test="longitude">
					<v1:longitude>
						<xsl:value-of select="longitude"/>
					</v1:longitude>
				</xsl:if>
			</v1:geographicCoordinates>
		</xsl:if>
	</xsl:template>

	<xsl:template match="addressCommunication" mode="lineOfService-SC">
		<xsl:if test="current() != '' or @id != '' or @actionCode != ''">
			<v1:addressCommunication>
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
				<xsl:apply-templates select="privacyProfile"/>
				<xsl:apply-templates select="address" mode="LOS"/>
				<xsl:if test="normalize-space(usageContext) != ''">
					<v1:usageContext>
						<xsl:value-of select="usageContext"/>
					</v1:usageContext>
				</xsl:if>
			</v1:addressCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="address" mode="LOS">
		<xsl:if test="current() != ''">
			<v1:address>
				<xsl:apply-templates select="key"/>
			</v1:address>
		</xsl:if>
	</xsl:template>

	<xsl:template match="addressCommunication" mode="person-addressCommunication">
		<xsl:if test="current() != '' or @id != ''">
			<v1:addressCommunication>
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="privacyProfile"/>
				<xsl:apply-templates select="address" mode="addressCommunication-address"/>
				<xsl:apply-templates select="usageContext"/>
			</v1:addressCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="privacyProfile">
		<xsl:if test="current() != ''">
			<v1:privacyProfile>
				<xsl:if test="normalize-space(optOut) != ''">
					<v1:optOut>
						<xsl:value-of select="optOut"/>
					</v1:optOut>
				</xsl:if>

				<xsl:if test="normalize-space(activityType) != ''">
					<v1:activityType>
						<xsl:value-of select="activityType"/>
					</v1:activityType>
				</xsl:if>
			</v1:privacyProfile>
		</xsl:if>
	</xsl:template>

	<xsl:template match="paymentProfile">
		<xsl:if test="current() != ''">
			<v1:paymentProfile>
				<xsl:if test="normalize-space(paymentTerm) != ''">
					<v1:paymentTerm>
						<xsl:value-of select="paymentTerm"/>
					</v1:paymentTerm>
				</xsl:if>
			</v1:paymentProfile>
		</xsl:if>
	</xsl:template>

	<!--xsl:template match="financialAccount">
		<xsl:if test="current()!='' or @actionCode != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="@actionCode"/>
				<xsl:apply-templates select="financialAccountNumber"/>
				<xsl:apply-templates select="billingMethod"/>
				<xsl:apply-templates select="status"/>
				<xsl:apply-templates select="billCycle"/>
				<xsl:apply-templates select="billingArrangement"/>
				<xsl:apply-templates select="accountBalanceSummaryGroup"/>
				<xsl:apply-templates select="accountContact"/>
				<xsl:apply-templates select="specificationGroup"/>
				<xsl:apply-templates select="paymentProfile"/>
				
				<xsl:apply-templates select="programMembership"/>
				<xsl:apply-templates select="specialTreatment"/>
				<xsl:if test="$orderType='ACTIVATION'">
					<xsl:apply-templates select="customerGroup"/>
				</xsl:if>
			</xsl:element>
		</xsl:if>
	</xsl:template-->

	<xsl:template match="accountContact">
		<xsl:if test="current() != ''">
			<v1:accountContact>
				<xsl:apply-templates select="addressCommunication"
					mode="accountContact-addressCommunication"/>
			</v1:accountContact>
		</xsl:if>
	</xsl:template>

	<xsl:template match="addressCommunication" mode="accountContact-addressCommunication">
		<xsl:if test="current() != '' or @actionCode != '' or @id != ''">
			<v1:addressCommunication>
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
				<xsl:apply-templates select="address" mode="addressCommunication-address"/>
				<xsl:if test="normalize-space(usageContext) != ''">
					<v1:usageContext>
						<xsl:value-of select="usageContext"/>
					</v1:usageContext>
				</xsl:if>
			</v1:addressCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="privacyProfile" mode="addressCommunication-privacyProfile">
		<xsl:if test="current() != ''">
			<v1:privacyProfile>
				<xsl:if test="normalize-space(optOut) != ''">
					<v1:optOut>
						<xsl:value-of select="optOut"/>
					</v1:optOut>
				</xsl:if>
				<xsl:if test="normalize-space(activityType) != ''">
					<v1:activityType>
						<xsl:value-of select="activityType"/>
					</v1:activityType>
				</xsl:if>
			</v1:privacyProfile>
		</xsl:if>
	</xsl:template>

	<xsl:template match="financialAccount" mode="billTo-CustomerAccount">
		<xsl:if test="current() != '' or @actionCode != ''">
			<v1:financialAccount>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="normalize-space(financialAccountNumber) != ''">
					<v1:financialAccountNumber>
						<xsl:value-of select="financialAccountNumber"/>
					</v1:financialAccountNumber>
				</xsl:if>
				<xsl:if test="normalize-space(billingMethod) != ''">
					<v1:billingMethod>
						<xsl:value-of select="billingMethod"/>
					</v1:billingMethod>
				</xsl:if>
				<xsl:apply-templates select="status"/>
				<xsl:apply-templates select="billCycle"/>
				<xsl:choose>
					<xsl:when test="$orderType = 'ACTIVATION' or $custFinActionCode = 'ADD'">
						<xsl:choose>
							<xsl:when test="billingArrangement">
								<xsl:apply-templates select="billingArrangement"/>
							</xsl:when>
							<xsl:when
								test="$orderType = 'ACTIVATION' and (../../../billTo/customer/party/person/addressCommunication/usageContext | ../../../billTo/customer/party/person/addressCommunication/@id)">
								<v1:billingArrangement>
									<v1:billingContact>
										<v1:addressCommunication>
											<xsl:if
												test="../../../billTo/customer/party/person/addressCommunication/@id">
												<xsl:attribute name="id"
												select="../../../billTo/customer/party/person/addressCommunication/@id"
												/>
											</xsl:if>
											<xsl:if
												test="../../../billTo/customer/party/person/addressCommunication/usageContext">
												<v1:usageContext>
												<xsl:value-of
												select="../../../billTo/customer/party/person/addressCommunication/usageContext/node()"
												/>
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
				<xsl:apply-templates select="accountContact"/>
				<xsl:apply-templates select="specificationGroup"/>
				<xsl:apply-templates select="paymentProfile"/>
				<xsl:choose>
					<xsl:when test="$orderType = 'ACTIVATION' or $custFinActionCode = 'ADD'">
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
			</v1:financialAccount>
		</xsl:if>
	</xsl:template>

	<xsl:template match="status">
		<xsl:if test="current() != ''">
			<v1:status>
				<xsl:if test="normalize-space(reasonCode) != ''">
					<v1:reasonCode>
						<xsl:value-of select="reasonCode"/>
					</v1:reasonCode>
				</xsl:if>
			</v1:status>
		</xsl:if>
	</xsl:template>

	<xsl:template match="billCycle">
		<xsl:if test="current() != '' or @billCycleId != '' or @actionCode != ''">
			<v1:billCycle>
				<xsl:if test="@billCycleId">
					<xsl:attribute name="billCycleId">
						<xsl:value-of select="@billCycleId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:if test="normalize-space(dayOfMonth) != ''">
					<v1:dayOfMonth>
						<xsl:value-of select="dayOfMonth"/>
					</v1:dayOfMonth>
				</xsl:if>
				<!-- xsl:apply-templates select="frequencyCode"/ -->
			</v1:billCycle>
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
										<xsl:if
											test="../../../../billTo/customer/party/person/addressCommunication/@id">
											<xsl:attribute name="id"
												select="../../../../billTo/customer/party/person/addressCommunication/@id"
											/>
										</xsl:if>
										<xsl:if
											test="../../../../billTo/customer/party/person/addressCommunication/usageContext">
											<v1:usageContext>
												<xsl:value-of
												select="../../../../billTo/customer/party/person/addressCommunication/usageContext/node()"
												/>
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
									mode="addressCommunication-billingContact"/>
							</xsl:when>
							<xsl:when
								test="../../../../../billTo/customer/party/person/addressCommunication/usageContext | ../../../../../billTo/customer/party/person/addressCommunication/@id">
								<v1:addressCommunication>
									<xsl:if
										test="../../../../../billTo/customer/party/person/addressCommunication/@id">
										<xsl:attribute name="id"
											select="../../../../../billTo/customer/party/person/addressCommunication/@id"
										/>
									</xsl:if>
									<xsl:if
										test="../../../../../billTo/customer/party/person/addressCommunication/usageContext">
										<v1:usageContext>
											<xsl:value-of
												select="../../../../../billTo/customer/party/person/addressCommunication/usageContext/node()"
											/>
										</v1:usageContext>
									</xsl:if>
								</v1:addressCommunication>
							</xsl:when>
						</xsl:choose>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="addressCommunication"
							mode="addressCommunication-billingContact"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="addressCommunication" mode="addressCommunication-billingContact">
		<xsl:if test="current() != '' or @actionCode != '' or @id != ''">
			<v1:addressCommunication>
				<xsl:choose>
					<xsl:when test="$orderType = 'ACTIVATION'">
						<xsl:choose>
							<xsl:when
								test="../../../../../../billTo/customer/party/person/addressCommunication/usageContext | ../../../../../../billTo/customer/party/person/addressCommunication/@id">
								<xsl:if
									test="../../../../../../billTo/customer/party/person/addressCommunication/@id">
									<xsl:attribute name="id"
										select="../../../../../../billTo/customer/party/person/addressCommunication/@id"
									/>
								</xsl:if>
								<xsl:apply-templates select="address" mode="key"/>
								<xsl:if
									test="../../../../../../billTo/customer/party/person/addressCommunication/usageContext">
									<v1:usageContext>
										<xsl:value-of
											select="../../../../../../billTo/customer/party/person/addressCommunication/usageContext/node()"
										/>
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
			</v1:addressCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="address" mode="addressCommunication-address">
		<xsl:if test="current() != ''">
			<v1:address>
				<xsl:apply-templates select="key"/>
			</v1:address>
		</xsl:if>
	</xsl:template>

	<xsl:template match="specificationGroup">
		<xsl:if test="current() != '' or @name != ''">
			<v1:specificationGroup>
				<xsl:if test="@name != ''">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="specificationValue" mode="cartSpecification"/>
			</v1:specificationGroup>
		</xsl:if>
	</xsl:template>

	<xsl:template match="customer">
		<xsl:if test="normalize-space(.) != '' or @actionCode != '' or @customerId != ''">
			<v1:customer>
				<xsl:if test="@actionCode != ''">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@customerId != ''">
					<xsl:attribute name="customerId">
						<xsl:value-of select="@customerId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="key"/>
				<xsl:if test="normalize-space(customerType) != ''">
					<v1:customerType>
						<xsl:value-of select="customerType"/>
					</v1:customerType>
				</xsl:if>
				<xsl:apply-templates select="status" mode="customer-status"/>
				<xsl:apply-templates select="party" mode="customer-party"/>
				<xsl:if test="$orderType = 'ACTIVATION'">
					<xsl:if test="normalize-space(customerGroup) != ''">
						<v1:customerGroup>
							<xsl:value-of select="customerGroup"/>
						</v1:customerGroup>
					</xsl:if>
				</xsl:if>
			</v1:customer>
		</xsl:if>
	</xsl:template>

	<xsl:template match="key">
		<xsl:if test="normalize-space(.) != '' or @domainName != ''">
			<v1:key>
				<xsl:if test="@domainName != ''">
					<xsl:attribute name="domainName">
						<xsl:value-of select="@domainName"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="normalize-space(keyName) != ''">
					<v1:keyName>
						<xsl:value-of select="keyName"/>
					</v1:keyName>
				</xsl:if>
				<xsl:if test="normalize-space(keyValue) != ''">
					<v1:keyValue>
						<xsl:value-of select="keyValue"/>
					</v1:keyValue>
				</xsl:if>
			</v1:key>
		</xsl:if>
	</xsl:template>

	<xsl:template match="status" mode="customer-status">
		<xsl:if test="current() != '' or @statusCode != ''">
			<v1:status>
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
			</v1:status>
		</xsl:if>
	</xsl:template>

	<xsl:template match="party" mode="customer-party">
		<xsl:if test="current() != ''">
			<v1:party>
				<xsl:apply-templates select="organization" mode="party-organization"/>
				<xsl:apply-templates select="person" mode="party-person"/>
			</v1:party>
		</xsl:if>
	</xsl:template>

	<xsl:template match="organization" mode="party-organization">
		<xsl:if test="current() != ''">
			<v1:organization>
				<xsl:if test="normalize-space(fullName) != ''">
					<v1:fullName>
						<xsl:value-of select="fullName"/>
					</v1:fullName>
				</xsl:if>
				<xsl:if test="normalize-space(shortName) != ''">
					<v1:shortName>
						<xsl:value-of select="shortName"/>
					</v1:shortName>
				</xsl:if>
				<xsl:if test="normalize-space(legalName) != ''">
					<v1:legalName>
						<xsl:value-of select="legalName"/>
					</v1:legalName>
				</xsl:if>

				<xsl:apply-templates select="organizationSpecification"/>

				<xsl:if test="normalize-space(sicCode) != ''">
					<v1:sicCode>
						<xsl:value-of select="sicCode"/>
					</v1:sicCode>
				</xsl:if>
				<xsl:apply-templates select="organizationEmploymentStatistics"/>
			</v1:organization>
		</xsl:if>
	</xsl:template>

	<xsl:template match="organizationSpecification">
		<xsl:if test="current() != ''">
			<v1:organizationSpecification>
				<xsl:apply-templates select="specificationValue"
					mode="organizationSpecification-specificationValue"/>
			</v1:organizationSpecification>
		</xsl:if>
	</xsl:template>

	<xsl:template match="specificationValue" mode="organizationSpecification-specificationValue">
		<xsl:if test="current() != '' or @name != ''">
			<v1:specificationValue>
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</v1:specificationValue>
		</xsl:if>
	</xsl:template>

	<xsl:template match="organizationEmploymentStatistics">
		<xsl:if test="current() != ''">
			<v1:organizationEmploymentStatistics>
				<xsl:apply-templates select="totalEmployment"/>
			</v1:organizationEmploymentStatistics>
		</xsl:if>
	</xsl:template>

	<xsl:template match="totalEmployment">
		<xsl:if test="current() != ''">
			<v1:totalEmployment>
				<xsl:if test="normalize-space(employeeCount) != ''">
					<v1:employeeCount>
						<xsl:value-of select="employeeCount"/>
					</v1:employeeCount>
				</xsl:if>
			</v1:totalEmployment>
		</xsl:if>
	</xsl:template>

	<xsl:template match="person" mode="party-person">
		<xsl:if test="current() != ''">
			<v1:person>
				<xsl:apply-templates select="personName" mode="shipTo-personName"/>
				<xsl:apply-templates select="ssn" mode="party-person"/>
				<xsl:apply-templates select="preferredLanguage" mode="person-preferredLanguage"/>
				<xsl:apply-templates select="addressCommunication"
					mode="person-party-addressCommunication"/>
				<xsl:if test="normalize-space(birthDate) != ''">
					<v1:birthDate>
						<xsl:value-of select="birthDate"/>
					</v1:birthDate>
				</xsl:if>
				<xsl:apply-templates select="phoneCommunication" mode="person-phoneCommunication"/>
				<xsl:apply-templates select="emailCommunication" mode="person-emailCommunication"/>
				<xsl:apply-templates select="driversLicense"/>
				<xsl:apply-templates select="nationalIdentityDocument"/>
				<xsl:apply-templates select="citizenship"/>
				<xsl:apply-templates select="passport"/>
				<xsl:apply-templates select="visa"/>
				<xsl:if test="normalize-space(gender) != ''">
					<v1:gender>
						<xsl:value-of select="gender"/>
					</v1:gender>
				</xsl:if>
				<xsl:if test="normalize-space(maritalStatus) != ''">
					<v1:maritalStatus>
						<xsl:value-of select="maritalStatus"/>
					</v1:maritalStatus>
				</xsl:if>
				<xsl:if test="normalize-space(activeDutyMilitary) != ''">
					<v1:activeDutyMilitary>
						<xsl:value-of select="activeDutyMilitary"/>
					</v1:activeDutyMilitary>
				</xsl:if>

				<xsl:apply-templates select="securityProfile"/>

				<xsl:apply-templates select="identityDocumentVerification"/>
			</v1:person>
		</xsl:if>
	</xsl:template>

	<xsl:template match="ssn" mode="party-person">
		<xsl:if test="current() != '' or @maskingType != ''">
			<v1:ssn>
				<xsl:if test="@maskingType">
					<xsl:attribute name="maskingType">
						<xsl:value-of select="@maskingType"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</v1:ssn>
		</xsl:if>
	</xsl:template>

	<xsl:template match="preferredLanguage" mode="person-preferredLanguage">
		<xsl:if test="current() != '' or @usageContext != ''">
			<v1:preferredLanguage>
				<xsl:if test="@usageContext">
					<xsl:attribute name="usageContext">
						<xsl:value-of select="@usageContext"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</v1:preferredLanguage>
		</xsl:if>
	</xsl:template>

	<xsl:template match="addressCommunication" mode="person-party-addressCommunication">
		<xsl:if test="current() != '' or @id != '' or @actionCode != ''">
			<v1:addressCommunication>
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
				<xsl:if test="normalize-space(usageContext) != ''">
					<v1:usageContext>
						<xsl:value-of select="usageContext"/>
					</v1:usageContext>
				</xsl:if>
			</v1:addressCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="phoneCommunication" mode="person-phoneCommunication">
		<xsl:if test="normalize-space(.) != ''">
			<v1:phoneCommunication>
				<xsl:if test="normalize-space(phoneType) != ''">
					<v1:phoneType>
						<xsl:value-of select="phoneType"/>
					</v1:phoneType>
				</xsl:if>
				<xsl:if test="normalize-space(phoneNumber) != ''">
					<v1:phoneNumber>
						<xsl:value-of select="phoneNumber"/>
					</v1:phoneNumber>
				</xsl:if>
				<xsl:if test="normalize-space(countryDialingCode) != ''">
					<v1:countryDialingCode>
						<xsl:value-of select="countryDialingCode"/>
					</v1:countryDialingCode>
				</xsl:if>
				<xsl:if test="normalize-space(areaCode) != ''">
					<v1:areaCode>
						<xsl:value-of select="areaCode"/>
					</v1:areaCode>
				</xsl:if>
				<xsl:if test="normalize-space(localNumber) != ''">
					<v1:localNumber>
						<xsl:value-of select="localNumber"/>
					</v1:localNumber>
				</xsl:if>
				<xsl:if test="normalize-space(phoneExtension) != ''">
					<v1:phoneExtension>
						<xsl:value-of select="phoneExtension"/>
					</v1:phoneExtension>
				</xsl:if>
			</v1:phoneCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="emailCommunication" mode="person-emailCommunication">
		<xsl:if test="current() != ''">
			<v1:emailCommunication>
				<xsl:if test="normalize-space(preference) != ''">
					<v1:preference>
						<xsl:if test="preference/preferred">
							<v1:preferred>
								<xsl:value-of select="preference/preferred"/>
							</v1:preferred>
						</xsl:if>
					</v1:preference>
				</xsl:if>

				<xsl:if test="normalize-space(emailAddress) != ''">
					<v1:emailAddress>
						<xsl:value-of select="emailAddress"/>
					</v1:emailAddress>
				</xsl:if>

				<xsl:if test="normalize-space(usageContext) != ''">
					<v1:usageContext>
						<xsl:value-of select="usageContext"/>
					</v1:usageContext>
				</xsl:if>
			</v1:emailCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="driversLicense">
		<xsl:if test="current() != '' or @id != ''">
			<v1:driversLicense>
				<xsl:if test="@id">
					<xsl:attribute name="id">
						<xsl:value-of select="@id"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="legislationAuthorityCode">
					<v1:legislationAuthorityCode>
						<xsl:value-of select="legislationAuthorityCode"/>
					</v1:legislationAuthorityCode>
				</xsl:if>
				<xsl:if test="issuingAuthority">
					<v1:issuingAuthority>
						<xsl:value-of select="issuingAuthority"/>
					</v1:issuingAuthority>
				</xsl:if>
				<xsl:if test="issuingCountryCode">
					<v1:issuingCountryCode>
						<xsl:value-of select="issuingCountryCode"/>
					</v1:issuingCountryCode>
				</xsl:if>
				<xsl:if test="suspendedIndicator">
					<v1:suspendedIndicator>
						<xsl:value-of select="suspendedIndicator"/>
					</v1:suspendedIndicator>
				</xsl:if>
				<xsl:if test="suspendedFromDate">
					<v1:suspendedFromDate>
						<xsl:value-of select="suspendedFromDate"/>
					</v1:suspendedFromDate>
				</xsl:if>
				<xsl:if test="issuingLocation">
					<v1:issuingLocation>
						<xsl:value-of select="issuingLocation"/>
					</v1:issuingLocation>
				</xsl:if>
				<xsl:if test="comment">
					<v1:comment>
						<xsl:value-of select="comment"/>
					</v1:comment>
				</xsl:if>

				<xsl:apply-templates select="issuePeriod"/>

				<xsl:if test="driversLicenseClass">
					<v1:driversLicenseClass>
						<xsl:value-of select="driversLicenseClass"/>
					</v1:driversLicenseClass>
				</xsl:if>

			</v1:driversLicense>
		</xsl:if>
	</xsl:template>

	<xsl:template match="issuePeriod">
		<v1:issuePeriod>
			<xsl:if test="startTime">
				<v1:startTime>
					<xsl:value-of select="startTime"/>
				</v1:startTime>
			</xsl:if>
			<xsl:if test="endTime">
				<v1:endTime>
					<xsl:value-of select="endTime"/>
				</v1:endTime>
			</xsl:if>
		</v1:issuePeriod>
	</xsl:template>

	<xsl:template match="nationalIdentityDocument">
		<xsl:if test="current() != ''">
			<v1:nationalIdentityDocument>
				<xsl:if test="nationalIdentityDocumentIdentifier">
					<v1:nationalIdentityDocumentIdentifier>
						<xsl:value-of select="nationalIdentityDocumentIdentifier"/>
					</v1:nationalIdentityDocumentIdentifier>
				</xsl:if>
				<xsl:if test="issuingCountryCode">
					<v1:issuingCountryCode>
						<xsl:value-of select="issuingCountryCode"/>
					</v1:issuingCountryCode>
				</xsl:if>
				<xsl:if test="typeCode">
					<v1:typeCode>
						<xsl:value-of select="typeCode"/>
					</v1:typeCode>
				</xsl:if>
				<xsl:if test="primaryIndicator">
					<v1:primaryIndicator>
						<xsl:value-of select="primaryIndicator"/>
					</v1:primaryIndicator>
				</xsl:if>
				<xsl:if test="taxIDIndicator">
					<v1:taxIDIndicator>
						<xsl:value-of select="taxIDIndicator"/>
					</v1:taxIDIndicator>
				</xsl:if>
				<xsl:if test="issuedDate">
					<v1:issuedDate>
						<xsl:value-of select="issuedDate"/>
					</v1:issuedDate>
				</xsl:if>
				<xsl:if test="expirationDate">
					<v1:expirationDate>
						<xsl:value-of select="expirationDate"/>
					</v1:expirationDate>
				</xsl:if>
				<xsl:if test="issuingAuthority">
					<v1:issuingAuthority>
						<xsl:value-of select="issuingAuthority"/>
					</v1:issuingAuthority>
				</xsl:if>
			</v1:nationalIdentityDocument>
		</xsl:if>
	</xsl:template>

	<xsl:template match="citizenship">
		<xsl:if test="normalize-space(countryCode) != ''">
			<v1:citizenship>
				<v1:countryCode>
					<xsl:value-of select="countryCode"/>
				</v1:countryCode>
			</v1:citizenship>
		</xsl:if>
	</xsl:template>

	<xsl:template match="passport">
		<xsl:if test="normalize-space(passport) != ''">
			<v1:passport>
				<xsl:if test="passportNumber">
					<v1:passportNumber>
						<xsl:value-of select="passportNumber"/>
					</v1:passportNumber>
				</xsl:if>
				<xsl:if test="typeCode">
					<v1:typeCode>
						<xsl:value-of select="typeCode"/>
					</v1:typeCode>
				</xsl:if>
				<xsl:if test="issuedDate">
					<v1:issuedDate>
						<xsl:value-of select="issuedDate"/>
					</v1:issuedDate>
				</xsl:if>
				<xsl:if test="expirationDate">
					<v1:expirationDate>
						<xsl:value-of select="expirationDate"/>
					</v1:expirationDate>
				</xsl:if>
				<xsl:if test="issuingCountryCode">
					<v1:issuingCountryCode>
						<xsl:value-of select="issuingCountryCode"/>
					</v1:issuingCountryCode>
				</xsl:if>
				<xsl:if test="issuingStateCode">
					<v1:issuingStateCode>
						<xsl:value-of select="issuingStateCode"/>
					</v1:issuingStateCode>
				</xsl:if>
				<xsl:if test="issuingLocation">
					<v1:issuingLocation>
						<xsl:value-of select="issuingLocation"/>
					</v1:issuingLocation>
				</xsl:if>
				<xsl:if test="issuingAuthority">
					<v1:issuingAuthority>
						<xsl:value-of select="issuingAuthority"/>
					</v1:issuingAuthority>
				</xsl:if>
			</v1:passport>
		</xsl:if>
	</xsl:template>

	<xsl:template match="visa">
		<xsl:if test="normalize-space(visa) != ''">
			<v1:visa>
				<xsl:if test="numberID">
					<v1:numberID>
						<xsl:value-of select="numberID"/>
					</v1:numberID>
				</xsl:if>
				<xsl:if test="typeCode">
					<v1:typeCode>
						<xsl:value-of select="typeCode"/>
					</v1:typeCode>
				</xsl:if>
				<xsl:if test="classificationCode">
					<v1:classificationCode>
						<xsl:value-of select="classificationCode"/>
					</v1:classificationCode>
				</xsl:if>
				<xsl:if test="issuingCountryCode">
					<v1:issuingCountryCode>
						<xsl:value-of select="issuingCountryCode"/>
					</v1:issuingCountryCode>
				</xsl:if>
				<xsl:if test="legislationCode">
					<v1:legislationCode>
						<xsl:value-of select="legislationCode"/>
					</v1:legislationCode>
				</xsl:if>
				<xsl:if test="validIndicator">
					<v1:validIndicator>
						<xsl:value-of select="validIndicator"/>
					</v1:validIndicator>
				</xsl:if>
				<xsl:if test="profession">
					<v1:profession>
						<xsl:value-of select="profession"/>
					</v1:profession>
				</xsl:if>
				<xsl:if test="issuedDate">
					<v1:issuedDate>
						<xsl:value-of select="issuedDate"/>
					</v1:issuedDate>
				</xsl:if>
				<xsl:if test="expirationDate">
					<v1:expirationDate>
						<xsl:value-of select="expirationDate"/>
					</v1:expirationDate>
				</xsl:if>
				<xsl:if test="entryDate">
					<v1:entryDate>
						<xsl:value-of select="entryDate"/>
					</v1:entryDate>
				</xsl:if>

				<xsl:apply-templates select="status" mode="customer-status"/>

				<xsl:if test="issuingLocation">
					<v1:issuingLocation>
						<xsl:value-of select="issuingLocation"/>
					</v1:issuingLocation>
				</xsl:if>
				<xsl:if test="issuingAuthority">
					<v1:issuingAuthority>
						<xsl:value-of select="issuingAuthority"/>
					</v1:issuingAuthority>
				</xsl:if>
			</v1:visa>
		</xsl:if>
	</xsl:template>

	<xsl:template match="securityProfile">
		<xsl:if test="normalize-space(.) != ''">
			<v1:securityProfile>
				<xsl:if test="normalize-space(userName) != ''">
					<v1:userName>
						<xsl:value-of select="userName"/>
					</v1:userName>
				</xsl:if>
				<xsl:if test="normalize-space(pin) != ''">
					<v1:pin>
						<xsl:value-of select="pin"/>
					</v1:pin>
				</xsl:if>
			</v1:securityProfile>
		</xsl:if>
	</xsl:template>

	<xsl:template match="identityDocumentVerification">
		<xsl:if test="current() != ''">
			<v1:identityDocumentVerification>
				<xsl:if test="normalize-space(identityDocumentType) != ''">
					<v1:identityDocumentType>
						<xsl:value-of select="identityDocumentType"/>
					</v1:identityDocumentType>
				</xsl:if>

				<xsl:apply-templates select="validPeriod"/>
				<xsl:apply-templates select="verificationEvent"/>
				<xsl:apply-templates select="verificationStatus"/>
			</v1:identityDocumentVerification>
		</xsl:if>
	</xsl:template>

	<xsl:template match="validPeriod">
		<xsl:if test="normalize-space(.) != ''">
			<v1:validPeriod>
				<xsl:if test="normalize-space(startDate) != ''">
					<v1:startDate>
						<xsl:value-of select="startDate"/>
					</v1:startDate>
				</xsl:if>
				<xsl:if test="normalize-space(endDate) != ''">
					<v1:endDate>
						<xsl:value-of select="endDate"/>
					</v1:endDate>
				</xsl:if>
			</v1:validPeriod>
		</xsl:if>
	</xsl:template>

	<xsl:template match="verificationEvent">
		<xsl:if test="normalize-space(.) != ''">
			<v1:verificationEvent>
				<xsl:apply-templates select="creationContext"/>
			</v1:verificationEvent>
		</xsl:if>
	</xsl:template>

	<xsl:template match="creationContext">
		<xsl:if test="normalize-space(.) != ''">
			<v1:creationContext>
				<xsl:if test="normalize-space(userName) != ''">
					<v1:userName>
						<xsl:value-of select="userName"/>
					</v1:userName>
				</xsl:if>
				<xsl:if test="normalize-space(eventTime) != ''">
					<v1:eventTime>
						<xsl:value-of select="eventTime"/>
					</v1:eventTime>
				</xsl:if>
			</v1:creationContext>
		</xsl:if>
	</xsl:template>

	<xsl:template match="verificationStatus">
		<xsl:if test="current() != '' or @statusCode != ''">
			<v1:verificationStatus>
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</v1:verificationStatus>
		</xsl:if>
	</xsl:template>

	<xsl:template match="cartItem">
		<xsl:if test="current() != '' or @cartItemId != '' or @actionCode != ''">
			<v1:cartItem>
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
				<xsl:if test="normalize-space(overridePriceAllowedIndicator) != ''">
					<v1:overridePriceAllowedIndicator>
						<xsl:value-of select="overridePriceAllowedIndicator"/>
					</v1:overridePriceAllowedIndicator>
				</xsl:if>
				<xsl:apply-templates select="quantity" mode="cartItem"/>
				<xsl:apply-templates select="cartItemStatus" mode="cartItem"/>

				<xsl:if test="normalize-space(parentCartItemId) != ''">
					<v1:parentCartItemId>
						<xsl:value-of select="parentCartItemId"/>
					</v1:parentCartItemId>
				</xsl:if>
				<xsl:if test="normalize-space(rootParentCartItemId) != ''">
					<v1:rootParentCartItemId>
						<xsl:value-of select="rootParentCartItemId"/>
					</v1:rootParentCartItemId>
				</xsl:if>

				<xsl:apply-templates select="effectivePeriod"/>
				<xsl:apply-templates select="productOffering"/>
				<xsl:apply-templates select="assignedProduct" mode="cartItem_assignedProduct"/>
				<xsl:apply-templates select="cartSchedule"/>
				<!--xsl:apply-templates select="specificationGroup"/-->
				<xsl:apply-templates select="promotion"/>
				<!--xsl:apply-templates select="relatedCartItemId"/-->
				<xsl:apply-templates select="lineOfService"/>
				<xsl:apply-templates select="networkResource"/>
				<xsl:if test="transactionType">
					<v1:transactionType>
						<xsl:value-of select="transactionType"/>
					</v1:transactionType>
				</xsl:if>
				<xsl:apply-templates select="inventoryStatus"/>
				<!--xsl:apply-templates select="deviceConditionQuestions"/>
				<xsl:apply-templates select="originalOrderLineId"/>
				<xsl:apply-templates select="deviceDiagnostics"/>
				<xsl:apply-templates select="reasonCode"/>
				<xsl:apply-templates select="returnAuthorizationType"/>
				<xsl:apply-templates select="revisionReason"/>
				<xsl:apply-templates select="priceChangedIndicator"/>
				<xsl:apply-templates select="financialAccount" mode="financialAccount-cartItem"/>
				<xsl:apply-templates select="backendChangedIndicator"/-->
				<xsl:apply-templates select="port"/>
			</v1:cartItem>
		</xsl:if>
	</xsl:template>

	<xsl:template match="cartItemStatus" mode="cartItem">
		<v1:cartItemStatus>
			<xsl:if test="@statusCode">
				<xsl:attribute name="statusCode">
					<xsl:value-of select="@statusCode"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:if test="name">
				<v1:name>
					<xsl:value-of select="name"/>
				</v1:name>
			</xsl:if>
			<xsl:if test="description">
				<v1:description>
					<xsl:if test="description/@usageContext">
						<xsl:attribute name="usageContext">
							<xsl:value-of select="description/@usageContext"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="description"/>
				</v1:description>
			</xsl:if>
	</v1:cartItemStatus>
  </xsl:template>

	<xsl:template match="quantity" mode="cartItem">
		<xsl:if test="normalize-space(.) != ''">
			<v1:quantity>
				<xsl:if test="@measurementUnit">
					<xsl:attribute name="measurementUnit">
						<xsl:value-of select="@measurementUnit"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</v1:quantity>
		</xsl:if>
	</xsl:template>

	<xsl:template match="port">
		<xsl:if test="current() != '' or @actionCode != ''">
			<v1:port>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:if test="MSISDN">
					<v1:MSISDN>
						<xsl:value-of select="MSISDN"/>
					</v1:MSISDN>
				</xsl:if>
				<xsl:if test="donorBillingSystem">
					<v1:donorBillingSystem>
						<xsl:value-of select="donorBillingSystem"/>
					</v1:donorBillingSystem>
				</xsl:if>

				<xsl:if test="donorAccountNumber">
					<v1:donorAccountNumber>
						<xsl:value-of select="donorAccountNumber"/>
					</v1:donorAccountNumber>
				</xsl:if>

				<xsl:if test="donorAccountPassword">
					<v1:donorAccountPassword>
						<xsl:value-of select="donorAccountPassword"/>
					</v1:donorAccountPassword>
				</xsl:if>
				<xsl:if test="oldServiceProvider">
					<v1:oldServiceProvider>
						<xsl:value-of select="oldServiceProvider"/>
					</v1:oldServiceProvider>
				</xsl:if>
				<xsl:if test="portDueTime">
					<v1:portDueTime>
						<xsl:value-of select="portDueTime"/>
					</v1:portDueTime>
				</xsl:if>
				<xsl:if test="portRequestedTime">
					<v1:portRequestedTime>
						<xsl:value-of select="portRequestedTime"/>
					</v1:portRequestedTime>
				</xsl:if>

				<xsl:if test="oldServiceProviderName">
					<v1:oldServiceProviderName>
						<xsl:value-of select="oldServiceProviderName"/>
					</v1:oldServiceProviderName>
				</xsl:if>
				<xsl:if test="oldVirtualServiceProviderId">
					<v1:oldVirtualServiceProviderId>
						<xsl:value-of select="oldVirtualServiceProviderId"/>
					</v1:oldVirtualServiceProviderId>
				</xsl:if>
				<xsl:apply-templates select="personProfile" mode="port"/>
			</v1:port>
		</xsl:if>
	</xsl:template>

	<xsl:template match="personProfile" mode="port">
		<xsl:if test="current() != ''">
			<v1:personProfile>
				<xsl:apply-templates select="addressCommunication" mode="port"/>
			</v1:personProfile>
		</xsl:if>
	</xsl:template>

	<xsl:template match="addressCommunication" mode="port">
		<xsl:if test="normalize-space(.) != ''">
			<v1:addressCommunication>
				<xsl:apply-templates select="address" mode="port"/>
			</v1:addressCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="address" mode="port">
		<xsl:if test="normalize-space(.) != ''">
			<v1:address>
				<xsl:if test="addressLine1">
					<v1:addressLine1>
						<xsl:value-of select="addressLine1"/>
					</v1:addressLine1>
				</xsl:if>
				<xsl:if test="addressLine2">
					<v1:addressLine2>
						<xsl:value-of select="addressLine2"/>
					</v1:addressLine2>
				</xsl:if>
				<xsl:if test="cityName">
					<v1:cityName>
						<xsl:value-of select="cityName"/>
					</v1:cityName>
				</xsl:if>
				<xsl:if test="stateCode">
					<v1:stateCode>
						<xsl:value-of select="stateCode"/>
					</v1:stateCode>
				</xsl:if>
				<xsl:if test="countryCode">
					<v1:countryCode>
						<xsl:value-of select="countryCode"/>
					</v1:countryCode>
				</xsl:if>
				<xsl:if test="postalCode">
					<v1:postalCode>
						<xsl:value-of select="postalCode"/>
					</v1:postalCode>
				</xsl:if>
			</v1:address>
		</xsl:if>
	</xsl:template>

	<xsl:template match="inventoryStatus">
		<xsl:if test="current() != '' or @statusCode != ''">
			<v1:inventoryStatus>
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="estimatedAvailable"/>
			</v1:inventoryStatus>
		</xsl:if>
	</xsl:template>

	<xsl:template match="estimatedAvailable">
		<xsl:if test="normalize-space(.) != ''">
			<v1:estimatedAvailable>
				<xsl:if test="startDate">
					<v1:startDate>
						<xsl:value-of select="startDate"/>
					</v1:startDate>
				</xsl:if>
				<xsl:if test="v1:endDate">
					<v1:endDate>
						<xsl:value-of select="v1:endDate"/>
					</v1:endDate>
				</xsl:if>
			</v1:estimatedAvailable>
		</xsl:if>
	</xsl:template>

	<xsl:template match="networkResource">
		<xsl:if test="current() != '' or @actionCode != ''">
			<v1:networkResource>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:if test="imei">
					<v1:imei>
						<xsl:value-of select="imei"/>
					</v1:imei>
				</xsl:if>
				<xsl:apply-templates select="sim"/>
				<xsl:apply-templates select="mobileNumber"/>
				<xsl:apply-templates select="resourceSpecification"/>
			</v1:networkResource>
		</xsl:if>
	</xsl:template>

	<xsl:template match="networkResource" mode="simpleChoice">
		<v1:networkResource>
			<xsl:if test="@actionCode">
				<xsl:attribute name="actionCode">
					<xsl:value-of select="@actionCode"/>
				</xsl:attribute>
			</xsl:if>

			<xsl:if test="imei">
				<v1:imei>
					<xsl:value-of select="imei"/>
				</v1:imei>
			</xsl:if>
			<xsl:apply-templates select="sim"/>
			<xsl:apply-templates select="mobileNumber"/>
			<xsl:apply-templates select="resourceSpecification"/>
		</v1:networkResource>
	</xsl:template>

	<xsl:template match="networkResource" mode="networkResource-lineOfService">
		<xsl:if test="current() != '' or @actionCode != ''">
			<v1:networkResource>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="mobileNumber"
					mode="mobileNumber-networkResource-lineOfService"/>
				<!--xsl:apply-templates select="resourceStatus"/-->
				<xsl:apply-templates select="resourceSpecification"/>
			</v1:networkResource>
		</xsl:if>
	</xsl:template>

	<xsl:template match="resourceSpecification">
		<xsl:if test="current() != '' or @name != ''">
			<v1:resourceSpecification>
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="specificationValue">
					<v1:specificationValue>
						<xsl:value-of select="specificationValue"/>
					</v1:specificationValue>
				</xsl:if>
			</v1:resourceSpecification>
		</xsl:if>
	</xsl:template>

	<xsl:template match="mobileNumber">
		<xsl:if test="current() != ''">
			<v1:mobileNumber>
				<xsl:if test="msisdn">
					<v1:msisdn>
						<xsl:value-of select="msisdn"/>
					</v1:msisdn>
				</xsl:if>
				<xsl:if test="portIndicator">
					<v1:portIndicator>
						<xsl:value-of select="portIndicator"/>
					</v1:portIndicator>
				</xsl:if>
				<xsl:if test="portReason">
					<v1:portReason>
						<xsl:value-of select="portReason"/>
					</v1:portReason>
				</xsl:if>
			</v1:mobileNumber>
		</xsl:if>
	</xsl:template>

	<xsl:template match="mobileNumber" mode="mobileNumber-networkResource-lineOfService">
		<xsl:if test="current() != ''">
			<v1:mobileNumber>
				<xsl:if test="msisdn">
					<v1:msisdn>
						<xsl:value-of select="msisdn"/>
					</v1:msisdn>
				</xsl:if>
			</v1:mobileNumber>
		</xsl:if>
	</xsl:template>

	<xsl:template match="sim">
		<xsl:if test="normalize-space(.) != ''">
			<v1:sim>
				<xsl:if test="imsi">
					<v1:imsi>
						<xsl:value-of select="imsi"/>
					</v1:imsi>
				</xsl:if>
				<xsl:if test="simNumber">
					<v1:simNumber>
						<xsl:value-of select="simNumber"/>
					</v1:simNumber>
				</xsl:if>

				<xsl:if test="simType">
					<v1:simType>
						<xsl:value-of select="simType"/>
					</v1:simType>
				</xsl:if>
				<xsl:if test="virtualSim">
					<v1:virtualSim>
						<xsl:value-of select="virtualSim"/>
					</v1:virtualSim>
				</xsl:if>
				<xsl:if test="embeddedSIMIndicator">
					<v1:embeddedSIMIndicator>
						<xsl:value-of select="embeddedSIMIndicator"/>
					</v1:embeddedSIMIndicator>
				</xsl:if>
			</v1:sim>
		</xsl:if>
	</xsl:template>

	<xsl:template match="lineOfService">
		<xsl:if test="current() != '' or @lineOfServiceId != '' or @actionCode != ''">
			<v1:lineOfService>
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

				<xsl:if test="normalize-space(financialAccountNumber) != ''">
					<v1:financialAccountNumber>
						<xsl:value-of select="financialAccountNumber"/>
					</v1:financialAccountNumber>
				</xsl:if>
				<xsl:apply-templates select="subscriberContact"/>
				<xsl:apply-templates select="networkResource" mode="networkResource-lineOfService"/>
				<xsl:if test="primaryLineIndicator">
					<v1:primaryLineIndicator>
						<xsl:value-of select="primaryLineIndicator"/>
					</v1:primaryLineIndicator>
				</xsl:if>

				<xsl:if test="lineAlias">
					<v1:lineAlias>
						<xsl:value-of select="lineAlias"/>
					</v1:lineAlias>
				</xsl:if>
				<xsl:if test="lineSequence">
					<v1:lineSequence>
						<xsl:value-of select="lineSequence"/>
					</v1:lineSequence>
				</xsl:if>

				<xsl:apply-templates select="assignedProduct"/>
				<xsl:apply-templates select="effectivePeriod"/>
				<xsl:apply-templates select="memberLineOfService"/>
				<xsl:apply-templates select="specificationGroup" mode="lineOfService"/>
				<xsl:apply-templates select="privacyProfile"/>

			</v1:lineOfService>
		</xsl:if>
	</xsl:template>

	<xsl:template match="specificationGroup" mode="lineOfService">
		<xsl:if test="normalize-space(.) != '' or specificationValue/@name != ''">
			<v1:specificationGroup>
				<xsl:apply-templates select="specificationValue" mode="cartSpecification"/>
			</v1:specificationGroup>
		</xsl:if>
	</xsl:template>

	<xsl:template match="memberLineOfService">
		<xsl:if test="normalize-space(.) != ''">
			<v1:memberLineOfService>
				<xsl:if test="primaryLineIndicator">
					<v1:primaryLineIndicator>
						<xsl:value-of select="primaryLineIndicator"/>
					</v1:primaryLineIndicator>
				</xsl:if>
			</v1:memberLineOfService>
		</xsl:if>
	</xsl:template>

	<xsl:template match="assignedProduct">
		<xsl:if test="current() != '' or @actionCode != '' or count(//@*) > 0 ">
			<v1:assignedProduct>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="productOffering" mode="lineOfService"/>
				<xsl:apply-templates select="effectivePeriod"
					mode="effectivePeriod-productOffering-assignedProduct"/>
				<xsl:if test="customerOwnedIndicator">
					<v1:customerOwnedIndicator>
						<xsl:value-of select="customerOwnedIndicator"/>
					</v1:customerOwnedIndicator>
				</xsl:if>
				<xsl:apply-templates select="eligibilityEvaluation"/>
				<xsl:apply-templates select="warranty"/>
			</v1:assignedProduct>
		</xsl:if>
	</xsl:template>

	<xsl:template match="assignedProduct" mode="cartItem_assignedProduct">
		<xsl:if test="current() != '' or @actionCode != ''">
			<v1:assignedProduct>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="productOffering"
					mode="cartItem_assignedProduct_productOffering"/>
			</v1:assignedProduct>
		</xsl:if>
	</xsl:template>

	<xsl:template match="effectivePeriod" mode="effectivePeriod-productOffering-assignedProduct">
		<xsl:if test="normalize-space(.) != ''">
			<v1:effectivePeriod>
				<xsl:if test="endTime">
					<v1:endTime>
						<xsl:value-of select="endTime"/>
					</v1:endTime>
				</xsl:if>
				<xsl:if test="usageContext">
					<v1:usageContext>
						<xsl:value-of select="usageContext"/>
					</v1:usageContext>
				</xsl:if>
			</v1:effectivePeriod>
		</xsl:if>
	</xsl:template>

	<xsl:template match="eligibilityEvaluation">
		<xsl:if test="current() != ''">
			<v1:eligibilityEvaluation>
				<xsl:apply-templates select="overrideIndicator"/>
			</v1:eligibilityEvaluation>
		</xsl:if>
	</xsl:template>

	<xsl:template match="warranty">
		<xsl:if test="normalize-space(.) != ''">
			<v1:warranty>
				<xsl:if test="warrantyExpirationDate">
					<v1:warrantyExpirationDate>
						<xsl:value-of select="warrantyExpirationDate"/>
					</v1:warrantyExpirationDate>
				</xsl:if>
			</v1:warranty>
		</xsl:if>
	</xsl:template>

	<xsl:template match="subscriberContact">
		<xsl:if test="current() != ''">
			<v1:subscriberContact>
				<!-- xsl:apply-templates select="personName"/-->
				<xsl:apply-templates select="addressCommunication" mode="lineOfService-SC"/>
			</v1:subscriberContact>
		</xsl:if>
	</xsl:template>


	<xsl:template match="cartSchedule">
		<xsl:if test="current() != ''">
			<v1:cartSchedule>
				<xsl:apply-templates select="cartScheduleStatus"/>
				<xsl:apply-templates select="cartScheduleCharge"/>
			</v1:cartSchedule>
		</xsl:if>
	</xsl:template>

	<xsl:template match="cartScheduleStatus">
		<xsl:if test="current() != '' or @statusCode != ''">
			<v1:cartScheduleStatus>
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode">
						<xsl:value-of select="@statusCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</v1:cartScheduleStatus>
		</xsl:if>
	</xsl:template>

	<xsl:template match="cartScheduleCharge">
		<xsl:if test="current() != '' or @actionCode != ''">
			<v1:cartScheduleCharge>
				<xsl:if test="@actionCode">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="typeCode">
					<v1:typeCode>
						<xsl:value-of select="typeCode"/>
					</v1:typeCode>
				</xsl:if>
				<xsl:if test="chargeFrequencyCode">
					<v1:chargeFrequencyCode>
						<xsl:value-of select="chargeFrequencyCode"/>
					</v1:chargeFrequencyCode>
				</xsl:if>

				<xsl:apply-templates select="amount"/>
				<xsl:if test="reason">
					<v1:reason>
						<xsl:value-of select="reason"/>
					</v1:reason>
				</xsl:if>
				<xsl:if test="description">
					<v1:description>
						<xsl:value-of select="description"/>
					</v1:description>
				</xsl:if>

				<xsl:if test="chargeCode">
					<v1:chargeCode>
						<xsl:value-of select="chargeCode"/>
					</v1:chargeCode>
				</xsl:if>
				<xsl:if test="waiverIndicator">
					<v1:waiverIndicator>
						<xsl:value-of select="waiverIndicator"/>
					</v1:waiverIndicator>
				</xsl:if>

				<xsl:if test="waiverReason">
					<v1:waiverReason>
						<xsl:value-of select="waiverReason"/>
					</v1:waiverReason>
				</xsl:if>

				<xsl:if test="manuallyAddedCharge">
					<v1:manuallyAddedCharge>
						<xsl:value-of select="manuallyAddedCharge"/>
					</v1:manuallyAddedCharge>
				</xsl:if>
				<xsl:if test="supervisorID">
					<v1:supervisorID>
						<xsl:value-of select="supervisorID"/>
					</v1:supervisorID>
				</xsl:if>
				<xsl:apply-templates select="overrideAmount"/>
				<xsl:if test="overrideReason">
					<v1:overrideReason>
						<xsl:value-of select="overrideReason"/>
					</v1:overrideReason>
				</xsl:if>
			</v1:cartScheduleCharge>
		</xsl:if>
	</xsl:template>

	<xsl:template match="overrideAmount">
		<xsl:if test="current() != '' or @currencyCode != ''">
			<v1:overrideAmount>
				<xsl:if test="@currencyCode">
					<xsl:attribute name="currencyCode">
						<xsl:value-of select="@currencyCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</v1:overrideAmount>
		</xsl:if>
	</xsl:template>


	<xsl:template match="effectivePeriod">
		<xsl:if test="startTime != ''">
			<v1:effectivePeriod>
				<v1:startTime>
					<xsl:value-of select="."/>
				</v1:startTime>
			</v1:effectivePeriod>
		</xsl:if>
	</xsl:template>

	<xsl:template match="productOffering">
		<xsl:if test="current() != '' or @productOfferingId != ''">
			<v1:productOffering>
				<xsl:if test="@productOfferingId">
					<xsl:attribute name="productOfferingId">
						<xsl:value-of select="@productOfferingId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="normalize-space(name) != ''">
					<v1:name>
						<xsl:value-of select="name"/>
					</v1:name>
				</xsl:if>
				<xsl:if test="normalize-space(shortName) != ''">
					<v1:shortName>
						<xsl:value-of select="shortName"/>
					</v1:shortName>
				</xsl:if>
				<xsl:if test="normalize-space(displayName) != ''">
					<v1:displayName>
						<xsl:value-of select="displayName"/>
					</v1:displayName>
				</xsl:if>

				<xsl:apply-templates select="description" mode="productOffering-description"/>
				<xsl:apply-templates select="shortDescription" mode="productOffering-description"/>
				<xsl:apply-templates select="longDescription"/>
				<xsl:apply-templates select="alternateDescription"/>
				<xsl:apply-templates select="keyword"/>

				<xsl:if test="normalize-space(offerType) != ''">
					<v1:offerType>
						<xsl:value-of select="offerType"/>
					</v1:offerType>
				</xsl:if>
				<xsl:if test="normalize-space(offerSubType) != ''">
					<v1:offerSubType>
						<xsl:value-of select="offerSubType"/>
					</v1:offerSubType>
				</xsl:if>
				<xsl:if test="normalize-space(offerLevel) != ''">
					<v1:offerLevel>
						<xsl:value-of select="offerLevel"/>
					</v1:offerLevel>
				</xsl:if>
				<xsl:apply-templates select="offeringClassification"/>
				<xsl:if test="normalize-space(businessUnit) != ''">
					<v1:businessUnit>
						<xsl:value-of select="businessUnit"/>
					</v1:businessUnit>
				</xsl:if>

				<xsl:if test="normalize-space(productType) != ''">
					<v1:productType>
						<xsl:value-of select="productType"/>
					</v1:productType>
				</xsl:if>

				<xsl:if test="normalize-space(productSubType) != ''">
					<v1:productSubType>
						<xsl:value-of select="productSubType"/>
					</v1:productSubType>
				</xsl:if>

				<xsl:apply-templates select="key"/>
				<xsl:apply-templates select="specificationGroup"
					mode="productOffering-specificationGroup"/>
				<xsl:apply-templates select="offeringPrice"/>
				<xsl:apply-templates select="orderBehavior" mode="productOffering_orderBehavior"/>
				<xsl:apply-templates select="image"/>
				<xsl:apply-templates select="marketingMessage"/>
				<xsl:apply-templates select="equipmentCharacteristics"/>
				<xsl:apply-templates select="serviceCharacteristics"/>
				<xsl:apply-templates select="offeringVariant"/>
				<xsl:apply-templates select="productOfferingComponent"/>
				<xsl:apply-templates select="productSpecification"/>
			</v1:productOffering>
		</xsl:if>
	</xsl:template>

	<xsl:template match="productOffering" mode="cartItem_assignedProduct_productOffering">
		<xsl:if test="current() != '' or @productOfferingId != ''">
			<v1:productOffering>
				<xsl:if test="@productOfferingId">
					<xsl:attribute name="productOfferingId">
						<xsl:value-of select="@productOfferingId"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:if test="normalize-space(name) != ''">
					<v1:name>
						<xsl:value-of select="name"/>
					</v1:name>
				</xsl:if>
				<xsl:if test="normalize-space(shortName) != ''">
					<v1:shortName>
						<xsl:value-of select="shortName"/>
					</v1:shortName>
				</xsl:if>
				<xsl:if test="normalize-space(displayName) != ''">
					<v1:displayName>
						<xsl:value-of select="displayName"/>
					</v1:displayName>
				</xsl:if>
				<xsl:apply-templates select="description" mode="productOffering-description"/>
				<xsl:apply-templates select="shortDescription" mode="productOffering-description"/>
				<xsl:apply-templates select="longDescription"/>
				<xsl:apply-templates select="alternateDescription"/>
				<xsl:apply-templates select="keyword"/>
				<xsl:if test="normalize-space(offerType) != ''">
					<v1:offerType>
						<xsl:value-of select="offerType"/>
					</v1:offerType>
				</xsl:if>
				<xsl:if test="normalize-space(offerSubType) != ''">
					<v1:offerSubType>
						<xsl:value-of select="offerSubType"/>
					</v1:offerSubType>
				</xsl:if>
				<xsl:if test="normalize-space(offerLevel) != ''">
					<v1:offerLevel>
						<xsl:value-of select="offerLevel"/>
					</v1:offerLevel>
				</xsl:if>
				<xsl:apply-templates select="offeringClassification"/>
				<xsl:if test="normalize-space(businessUnit) != ''">
					<v1:businessUnit>
						<xsl:value-of select="businessUnit"/>
					</v1:businessUnit>
				</xsl:if>

				<xsl:if test="normalize-space(productType) != ''">
					<v1:productType>
						<xsl:value-of select="productType"/>
					</v1:productType>
				</xsl:if>

				<xsl:if test="normalize-space(productSubType) != ''">
					<v1:productSubType>
						<xsl:value-of select="productSubType"/>
					</v1:productSubType>
				</xsl:if>
				<xsl:apply-templates select="key"/>
				<xsl:apply-templates select="specificationGroup"
					mode="productOffering-specificationGroup"/>
				<xsl:apply-templates select="offeringPrice"/>
				<xsl:apply-templates select="image"/>
				<xsl:apply-templates select="marketingMessage"/>
				<xsl:apply-templates select="equipmentCharacteristics"/>
				<xsl:apply-templates select="serviceCharacteristics" mode="cartItem"/>
				<xsl:apply-templates select="offeringVariant"/>
				<xsl:apply-templates select="productOfferingComponent"/>
				<xsl:apply-templates select="productSpecification" mode="cartItem"/>
			</v1:productOffering>
		</xsl:if>
	</xsl:template>

	<xsl:template match="image">
		<xsl:if test="normalize-space(.) != ''">
			<v1:image>
				<xsl:if test="normalize-space(URI) != ''">
					<v1:URI>
						<xsl:value-of select="URI"/>
					</v1:URI>
				</xsl:if>
				<xsl:if test="normalize-space(sku) != ''">
					<v1:sku>
						<xsl:value-of select="sku"/>
					</v1:sku>
				</xsl:if>
				<xsl:if test="normalize-space(imageDimensions) != ''">
					<v1:imageDimensions>
						<xsl:value-of select="imageDimensions"/>
					</v1:imageDimensions>
				</xsl:if>
				<xsl:if test="normalize-space(displayPurpose) != ''">
					<v1:displayPurpose>
						<xsl:value-of select="displayPurpose"/>
					</v1:displayPurpose>
				</xsl:if>
			</v1:image>
		</xsl:if>
	</xsl:template>

	<xsl:template match="productOfferingComponent">
		<xsl:if test="current() != '' or @offeringComponentId != ''">
			<v1:productOfferingComponent>
				<xsl:if test="@offeringComponentId">
					<xsl:attribute name="offeringComponentId">
						<xsl:value-of select="@offeringComponentId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="offeringVariant/sku">
					<v1:offeringVariant>
						<v1:sku>
							<xsl:value-of select="offeringVariant/sku"/>
						</v1:sku>
					</v1:offeringVariant>
				</xsl:if>
			</v1:productOfferingComponent>
		</xsl:if>
	</xsl:template>

	<xsl:template match="offeringVariant">
		<xsl:if test="current() != ''">
			<v1:offeringVariant>
				<xsl:if test="normalize-space(sku) != ''">
					<v1:sku>
						<xsl:value-of select="sku"/>
					</v1:sku>
				</xsl:if>
				<xsl:apply-templates select="specificationGroup"/>
				<xsl:apply-templates select="offeringVariantPrice"/>
				<xsl:if test="productCondition">
					<v1:productCondition>
						<xsl:value-of select="productCondition"/>
					</v1:productCondition>
				</xsl:if>
				<xsl:if test="normalize-space(color) != ''">
					<v1:color>
						<xsl:value-of select="color"/>
					</v1:color>
				</xsl:if>
				<xsl:if test="normalize-space(memory) != ''">
					<v1:memory>
						<xsl:value-of select="memory"/>
					</v1:memory>
				</xsl:if>
				<xsl:if test="normalize-space(tacCode) != ''">
					<v1:tacCode>
						<xsl:value-of select="tacCode"/>
					</v1:tacCode>
				</xsl:if>
				<xsl:apply-templates select="orderBehavior" mode="productOffering_orderBehavior"/>
			</v1:offeringVariant>
		</xsl:if>
	</xsl:template>

	<xsl:template match="offeringVariantPrice">
		<xsl:if test="current() != '' or @priceListLineId">
			<v1:offeringVariantPrice>
				<xsl:if test="@priceListLineId">
					<xsl:attribute name="priceListLineId">
						<xsl:value-of select="@priceListLineId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="name"/>
			</v1:offeringVariantPrice>
		</xsl:if>
	</xsl:template>

	<xsl:template match="productSpecification">
		<xsl:if test="current() != '' or @actionCode">
			<v1:productSpecification>
				<xsl:if test="@actionCode != ''">
					<xsl:attribute name="actionCode">
						<xsl:value-of select="@actionCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="name">
					<v1:name>
						<xsl:value-of select="name"/>
					</v1:name>
				</xsl:if>
				<xsl:apply-templates select="keyword"/>
				<xsl:if test="productType">
					<v1:productType>
						<xsl:value-of select="productType"/>
					</v1:productType>
				</xsl:if>
				<xsl:if test="productSubType">
					<v1:productSubType>
						<xsl:value-of select="productSubType"/>
					</v1:productSubType>
				</xsl:if>
			</v1:productSpecification>
		</xsl:if>
	</xsl:template>

	<xsl:template match="productSpecification" mode="cartItem">
		<xsl:if test="current() != '' or @actionCode or @productSpecificationId">
			<v1:productSpecification>
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
				<xsl:if test="normalize-space(name) != ''">
					<v1:name>
						<xsl:value-of select="name"/>
					</v1:name>
				</xsl:if>
				<xsl:apply-templates select="keyword"/>
				<xsl:if test="normalize-space(productType) != ''">
					<v1:productType>
						<xsl:value-of select="productType"/>
					</v1:productType>
				</xsl:if>
				<xsl:if test="normalize-space(productSubType) != ''">
					<v1:productSubType>
						<xsl:value-of select="productSubType"/>
					</v1:productSubType>
				</xsl:if>
				<xsl:apply-templates select="additionalSpecification"/>
			</v1:productSpecification>
		</xsl:if>
	</xsl:template>

	<xsl:template match="additionalSpecification">
		<xsl:if test="normalize-space(.) != ''">
			<v1:additionalSpecification>
				<xsl:apply-templates select="specificationValue"
					mode="organizationSpecification-specificationValue"/>
			</v1:additionalSpecification>
		</xsl:if>
	</xsl:template>

	<xsl:template match="productOffering" mode="lineOfService">
		<xsl:if test="current() != '' or @productOfferingId != '' or count(//@*) > 0">
			<v1:productOffering>
				<xsl:if test="@productOfferingId">
					<xsl:attribute name="productOfferingId">
						<xsl:value-of select="@productOfferingId"/>
					</xsl:attribute>
				</xsl:if>

				<xsl:if test="normalize-space(name) != ''">
					<v1:name>
						<xsl:value-of select="name"/>
					</v1:name>
				</xsl:if>
				<xsl:if test="normalize-space(shortName) != ''">
					<v1:shortName>
						<xsl:value-of select="shortName"/>
					</v1:shortName>
				</xsl:if>
				<xsl:if test="normalize-space(displayName) != ''">
					<v1:displayName>
						<xsl:value-of select="displayName"/>
					</v1:displayName>
				</xsl:if>
				<xsl:apply-templates select="description" mode="productOffering-description"/>
				<xsl:apply-templates select="shortDescription" mode="productOffering-description"/>
				<xsl:apply-templates select="longDescription"/>
				<xsl:apply-templates select="alternateDescription"/>
				<xsl:apply-templates select="keyword"/>

				<xsl:if test="normalize-space(offerType) != ''">
					<v1:offerType>
						<xsl:value-of select="offerType"/>
					</v1:offerType>
				</xsl:if>
				<xsl:if test="normalize-space(offerSubType) != ''">
					<v1:offerSubType>
						<xsl:value-of select="offerSubType"/>
					</v1:offerSubType>
				</xsl:if>
				<xsl:if test="normalize-space(offerLevel) != ''">
					<v1:offerLevel>
						<xsl:value-of select="offerLevel"/>
					</v1:offerLevel>
				</xsl:if>


				<xsl:apply-templates select="offeringClassification"/>
				<xsl:if test="normalize-space(businessUnit) != ''">
					<v1:businessUnit>
						<xsl:value-of select="businessUnit"/>
					</v1:businessUnit>
				</xsl:if>

				<xsl:if test="normalize-space(productType) != ''">
					<v1:productType>
						<xsl:value-of select="productType"/>
					</v1:productType>
				</xsl:if>

				<xsl:if test="normalize-space(productSubType) != ''">
					<v1:productSubType>
						<xsl:value-of select="productSubType"/>
					</v1:productSubType>
				</xsl:if>

				<xsl:apply-templates select="key"/>
				<xsl:apply-templates select="specificationGroup"
					mode="productOffering-specificationGroup"/>
				<xsl:apply-templates select="offeringPrice"/>
				<xsl:apply-templates select="orderBehavior" mode="productOffering_orderBehavior"/>
				<xsl:apply-templates select="image"/>
				<xsl:apply-templates select="marketingMessage"/>
				<xsl:apply-templates select="equipmentCharacteristics"/>
				<xsl:apply-templates select="serviceCharacteristics"/>
				<xsl:apply-templates select="offeringVariant"/>
				<xsl:apply-templates select="productSpecification" mode="cartItem"/>
			</v1:productOffering>
		</xsl:if>
	</xsl:template>

	<xsl:template match="serviceCharacteristics">
		<xsl:if test="current() != ''">
			<v1:serviceCharacteristics>
				<xsl:apply-templates select="backDateAllowedIndicator"/>
				<xsl:apply-templates select="futureDateAllowedIndicator"/>
				<xsl:apply-templates select="backDateVisibleIndicator"/>
				<xsl:apply-templates select="futureDateVisibleIndicator"/>
				<xsl:apply-templates select="includedServiceCapacity"/>
				<xsl:if test="billEffectiveCode">
					<v1:billEffectiveCode>
						<xsl:value-of select="billEffectiveCode"/>
					</v1:billEffectiveCode>
				</xsl:if>
				<xsl:apply-templates select="billableThirdPartyServiceIndicator"/>
				<xsl:apply-templates select="prorateAllowedIndicator"/>
				<xsl:apply-templates select="prorateVisibleIndicator"/>
				<xsl:if test="duration">
					<v1:duration>
						<xsl:value-of select="duration"/>
					</v1:duration>
				</xsl:if>
			</v1:serviceCharacteristics>
		</xsl:if>
	</xsl:template>

	<xsl:template match="serviceCharacteristics" mode="cartItem">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="backDateAllowedIndicator"/>
				<xsl:apply-templates select="futureDateAllowedIndicator"/>
				<xsl:apply-templates select="backDateVisibleIndicator"/>
				<xsl:apply-templates select="futureDateVisibleIndicator"/>
				<xsl:apply-templates select="includedServiceCapacity"/>

				<xsl:if test="billEffectiveCode">
					<v1:billEffectiveCode>
						<xsl:value-of select="billEffectiveCode"/>
					</v1:billEffectiveCode>
				</xsl:if>
				<xsl:apply-templates select="billableThirdPartyServiceIndicator"/>
				<xsl:apply-templates select="prorateAllowedIndicator"/>
				<xsl:if test="duration">
					<v1:duration>
						<xsl:value-of select="duration"/>
					</v1:duration>
				</xsl:if>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="includedServiceCapacity">
		<xsl:if test="current() != ''">
			<v1:includedServiceCapacity>
				<xsl:if test="capacityType">
					<v1:capacityType>
						<xsl:value-of select="capacityType"/>
					</v1:capacityType>
				</xsl:if>
				<xsl:if test="capacitySubType">
					<v1:capacitySubType>
						<xsl:value-of select="capacitySubType"/>
					</v1:capacitySubType>
				</xsl:if>
				<xsl:apply-templates select="unlimitedIndicator"/>

				<xsl:if test="size">
					<v1:size>
						<xsl:value-of select="size"/>
					</v1:size>
				</xsl:if>
				<xsl:if test="measurementUnit">
					<v1:measurementUnit>
						<xsl:value-of select="measurementUnit"/>
					</v1:measurementUnit>
				</xsl:if>
			</v1:includedServiceCapacity>
		</xsl:if>
	</xsl:template>

	<xsl:template
		match="unlimitedIndicator | backDateAllowedIndicator | futureDateAllowedIndicator | backDateVisibleIndicator | futureDateVisibleIndicator | billableThirdPartyServiceIndicator | prorateAllowedIndicator | prorateVisibleIndicator | overrideIndicator">
		<xsl:if test="current() != '' or @name != ''">
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

	<xsl:template match="equipmentCharacteristics">
		<xsl:if test="current() != ''">
			<v1:equipmentCharacteristics>
				<xsl:if test="model">
					<v1:model>
						<xsl:value-of select="model"/>
					</v1:model>
				</xsl:if>

				<xsl:if test="manufacturer">
					<v1:manufacturer>
						<xsl:value-of select="manufacturer"/>
					</v1:manufacturer>
				</xsl:if>

				<xsl:if test="color">
					<v1:color>
						<xsl:value-of select="color"/>
					</v1:color>
				</xsl:if>
				<xsl:if test="memory">
					<v1:memory>
						<xsl:value-of select="memory"/>
					</v1:memory>
				</xsl:if>

				<xsl:if test="tacCode">
					<v1:tacCode>
						<xsl:value-of select="tacCode"/>
					</v1:tacCode>
				</xsl:if>
			</v1:equipmentCharacteristics>
		</xsl:if>
	</xsl:template>

	<xsl:template match="marketingMessage">
		<xsl:if test="current() != ''">
			<v1:marketingMessage>
				<xsl:if test="salesChannelCode">
					<v1:salesChannelCode>
						<xsl:value-of select="salesChannelCode"/>
					</v1:salesChannelCode>
				</xsl:if>
				<xsl:if test="relativeSize">
					<v1:relativeSize>
						<xsl:value-of select="relativeSize"/>
					</v1:relativeSize>
				</xsl:if>
				<xsl:apply-templates select="messagePart"/>
			</v1:marketingMessage>
		</xsl:if>
	</xsl:template>

	<xsl:template match="messagePart">
		<xsl:if test="current() != ''">
			<v1:messagePart>
				<xsl:if test="code">
					<v1:code>
						<xsl:value-of select="code"/>
					</v1:code>
				</xsl:if>
				<xsl:apply-templates select="messageText"/>
				<xsl:if test="messageSequence">
					<v1:messageSequence>
						<xsl:value-of select="messageSequence"/>
					</v1:messageSequence>
				</xsl:if>
			</v1:messagePart>
		</xsl:if>
	</xsl:template>

	<xsl:template match="messageText">
		<xsl:if test="current() != '' or @languageCode != ''">
			<v1:messageText>
				<xsl:if test="@languageCode">
					<xsl:attribute name="languageCode">
						<xsl:value-of select="@languageCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</v1:messageText>
		</xsl:if>
	</xsl:template>

	<xsl:template match="description | shortDescription" mode="productOffering-description">
		<xsl:if
			test="current() != '' or @languageCode != '' or @usageContext != '' or @salesChannelCode != ''">
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

	<xsl:template match="longDescription | alternateDescription">
		<xsl:if test="current() != ''">
			<xsl:element name="v1:{local-name()} ">
				<xsl:if test="normalize-space(descriptionCode) != ''">
					<v1:descriptionCode>
						<xsl:value-of select="descriptionCode"/>
					</v1:descriptionCode>
				</xsl:if>

				<xsl:if test="normalize-space(salesChannelCode) != ''">
					<v1:salesChannelCode>
						<xsl:value-of select="salesChannelCode"/>
					</v1:salesChannelCode>
				</xsl:if>

				<xsl:if test="normalize-space(languageCode) != ''">
					<v1:languageCode>
						<xsl:value-of select="languageCode"/>
					</v1:languageCode>
				</xsl:if>
				<xsl:if test="normalize-space(relativeSize) != ''">
					<v1:relativeSize>
						<xsl:value-of select="relativeSize"/>
					</v1:relativeSize>
				</xsl:if>
				<xsl:if test="normalize-space(contentType) != ''">
					<v1:contentType>
						<xsl:value-of select="contentType"/>
					</v1:contentType>
				</xsl:if>

				<xsl:if test="normalize-space(descriptionText) != ''">
					<v1:descriptionText>
						<xsl:value-of select="descriptionText"/>
					</v1:descriptionText>
				</xsl:if>
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="keyword">
		<xsl:if test="current() != '' or @name != ''">
			<v1:keyword>
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</v1:keyword>
		</xsl:if>
	</xsl:template>

	<xsl:template match="offeringClassification">
		<xsl:if test="normalize-space(.) != ''">
			<v1:offeringClassification>
				<xsl:if test="normalize-space(classificationCode) != ''">
					<v1:classificationCode>
						<xsl:value-of select="classificationCode"/>
					</v1:classificationCode>
				</xsl:if>
				<xsl:if test="normalize-space(nameValue) != ''">
					<v1:nameValue>
						<xsl:value-of select="nameValue"/>
					</v1:nameValue>
				</xsl:if>
			</v1:offeringClassification>
		</xsl:if>
	</xsl:template>

	<xsl:template match="specificationGroup" mode="productOffering-specificationGroup">
		<xsl:if test="current() != '' or @name != ''">
			<v1:specificationGroup>
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:apply-templates select="specificationValue"
					mode="organizationSpecification-specificationValue"/>
			</v1:specificationGroup>
		</xsl:if>
	</xsl:template>

	<xsl:template match="offeringPrice">
		<xsl:if test="current() != '' or @priceListLineId != ''">
			<v1:offeringPrice>
				<xsl:if test="@priceListLineId">
					<xsl:attribute name="priceListLineId">
						<xsl:value-of select="@priceListLineId"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="normalize-space(name) != ''">
					<v1:name>
						<xsl:value-of select="name"/>
					</v1:name>
				</xsl:if>
				<xsl:apply-templates select="productOfferingPrice"/>
			</v1:offeringPrice>
		</xsl:if>
	</xsl:template>

	<xsl:template match="productOfferingPrice">
		<xsl:if test="current() != ''">
			<v1:productOfferingPrice>
				<xsl:if test="normalize-space(name) != ''">
					<v1:name>
						<xsl:value-of select="name"/>
					</v1:name>
				</xsl:if>
				<xsl:if test="normalize-space(productChargeType) != ''">
					<v1:productChargeType>
						<xsl:value-of select="productChargeType"/>
					</v1:productChargeType>
				</xsl:if>
				<xsl:if test="normalize-space(productChargeIncurredType) != ''">
					<v1:productChargeIncurredType>
						<xsl:value-of select="productChargeIncurredType"/>
					</v1:productChargeIncurredType>
				</xsl:if>
				<xsl:apply-templates select="basisAmount"/>
				<xsl:apply-templates select="amount"/>
				<xsl:if test="normalize-space(oneTimeCharge) != ''">
					<v1:oneTimeCharge>
						<xsl:value-of select="oneTimeCharge"/>
					</v1:oneTimeCharge>
				</xsl:if>

				<xsl:if test="normalize-space(taxInclusiveIndicator) != ''">
					<v1:taxInclusiveIndicator>
						<xsl:value-of select="taxInclusiveIndicator"/>
					</v1:taxInclusiveIndicator>
				</xsl:if>
				<xsl:apply-templates select="specificationValue"
					mode="organizationSpecification-specificationValue"/>
			</v1:productOfferingPrice>
		</xsl:if>
	</xsl:template>

	<xsl:template match="basisAmount">
		<xsl:if test="current() != '' or @currencyCode != ''">
			<v1:basisAmount>
				<xsl:if test="@currencyCode">
					<xsl:attribute name="currencyCode">
						<xsl:value-of select="@currencyCode"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</v1:basisAmount>
		</xsl:if>
	</xsl:template>

	<!--xsl:template match="orderBehavior">
		<xsl:if test="current()!='' or count(@*)>0">
			<xsl:element name="v1:{local-name()} ">
				<xsl:apply-templates select="preOrderAllowedIndicator"/>
				<xsl:apply-templates select="preOrderAvailableTime"/>
				<xsl:apply-templates select="saleStartTime"/>
				<xsl:apply-templates select="saleEndTime"/>
			</xsl:element>
		</xsl:if>
	</xsl:template-->

	<xsl:template match="orderBehavior" mode="productOffering_orderBehavior">
		<xsl:if test="current() != ''">
			<v1:orderBehavior>
				<xsl:apply-templates select="preOrderAllowedIndicator"/>
				<xsl:if test="normalize-space(preOrderAvailableTime) != ''">
					<v1:preOrderAvailableTime>
						<xsl:value-of select="preOrderAvailableTime"/>
					</v1:preOrderAvailableTime>
				</xsl:if>
			</v1:orderBehavior>
		</xsl:if>
	</xsl:template>

	<xsl:template match="preOrderAllowedIndicator">
		<xsl:if test="current() != '' or @name != ''">
			<v1:preOrderAllowedIndicator>
				<xsl:if test="@name">
					<xsl:attribute name="name">
						<xsl:value-of select="@name"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</v1:preOrderAllowedIndicator>
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
