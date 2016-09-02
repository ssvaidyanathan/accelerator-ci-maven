<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
    xmlns:ent="http://services.tmobile.com/SecurityManagement/UserSecurityEnterprise/V1"
    xmlns:TO_BE_REPLACED_BASE_PREFIX="TO_BE_REPLACED_BASE_NAMESPACE"
    xmlns:saxon="http://saxon.sf.net/" exclude-result-prefixes="saxon soapenv ent">
    <xsl:output method="xml" omit-xml-declaration="yes"/>
    <xsl:param name="apiABFList"/>
    <xsl:template match="/">
        <xsl:variable name="domainlist" select="(tokenize($apiABFList, ':'))[2]"/>
        <xsl:variable name="domainNames" select="tokenize($domainlist, ',')"/>    
           <xsl:variable name="entitlementsVar"> 
            <xsl:for-each select="//ent:entitlement[ent:resourceName = $domainNames]">
                <TO_BE_REPLACED_BASE_PREFIX:entitlement>
                    <TO_BE_REPLACED_BASE_PREFIX:resourceName>
                        <xsl:value-of select="./ent:resourceName"/>
                    </TO_BE_REPLACED_BASE_PREFIX:resourceName>
                    <TO_BE_REPLACED_BASE_PREFIX:actionName>
                        <xsl:value-of select="./ent:actionName"/>
                    </TO_BE_REPLACED_BASE_PREFIX:actionName>
                    <TO_BE_REPLACED_BASE_PREFIX:isAccessAllowed>
                        <xsl:value-of select="./ent:isAccessAllowed"/>
                    </TO_BE_REPLACED_BASE_PREFIX:isAccessAllowed>
                    <xsl:for-each select="./ent:responseAttribute">
                        <TO_BE_REPLACED_BASE_PREFIX:responseAttribute>
                            <xsl:copy-of select="./@*"/>
                        </TO_BE_REPLACED_BASE_PREFIX:responseAttribute>
                    </xsl:for-each>
                </TO_BE_REPLACED_BASE_PREFIX:entitlement>
            </xsl:for-each>
            </xsl:variable>
            <xsl:if test="normalize-space($entitlementsVar) != ''">
          		<TO_BE_REPLACED_BASE_PREFIX:entitlements>
                   <xsl:copy-of select="$entitlementsVar"/>
          		</TO_BE_REPLACED_BASE_PREFIX:entitlements>
            </xsl:if>        
    </xsl:template>
</xsl:stylesheet>