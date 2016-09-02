<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:v1="http://services.tmobile.com/OrderManagement/CartWSIL/V1"
	xmlns:base="http://services.tmobile.com/base" xmlns:saxon="http://saxon.sf.net/"
	exclude-result-prefixes="saxon" version="2.0">

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

	<xsl:param name="ABFEntitlements"/>
	<!--<xsl:variable name="capientitlementprefix">v1</xsl:variable>
	<xsl:variable name="capientitlementns">http://services.tmobile.com/OrderManagement/CartWSIL/V1</xsl:variable>-->

	<xsl:variable name="capibaseprefix">base</xsl:variable>
	<xsl:variable name="capibase">http://services.tmobile.com/base</xsl:variable>

	<xsl:param name="cartId"/>

	<xsl:template match="/">
		<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
			<soapenv:Header/>
			<soapenv:Body>
				<v1:updateCartRequest version="1">
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
				</v1:updateCartRequest>
			</soapenv:Body>
		</soapenv:Envelope>
	</xsl:template>

	<xsl:template match="cart">
		<v1:cart>
			<xsl:if test="@cartId">
				<xsl:attribute name="cartId">
					<xsl:value-of select="@cartId"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="actionCode">
				<xsl:value-of select="@actionCode"/>
			</xsl:attribute>
			<xsl:apply-templates select="billTo"/>
			<xsl:apply-templates select="addressList"/>
		</v1:cart>
	</xsl:template>

	<xsl:template match="addressList">
		<xsl:if test="current() != ''">
			<v1:addressList>
				<xsl:apply-templates select="addressCommunication" mode="addressList-addressCommunication"/>
			</v1:addressList>
		</xsl:if>
	</xsl:template>

	<xsl:template match="addressCommunication" mode="addressList-addressCommunication">
		<xsl:if test="current() != '' or @id != ''">
			<v1:addressCommunication>
				<xsl:if test="@id">
					<xsl:attribute name="id" select="@id"/>
				</xsl:if>
				<xsl:apply-templates select="address" mode="addressList-addressCommunication-address"/>
				<xsl:apply-templates select="usageContext"/>
				<xsl:apply-templates select="communicationStatus"/>
				<xsl:apply-templates select="specialInstruction"/>
			</v1:addressCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="communicationStatus">
		<xsl:if test="current() != '' or @statusCode != '' or @subStatusCode">
			<v1:communicationStatus>
				<xsl:if test="@statusCode">
					<xsl:attribute name="statusCode" select="@statusCode"/>
				</xsl:if>
				<xsl:if test="@subStatusCode">
					<xsl:attribute name="subStatusCode" select="@subStatusCode"/>
				</xsl:if>
			</v1:communicationStatus>
		</xsl:if>
	</xsl:template>

	<xsl:template match="address" mode="addressList-addressCommunication-address">
		<xsl:if test="current() != ''">
			<v1:address>
				<xsl:apply-templates select="addressFormatType"/>
				<xsl:apply-templates select="addressLine1"/>
				<xsl:apply-templates select="addressLine2"/>
				<xsl:apply-templates select="addressLine3"/>
				<xsl:apply-templates select="cityName"/>
				<xsl:apply-templates select="stateCode"/>
				<xsl:apply-templates select="stateName"/>
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
			</v1:address>
		</xsl:if>
	</xsl:template>

	<xsl:template match="geographicCoordinates">
		<xsl:if test="current() != ''">
			<v1:geographicCoordinates>
				<xsl:apply-templates select="latitude"/>
				<xsl:apply-templates select="longitude"/>
			</v1:geographicCoordinates>
		</xsl:if>
	</xsl:template>

	<xsl:template match="geoCodeID">
		<xsl:if test="current() != '' or @manualIndicator != '' or @referenceLayer != '' or @usageContext != ''">
			<v1:geoCodeID>
				<xsl:if test="@manualIndicator != ''">
					<xsl:attribute name="manualIndicator">
						<xsl:value-of select="@manualIndicator"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@referenceLayer != ''">
					<xsl:attribute name="referenceLayer">
						<xsl:value-of select="@referenceLayer"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:if test="@usageContext != ''">
					<xsl:attribute name="usageContext">
						<xsl:value-of select="@usageContext"/>
					</xsl:attribute>
				</xsl:if>
				<xsl:value-of select="."/>
			</v1:geoCodeID>
		</xsl:if>
	</xsl:template>

	<xsl:template match="billTo">
		<xsl:if test="current() != ''">
			<v1:billTo>
				<xsl:apply-templates select="customerAccount"/>
				<xsl:apply-templates select="customer"/>
			</v1:billTo>
		</xsl:if>
	</xsl:template>

	<xsl:template match="customerAccount">
		<xsl:if test="current() != ''">
			<v1:customerAccount>
				<xsl:apply-templates select="accountClassification"/>
				<xsl:apply-templates select="programMembership"/>
				<xsl:apply-templates select="specificationGroup"/>
				<xsl:apply-templates select="paymentProfile"/>
				<xsl:apply-templates select="idVerificationIndicator"/>
				<xsl:apply-templates select="corporateAffiliationProgram"/>
				<xsl:apply-templates select="strategicAccountIndicator"/>
				<xsl:apply-templates select="financialAccount"/>
			</v1:customerAccount>
		</xsl:if>
	</xsl:template>

	<xsl:template match="programMembership">
		<xsl:if test="current() != ''">
			<v1:programMembership>
				<xsl:apply-templates select="programCode"/>
				<xsl:apply-templates select="description"/>
			</v1:programMembership>
		</xsl:if>
	</xsl:template>

	<xsl:template match="paymentProfile">
		<xsl:if test="current() != ''">
			<v1:paymentProfile>
				<xsl:apply-templates select="paymentTerm"/>
			</v1:paymentProfile>
		</xsl:if>
	</xsl:template>

	<xsl:template match="financialAccount">
		<xsl:if test="current() != '' or @actionCode != ''">
			<v1:financialAccount>
				<xsl:if test="@actionCode != ''">
					<xsl:attribute name="actionCode" select="@actionCode"/>
				</xsl:if>
				<xsl:apply-templates select="financialAccountNumber"/>
				<xsl:apply-templates select="billingMethod"/>
				<xsl:apply-templates select="status" mode="status-financialAccount"/>
				<xsl:apply-templates select="billCycle"/>
				<xsl:apply-templates select="billingArrangement"/>
				<xsl:apply-templates select="accountContact"/>
				<xsl:apply-templates select="specificationGroup"/>
				<xsl:apply-templates select="paymentProfile"/>
				<xsl:apply-templates select="programMembership"/>
				<xsl:apply-templates select="specialTreatment"/>
			</v1:financialAccount>
		</xsl:if>
	</xsl:template>

	<xsl:template match="accountContact">
		<xsl:if test="current() != ''">
			<v1:accountContact>
				<xsl:apply-templates select="addressCommunication" mode="financialAccount-accountContact"/>
			</v1:accountContact>
		</xsl:if>
	</xsl:template>

	<xsl:template match="addressCommunication" mode="financialAccount-accountContact">
		<xsl:if test="current() != '' or @actionCode != '' or @id != '' and lower-case(normalize-space((uiAddedIndicator))) = 'true'">
			<v1:addressCommunication>
				<xsl:if test="@actionCode != ''">
					<xsl:attribute name="actionCode" select="@actionCode"/>
				</xsl:if>
				<xsl:if test="@id != ''">
					<xsl:attribute name="id" select="@id"/>
				</xsl:if>
				<xsl:apply-templates select="privacyProfile"/>
				<xsl:apply-templates select="address" mode="address-addressCommunication"/>
				<xsl:apply-templates select="usageContext"/>
			</v1:addressCommunication>
		</xsl:if>
	</xsl:template>


	<xsl:template match="billCycle">
		<xsl:if test="current() != '' or @actionCode != '' or @billCycleId != '' and lower-case(normalize-space((uiAddedIndicator))) = 'true'">
			<v1:billCycle>
				<xsl:if test="@actionCode != ''">
					<xsl:attribute name="actionCode" select="@actionCode"/>
				</xsl:if>
				<xsl:if test="@billCycleId != ''">
					<xsl:attribute name="billCycleId" select="@billCycleId"/>
				</xsl:if>
				<xsl:apply-templates select="dayOfMonth"/>
			</v1:billCycle>
		</xsl:if>
	</xsl:template>

	<xsl:template match="billingArrangement">
		<xsl:if test="current() != ''">
			<v1:billingArrangement>
				<xsl:apply-templates select="billingContact"/>
			</v1:billingArrangement>
		</xsl:if>
	</xsl:template>

	<xsl:template match="billingContact">
		<xsl:if test="current() != ''">
			<v1:billingContact>
				<xsl:apply-templates select="addressCommunication" mode="financialAccount-billingArragement"/>
			</v1:billingContact>
		</xsl:if>
	</xsl:template>

	<xsl:template match="addressCommunication" mode="financialAccount-billingArragement">
		<xsl:if test="current() != '' or @actionCode != '' or @billCycleId != '' and lower-case(normalize-space((uiAddedIndicator))) = 'true'">
			<v1:addressCommunication>
				<xsl:if test="@actionCode != ''">
					<xsl:attribute name="actionCode" select="@actionCode"/>
				</xsl:if>
				<xsl:if test="@id != ''">
					<xsl:attribute name="id" select="@id"/>
				</xsl:if>
				<xsl:apply-templates select="address" mode="address-addressCommunication"/>
				<xsl:apply-templates select="usageContext"/>
			</v1:addressCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="address" mode="address-addressCommunication">
		<xsl:if test="current() != ''">
			<v1:address>
				<xsl:apply-templates select="key"/>
			</v1:address>
		</xsl:if>
	</xsl:template>

	<xsl:template match="specialTreatment">
		<xsl:if test="current() != ''">
			<v1:specialTreatment>
				<xsl:apply-templates select="treatmentType"/>
			</v1:specialTreatment>
		</xsl:if>
	</xsl:template>

	<!--<xsl:template match="billCycle">
		<xsl:variable name="uiIndicatorCheck">
			<xsl:choose>
				<xsl:when test="normalize-space(uiAddedIndicator)='true'">
					<xsl:value-of select="1"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="''"/>
				</xsl:otherwise>
			</xsl:choose>  
		</xsl:variable>
		
		<xsl:if test="(current()!='' or count(@*)>0) and boolean(string($uiIndicatorCheck))">
			<v1:billCycle>
				
			</v1:billCycle>
		</xsl:if>
	</xsl:template>-->

	<xsl:template match="specificationGroup">
		<xsl:if test="current() != ''">
			<v1:specificationGroup>
				<xsl:apply-templates select="specificationValue"/>
			</v1:specificationGroup>
		</xsl:if>
	</xsl:template>

	<xsl:template match="specificationValue">
		<xsl:if test="current() != '' or @name != ''">
			<v1:specificationValue>
				<xsl:if test="@name != ''">
					<xsl:attribute name="name" select="@name"/>
				</xsl:if>
				<xsl:value-of select="."/>
			</v1:specificationValue>
		</xsl:if>
	</xsl:template>


	<!--<xsl:template match="financialAccount">
		<xsl:if test="current()!='' or count(@*)>0">
		<v1:financialAccount>
		<xsl:apply-templates select="@*"/>
		<xsl:apply-templates select="financialAccountNumber"/>
		<xsl:apply-templates select="billCycle"/>
		</v1:financialAccount>
		</xsl:if>
		</xsl:template>-->

	<xsl:template match="party">
		<xsl:if test="current() != '' or count(@*) > 0">
			<v1:party>
				<xsl:apply-templates select="person"/>
			</v1:party>
		</xsl:if>
	</xsl:template>

	<xsl:template match="person">
		<xsl:if test="current() != '' or count(@*) > 0">
			<v1:person>
				<xsl:apply-templates select="addressCommunication"/>
			</v1:person>
		</xsl:if>
	</xsl:template>

	<xsl:template match="addressCommunication">
		<xsl:if
			test="current() != '' or count(@*) > 0 and lower-case(normalize-space((uiAddedIndicator))) = 'true'">
			<v1:addressCommunication>
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates select="privacyProfile"/>
				<xsl:apply-templates select="usageContext"/>
			</v1:addressCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="privacyProfile">
		<xsl:if test="current() != ''">
			<v1:privacyProfile>
				<xsl:apply-templates select="optOut"/>
				<xsl:apply-templates select="activityType"/>
			</v1:privacyProfile>
		</xsl:if>
	</xsl:template>

	<xsl:template match="customer">
		<xsl:if test="current() != '' or @actionCode != '' or @customerId != ''">
			<v1:customer>
				<xsl:if test="@actionCode != ''">
					<xsl:attribute name="actionCode" select="@actionCode"/>
				</xsl:if>
				<xsl:if test="@customerId != ''">
					<xsl:attribute name="customerId" select="@customerId"/>
				</xsl:if>
				<xsl:apply-templates select="key"/>
				<xsl:apply-templates select="customerType"/>
				<xsl:apply-templates select="status"/>
				<xsl:apply-templates select="party" mode="customer"/>
			</v1:customer>
		</xsl:if>
	</xsl:template>

	<xsl:template match="key">
		<xsl:if test="current() != '' or @domainName != ''">
			<v1:key>
				<xsl:attribute name="domainName" select="@domainName"/>
				<xsl:apply-templates select="keyName"/>
				<xsl:apply-templates select="keyValue"/>
			</v1:key>
		</xsl:if>
	</xsl:template>

	<xsl:template match="status">
		<xsl:if test="@statusCode != ''">
			<v1:status>
				<xsl:attribute name="statusCode" select="@statusCode"/>
			</v1:status>
		</xsl:if>
	</xsl:template>

	<xsl:template match="status" mode="status-financialAccount">
		<v1:status>
			<xsl:if test="@statusCode != ''">
				<xsl:attribute name="statusCode" select="@statusCode"/>
			</xsl:if>
			<xsl:apply-templates select="reasonCode"/>
		</v1:status>
	</xsl:template>



	<xsl:template match="party" mode="customer">
		<xsl:if test="current() != ''">
			<v1:party>
				<xsl:apply-templates select="organization"/>
				<xsl:apply-templates select="person" mode="customer"/>
			</v1:party>
		</xsl:if>
	</xsl:template>

	<xsl:template match="organization">
		<xsl:if test="current() != ''">
			<v1:organization>
				<xsl:apply-templates select="fullName"/>
				<xsl:apply-templates select="shortName"/>
				<xsl:apply-templates select="legalName"/>
				<xsl:apply-templates select="organizationSpecification"/>
				<xsl:apply-templates select="sicCode"/>
				<xsl:apply-templates select="organizationEmploymentStatistics"/>
			</v1:organization>
		</xsl:if>
	</xsl:template>

	<xsl:template match="totalEmployment">
		<xsl:if test="current() != ''">
			<v1:totalEmployment>
				<xsl:apply-templates select="employeeCount"/>
			</v1:totalEmployment>
		</xsl:if>
	</xsl:template>

	<xsl:template match="organizationEmploymentStatistics">
		<xsl:if test="current() != ''">
			<v1:organizationEmploymentStatistics>
				<xsl:apply-templates select="totalEmployment"/>
			</v1:organizationEmploymentStatistics>
		</xsl:if>
	</xsl:template>

	<xsl:template match="organizationSpecification">
		<xsl:if test="current() != ''">
			<v1:organizationSpecification>
				<xsl:apply-templates select="specificationValue"/>
			</v1:organizationSpecification>
		</xsl:if>
	</xsl:template>

	<xsl:template match="person" mode="customer">
		<xsl:if test="current() != ''">
			<v1:person>
				<xsl:apply-templates select="personName"/>
				<xsl:apply-templates select="ssn"/>
				<xsl:apply-templates select="preferredLanguage"/>
				<xsl:apply-templates select="addressCommunication" mode="customer"/>
				<xsl:apply-templates select="birthDate"/>
				<xsl:apply-templates select="phoneCommunication"/>
				<xsl:apply-templates select="emailCommunication"/>
				<xsl:apply-templates select="driversLicense"/>
				<xsl:apply-templates select="citizenship"/>
				<xsl:apply-templates select="passport"/>
				<xsl:apply-templates select="gender"/>
				<xsl:apply-templates select="maritalStatus"/>
				<xsl:apply-templates select="activeDutyMilitary"/>
				<xsl:apply-templates select="securityProfile"/>
				<xsl:apply-templates select="identityDocumentVerification"/>
			</v1:person>
		</xsl:if>
	</xsl:template>

	<xsl:template match="preferredLanguage">
		<xsl:if test="current() != '' or @usageContext != ''">
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


	<xsl:template match="identityDocumentVerification">
		<xsl:if test="current() != ''">
			<v1:identityDocumentVerification>
				<xsl:apply-templates select="identityDocumentType"/>
				<xsl:apply-templates select="validPeriod"/>
				<xsl:apply-templates select="verificationEvent"/>
				<xsl:apply-templates select="verificationStatus"/>
			</v1:identityDocumentVerification>
		</xsl:if>
	</xsl:template>

	<xsl:template match="verificationStatus">
		<xsl:if test="@statusCode != ''">
			<v1:verificationStatus>
				<xsl:attribute name="statusCode" select="@statusCode"/>
			</v1:verificationStatus>
		</xsl:if>
	</xsl:template>

	<xsl:template match="verificationEvent">
		<xsl:if test="current() != ''">
			<v1:verificationEvent>
				<xsl:apply-templates select="creationContext"/>
			</v1:verificationEvent>
		</xsl:if>
	</xsl:template>

	<xsl:template match="creationContext">
		<xsl:if test="current() != ''">
			<v1:creationContext>
				<xsl:apply-templates select="userName"/>
				<xsl:apply-templates select="eventTime"/>
			</v1:creationContext>
		</xsl:if>
	</xsl:template>

	<xsl:template match="validPeriod">
		<xsl:if test="current() != ''">
			<v1:validPeriod>
				<xsl:apply-templates select="startDate"/>
				<xsl:apply-templates select="endDate"/>
			</v1:validPeriod>
		</xsl:if>
	</xsl:template>


	<xsl:template match="passport">
		<xsl:if test="current() != ''">
			<v1:passport>
				<xsl:apply-templates select="passportNumber"/>
			</v1:passport>
		</xsl:if>
	</xsl:template>

	<xsl:template match="citizenship">
		<xsl:if test="current() != ''">
			<v1:citizenship>
				<xsl:apply-templates select="countryCode"/>
			</v1:citizenship>
		</xsl:if>
	</xsl:template>

	<xsl:template match="driversLicense">
		<xsl:if test="@id != ''">
			<v1:driversLicense>
				<xsl:attribute name="id" select="@id"/>
			</v1:driversLicense>
		</xsl:if>
	</xsl:template>

	<xsl:template match="personName">
		<xsl:if test="current() != ''">
			<v1:personName>
				<xsl:apply-templates select="firstName"/>
				<xsl:apply-templates select="middleName"/>
				<xsl:apply-templates select="familyName"/>
				<xsl:apply-templates select="aliasName"/>
			</v1:personName>
		</xsl:if>
	</xsl:template>

	<xsl:template match="ssn">
		<xsl:if test="current() != '' or @maskingType != ''">
			<v1:ssn>
				<xsl:if test="@maskingType != ''">
					<xsl:attribute name="maskingType" select="@maskingType"/>
				</xsl:if>
				<xsl:value-of select="."/>
			</v1:ssn>
		</xsl:if>
	</xsl:template>

	<xsl:template match="addressCommunication" mode="customer">
		<xsl:if test="current() != '' or @actionCode != '' or @id !='' and lower-case(normalize-space((uiAddedIndicator))) = 'true'">
			<v1:addressCommunication>
				<xsl:attribute name="actionCode">
					<xsl:value-of select="@actionCode"/>
				</xsl:attribute>
				<xsl:attribute name="id">
					<xsl:value-of select="@id"/>
				</xsl:attribute>
				<xsl:apply-templates select="usageContext"/>
			</v1:addressCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="phoneCommunication">
		<xsl:if test="current() != ''">
			<v1:phoneCommunication>
				<xsl:apply-templates select="phoneType"/>
				<xsl:apply-templates select="phoneNumber"/>
				<xsl:apply-templates select="countryDialingCode"/>
				<xsl:apply-templates select="areaCode"/>
				<xsl:apply-templates select="localNumber"/>
				<xsl:apply-templates select="phoneExtension"/>
			</v1:phoneCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="emailCommunication">
		<xsl:if test="current() != ''">
			<v1:emailCommunication>
				<xsl:apply-templates select="preference"/>
				<xsl:apply-templates select="emailAddress"/>
				<xsl:apply-templates select="usageContext"/>
			</v1:emailCommunication>
		</xsl:if>
	</xsl:template>

	<xsl:template match="preference">
		<xsl:if test="current() != '' or count(@*) > 0">
			<v1:preference>
				<xsl:apply-templates select="preferred"/>
			</v1:preference>
		</xsl:if>
	</xsl:template>

	<xsl:template match="securityProfile">
		<xsl:if test="current() != ''">
			<v1:securityProfile>
				<xsl:apply-templates select="userName"/>
				<xsl:apply-templates select="pin"/>
			</v1:securityProfile>
		</xsl:if>
	</xsl:template>

	<xsl:template match="@* | node()">
		<xsl:choose>
			<xsl:when test=". instance of element()">
				<xsl:if test=". != ''">
					<xsl:element name="v1:{local-name()} ">
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
