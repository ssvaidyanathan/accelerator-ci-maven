<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:v1="http://services.tmobile.com/OrderManagement/CartWSIL/V1"
    xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:base="http://services.tmobile.com/base"  exclude-result-prefixes="v1 base soapenv" 
    version="2.0">
    
    <xsl:output method="xml" indent="no" version="1.0" encoding="UTF-8"/>
    
    <xsl:strip-space elements="*"/>
    
    <xsl:param name="acceptType"/>
    <xsl:param name="pINTEGER"/>
    <xsl:param name="pARRAY" select="'~ARRAY~'"/>
    
    <xsl:template match="/">
        <xsl:variable name="varResponse" select="soapenv:Envelope/soapenv:Body/v1:updateCartResponse"/>
        <taxUpdate>
            <xsl:apply-templates select="$varResponse/v1:cart"/>
        </taxUpdate>
    </xsl:template>
    
    <xsl:template match="v1:cart">
        <xsl:if test="not(empty(.)) or count(@*)>0">
            <xsl:apply-templates select="v1:totalTaxAmount"/>
            <xsl:apply-templates select="v1:cartItem"/>
            <xsl:apply-templates select="v1:tax"/>
            <xsl:apply-templates select="v1:cartSummary"/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:cartItem">
        <xsl:if test="not(empty(.)) or count(@*)>0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:cartSchedule"/>
                <xsl:apply-templates select="v1:totalTaxAmount"/>
            </xsl:element>
            <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:cartSchedule">
        <xsl:if test="not(empty(.)) or count(@*)>0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:cartScheduleTax"/>
                <xsl:apply-templates select="v1:calculationType"/>
            </xsl:element>
            <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:cartScheduleTax">
        <xsl:if test="not(empty(.)) or count(@*)>0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="@id"/>
                <xsl:apply-templates select="v1:code"/>
                <xsl:apply-templates select="v1:taxJurisdiction"/>
                <xsl:apply-templates select="v1:amount"/>
                <xsl:apply-templates select="v1:typeCode"/>
                <xsl:apply-templates select="v1:description"/>
                <xsl:apply-templates select="v1:taxRate"/>
            </xsl:element>
            <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:tax">
        <xsl:if test="not(empty(.)) or count(@*)>0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:amount"/>
                <xsl:apply-templates select="v1:description"/>
            </xsl:element>
            
            <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>
            
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:tax" mode="cartSummary">
        <xsl:if test="not(empty(.)) or count(@*)>0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="@id"/>
                <xsl:apply-templates select="v1:code"/>
                <xsl:apply-templates select="v1:taxJurisdiction"/>
                <xsl:apply-templates select="v1:amount"/>
                <xsl:apply-templates select="v1:typeCode"/>
                <xsl:apply-templates select="v1:description"/>
                <xsl:apply-templates select="v1:taxRate"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:description">
        <xsl:if test="not(empty(.)) or count(@*)>0">
            <xsl:element name="{local-name()}">
                <xsl:value-of select="."/>
            </xsl:element>
            
            <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>
            
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="v1:totalFeeAmount|v1:totalTaxAmount|v1:totalSoftGoodRecurringDueNowAmount|
        v1:totalSoftGoodOneTimeDueNowAmount| v1:totalHardGoodDueNowAmount|v1:totalSoftGoodDueNowAmount|
        v1:totalExtendedAmount|v1:totalDeltaRecurringDueAmount|v1:amount|v1:totalDueAmount|
        v1:totalRecurringDueAmount|v1:totalCurrentRecurringAmount|v1:totalRefundAmountDueLater|v1:totalRefundAmountDueNow|v1:finalRefundAmountDueNow">
        <xsl:if test="not(empty(.)) or count(@*)>0">
            <xsl:element name="{local-name()}">
                <xsl:attribute name="currencyCode">
                    <xsl:value-of select="if (@currencyCode != '')
                        then  @currencyCode else 'USD'"/>
                </xsl:attribute>
                <xsl:choose>
                    <xsl:when test="not(contains($acceptType, 'xml'))">
                        <xsl:value-of select="concat($pINTEGER,.,$pINTEGER)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="."/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:cartSummary">
        <xsl:if test="not(empty(.)) or count(@*)>0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:financialAccountId"/>
                <xsl:apply-templates select="v1:lineOfServiceId"/>
                <xsl:apply-templates select="v1:summaryScope"/>
                <xsl:apply-templates select="v1:totalDueAmount"/>
                <xsl:apply-templates select="v1:totalRecurringDueAmount"/>
                <xsl:apply-templates select="v1:charge"/>
                <xsl:apply-templates select="v1:deduction"/>
                <xsl:apply-templates select="v1:tax" mode="cartSummary"/>
                <xsl:apply-templates select="v1:calculationType"/>
                <xsl:apply-templates select="v1:totalCurrentRecurringAmount"/>
                <xsl:apply-templates select="v1:totalDeltaRecurringDueAmount"/>
                <xsl:apply-templates select="v1:totalExtendedAmount"/>
                <xsl:apply-templates select="v1:totalSoftGoodDueNowAmount"/>
                <xsl:apply-templates select="v1:totalHardGoodDueNowAmount"/>
                <xsl:apply-templates select="v1:totalSoftGoodOneTimeDueNowAmount"/>
                <xsl:apply-templates select="v1:totalSoftGoodRecurringDueNowAmount"/>
                <xsl:apply-templates select="v1:totalTaxAmount"/>
                <xsl:apply-templates select="v1:totalFeeAmount"/>
                <xsl:apply-templates select="v1:rootParentId"/>
                <xsl:apply-templates select="v1:totalRefundAmountDueLater"/>
                <xsl:apply-templates select="v1:totalRefundAmountDueNow"/>
                <xsl:apply-templates select="v1:finalRefundAmountDueNow"/>
            </xsl:element>
            <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:charge">
        <xsl:if test="not(empty(.)) or count(@*)>0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:typeCode"/>
                <xsl:apply-templates select="v1:chargeFrequencyCode"/>
                <xsl:apply-templates select="v1:amount"/>
                <xsl:apply-templates select="v1:description"/>
                <xsl:apply-templates select="v1:chargeCode"/>
                <xsl:apply-templates select="v1:productOfferingPriceId"/>
            </xsl:element>
            <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:deduction">
        <xsl:if test="not(empty(.)) or count(@*)>0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="v1:amount"/>
                <xsl:apply-templates select="v1:description"/>
                <xsl:apply-templates select="v1:recurringFrequency"/>
                <xsl:apply-templates select="v1:promotion"/>
                <xsl:apply-templates select="v1:chargeCode"/>
                <xsl:apply-templates select="v1:productOfferingPriceId"/>
            </xsl:element>
            <xsl:if test="not(contains($acceptType, 'xml'))">
                <xsl:element name="{local-name()}">
                    <xsl:value-of select="$pARRAY"/>
                </xsl:element>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="v1:promotion">
        <xsl:if test="not(empty(.)) or count(@*)>0">
            <xsl:element name="{local-name()}">
                <xsl:apply-templates select="@promotionId"/>
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
