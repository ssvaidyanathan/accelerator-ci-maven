<xsl:stylesheet version="2.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:param name="cartId"/>
    <xsl:template match="/">
        <xsl:variable name="actionCode" select="/cart/@actionCode"/>
        <apiError>
            <statusCode>
                <xsl:value-of select="&quot;400&quot;"/>
            </statusCode>
            <reasonPhrase>
                <xsl:value-of select="&quot;Bad Request&quot;"/>
            </reasonPhrase>
            <errors>
                <xsl:choose>
                    <xsl:when test="not(contains($actionCode, 'SAVE')or contains($actionCode, 'REMOVE') or contains($actionCode, 'CHANGE')
                        or contains($actionCode, 'REVIEW') or contains($actionCode, 'CHECKOUT') or contains($actionCode, 'EXISTING') or contains($actionCode, 'ADD'))">
                        <error>
                            <code>
                                <xsl:value-of select="&quot;GENERAL-0001&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of select="&quot;Input Data Invalid&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;actionCode is missing&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>
                    
                </xsl:choose>
            </errors>
        </apiError>
    </xsl:template>
</xsl:stylesheet>