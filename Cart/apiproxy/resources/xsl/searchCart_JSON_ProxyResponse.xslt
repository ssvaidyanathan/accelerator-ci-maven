<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:v1="http://services.tmobile.com/OrderManagement/CartWSIL/V1"
    xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:base="http://services.tmobile.com/base" xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="v1 base xsd soapenv">

    <xsl:output method="xml" indent="yes" version="1.0" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>

    <xsl:param name="pARRAY" />
    <xsl:param name="acceptType" />
    <xsl:param name="pINTEGER"/>
    <xsl:param name="pageSize"/>
    <xsl:param name="pageNumber"/>
    <xsl:variable name="totalCountVar"  select="count(/soapenv:Envelope/soapenv:Body/v1:getCartDetailsResponse/v1:cart)" as="xsd:integer"/>

    <xsl:variable name="offset" as="xsd:integer">
        <xsl:choose>
            <xsl:when
                test="$pageNumber != '' and number($pageNumber) and number($pageNumber)  &gt; 0">
                <xsl:value-of select="number($pageNumber)"/>
            </xsl:when>
            <xsl:when test="$pageSize = '' or number($pageSize) &lt;1 or not(number($pageNumber))">
                <xsl:value-of select="xsd:integer(1)"/>
            </xsl:when>
         
        </xsl:choose>
    </xsl:variable>
    
    <xsl:variable name="limit" as="xsd:integer">
        <xsl:choose>
            <xsl:when test="$pageSize != '' and number($pageSize) and number($pageSize)  &gt; 0">
                <xsl:if test="number($pageSize) > 500">
                    <xsl:value-of select="xsd:integer(500)"/>
                </xsl:if>
                <xsl:if test="number($pageSize) &lt;= 500">
                    <xsl:value-of select="number($pageSize)"/>
                </xsl:if>
            </xsl:when>
            <xsl:when test="$pageSize = '' or number($pageSize) &lt;1 or not(number($pageNumber))">
                <xsl:value-of select="xsd:integer(10)"/>
            </xsl:when>
      
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="start" select="(((xsd:integer($offset) -1) * xsd:integer($limit)) + 1)" as="xsd:integer"/>
    <xsl:variable name="end" select="$start + $limit" as="xsd:integer"/>

    <xsl:template match="/">
        <carts>
            <xsl:apply-templates
                select="/soapenv:Envelope/soapenv:Body/v1:getCartDetailsResponse/v1:cart[position() ge $start and position() lt $end]"/>
            <metadata>
                <pageSize>
                    <xsl:value-of select="concat($pINTEGER,$limit,$pINTEGER)"/>
                </pageSize>
                <pageNumber>
                    <xsl:value-of select="concat($pINTEGER,$offset,$pINTEGER)"/>
                </pageNumber>
                <totalRecordCount>
                    <xsl:value-of select="concat($pINTEGER,$totalCountVar,$pINTEGER)"/>
                </totalRecordCount>
            </metadata>
        </carts>
    </xsl:template>

    <xsl:template match="v1:cart">
        <xsl:if test="normalize-space(.) != '' or @cartId != ''">
            <cart>
                <xsl:if test="@cartId">
                    <xsl:attribute name="cartId">
                        <xsl:value-of select="@cartId"/>
                    </xsl:attribute>
                </xsl:if>               
                <xsl:apply-templates select="v1:totalTaxAmount"/>
                <xsl:apply-templates select="v1:extendedAmount"/>
                <xsl:apply-templates select="v1:orderLocation"/>
                <xsl:if test="normalize-space(v1:orderTime)!=''">
                    <orderTime>
                        <xsl:value-of select="v1:orderTime"/>
                    </orderTime>
                </xsl:if>
                <xsl:apply-templates select="v1:status"/>
                <xsl:if test="normalize-space(v1:reason)!=''">
                    <reason>
                        <xsl:value-of select="v1:reason"/>
                     </reason>
                </xsl:if>
                <xsl:if test="normalize-space(v1:orderType)!=''">
                    <orderType>
                        <xsl:value-of select="v1:orderType"/>
                    </orderType>
                </xsl:if>
                <xsl:apply-templates select="v1:salesChannel"/>
                <xsl:apply-templates select="v1:cartSpecification"/>
                <xsl:apply-templates select="v1:termsAndConditionsDisposition"/>
                <xsl:apply-templates select="v1:currentRecurringChargeAmount"/>
                <xsl:apply-templates select="v1:totalRecurringDueAmount"/>
                <xsl:apply-templates select="v1:totalDueAmount"/>
                <xsl:if test="normalize-space(v1:originalOrderId)!=''">
                    <originalOrderId>
                        <xsl:value-of select="v1:originalOrderId"/>
                    </originalOrderId>
                </xsl:if>
                <xsl:if test="normalize-space(v1:modeOfExchange)!=''">
                    <modeOfExchange>
                        <xsl:value-of select="v1:modeOfExchange"/>
                    </modeOfExchange>
                </xsl:if>
                <xsl:apply-templates select="v1:relatedOrder"/>
                <xsl:if test="normalize-space(v1:reasonDescription)!=''">
                    <reasonDescription>
                        <xsl:value-of select="v1:reasonDescription"/>
                    </reasonDescription>
                </xsl:if>
                <xsl:if test="normalize-space(v1:fraudCheckRequired)!=''">
                    <fraudCheckRequired>
                        <xsl:value-of select="v1:fraudCheckRequired"/>
                    </fraudCheckRequired>
                </xsl:if>
                <xsl:if test="normalize-space(v1:isInFlightOrder)!=''">
                    <isInFlightOrder>
                        <xsl:value-of select="v1:isInFlightOrder"/>
                    </isInFlightOrder>
                </xsl:if>
                <xsl:apply-templates select="v1:fraudCheckStatus"/>
                <xsl:apply-templates select="v1:relatedCart"/>
                <xsl:apply-templates select="v1:billTo"/>
                <xsl:apply-templates select="v1:cartItem"/>
            </cart>     
            <cart>
                <xsl:value-of select="$pARRAY"/>
            </cart>            
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:relatedOrder">
        <xsl:if test="normalize-space(.) != ''">
            <relatedOrder>
                <xsl:if test="normalize-space(v1:orderId)!=''">
                    <orderId>
                        <xsl:value-of select="v1:orderId"/>
                    </orderId>
                </xsl:if>
                <xsl:if test="normalize-space(v1:relationshipType)!=''">
                    <relationshipType>
                        <xsl:value-of select="v1:relationshipType"/>
                    </relationshipType>
                </xsl:if>                
                <xsl:apply-templates select="v1:orderStatus"/>
            </relatedOrder>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:orderStatus">
        <xsl:if test="normalize-space(.) != '' or @statusCode">
            <orderStatus>
                <xsl:if test="@statusCode">
                    <xsl:attribute name="statusCode">
                        <xsl:value-of select="@statusCode"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="."/>
            </orderStatus>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:cartSpecification">
        <xsl:if test="normalize-space(.) != ''  or @name">
            <cartSpecification>                
                <xsl:if test="@name">
                    <xsl:attribute name="name">
                        <xsl:value-of select="@name"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="v1:specificationValue"/>
            </cartSpecification>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:specificationValue">
        <xsl:if test="normalize-space(.) != '' or @name">
            <specificationValue>
                <xsl:if test="@name">
                    <xsl:attribute name="name">
                        <xsl:value-of select="@name"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="."/>
            </specificationValue>
            <specificationValue>
                <xsl:value-of select="$pARRAY"/>
            </specificationValue>
        </xsl:if>
    </xsl:template>
    <xsl:template match="v1:fraudCheckStatus">
        <xsl:if test="normalize-space(.) != ''">
            <fraudCheckStatus>
                <xsl:if test="normalize-space(v1:name)!=''">
                    <name>
                       <xsl:value-of select="v1:name"/>
                    </name>
                </xsl:if>
                <xsl:if test="normalize-space(v1:reasonCode)!=''">
                    <reasonCode>
                        <xsl:value-of select="v1:reasonCode"/>
                    </reasonCode>
                </xsl:if>               
            </fraudCheckStatus>
        </xsl:if>
    </xsl:template>
    <xsl:template match="v1:relatedCart">
        <xsl:if test="normalize-space(.) != ''">
            <relatedCart>
                <xsl:if test="normalize-space(v1:cartId)!=''">
                    <cartId>
                        <xsl:value-of select="v1:cartId"/>
                    </cartId>
                </xsl:if>   
                <xsl:if test="normalize-space(v1:orderRelationshipType)!=''">
                    <orderRelationshipType>
                        <xsl:value-of select="v1:orderRelationshipType"/>
                    </orderRelationshipType>
                </xsl:if> 
                                
                <xsl:apply-templates select="v1:cartStatus"/>
                <!--xsl:apply-templates select="v1:orderRelationshipType"/-->
            </relatedCart>           
            <relatedCart>
                <xsl:value-of select="$pARRAY"/>
            </relatedCart>            
        </xsl:if>
    </xsl:template>
    <xsl:template match="v1:orderLocation">
        <xsl:if test="normalize-space(.)!='' or  @id!= ''">
            <orderLocation>
                <xsl:if test="@id">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="v1:location"/>              
                <xsl:if test="normalize-space(v1:tillNumber)!=''">
                    <tillNumber>
                        <xsl:value-of select="v1:tillNumber"/>
                    </tillNumber>
                </xsl:if>
            </orderLocation>
        </xsl:if>
    </xsl:template>
    <xsl:template match="v1:location">
        <xsl:if test="normalize-space(.)!='' or @id!= ''">
            <location>
                <xsl:if test="@id">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@id"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="."/>
            </location>
        </xsl:if>
    </xsl:template>
    <xsl:template match="v1:salesChannel">
        <xsl:if test="normalize-space(.)!=''">
            <salesChannel>
                <xsl:if test="v1:salesChannelCode != ''">
                    <salesChannelCode>
                        <xsl:value-of select="v1:salesChannelCode"/>                           
                    </salesChannelCode>
                </xsl:if>
                <xsl:if test="v1:salesSubChannelCode != ''">
                    <salesSubChannelCode>
                        <xsl:value-of select="v1:salesSubChannelCode"/>                        
                    </salesSubChannelCode>
                </xsl:if>
                <xsl:if test="v1:subChannelCategory != ''">
                    <subChannelCategory>
                        <xsl:value-of select="v1:subChannelCategory"/>                          
                    </subChannelCategory>
                </xsl:if>
            </salesChannel>
        </xsl:if>
    </xsl:template>
    <xsl:template match="v1:termsAndConditionsDisposition">
        <xsl:if test="normalize-space(termsAndConditionsDisposition) != ''">
            <termsAndConditionsDisposition>
                <xsl:if test="normalize-space(v1:acceptanceIndicator) != ''">
                    <acceptanceIndicator>
                        <xsl:value-of select="v1:acceptanceIndicator"/>                        
                    </acceptanceIndicator>
                </xsl:if>
                
                <xsl:if test="v1:acceptanceTime">
                    <acceptanceTime>
                        <xsl:value-of select="v1:acceptanceTime"/>                         
                    </acceptanceTime>
                </xsl:if>                
            </termsAndConditionsDisposition>
        </xsl:if>
    </xsl:template>
    <xsl:template match="v1:billTo">
        <xsl:if test="normalize-space(.) != ''">
            <billTo>
                <xsl:apply-templates select="v1:customerAccount"/>
                <xsl:apply-templates select="v1:customer"/>
            </billTo>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:customerAccount">
        <xsl:if test="normalize-space(.) != '' or @customerAccountId != ''">
            <customerAccount>              
                <xsl:if test="@customerAccountId">
                    <xsl:attribute name="customerAccountId">
                        <xsl:value-of select="@customerAccountId"/>
                    </xsl:attribute>
                </xsl:if>
            </customerAccount>
        </xsl:if>
    </xsl:template>
    <xsl:template match="v1:customer">
        <xsl:if test="normalize-space(.) != '' or @customerId != ''">
            <customer>
                <xsl:if test="@customerId">
                    <xsl:attribute name="customerId">
                        <xsl:value-of select="@customerId"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:apply-templates select="v1:party"/>
            </customer>
        </xsl:if>
    </xsl:template>
    <xsl:template match="v1:party">
        <xsl:if test="normalize-space(.) != ''">
            <party>
                <xsl:apply-templates select="v1:organization"/>
                <xsl:apply-templates select="v1:person"/>
            </party>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:organization">
        <xsl:if test="normalize-space(.) != ''">
            <organization>
                <xsl:if test="normalize-space(v1:fullName)!=''">
                    <fullName>
                        <xsl:value-of select="v1:fullName"/>                        
                    </fullName>
                </xsl:if>                
            </organization>
        </xsl:if>
    </xsl:template>
    <xsl:template match="v1:person">
        <xsl:if test="normalize-space(.) != ''">
            <person>
                <xsl:apply-templates select="v1:personName"/>
            </person>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:personName">
        <xsl:if test="normalize-space(.) != ''">
            <personName>
                <xsl:if test="normalize-space(v1:firstName)!=''">
                    <firstName>
                        <xsl:value-of select="v1:firstName"/>                        
                    </firstName>
                </xsl:if>  
                              
                <xsl:if test="normalize-space(v1:middleName)!=''">
                    <middleName>
                        <xsl:value-of select="v1:middleName"/>
                    </middleName>
                    <middleName>
                        <xsl:value-of select="$pARRAY"/>
                    </middleName>
                </xsl:if>
                
                <xsl:if test="normalize-space(v1:familyName)!=''">
                    <familyName>
                        <xsl:value-of select="v1:familyName"/>
                    </familyName>
                    <familyName>
                        <xsl:value-of select="$pARRAY"/>
                    </familyName>
                </xsl:if>                
                <!--xsl:apply-templates select="v1:title"/-->
            </personName>
        </xsl:if>
    </xsl:template>
   

    <xsl:template match="v1:cartItem">
        <xsl:if test="normalize-space(.) != '' or @cartItemId != ''">
            <cartItem>
                <xsl:if test="@cartItemId">
                    <xsl:attribute name="cartItemId">
                        <xsl:value-of select="@cartItemId"/>
                    </xsl:attribute>
                </xsl:if>               
                <xsl:apply-templates select="v1:networkResource"/>
                <xsl:apply-templates select="v1:lineOfService"/>
                <xsl:apply-templates select="v1:totalChargeAmount"/>
                <xsl:apply-templates select="v1:totalDiscountAmount"/>
                <xsl:apply-templates select="v1:totalFeeAmount"/>
                <xsl:apply-templates select="v1:totalTaxAmount"/>
                <xsl:apply-templates select="v1:totalDueNowAmount"/>
                <xsl:apply-templates select="v1:totalDueMonthlyAmount"/>
                <xsl:apply-templates select="v1:totalAmount"/>
            </cartItem>      
            <cartItem>
                <xsl:value-of select="$pARRAY"/>
            </cartItem>
        </xsl:if>
    </xsl:template>

    <xsl:template
        match="v1:totalTaxAmount | v1:extendedAmount | v1:currentRecurringChargeAmount | v1:totalRecurringDueAmount | v1:totalChargeAmount | v1:totalDiscountAmount | v1:totalFeeAmount | v1:totalDueNowAmount | v1:totalDueMonthlyAmount | v1:totalAmount | v1:totalDueAmount">
        <xsl:if test="normalize-space(.) != '' or normalize-space(@currencyCode) != ''">
            <xsl:element name="{local-name()}">
                <xsl:attribute name="currencyCode">
                    <xsl:value-of select="if (@currencyCode != '')
                        then  @currencyCode else 'USD'"/>
                </xsl:attribute>
                <xsl:value-of select="concat($pINTEGER, ., $pINTEGER)"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>

