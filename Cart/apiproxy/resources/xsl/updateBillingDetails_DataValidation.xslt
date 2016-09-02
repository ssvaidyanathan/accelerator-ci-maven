<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:param name="cartId"/>
    <xsl:param name="authfinancialaccountid"/>
    <xsl:param name="tokenScope"/>

    <xsl:template match="/">
        <xsl:variable name="actionCd" select="/cart/@actionCode"/>
        <xsl:variable name="orderType" select="/cart/orderType"/>

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
                                <xsl:value-of
                                    select="&quot;The Cart ID is missing in path paramt&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>

                    <xsl:when test="matches($cartId, '[^a-zA-Z0-9]')">
                        <error>
                            <code>
                                <xsl:value-of select="&quot;GENERAL-0001&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of select="&quot;Input Data Invalid&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of
                                    select="&quot;Only letters and numbers are allowed for CartID&quot;"
                                />
                            </systemMessage>
                        </error>
                    </xsl:when>
                    <xsl:when test="string-length($actionCd) = 0">
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

                    <xsl:when
                        test="
                            not(contains($actionCd, 'ADD') or contains($actionCd, 'SAVE') or contains($actionCd, 'REMOVE') or contains($actionCd, 'CHANGE')
                            or contains($actionCd, 'REVIEW') or contains($actionCd, 'CHECKOUT') or contains($actionCd, 'EXISTING'))">
                        <error>
                            <code>
                                <xsl:value-of select="&quot;GENERAL-0001&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of select="&quot;Input Data Invalid&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of
                                    select="&quot;Invalid action code.Possible values: ADD, REMOVE, CHANGE, SAVE, REVIEW, CHECKOUT, EXISTING&quot;"
                                />
                            </systemMessage>
                        </error>
                    </xsl:when>

                    <xsl:when
                        test="not(contains($orderType, 'ACTIVATION') or contains($orderType, 'ADDALINE') or contains($orderType, 'CHANGESIM'))">
                        <error>
                            <code>
                                <xsl:value-of select="&quot;GENERAL-0001&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of select="&quot;Input Data Invalid&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;orderType is missing&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>
                    
                    <xsl:when test="$tokenScope = 'logged-in' and $authfinancialaccountid != ''">
                        <xsl:variable name="fanNumber1">
                                    <xsl:for-each
                                        select="/cart/billTo/customerAccount/financialAccount[financialAccountNumber != '']">
                                        <xsl:choose>
                                            <xsl:when
                                                test="$authfinancialaccountid = financialAccountNumber/text()">
                                                <xsl:value-of select="'true'"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="'false'"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:for-each>
                        </xsl:variable>
                        
                        <xsl:if
                            test="($fanNumber1 != '') and not(contains($fanNumber1,'true'))">
                            <error>
                                <code>
                                    <xsl:value-of select="&quot;SECURITY-0054&quot;"/>
                                </code>
                                <userMessage>
                                    <xsl:value-of
                                        select="&quot;Insufficient permission on the requested Financial Account&quot;"
                                    />
                                </userMessage>
                                <systemMessage>
                                    <xsl:value-of
                                        select="&quot;Insufficient permission on the requested Financial Account&quot;"
                                    />
                                </systemMessage>
                            </error>
                        </xsl:if>
                    </xsl:when>
                </xsl:choose>
            </errors>
        </apiError>
    </xsl:template>
</xsl:stylesheet>
