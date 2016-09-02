<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:param name="cartId"/>
    <xsl:param name="cartItemId"/>
    
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
                                <xsl:value-of select="&quot;400&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of select="&quot;The Cart ID is missing in path param.&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;Bad Request&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>
                    <!--xsl:when test="number($cartId)!=$cartId">
                        <error>
                            <code>
                                <xsl:value-of select="&quot;400&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of select="&quot;The Cart ID must be Numeric Value.&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;Bad Request&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when-->
                    <xsl:when test="matches($cartId,'[^a-zA-Z0-9]')">
                        <error>
                            <code>
                                <xsl:value-of select="&quot;400&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of select="&quot;Only letters and numbers are allowed for CartID.&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;Bad Request&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>
                    <xsl:when test="(string-length($cartId) &lt; 2 or string-length($cartId) &gt; 30)">
                        <error>
                            <code>
                                <xsl:value-of select="&quot;400&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of select="&quot;The Cart ID length must be in between 2 to 30 digits&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;Bad Request&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>
                    
                    <xsl:when test="string-length($cartItemId) = 0">
                        <error>
                            <code>
                                <xsl:value-of select="&quot;400&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of select="&quot;The CartItem ID is missing in path param.&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;Bad Request&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>
                    <!--xsl:when test="number($cartItemId)!=$cartItemId">
                        <error>
                            <code>
                                <xsl:value-of select="&quot;400&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of select="&quot;The CartItem ID must be Numeric Value.&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;Bad Request&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when-->
                    <xsl:when test="matches($cartItemId,'[^a-zA-Z0-9]')">
                        <error>
                            <code>
                                <xsl:value-of select="&quot;400&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of select="&quot;Only letters and numbers are allowed for CartItemID.&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;Bad Request&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>
                    <xsl:when test="(string-length($cartItemId) &lt; 2 or string-length($cartItemId) &gt; 30)">
                        <error>
                            <code>
                                <xsl:value-of select="&quot;400&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of select="&quot;The CartItem ID length must be in between 2 to 30 digits&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;Bad Request&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>
                </xsl:choose>
            </errors>
        </apiError>
    </xsl:template>
</xsl:stylesheet>