<xsl:template match="v1:networkResource">
        <xsl:if test="normalize-space(.) != ''">
            <networkResource>
                <xsl:if test="normalize-space(v1:imei)!=''">
                    <imei>
                        <xsl:value-of select="v1:imei"/>                        
                    </imei>
                </xsl:if>               
                <xsl:apply-templates select="v1:sim"/>
                <xsl:apply-templates select="v1:mobileNumber"/>
             </networkResource>
              <networkResource>
                  <xsl:value-of select="$pARRAY"/>
              </networkResource>            
        </xsl:if>
    </xsl:template>
    
        <xsl:template match="v1:sim">
        <xsl:if test="normalize-space(.) != ''">
            <sim>
                <xsl:if test="normalize-space(v1:simNumber)!=''">
                    <simNumber>
                        <xsl:value-of select="v1:simNumber"/>                        
                    </simNumber>
                </xsl:if>  
                <xsl:if test="normalize-space(v1:imsi)!=''">
                    <imsi>
                        <xsl:value-of select="v1:imsi"/>                        
                    </imsi>
                </xsl:if>                 
            </sim>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:mobileNumber">
        <xsl:if test="normalize-space(.) != ''">
            <mobileNumber>
                <xsl:if test="normalize-space(v1:msisdn)!=''">
                    <msisdn>
                        <xsl:value-of select="v1:msisdn"/>                        
                    </msisdn>
                </xsl:if>                 
            </mobileNumber>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:lineOfService">
        <xsl:if test="normalize-space(.) != '' or @lineOfServiceId != ''">
            <lineOfService>
                <xsl:if test="@lineOfServiceId">
                    <xsl:attribute name="lineOfServiceId">
                        <xsl:value-of select="@lineOfServiceId"/>
                    </xsl:attribute>
                </xsl:if>   
                <xsl:if test="normalize-space(v1:financialAccountNumber)!=''">
                    <financialAccountNumber>
                        <xsl:value-of select="v1:financialAccountNumber"/>                        
                    </financialAccountNumber>
                </xsl:if>                
            </lineOfService>
        </xsl:if>
    </xsl:template>

    <xsl:template match="v1:status | v1:statusCode">
        <xsl:if test="current()!='' or @statusCode != ''">
            <xsl:element name="{local-name()}">              
                <xsl:if test="@statusCode">
                    <xsl:attribute name="statusCode">
                        <xsl:value-of select="@statusCode"/>
                    </xsl:attribute>
                </xsl:if>
               <xsl:value-of select="."/>
            </xsl:element>
        </xsl:if>
    </xsl:template> 
    
    <xsl:template match="v1:*|base:*">
        <xsl:choose>
            <xsl:when test=". instance of element()">
                <xsl:if test=".!=''">
                    <xsl:element name="{local-name()} ">
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

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
