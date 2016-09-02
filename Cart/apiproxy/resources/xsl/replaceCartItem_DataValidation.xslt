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
                                <xsl:value-of select="&quot;GENERAL-0001&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of
                                    select="&quot;Input Data Invalid&quot;"/>
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
                                <xsl:value-of
                                    select="&quot;Input Data Invalid&quot;"
                                />
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;Only letters and numbers are allowed for CartID&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>

                    <xsl:when test="string-length($cartItemId) = 0">
                        <error>
                            <code>
                                <xsl:value-of select="&quot;GENERAL-0001&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of
                                    select="&quot;Input Data Invalid&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;The CartItem ID is missing in path param&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>
                    <xsl:when test="matches($cartItemId,'[^a-zA-Z0-9]')">
                        <error>
                            <code>
                                <xsl:value-of select="&quot;GENERAL-0001&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of
                                    select="&quot;Input Data Invalid&quot;"
                                />
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;Only letters and numbers are allowed for CartItemID&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>

                </xsl:choose>
            </errors>
        </apiError>
    </xsl:template>

</xsl:stylesheet>
