<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:saxon="http://saxon.sf.net/" exclude-result-prefixes="saxon">
    <xsl:output omit-xml-declaration="yes"/>
    <xsl:output name="default" indent="yes"
    omit-xml-declaration="yes" 
    exclude-result-prefixes="saxon"/>
    <xsl:template match="/">
        <xsl:variable name="customerEntitlementsVar" select="//*:customerEntitlements//*:entitlement"/>
        <xsl:variable name="userEntitlementsVar" select="//*:userEntitlements//*:entitlement"/>

            <xsl:choose>
                  <xsl:when test="(//*:responseStatus/@code = '100') ">
                    <xsl:for-each select="$customerEntitlementsVar | $userEntitlementsVar">
                        <xsl:value-of select="if (string-length(./*:actionName) gt 0) 
        					then if (position() = 1) then ./*:actionName else concat(',', ./*:actionName) else ''"/>
                    </xsl:for-each>
                 </xsl:when>
                 <xsl:otherwise>
                    <apiError>
                        <xsl:choose>
                            <xsl:when test="//*:Envelope/*:Body/*:Fault/*:faultcode">  
                                <statusCode>503</statusCode>
                                <reasonPhrase>Service Unavailable</reasonPhrase>
                                <errors>
                                    <error>
                                          <code>SECURITY-0051</code>
                                          <userMessage>
                                              <xsl:value-of select="//*:Envelope/*:Body/*:Fault/*:faultstring/node()"/>
                                          </userMessage>
                                          <systemMessage>
                                              <xsl:value-of select="//*:Envelope/*:Body/*:Fault/*:faultstring/node()"/>
                                          </systemMessage>                           
                                    </error>
                                </errors>
                              </xsl:when>
                            <xsl:otherwise>
                                <statusCode>503</statusCode>
                                <reasonPhrase>Service Unavailable</reasonPhrase>
                                <errors>
                                    <error>
                                        <code>GENERAL-0001</code>
                                        <userMessage>Invalid Data</userMessage>
                                        <systemMessage>
                                            <xsl:value-of select="//*:Envelope/*:Body/*/*:responseStatus/*:detail/*:definition/node()"/>
                                        </systemMessage>
                                    </error>
                                </errors>    
                            </xsl:otherwise> 
                        </xsl:choose>
                    </apiError>
                </xsl:otherwise>
            </xsl:choose>

    </xsl:template>
</xsl:stylesheet>
