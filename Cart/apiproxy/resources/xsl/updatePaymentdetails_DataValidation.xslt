<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:param name="cartId"/>
    <xsl:param name="channelId"/>
    <xsl:param name="isMobile"/>
    
    <xsl:template match="/">
        
        <apiError>
            <statusCode>
                <xsl:value-of select="&quot;400&quot;"/>
            </statusCode>
            <reasonPhrase>
                <xsl:value-of select="&quot;Bad Request&quot;"/>
            </reasonPhrase>
            <errors>
                <xsl:choose>
                    <xsl:when test="string-length($cartId) = 0">
                        <error>
                            <code>
                                <xsl:value-of select="&quot;GENERAL-0001&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of select="&quot;Input Data Invalid&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;The Cart ID is missing in path param&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>					
                    
                    <xsl:when test="matches($cartId,'[^a-zA-Z0-9]')">
                        <error>
                            <code>
                                <xsl:value-of select="&quot;GENERAL-0001&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of select="&quot;Input Data Invalid&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;Only letters and numbers are allowed for CartID&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>
                    
                    <xsl:when test="contains($channelId,'RETAIL')">
                        <xsl:if test="not((lower-case($isMobile) = 't' or lower-case($isMobile) = 'true' or lower-case($isMobile) = 'false' or lower-case($isMobile) = 'f'))">
                            <error>
                                <code>
                                    <xsl:value-of select="&quot;GENERAL-0001&quot;"/>
                                </code>
                                <userMessage>
                                    <xsl:value-of select="&quot;Input Data Invalid&quot;"/>
                                </userMessage>
                                <systemMessage>
                                    <xsl:value-of select="&quot;isMobile valid value is need to be paased in the request&quot;"/>
                                </systemMessage>
                            </error>
                         </xsl:if>
                    </xsl:when>
                    
                </xsl:choose>
            </errors>
        </apiError>
    </xsl:template>
    
</xsl:stylesheet>