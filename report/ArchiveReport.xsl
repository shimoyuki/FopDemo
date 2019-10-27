<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format"
	exclude-result-prefixes="fo">

	<!-- 根元素 -->
	<xsl:template match="/">
		<xsl:apply-templates select="ItemListReport" />
	</xsl:template>

	<!--主模板// -->
	<xsl:template match="ItemListReport">
		<xsl:processing-instruction name="cocoon-format">
			type="text/xslfo"
		</xsl:processing-instruction>
		<!--在此可以定义一些全局的风格信息，如字体等 -->
		<fo:root font-family="SimSun" xmlns:fo="http://www.w3.org/1999/XSL/Format">
			<!--版面定义// -->
			<fo:layout-master-set>
				<fo:simple-page-master master-name="content" page-height="317mm" page-width="230mm" margin="10mm">
					<!--主体// -->
					<fo:region-body/>
					<!--页脚// -->
					<fo:region-after extent="1cm" />
				</fo:simple-page-master>
			</fo:layout-master-set>

			<fo:page-sequence master-reference="content">
				<!--页脚显示内容 -->
				<fo:static-content flow-name="xsl-region-after">
					<fo:block line-height="10px" font-size="10px" text-align="center">
						第
						<fo:page-number />
						/
						<fo:page-number-citation ref-id="endofdoc" />
						页
					</fo:block>
				</fo:static-content>
				<!--页面主体内容 -->
				<fo:flow flow-name="xsl-region-body">
					<fo:block>
						<!--报表头 -->
						<xsl:apply-templates select="RegisterHeader" />
						<!--报表体(若有多个部分内容，参照下面一行重复) -->
						<xsl:apply-templates select="RegisterBody" />
					</fo:block>
					<fo:block break-before="page" />

					<fo:block>
						<xsl:apply-templates select="SecurityHeader" />
						<xsl:apply-templates select="SecurityBody" />
					</fo:block>
					<fo:block break-before="page" />

					<fo:block>
						<xsl:apply-templates select="InformationBody" />
					</fo:block>

					<fo:block>
						<xsl:apply-templates select="ActivityBody" />
					</fo:block>

					<fo:block>
						<xsl:apply-templates select="LeaveBody" />
					</fo:block>

					<!--报表尾 -->
					<xsl:apply-templates select="ReportFooter" />
				</fo:flow>
			</fo:page-sequence>
		</fo:root>
	</xsl:template>

	<!--报表头// -->
	<xsl:template match="RegisterHeader">
		<fo:block height="100px">
			<fo:table table-layout="fixed" width="100%" text-align="center"
				border-after-width="1px" border-after-style="solid">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="3cm" />
				<fo:table-column column-width="8cm" />
				<fo:table-column column-width="7cm" />
				<fo:table-column column-width="3cm" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block height="60px" float="start" margin-top="10px"
								margin-left="0.6cm">
								<fo:external-graphic src="{Icon}" width="60px"
									height="60px" content-width="60px" content-height="60px"
									display-align="center" text-align="center">
									<xsl:value-of select="Icon" />
								</fo:external-graphic>
							</fo:block>
							<fo:block height="30px" margin-top="20px" margin-left="0.6cm"
								font-size="10px" background-color="#267DD2" color="white">
								<xsl:value-of select="Title" />
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block height="60px" float="start" margin-top="10px"
								margin-left="20px">
								<fo:block text-align="start" line-height="30px"
									font-size="14px" font-weight="bold">交城县公安局天宁派出所办案区</fo:block>
								<fo:block text-align="start" line-height="30px"
									font-size="12px">涉案人员入区报告</fo:block>
							</fo:block>
						</fo:table-cell>

						<fo:table-cell>
							<fo:block height="40px" float="start" margin-top="50px"
								margin-left="20px">
								<fo:block line-height="20px" font-size="10px"
									text-align="start">
									<xsl:text>报告时间：</xsl:text>
									<xsl:value-of select="Time" />
								</fo:block>
								<fo:block line-height="20px" font-size="10px"
									text-align="start">
									<xsl:text>档案编号：</xsl:text>
									<xsl:value-of select="Code" />
								</fo:block>
							</fo:block>
						</fo:table-cell>

						<fo:table-cell>
							<fo:block width="80px" height="80px" float="end"
								margin-top="10px" margin-right="0.6cm">
								<fo:block>
									<fo:external-graphic src="{QRCode}" width="80px"
										height="80px" content-width="80px" content-height="80px"
										float="end">
										<xsl:value-of select="QRCode" />
									</fo:external-graphic>
								</fo:block>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

	<!--报表头// -->
	<xsl:template match="SecurityHeader">
		<fo:block border-after-width="1px" border-after-style="solid">
			<fo:block height="30px" margin-top="20px" margin-left="0.6cm"
				margin-right="18cm" font-size="10px" background-color="#267DD2"
				color="white" text-align="center">
				<xsl:value-of select="Title" />
			</fo:block>
		</fo:block>
		<fo:block color="#267DD2" height="30px" line-height="30px"
			margin-left="0.6cm" margin-right="17.4cm" border-after-width="1px"
			border-after-style="solid" border-after-color="#267DD2">自述症状</fo:block>
		<fo:block font-size="12px">
			<fo:table table-layout="fixed" width="100%" text-align="start" margin-top="10px" margin-bottom="10px">
				<fo:table-column column-width="8.4cm" />
				<fo:table-column column-width="1.8cm" />
				<fo:table-column column-width="8.4cm" />
				<fo:table-column column-width="2.4cm" />
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell margin-left="0.6cm">
							<fo:block line-height="20px" color="#267DD2">
								<xsl:text>是否饮酒：</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="Drink" />
								</fo:inline>
							</fo:block>
							<fo:block line-height="20px" color="#267DD2" margin-top="20px">
								<xsl:text>是否患有传染性疾病：</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="Disease" />
								</fo:inline>
							</fo:block>
							<fo:block height="20px" line-height="20px" margin-top="20px">自述症状</fo:block>
							<fo:block height="60px" line-height="20px">
							<xsl:value-of select="Symptom" />
							</fo:block>
						</fo:table-cell>
						
						<fo:table-cell border-left-width="1px" border-left-style="solid" border-left-color="#267DD2">
						<fo:block><fo:inline padding-left="1cm">伤</fo:inline></fo:block>
						<fo:block><fo:inline padding-left="1cm">情</fo:inline></fo:block>
						<fo:block><fo:inline padding-left="1cm">示</fo:inline></fo:block>
						<fo:block><fo:inline padding-left="1cm">意</fo:inline></fo:block>
						<fo:block><fo:inline padding-left="1cm">图</fo:inline></fo:block>
						</fo:table-cell>
						
						<fo:table-cell>
							<fo:block border-after-width="0.2px" background-image="{Image}">
								<fo:table>
									<!-- 定义列（与实际列数严格一致） // -->
									<fo:table-column column-width="1.2cm" />
									<fo:table-column column-width="2.4cm" />
									<fo:table-column column-width="2.4cm" />
									<fo:table-column column-width="2.4cm" />
									<!-- 表格数据 // -->
									<fo:table-body>
										<fo:table-row>
											<fo:table-cell>
												<fo:block line-height="0.45cm" color="white">
												 .
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block line-height="0.45cm">
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block line-height="0.45cm">
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block line-height="0.45cm">
												</fo:block>
											</fo:table-cell>
										</fo:table-row>

										<fo:table-row>
											<fo:table-cell>
												<fo:block line-height="0.45cm" color="white">
												 .
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="A1='true'">
														<fo:block line-height="1.2cm" background-color="#ADD8E6" color="#207fe1" font-size="20px" text-align="center">
															A1
														</fo:block>
													</xsl:when>
													<xsl:otherwise>
														<fo:block></fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:table-cell>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="B1='true'">
														<fo:block line-height="1.2cm" background-color="#ADD8E6" color="#207fe1" font-size="20px" text-align="center">
															B1
														</fo:block>
													</xsl:when>
													<xsl:otherwise>
														<fo:block></fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:table-cell>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="C1='true'">
														<fo:block line-height="1.2cm" background-color="#ADD8E6" color="#207fe1" font-size="20px" text-align="center">
															C1
														</fo:block>
													</xsl:when>
													<xsl:otherwise>
														<fo:block></fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:table-cell>
										</fo:table-row>
										
										<fo:table-row>
											<fo:table-cell>
												<fo:block line-height="1.2cm" color="white">
												.
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="A2='true'">
														<fo:block line-height="1.2cm" background-color="#ADD8E6" color="#207fe1" font-size="20px" text-align="center">
															A2
														</fo:block>
													</xsl:when>
													<xsl:otherwise>
														<fo:block></fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:table-cell>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="B2='true'">
														<fo:block line-height="1.2cm" background-color="#ADD8E6" color="#207fe1" font-size="20px" text-align="center">
															B2
														</fo:block>
													</xsl:when>
													<xsl:otherwise>
														<fo:block></fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:table-cell>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="C2='true'">
														<fo:block line-height="1.2cm" background-color="#ADD8E6" color="#207fe1" font-size="20px" text-align="center">
															C2
														</fo:block>
													</xsl:when>
													<xsl:otherwise>
														<fo:block></fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:table-cell>
										</fo:table-row>
										
										<fo:table-row>
											<fo:table-cell>
												<fo:block line-height="1.2cm" color="white">
												.
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="A3='true'">
														<fo:block line-height="1.2cm" background-color="#ADD8E6" color="#207fe1" font-size="20px" text-align="center">
															A3
														</fo:block>
													</xsl:when>
													<xsl:otherwise>
														<fo:block></fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:table-cell>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="B3='true'">
														<fo:block line-height="1.2cm" background-color="#ADD8E6" color="#207fe1" font-size="20px" text-align="center">
															B3
														</fo:block>
													</xsl:when>
													<xsl:otherwise>
														<fo:block></fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:table-cell>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="C3='true'">
														<fo:block line-height="1.2cm" background-color="#ADD8E6" color="#207fe1" font-size="20px" text-align="center">
															C3
														</fo:block>
													</xsl:when>
													<xsl:otherwise>
														<fo:block></fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:table-cell>
										</fo:table-row>
										
										<fo:table-row>
											<fo:table-cell>
												<fo:block line-height="1.2cm" color="white">
												.
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="A4='true'" >
														<fo:block line-height="1.2cm" background-color="#ADD8E6" color="#207fe1" font-size="20px" text-align="center">
															A4
														</fo:block>
													</xsl:when>
													<xsl:otherwise>
														<fo:block></fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:table-cell>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="B4='true'">
														<fo:block line-height="1.2cm" background-color="#ADD8E6" color="#207fe1" font-size="20px" text-align="center">
															B4
														</fo:block>
													</xsl:when>
													<xsl:otherwise>
														<fo:block></fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:table-cell>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="C4='true'">
														<fo:block line-height="1.2cm" background-color="#ADD8E6" color="#207fe1" font-size="20px" text-align="center">
															C4
														</fo:block>
													</xsl:when>
													<xsl:otherwise>
														<fo:block></fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:table-cell>
										</fo:table-row>
										
										<fo:table-row>
											<fo:table-cell>
												<fo:block line-height="1.2cm" color="white">
												.
												</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="A5='true'">
														<fo:block line-height="1.2cm" background-color="#ADD8E6" color="#207fe1" font-size="20px" text-align="center">
															A5
														</fo:block>
													</xsl:when>
													<xsl:otherwise>
														<fo:block></fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:table-cell>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="B5='true'">
														<fo:block line-height="1.2cm" background-color="#ADD8E6" color="#207fe1" font-size="20px" text-align="center">
															B5
														</fo:block>
													</xsl:when>
													<xsl:otherwise>
														<fo:block></fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:table-cell>
											<fo:table-cell>
												<xsl:choose>
													<xsl:when test="C5='true'">
														<fo:block line-height="1.2cm" background-color="#ADD8E6" color="#207fe1" font-size="20px" text-align="center">
															C5
														</fo:block>
													</xsl:when>
													<xsl:otherwise>
														<fo:block></fo:block>
													</xsl:otherwise>
												</xsl:choose>
											</fo:table-cell>
										</fo:table-row>
									</fo:table-body>
								</fo:table>
								<!-- <fo:external-graphic src="{Image}" width="7.8cm"
									content-width="7.8cm">
									<xsl:value-of select="Image" />
								</fo:external-graphic> -->
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
						<fo:block>
						</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

	<!--报表第一页// -->
	<xsl:template match="RegisterBody">
		<xsl:apply-templates select="IdentityTable" />
		<xsl:apply-templates select="RegisterTable" />
	</xsl:template>

	<!--报表第二页// -->
	<xsl:template match="SecurityBody">
		<xsl:apply-templates select="SecurityTable" />
		<xsl:apply-templates select="FinanceTable" />
	</xsl:template>

	<!--报表第三页// -->
	<xsl:template match="InformationBody">
		<xsl:apply-templates select="InformationTable" />
	</xsl:template>

	<!--报表第四页// -->
	<xsl:template match="ActivityBody">
		<xsl:apply-templates select="ActivityTable" />
	</xsl:template>

	<!--报表第五页// -->
	<xsl:template match="LeaveBody">
		<xsl:apply-templates select="TemporaryTable" />
		<xsl:apply-templates select="FinalTable" />
	</xsl:template>

	<!--报表尾// -->
	<xsl:template match="ReportFooter">
		<fo:block id="endofdoc"></fo:block>
	</xsl:template>

	<!--身份证照表格数据// -->
	<xsl:template match="IdentityTable">
		<fo:block font-size="12px">
			<fo:table table-layout="fixed" width="100%" text-align="center"
				margin-top="10px" margin-bottom="10px" border-after-width="1px"
				border-after-style="solid" border-after-color="#EEEEEE">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="5.1cm" />
				<fo:table-column column-width="5.1cm" />
				<fo:table-column column-width="5.1cm" />
				<fo:table-column column-width="5.7cm" />
				<!-- 定义表头 // -->
				<fo:table-header>
					<fo:table-row font-weight="bold" font-size="13px">
						<fo:table-cell>
							<fo:block color="#267DD2" height="30px" line-height="30px"
								background-color="#f8f8f8" margin-left="0.6cm"
								border-after-width="1px" border-after-style="solid"
								border-after-color="#267DD2">身份证照</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block color="#267DD2" height="30px" line-height="30px"
								background-color="#f8f8f8" margin-left="0.6cm"
								border-after-width="1px" border-after-style="solid"
								border-after-color="#267DD2">左侧照</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block color="#267DD2" height="30px" line-height="30px"
								background-color="#f8f8f8" margin-left="0.6cm"
								border-after-width="1px" border-after-style="solid"
								border-after-color="#267DD2">正面照</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block color="#267DD2" height="30px" line-height="30px"
								background-color="#f8f8f8" margin-left="0.6cm" margin-right="0.6cm"
								border-after-width="1px" border-after-style="solid"
								border-after-color="#267DD2">右侧照</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<!-- 表格数据 // -->
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block color="#267DD2" height="30px" line-height="30px"
								background-color="#f8f8f8" margin-left="0.6cm">
								<fo:external-graphic src="{Photo}" width="102px"
									height="126px" content-width="102px" content-height="126px"
									margin-left="35px" margin-top="50px">
									<xsl:value-of select="Photo" />
								</fo:external-graphic>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block color="#267DD2" height="30px" line-height="30px"
								background-color="#f8f8f8" margin-left="0.6cm">
								<fo:external-graphic src="{PhotoLeft}"
									width="102px" height="126px" content-width="102px"
									content-height="126px" margin-left="35px" margin-top="50px">
									<xsl:value-of select="PhotoLeft" />
								</fo:external-graphic>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block color="#267DD2" height="30px" line-height="30px"
								background-color="#f8f8f8" margin-left="0.6cm">
								<fo:external-graphic src="{PhotoFront}"
									width="102px" height="126px" content-width="102px"
									content-height="126px" margin-left="35px" margin-top="50px">
									<xsl:value-of select="PhotoFront" />
								</fo:external-graphic>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block color="#267DD2" height="30px" line-height="30px"
								background-color="#f8f8f8" margin-left="0.6cm" margin-right="0.6cm">
								<fo:external-graphic src="{PhotoRight}"
									width="102px" height="126px" content-width="102px"
									content-height="126px" margin-left="35px" margin-top="50px">
									<xsl:value-of select="PhotoRight " />
								</fo:external-graphic>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

	<!--入区信息表格数据// -->
	<xsl:template match="RegisterTable">
		<fo:block font-size="12px">
			<fo:table table-layout="fixed" width="100%" text-align="start"
				margin-top="5px">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="10.5cm" />
				<fo:table-column column-width="10.5cm" />
				<!-- 定义表头 // -->
				<fo:table-header>
					<fo:table-row font-weight="bold" font-size="13px">
						<fo:table-cell>
							<fo:block height="30px" line-height="30px" margin-left="0.6cm"
								margin-right="7.9cm" border-after-width="2px"
								border-after-style="solid" border-after-color="#267DD2">人员信息</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block></fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<!-- 表格数据 // -->
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>姓名：</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="Name" />
								</fo:inline>
							</fo:block>
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>民族：</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="Nation" />
								</fo:inline>
							</fo:block>
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>出生日期：</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="Birth" />
								</fo:inline>
							</fo:block>
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>户籍地址：</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="House" />
								</fo:inline>
							</fo:block>
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>现住地址：</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="Addr" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>

						<fo:table-cell margin-right="0.6cm">
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>性别：</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="Gender" />
								</fo:inline>
							</fo:block>
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>语言类型：</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="Lang" />
								</fo:inline>
							</fo:block>
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>联系方式：</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="Contact " />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>

		<fo:block font-size="12px">
			<fo:table table-layout="fixed" width="100%" text-align="start"
				margin-top="5px">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="10.5cm" />
				<fo:table-column column-width="10.5cm" />
				<!-- 定义表头 // -->
				<fo:table-header>
					<fo:table-row font-weight="bold" font-size="13px">
						<fo:table-cell>
							<fo:block height="30px" line-height="30px" margin-left="0.6cm"
								margin-right="7.9cm" border-after-width="2px"
								border-after-style="solid" border-after-color="#267DD2">入区信息</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block></fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<!-- 表格数据 // -->
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>入区手环：</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="Brace " />
								</fo:inline>
							</fo:block>
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>入区身份：</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="Identity" />
								</fo:inline>
							</fo:block>
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>入区案由：</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="Remark" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>

						<fo:table-cell margin-right="0.6cm">
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>入区时间：</xsl:text>
								<fo:inline color="black" font-size="9px">
									<xsl:value-of select="Time " />
								</fo:inline>
							</fo:block>
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>入区原因：</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="Reason" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
		
		<fo:block font-size="12px">
			<fo:table table-layout="fixed" width="100%" text-align="start"
				margin-top="5px" border-after-width="1px"
								border-after-style="dotted" border-after-color="#267DD2">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="10.5cm" />
				<fo:table-column column-width="10.5cm" />
				<!-- 定义表头 // -->
				<fo:table-header>
					<fo:table-row font-weight="bold" font-size="13px">
						<fo:table-cell>
							<fo:block height="30px" line-height="30px" margin-left="0.6cm"
								margin-right="7.9cm" border-after-width="2px"
								border-after-style="solid" border-after-color="#267DD2">入区签字 </fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block></fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<!-- 表格数据 // -->
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>业务干警:</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="BusinessIn1" />
								</fo:inline>
							</fo:block>
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>值班干警:</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="OnDutyIn" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>

						<fo:table-cell margin-right="0.6cm">
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>业务干警:</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="BusinessIn2" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
		
		<fo:block font-size="12px">
			<fo:table table-layout="fixed" width="100%" text-align="start"
				margin-top="5px">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="10.5cm" />
				<fo:table-column column-width="10.5cm" />
				<!-- 定义表头 // -->
				<fo:table-header>
					<fo:table-row font-weight="bold" font-size="13px">
						<fo:table-cell>
							<fo:block height="30px" line-height="30px" margin-left="0.6cm"
								margin-right="7.9cm" border-after-width="2px"
								border-after-style="solid" border-after-color="#267DD2">出区信息</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block></fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<!-- 表格数据 // -->
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>离开时间：</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="LeaveTime " />
								</fo:inline>
							</fo:block>
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>离区原因：</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="LeaveReason" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>

						<fo:table-cell margin-right="0.6cm">
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>羁押时长：</xsl:text>
								<fo:inline color="black" font-size="9px">
									<xsl:value-of select="StayTime" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
		
		<fo:block font-size="12px">
			<fo:table table-layout="fixed" width="100%" text-align="start"
				margin-top="5px" border-after-width="1px"
								border-after-style="dotted" border-after-color="#267DD2">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="10.5cm" />
				<fo:table-column column-width="10.5cm" />
				<!-- 定义表头 // -->
				<fo:table-header>
					<fo:table-row font-weight="bold" font-size="13px">
						<fo:table-cell>
							<fo:block height="30px" line-height="30px" margin-left="0.6cm"
								margin-right="7.9cm" border-after-width="2px"
								border-after-style="solid" border-after-color="#267DD2">出区签字 </fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block></fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<!-- 表格数据 // -->
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>业务干警:</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="BusinessOut1" />
								</fo:inline>
							</fo:block>
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>值班干警:</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="OnDutyOut" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>

						<fo:table-cell margin-right="0.6cm">
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>业务干警:</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="BusinessOut2" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
		
	</xsl:template>

	<!--伤情检查表格数据// -->
	<xsl:template match="SecurityTable">
		<fo:block color="#267DD2" height="30px" line-height="30px"
			margin-left="0.6cm" margin-right="17.4cm" border-after-width="1px"
			border-after-style="solid" border-after-color="#267DD2">伤情检查</fo:block>
		<fo:block font-size="9px">
				<fo:table table-layout="fixed" width="100%" text-align="center"
				margin-top="10px" margin-bottom="10px" margin-left="0.6cm"
				margin-right="0.6cm">
									<fo:table-column column-width="4.8cm" />
									<fo:table-column column-width="5cm" />
									<fo:table-column column-width="5cm" />
									<fo:table-column column-width="5cm" />

									<!-- 定义表头 // -->
									<fo:table-header>
										<fo:table-row font-weight="bold" height="20px" color="white" background-color="#267DD2"
										line-height="20px" border-width="1px" border-style="solid" border-color="#EEEEEE" >
											<fo:table-cell>
												<fo:block>序号</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>伤情说明</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>伤情描述</fo:block>
											</fo:table-cell>
											<fo:table-cell>
												<fo:block>伤情照片</fo:block>
											</fo:table-cell>
										</fo:table-row>
									</fo:table-header>

									<fo:table-body>
										<xsl:apply-templates select="SecurityRow" />
									</fo:table-body>
								</fo:table>
		</fo:block>
	</xsl:template>

	<!--伤情检查表格每一行的模板// -->
	<xsl:template match="SecurityRow">
		<fo:table-row border-width="1px" border-style="solid"
			border-color="#EEEEEE" line-height="20px">
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Number" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Explain" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Description" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Photo" />
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>

	<!--财务情况表格数据// -->
	<xsl:template match="FinanceTable">
		<fo:block color="#267DD2" height="30px" line-height="30px"
			margin-left="0.6cm" margin-right="17.4cm" border-after-width="1px"
			border-after-style="solid" border-after-color="#267DD2">随身财物</fo:block>
		<fo:block font-size="9px">
			<fo:table table-layout="fixed" width="100%" text-align="center"
				margin-top="10px" margin-bottom="10px" margin-left="0.6cm"
				margin-right="0.6cm">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="2.4cm" />
				<fo:table-column column-width="2.9cm" />
				<fo:table-column column-width="2.9cm" />
				<fo:table-column column-width="2.9cm" />
				<fo:table-column column-width="2.9cm" />
				<fo:table-column column-width="2.9cm" />
				<fo:table-column column-width="2.9cm" />
				<!-- 定义表头 // -->
				<fo:table-header>
					<fo:table-row font-weight="bold" height="20px"
						line-height="20px" border-width="1px" border-style="solid"
						border-color="#EEEEEE" background-color="#267DD2" color="white">
						<fo:table-cell>
							<fo:block>序号</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>物品名称</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>物品特征</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>数量单位</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>物品分类</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>保管措施</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>保管位置</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<!-- 表格数据 // -->
				<fo:table-body>
					<xsl:apply-templates select="FinanceRow" />
				</fo:table-body>
			</fo:table>
		</fo:block>
		<fo:block font-size="12px">
			<fo:table table-layout="fixed" width="100%" text-align="start"
				margin-top="5px" border-before-width="1px"
								border-before-style="solid" border-before-color="#EEEEEE">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="10.5cm" />
				<fo:table-column column-width="10.5cm" />
				<!-- 表格数据 // -->
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell>
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>业务干警:</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="Business1" />
								</fo:inline>
							</fo:block>
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>值班干警:</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="OnDuty" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>

						<fo:table-cell margin-right="0.6cm">
							<fo:block margin-left="0.6cm"
								line-height="20px" color="black">
								<xsl:text>业务干警:</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="Business2" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

	<!--财务情况表格每一行的模板// -->
	<xsl:template match="FinanceRow">
		<fo:table-row border-width="1px" border-style="solid"
			border-color="#EEEEEE" line-height="20px">
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Number" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Name" />
				</fo:block>
			</fo:table-cell>
			
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Feature" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Amount" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Classify" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Method" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Position" />
				</fo:block>
			</fo:table-cell>

		</fo:table-row>
	</xsl:template>

	<!--信息采集表格数据// -->
	<xsl:template match="InformationTable">
		<fo:block border-after-width="1px" border-after-style="solid">
			<fo:block height="30px" margin-top="20px" margin-left="0.6cm"
				margin-right="18cm" font-size="10px" background-color="#267DD2"
				color="white" text-align="center">
				<xsl:value-of select="Title" />
			</fo:block>
		</fo:block>
		<fo:block color="#267DD2" height="30px" line-height="30px"
			margin-left="0.6cm" margin-right="17.4cm" border-after-width="1px"
			border-after-style="solid" border-after-color="#267DD2">信息采集表</fo:block>
		<fo:block font-size="12px">
			<fo:table table-layout="fixed" width="100%" text-align="center"
				font-size="9px" margin-top="10px" margin-bottom="10px" margin-left="0.6cm"
				margin-right="0.6cm">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="6.6cm" />
				<fo:table-column column-width="6.6cm" />
				<fo:table-column column-width="6.6cm" />
				<!-- <fo:table-column column-width="5cm" /> -->

				<!-- 定义表头 // -->
				<fo:table-header>
					<fo:table-row font-weight="bold" height="20px"
						line-height="20px" border-width="1px" border-style="solid"
						border-color="#EEEEEE" background-color="#267DD2" color="white">
						<fo:table-cell>
							<fo:block>序号</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>采集项目</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>采集内容</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<!-- 表格数据 // -->
				<fo:table-body>
					<xsl:apply-templates select="InformationRow" />
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

	<!--信息采集表格每一行的模板// -->
	<xsl:template match="InformationRow">
		<fo:table-row border-width="1px" border-style="solid"
			border-color="#EEEEEE" line-height="20px">
			<fo:table-cell>
				<fo:block>1</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>免冠照</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Content1" />
				</fo:block>
			</fo:table-cell>

		</fo:table-row>
		<fo:table-row border-width="1px" border-style="solid"
			border-color="#EEEEEE" line-height="20px">
			<fo:table-cell>
				<fo:block>2</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>身高</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Content2" />
				</fo:block>
			</fo:table-cell>

		</fo:table-row>
		<fo:table-row border-width="1px" border-style="solid"
			border-color="#EEEEEE" line-height="20px">
			<fo:table-cell>
				<fo:block>3</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>体重</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Content3" />
				</fo:block>
			</fo:table-cell>

		</fo:table-row>
		<fo:table-row border-width="1px" border-style="solid"
			border-color="#EEEEEE" line-height="20px">
			<fo:table-cell>
				<fo:block>4</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>指纹</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Content4" />
				</fo:block>
			</fo:table-cell>

		</fo:table-row>
		<fo:table-row border-width="1px" border-style="solid"
			border-color="#EEEEEE" line-height="20px">
			<fo:table-cell>
				<fo:block>5</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>血样</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Content5" />
				</fo:block>
			</fo:table-cell>

		</fo:table-row>
		<fo:table-row border-width="1px" border-style="solid"
			border-color="#EEEEEE" line-height="20px">
			<fo:table-cell>
				<fo:block>6</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>身体特征</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Content6" />
				</fo:block>
			</fo:table-cell>

		</fo:table-row>
		<fo:table-row border-width="1px" border-style="solid"
			border-color="#EEEEEE" line-height="20px">
			<fo:table-cell>
				<fo:block>7</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>口音</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Content7" />
				</fo:block>
			</fo:table-cell>

		</fo:table-row>
		<fo:table-row border-width="1px" border-style="solid"
			border-color="#EEEEEE" line-height="20px">
			<fo:table-cell>
				<fo:block>8</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>DNA</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Content8" />
				</fo:block>
			</fo:table-cell>

		</fo:table-row>
		<fo:table-row border-width="1px" border-style="solid"
			border-color="#EEEEEE" line-height="20px">
			<fo:table-cell>
				<fo:block>9</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>手机SIS</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Content9" />
				</fo:block>
			</fo:table-cell>

		</fo:table-row>
		<fo:table-row border-width="1px" border-style="solid"
			border-color="#EEEEEE" line-height="20px">
			<fo:table-cell>
				<fo:block>10</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>其他采集项</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Content10" />
				</fo:block>
			</fo:table-cell>

		</fo:table-row>
	</xsl:template>

	<!--入区活动记录表格数据// -->
	<xsl:template match="ActivityTable">
		<fo:block border-after-width="1px" border-after-style="solid">
			<fo:block height="30px" margin-top="20px" margin-left="0.6cm"
				margin-right="18cm" font-size="10px" background-color="#267DD2"
				color="white" text-align="center">
				<xsl:value-of select="Title" />
			</fo:block>
		</fo:block>
		<fo:block color="#267DD2" height="30px" line-height="30px"
			margin-left="0.6cm" margin-right="14.4cm" border-after-width="1px"
			border-after-style="solid" border-after-color="#267DD2">
			嫌疑人(<fo:inline color="black">
				<xsl:value-of select="Name" />
			</fo:inline>)活动记录表
		</fo:block>
		<fo:block margin-left="0.6cm" color="#267DD2" margin-top="10px">
			<xsl:text>羁押时间：</xsl:text>
			<fo:inline color="black">
				<xsl:value-of select="Time" />
			</fo:inline>
		</fo:block>
		<fo:block font-size="9px">
			<fo:table table-layout="fixed" width="100%" text-align="center"
				margin-top="10px" margin-bottom="10px" margin-left="0.6cm"
				margin-right="0.6cm">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="2cm" />
				<fo:table-column column-width="3cm" />
				<fo:table-column column-width="3cm" />
				<fo:table-column column-width="5.9cm" />
				<fo:table-column column-width="5.9cm" />
				

				<!-- 定义表头 // -->
				<fo:table-header>
					<fo:table-row font-weight="bold" height="20px"
						line-height="20px" border-width="1px" border-style="solid"
						border-color="#EEEEEE" background-color="#267DD2" color="white">
						<fo:table-cell>
							<fo:block>序号</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>活动项目</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>房间</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>开始时间</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>结束时间</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<!-- 表格数据 // -->
				<fo:table-body>
					<xsl:apply-templates select="ActivityRow" />
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

	<!--入区活动记录表格每一行的模板// -->
	<xsl:template match="ActivityRow">
		<fo:table-row border-width="1px" border-style="solid"
			border-color="#EEEEEE" line-height="20px">
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Number" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Project" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Room" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="StartTime" />
				</fo:block>
			</fo:table-cell>
			
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="EndTime" />
				</fo:block>
			</fo:table-cell>

		</fo:table-row>
	</xsl:template>
	
	<!--临时离区记录表格数据// -->
	<xsl:template match="TemporaryTable">
		<fo:block border-after-width="1px" border-after-style="solid">
			<fo:block height="30px" margin-top="20px" margin-left="0.6cm"
				margin-right="18cm" font-size="10px" background-color="#267DD2"
				color="white" text-align="center">
				<xsl:value-of select="Title" />
			</fo:block>
		</fo:block>
		<fo:block color="#267DD2" height="30px" line-height="30px"
			margin-left="0.6cm" margin-right="17.4cm" border-after-width="1px"
			border-after-style="solid" border-after-color="#267DD2">临时离区记录</fo:block>
		<fo:block font-size="9px">
			<fo:table table-layout="fixed" width="100%" text-align="center"
				margin-top="10px" margin-bottom="10px" margin-left="0.6cm"
				margin-right="0.6cm">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="2cm" />
				<fo:table-column column-width="5.9cm" />
				<fo:table-column column-width="5.9cm" />
				<fo:table-column column-width="3cm" />
				<fo:table-column column-width="3cm" />

				<!-- 定义表头 // -->
				<fo:table-header>
					<fo:table-row font-weight="bold" height="20px"
						line-height="20px" border-width="1px" border-style="solid"
						border-color="#EEEEEE" background-color="#267DD2" color="white">
						<fo:table-cell>
							<fo:block>序号</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>离开时间</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>返回时间</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>离开事由</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>经办民警</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<!-- 表格数据 // -->
				<fo:table-body>
					<xsl:apply-templates select="TemporaryRow" />
				</fo:table-body>
			</fo:table>
		</fo:block>
		<fo:block margin-left="0.6cm"  margin-right="0.6cm" color="#267DD2" text-align="center" margin-top="20px" height="25px" line-height="20px">
			<xsl:text>临时出区办案部门负责人签字：</xsl:text>
			<fo:inline color="black">
				<xsl:value-of select="ChargeSign" />
			</fo:inline>
		</fo:block>
	</xsl:template>

	<!--临时离区记录表格每一行的模板// -->
	<xsl:template match="TemporaryRow">
		<fo:table-row border-width="1px" border-style="solid"
			border-color="#EEEEEE" line-height="20px">
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Number" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="LeaveTime" />
				</fo:block>
			</fo:table-cell>
			
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="ReturnTime" />
				</fo:block>
			</fo:table-cell>
			
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Reason" />
				</fo:block>
			</fo:table-cell>
			
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Police" />
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>
	
	<!--离区物品领取表格数据// -->
	<xsl:template match="FinalTable">
		<fo:block color="#267DD2" height="30px" line-height="30px"
			margin-left="0.6cm" margin-right="17.4cm" border-after-width="1px"
			border-after-style="solid" border-after-color="#267DD2">离区物品领取</fo:block>
		<fo:block font-size="12px">
			<fo:table table-layout="fixed" width="100%" text-align="center"
				margin-top="10px" margin-bottom="10px" margin-left="0.6cm"
				margin-right="0.6cm" font-size="9px">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="2cm" />
				<fo:table-column column-width="3cm" />
				<fo:table-column column-width="3cm" />
				<fo:table-column column-width="3cm" />
				<fo:table-column column-width="3cm" />
				<fo:table-column column-width="5.8cm" />

				<!-- 定义表头 // -->
				<fo:table-header>
					<fo:table-row font-weight="bold" height="20px"
						line-height="20px" border-width="1px" border-style="solid"
						border-color="#EEEEEE" background-color="#267DD2" color="white">
						<fo:table-cell>
							<fo:block>序号</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>物品名称</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>数量单位</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>物品分类</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>返还情况</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block>返还时间</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-header>
				<!-- 表格数据 // -->
				<fo:table-body>
					<xsl:apply-templates select="FinalRow" />
				</fo:table-body>
			</fo:table>
			<fo:table table-layout="fixed" width="100%" text-align="start"
				margin-top="20px" height="25px" line-height="20px">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="7cm" />
				<fo:table-column column-width="7cm" />
				<fo:table-column column-width="7cm" />
				<!-- 表格数据 // -->
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell >
							<fo:block margin-left="0.6cm" padding-left="0.5cm" background-color="#EEEEEE" color="#267DD2">
								<xsl:text>领取人签字：</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="Sign" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block padding-left="0.5cm" background-color="#EEEEEE" color="#267DD2">
								<xsl:text>领取人身份证号：</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="Identity" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
						<fo:table-cell>
							<fo:block padding-left="0.5cm" margin-right="0.6cm" background-color="#EEEEEE" color="#267DD2">
								<xsl:text>领取时间：</xsl:text>
								<fo:inline color="black">
									<xsl:value-of select="ReceiptorTime" />
								</fo:inline>
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

	<!--离区物品领取表格每一行的模板// -->
	<xsl:template match="FinalRow">
		<fo:table-row border-width="1px" border-style="solid"
			border-color="#EEEEEE" line-height="20px">
			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Number" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Name" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Amount" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Classify" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="Situation" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell>
				<fo:block>
					<xsl:value-of select="RuturnTime" />
				</fo:block>
			</fo:table-cell>
		</fo:table-row>
	</xsl:template>

	<!--签字表格数据// -->
	<xsl:template match="SignTable">
		<fo:block font-size="12px">
			<fo:table table-layout="fixed" width="100%" text-align="start"
				margin-top="10px" margin-bottom="10px" border-after-width="1px"
				border-after-style="solid" border-after-color="#EEEEEE">
				<!-- 定义列（与实际列数严格一致） // -->
				<fo:table-column column-width="2.6cm" />
				<fo:table-column column-width="7.9cm" />
				<fo:table-column column-width="10.5cm" />
				<!-- 表格数据 // -->
				<fo:table-body>
					<fo:table-row>
						<fo:table-cell margin-left="0.6cm">
							<fo:block line-height="60px" color="#267DD2">
								<xsl:text>业务干警</xsl:text>
							</fo:block>
						</fo:table-cell>

						<fo:table-cell margin-left="0.9cm">
							<fo:block margin-top="10px" line-height="20px">
								<xsl:text>警员姓名：</xsl:text>
								<xsl:value-of select="Name1" />
							</fo:block>
							<fo:block margin-top="10px" line-height="20px">
								<xsl:text>警员姓名：</xsl:text>
								<xsl:value-of select="Name2" />
							</fo:block>
						</fo:table-cell>

						<fo:table-cell margin-left="3.5cm">
							<fo:block margin-top="10px" line-height="20px">
								<xsl:text>警员编号：</xsl:text>
								<xsl:value-of select="No1" />
							</fo:block>
							<fo:block margin-top="10px" line-height="20px">
								<xsl:text>警员编号：</xsl:text>
								<xsl:value-of select="No2" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>

					<fo:table-row>
						<fo:table-cell margin-left="0.6cm">
							<fo:block line-height="20px" color="black">
								<xsl:text>值班干警</xsl:text>
							</fo:block>
						</fo:table-cell>

						<fo:table-cell margin-left="0.9cm">
							<fo:block margin-top="10px" line-height="20px">
								<xsl:text>警员姓名：</xsl:text>
								<xsl:value-of select="Name3" />
							</fo:block>
						</fo:table-cell>

						<fo:table-cell margin-left="3.5cm">
							<fo:block margin-top="10px" line-height="20px">
								<xsl:text>警员编号：</xsl:text>
								<xsl:value-of select="No3" />
							</fo:block>
						</fo:table-cell>
					</fo:table-row>
				</fo:table-body>
			</fo:table>
		</fo:block>
	</xsl:template>

</xsl:stylesheet>