<xsl:stylesheet version="2.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <xsl:param name="authfinancialaccountid"/>
    <xsl:param name="tokenScope"/>
    
    <xsl:template match="/">
        <xsl:variable name="actionCode" select="normalize-space(cart/@actionCode)" as="xs:string"/>
        <xsl:variable name="productOfferingId" select="normalize-space(cart/cartItem[1]/productOffering/@productOfferingId)" as="xs:string"/>
        <xsl:variable name="sku" select="normalize-space(cart/cartItem[1]/productOffering/offeringVariant[1]/sku)" as="xs:string"/>
        <xsl:variable name="transactionType" select="normalize-space(cart/cartItem[1]/transactionType)" as="xs:string"/>
        <xsl:variable name="orderType" select="normalize-space(cart/orderType)"/>
        <xsl:variable name="msisdn" select="normalize-space(cart/cartItem[1]/networkResource[1]/mobileNumber/msisdn)" as="xs:string"/>
        <xsl:variable name="financialAccount" select="normalize-space(cart/cartItem[1]/financialAccount/financialAccountNumber)" as="xs:string"/>
        <apiError>
            <statusCode>
                <xsl:value-of select="&quot;400&quot;"/>
            </statusCode>
            <reasonPhrase>
                <xsl:value-of select="&quot;Bad Request&quot;"/>
            </reasonPhrase>
            <errors>
                <xsl:choose>
                    <xsl:when test="$actionCode = ''">
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
                    <xsl:when test="not(contains($actionCode, 'ADD') or contains($actionCode, 'CHECKOUT'))">
                        <error>
                            <code>
                                <xsl:value-of select="&quot;GENERAL-0001&quot;"/>
                            </code>
                            <userMessage>
                                <xsl:value-of select="&quot;Input Data Invalid&quot;"/>
                            </userMessage>
                            <systemMessage>
                                <xsl:value-of select="&quot;Invalid actionCode&quot;"/>
                            </systemMessage>
                        </error>
                    </xsl:when>
                    <xsl:when test="$orderType = ''">
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
                    <xsl:when test="$transactionType != ''">
                            <xsl:if test="not($transactionType = 'REFILL' and $productOfferingId = 'HOD2ARefills' and $sku != '' and $orderType = 'PURCHASEEQUIPMENT' and $actionCode = 'CHECKOUT' and ($msisdn != '' or $financialAccount != ''))">
                                <error>
                                    <code>
                                        <xsl:value-of select="&quot;GENERAL-0002&quot;"/>
                                    </code>
                                    <userMessage>
                                        <xsl:value-of select="&quot;Input Data Invalid for One Time Fund flow&quot;"/>
                                    </userMessage>
                                    <systemMessage>
                                        <xsl:value-of select="&quot;Input Data Invalid for One Time Fund flow&quot;"/>
                                    </systemMessage>
                                </error>
                            </xsl:if>
                    </xsl:when>
                    <xsl:when test="$tokenScope = 'logged-in' and $authfinancialaccountid != ''">
                        <xsl:variable name="fanNumber1">
                            <xsl:for-each select="/cart/cartItem[financialAccount/financialAccountNumber != '']">
                                <xsl:choose>
                                    <xsl:when test="$authfinancialaccountid = financialAccount/financialAccountNumber/text()">
                                        <xsl:value-of select="'true'"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="'false'"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:variable>
                        <xsl:variable name="fanNumber2">
                            <xsl:choose>
                                <xsl:when test="contains($fanNumber1,'true')">
                                    <xsl:value-of select="$fanNumber1"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:for-each select="/cart/cartItem[lineOfService/financialAccountNumber != '']">
                                        <xsl:choose>
                                            <xsl:when test="$authfinancialaccountid = lineOfService/financialAccountNumber/text()">
                                                <xsl:value-of select="'true'"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="'false'"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:for-each>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="fanNumber3">
                            <xsl:choose>
                                <xsl:when test="contains($fanNumber2,'true')">
                                    <xsl:value-of select="$fanNumber2"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:for-each select="/cart/cartSummary[financialAccountId != '']">
                                        <xsl:choose>
                                            <xsl:when test="$authfinancialaccountid = financialAccountId/text()">
                                                <xsl:value-of select="'true'"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="'false'"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:for-each>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:variable name="fanNumber4">
                            <xsl:choose>
                                <xsl:when test="contains($fanNumber3,'true')">
                                    <xsl:value-of select="$fanNumber3"/>
                                </xsl:when>
                                <xsl:otherwise>
                                    <xsl:for-each select="/cart/billTo/customerAccount/financialAccount[financialAccountNumber != '']">
                                        <xsl:choose>
                                            <xsl:when test="$authfinancialaccountid = financialAccountNumber/text()">
                                                <xsl:value-of select="'true'"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="'false'"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:for-each>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <xsl:if test="($fanNumber4 != '' or $fanNumber3 != '' or $fanNumber2 != '' or $fanNumber1 != '') and not(contains($fanNumber4,'true'))">
                            <error>
                                <code>
                                    <xsl:value-of select="&quot;SECURITY-0054&quot;"/>
                                </code>
                                <userMessage>
                                    <xsl:value-of select="&quot;Insufficient permission on the requested Financial Account&quot;"/>
                                </userMessage>
                                <systemMessage>
                                    <xsl:value-of select="&quot;Insufficient permission on the requested Financial Account&quot;"/>
                                </systemMessage>
                            </error>
                        </xsl:if>
                    </xsl:when>
                </xsl:choose>
            </errors>
        </apiError>
    </xsl:template>
</xsl:stylesheet>