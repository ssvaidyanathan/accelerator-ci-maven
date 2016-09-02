<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  	<xsl:param name="cartId"/>
    <xsl:param name="senderId"/>
    <xsl:param name="channelId"/>
  	<xsl:param name="applicationId"/>
    <xsl:output method="xml" version="1.0" encoding="ISO-8859-1" indent="no" omit-xml-declaration="yes"/>
    <xsl:template match="/"> 
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
			   <soapenv:Header/>
			   <soapenv:Body>       
                <base:updateCartRequest serviceTransactionId="" version="" xmlns:car="http://services.tmobile.com/SalesManagement/CartWSIL/V1" xmlns:base="http://service.tmobile.com/base">
                    <base:header>
                        <base:sender>
                            <xsl:element name="base:senderId"><xsl:value-of select="$senderId"/></xsl:element>
                            <xsl:element name="base:channelId"><xsl:value-of select="$channelId"/></xsl:element>
                            <xsl:element name="base:applicationId"><xsl:value-of select="$applicationId"/></xsl:element>
                        </base:sender>
                    </base:header>
                  	<xsl:element name="car:cart">
                      <xsl:if test="$cartId">
                        <xsl:attribute name="statusCode">UPDATE</xsl:attribute>
                        <xsl:attribute name="cartId"><xsl:value-of select="$cartId"/></xsl:attribute>
                      </xsl:if>
                        <car:totalAmount currencyCode=""/>
                        <car:status statusCode="">
                            <car:name/>
                            <car:reasonCode/>
                        </car:status>
                        <car:businessUnitName>B2B</car:businessUnitName>
                        <car:salesperson>BOON</car:salesperson>
                        <car:cartItem>
                            <xsl:element name="car:quantity">
                                <xsl:attribute name="measurementUnit"><xsl:value-of select="//cartItem/measurementUnit"/></xsl:attribute>
                                <xsl:value-of select="//cartItem/quantity"/>
                            </xsl:element>
                            <car:currencyCode><xsl:value-of select="//cartItem/currencyCode"/></car:currencyCode>
                            <car:cartItemStatus statusCode="">
                                <car:name/>
                                <car:reasonCode/>
                            </car:cartItemStatus>
                            <car:parentCartItemId/>
                            <car:rootParentCartItemId/>
                            <car:productOffering>
                                <xsl:element name="car:bundledOffering">
                                    <xsl:attribute name="productOfferingId">
                                        <xsl:value-of select="//cartItem/productOffering/bundledOffering/productOfferingId"/>
                                    </xsl:attribute>
                                    <car:name>
                                        <xsl:value-of select="//cartItem/productOffering/bundledOffering/name"/>
                                    </car:name>
                                    <xsl:element name="car:description">
                                        <xsl:attribute name="languageCode">
                                            <xsl:value-of select="//cartItem/productOffering/bundledOffering/languageCode"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="usageContext">
                                            <xsl:value-of select="//cartItem/productOffering/bundledOffering/usageContext"/>
                                        </xsl:attribute>
                                        <xsl:value-of select="//cartItem/productOffering/bundledOffering/description"/>
                                    </xsl:element>
                                    <xsl:element name="car:shortDescription">
                                        <xsl:attribute name="languageCode">
                                            <xsl:value-of select="//cartItem/productOffering/bundledOffering/languageCode"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="usageContext">
                                            <xsl:value-of select="//cartItem/productOffering/bundledOffering/usageContext"/>
                                        </xsl:attribute>
                                        <xsl:value-of select="//cartItem/productOffering/bundledOffering/shortDescription"/>
                                    </xsl:element>
                                    <xsl:element name="car:longDescription">
                                        <xsl:attribute name="languageCode">
                                            <xsl:value-of select="//cartItem/productOffering/bundledOffering/languageCode"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="usageContext">
                                            <xsl:value-of select="//cartItem/productOffering/bundledOffering/usageContext"/>
                                        </xsl:attribute>
                                        <xsl:value-of select="//cartItem/productOffering/bundledOffering/longDescription"/>
                                    </xsl:element>
                                    <car:keyword/>
                                    <car:offerType>
                                        <xsl:value-of select="//cartItem/productOffering/bundledOffering/offerType"/>
                                    </car:offerType>
                                    <car:offerSubType>
                                        <xsl:value-of select="//cartItem/productOffering/bundledOffering/offerSubType"/>
                                    </car:offerSubType>
                                    <!--xsl:for-each select="//cartItem/productOffering/bundledOffering/specificationGroup"-->
                                        <xsl:element name="car:specificationGroup" >
											<xsl:attribute name="name">
												<xsl:value-of select="//cartItem/productOffering/bundledOffering/specificationGroup/name"/>
											</xsl:attribute>
										</xsl:element>
                                    <!--/xsl:for-each-->
                                    <!--xsl:for-each select="//cartItem/productOffering/bundledOffering/offeringPrice"-->
                                        <xsl:element name="car:offeringPrice">
                                            <xsl:attribute name="priceListLineId">
                                                <xsl:value-of select="//cartItem/productOffering/bundledOffering/offeringPrice/priceListLineId"/>
                                            </xsl:attribute>
                                            <car:name><xsl:value-of select="//cartItem/productOffering/bundledOffering/offeringPrice/name"/></car:name>
                                            <!--xsl:for-each select="productOfferingPrice"-->
                                                  <xsl:element name="car:productOfferingPrice">
                                                    <xsl:attribute name="productOfferingPriceId">
                                                        <xsl:value-of select="//cartItem/productOffering/bundledOffering/offeringPrice/productOfferingPrice/productOfferingPriceId"/>
                                                    </xsl:attribute>
                                                  <car:productChargeType>
                                                      <xsl:value-of select="//cartItem/productOffering/bundledOffering/offeringPrice/productOfferingPrice/productChargeType"/>
                                                  </car:productChargeType>
                                                  <!--xsl:for-each select="serviceFee"-->
                                                    <car:serviceFee>
                                                        <car:feeDetail>
                                                            <xsl:element name="car:amount">
                                                               <xsl:attribute name="currencyCode">
                                                                   <xsl:value-of 
                                                                       select="//cartItem/productOffering/bundledOffering/offeringPrice/productOfferingPrice/serviceFee/feeDetail/amount/currencyCode"/>
                                                               </xsl:attribute>
                                                                <xsl:value-of select="//cartItem/productOffering/bundledOffering/offeringPrice/productOfferingPrice/serviceFee/feeDetail/amount"/>
                                                            </xsl:element>
                                                            <car:oneTimeCharge>
                                                                <xsl:value-of select="//cartItem/productOffering/bundledOffering/offeringPrice/productOfferingPrice/serviceFee/feeDetail/oneTimeCharge"/>
                                                            </car:oneTimeCharge>
                                                        </car:feeDetail>
                                                    </car:serviceFee>
                                                  <!--/xsl:for-each-->
                                                  </xsl:element>
                                            <!--/xsl:for-each-->
                                        </xsl:element>
                                    <!--/xsl:for-each-->
                                    <!--xsl:for-each select="//cartItem/productOffering/bundledOffering/simpleOfferingComponent"-->
                                        <xsl:element name="car:simpleOfferingComponent">
                                            <xsl:attribute name="offeringComponentId">
                                                <xsl:value-of select="//cartItem/productOffering/bundledOffering/simpleOfferingComponent/simpleOfferingComponent/offeringComponentId"/>
                                            </xsl:attribute>
                                            <car:minimumComponentQuantity>
                                                <xsl:value-of select="//cartItem/productOffering/bundledOffering/simpleOfferingComponent/simpleOfferingComponent/minimumComponentQuantity"/>
                                            </car:minimumComponentQuantity>
                                            <car:maximumComponentQuantity>
                                                <xsl:value-of select="//cartItem/productOffering/bundledOffering/simpleOfferingComponent/simpleOfferingComponent/maximumComponentQuantity"/>
                                            </car:maximumComponentQuantity>
                                            <car:componentIsDefault>
                                                <xsl:value-of select="//cartItem/productOffering/bundledOffering/simpleOfferingComponent/simpleOfferingComponent/componentIsDefault"/>
                                            </car:componentIsDefault>
                                            <car:simpleOffering productOfferingId="" sku="">
                                                <car:name/>
                                                <car:shortName/>
                                                <car:displayName/>
                                                <car:keyword/>
                                            </car:simpleOffering>
                                        </xsl:element>
                                    <!--/xsl:for-each-->
                                </xsl:element>
                            </car:productOffering>
                            <!--xsl:for-each select="//cartItem/specificationGroup"-->
                          <xsl:element name="car:specificationGroup">
                                    <xsl:attribute name="name">
                                        <xsl:value-of select="//cartItem/specificationGroup/name"/>
                                    </xsl:attribute>
                                    <!--xsl:for-each select="specificationValue"-->
                                        <xsl:element name="car:specificationValue">
                                            <xsl:attribute name="currencyCode"><xsl:value-of select="//cartItem/specificationGroup/specificationValue/currencyCode"/></xsl:attribute>
                                            <xsl:attribute name="dataType"><xsl:value-of select="//cartItem/specificationGroup/specificationValue/dataType"/></xsl:attribute>
                                            <xsl:attribute name="measurementUnit"><xsl:value-of select="//cartItem/specificationGroup/specificationValue/measurementUnit"/></xsl:attribute>
                                            <xsl:attribute name="name"><xsl:value-of select="//cartItem/specificationGroup/specificationValue/name"/></xsl:attribute>
                                            <xsl:attribute name="precision"><xsl:value-of select="//cartItem/specificationGroup/specificationValue/precision"/></xsl:attribute>
                                            <xsl:attribute name="scale"><xsl:value-of select="//cartItem/specificationGroup/specificationValue/scale"/></xsl:attribute>
                                            <xsl:value-of select="//cartItem/specificationGroup/specificationValue"/>
                                        </xsl:element>
                                    <!--/xsl:for-each-->
                                </xsl:element>                             
                            <!--/xsl:for-each-->
                        </car:cartItem>
                        <car:cartSpecification name="CUSTOMER_ID">
                            <car:specificationValue currencyCode="USD" dataType=""
                                measurementUnit="2" name="3000000540" precision="1" scale="1"/>
                        </car:cartSpecification>
                    </xsl:element>
                </base:updateCartRequest>
            </soapenv:Body>
        </soapenv:Envelope>           
    </xsl:template>
</xsl:stylesheet>