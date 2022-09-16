<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Visualizzazione.aspx.cs" Inherits="Call_Evalutator.Visualizzazione" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="CSS/style.css" />
    <title>Call Evaluator&copy</title>
    <link rel="icon" type="image/png" href="images/favicon.png" id="favicon" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.5/themes/base/jquery-ui.css" type="text/css" media="all" />
    <link rel="stylesheet" href="http://static.jquery.com/ui/css/demo-docs-theme/ui.theme.css" type="text/css" media="all" />

    <script src="JS/scripts.js"></script>
</head>
<body>
    <form runat="server" defaultbutton="confirm_button">
        <section id="navigators">
            <!-- left navigator -->
            <div id="navigator">
                <asp:Chart runat="server" RenderType="ImageMap"></asp:Chart>
                <div id="navigator2"></div>
                <div id="navigator3"></div>
                <img src="images/favicon.png" alt="Logo" width="40px" id="logo" />
                <img src="images/kruk.png" alt="KRUK Logo" id="KRUK" width="60px" />
                <h1 id="title">Call Evaluator</h1>
                <div id="evaluation_parameters"></div>
            </div>
            <div id="parameters">
                <h3 class="subtitles">Card Information</h3>
                <span>
                    <img src="images/agent.png" alt="Agent" id="icon_agent" /></span>
                <img src="images/case.png" alt="case" id="icon_case" />
                <img src="images/date.png" alt="date" id="icon_date" />
                <img src="images/date.png" alt="date" id="icon_date2" />
                <img src="images/personincall.png" alt="personincall" id="icon_personincall" />
                <img src="images/teamleader.png" alt="team_leader" id="icon_owner" />
                <br />
                <ul id="list_parameters">
                    <li>
                        <label for="agent_name" class="label">Agent Name</label>
                        <asp:DropDownList name="agent_name" ID="agent_name" placeholder="Select the agent name" runat="server" class="dropdown filter" AutoPostBack="true" />
                    </li>
                    <br />
                    <li>
                        <label for="case_number" class="label">Case Number</label>
                        <input type="text" style="text-transform: uppercase" id="case_number" name="case_number" size="10" runat="server" class="input filter" />
                    </li>
                    <br />
                    <li>
                        <label for="date_evaluation" id="lblDate" class="label" runat="server">Date of evaluation</label>
                        <%--<input type="text" id="date_evaluation" name="date_evaluation" size="10" runat="server" readonly="true" />--%>
                        <input type="date" value="" id="date_evaluation" name="date_evaluation" size="10" runat="server" class="input filter" />
                    </li>
                    <br />
                    <li>
                        <label for="owner" class="label">Evaluation Owner</label>
                        <asp:DropDownList name="owner" ID="owner" placeholder="Select the owner" runat="server" class="dropdown filter" AutoPostBack="true" />
                    </li>
                    <br />
                    <li>
                        <label for="call_date" class="label">Date of call</label>
                        <input type="date" value="" id="call_date" name="call_date" size="10" runat="server" class="input filter" />
                    </li>
                    <br />
                    <li>
                        <label for="call_person" class="label">Person in call</label>
                        <asp:DropDownList name="call_person" ID="call_person" placeholder="Select a person" runat="server" class="dropdown filter" AutoPostBack="true" />
                    </li>
                </ul>
            </div>
            <div>
                <!-- clear and confirm button -->
                <button type="button" id="clear_button">
                    <img src="images/clean.png" alt="clean" class="image" onclick="Clear();" /></button>
                <asp:ImageButton ID="confirm_button" runat="server" ImageUrl="~/images/confirm.png" OnClick="confirm_button_Click" ValidationGroup="Send" />
                <button type="button" id="print_button" onclick="Print();">
                    <img src="images/download.png" alt="print" class="image" /></button>
                <button type="button" id="email_button" onclick="SendMail(cc_.value,body_.value,alert_mail_.value);" />
                <img src="images/mail.png" alt="email" class="image" />
            </div>
            <div id="support">This page has to be considered an official document. In case you need support, please send an email to supervisorIT@it.kruk.eu</div>
        </section>
        <div id="divExport" runat="server">
            <asp:ImageButton ID="imgExl" runat="server" OnClick="imgExl_Click" ImageUrl="~/images/excel.png" />
        </div>
        <div id="divGrid" runat="server" style="width: 79%; height: 100%; margin-left: 380px; margin-top: 20px; overflow-x: scroll;">
            <asp:GridView ID="grvDati" runat="server" Style="width: 115px;"
                PagerSettings-Visible="true"
                PagerSettings-Mode="NextPreviousFirstLast"
                PageSize="20" AllowPaging="true"
                AllowSorting="true"
                AutoGenerateColumns="false"
                DataKeyNames="Id"
                OnPageIndexChanging="grvDati_PageIndexChanging"
                OnRowCancelingEdit="grvDati_RowCancelingEdit"
                OnRowDeleting="grvDati_RowDeleting"
                OnRowEditing="grvDati_RowEditing"
                EmptyDataText="Non sono stati trovati record per la ricerca effettuata"
                OnRowCreated="grvDati_RowCreated"
                OnRowDataBound="GrvDati_RowDataBound"
                OnRowUpdating="grvDati_RowUpdating">
                <Columns>
                    <asp:CommandField ShowEditButton="true" CausesValidation="false" />
                    <asp:CommandField ShowDeleteButton="true" CausesValidation="false" />
                    <asp:TemplateField HeaderText="Agent name">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlAgentName" runat="server">
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="case_number" HeaderText="Case number" />
                    <asp:TemplateField HeaderText="Date of evalutation">
                        <ItemTemplate>
                            <asp:TextBox ID="txtDE" runat="server" CssClass="GridCalendar" TextMode="Date" Text='<%# Eval("date_evaluation","{0:yyyy-MM-dd}") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Owner">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlOwner" runat="server">
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Call date">
                        <ItemTemplate>
                            <asp:TextBox ID="txtCD" runat="server" CssClass="GridCalendar" TextMode="Date" Text='<%# Eval("call_date","{0:yyyy-MM-dd}") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Person in call">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlPersonCall" runat="server">
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="score_1" CssClass="score" ToolTip="Apertura e contratto: presentazione azienda, identificazione cliente, scopo della chiamata, spiegazione del caso." Text="Score 1"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox Text='<%# Bind("input_score1") %>' ID="score_1" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="score_2" CssClass="score" ToolTip="Informazione al cliente su registrazione chiamata (Solo chiamate OUC)." Text="Score 2"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox Text='<%# Bind("input_score2") %>' ID="score_2" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="score_3" CssClass="score" ToolTip="Ricerca della motivazione a pagare: l'advisor fa emergere la volontá del cliente a pagare." Text="Score 3"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox Text='<%# Bind("input_score3") %>' ID="score_3" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="score_4" CssClass="score" ToolTip="TEST_ToolTip" Text="Score 4"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox Text='<%# Bind("input_score4") %>' ID="score_4" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="score_5" CssClass="score" ToolTip="TEST_ToolTip" Text="Score 5"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox Text='<%# Bind("input_score5") %>' ID="score_5" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="score_6" CssClass="score" ToolTip="TEST_ToolTip" Text="Score 6"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox Text='<%# Bind("input_score6") %>' ID="score_6" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="score_7" CssClass="score" ToolTip="TEST_ToolTip" Text="Score 7"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox Text='<%# Bind("input_score7") %>' ID="score_7" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="score_8" CssClass="score" ToolTip="TEST_ToolTip" Text="Score 8"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox Text='<%# Bind("input_score8") %>' ID="score_8" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="score_9" CssClass="score" ToolTip="TEST_ToolTip" Text="Score 9"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox Text='<%# Bind("input_score9") %>' ID="score_9" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="score_10" CssClass="score" ToolTip="TEST_ToolTip" Text="Score 10"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox Text='<%# Bind("input_score10") %>' ID="score_10" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="score_11" CssClass="score" ToolTip="TEST_ToolTip" Text="Score 11"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox Text='<%# Bind("input_score11") %>' ID="score_11" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="score_12" CssClass="score" ToolTip="TEST_ToolTip" Text="Score 12"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox Text='<%# Bind("input_score12") %>' ID="score_12" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="score_13" CssClass="score" ToolTip="TEST_ToolTip" Text="Score 13"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox Text='<%# Bind("input_score13") %>' ID="score_13" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="score_14" CssClass="score" ToolTip="TEST_ToolTip" Text="Score 14"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox Text='<%# Bind("input_score14") %>' ID="score_14" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="score_15" CssClass="score" ToolTip="TEST_ToolTip" Text="Score 15"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox Text='<%# Bind("input_score15") %>' ID="score_15" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="score_16" CssClass="score" ToolTip="TEST_ToolTip" Text="Score 16"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox Text='<%# Bind("input_score16") %>' ID="score_16" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="score_17" CssClass="score" ToolTip="TEST_ToolTip" Text="Score 17"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox Text='<%# Bind("input_score17") %>' ID="score_17" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderTemplate>
                            <asp:Label runat="server" ID="score_18" CssClass="score" ToolTip="TEST_ToolTip" Text="Score 18"></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:TextBox Text='<%# Bind("input_score18") %>' ID="score_18" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
        <input type="hidden" id="cc_" runat="server" visible="true" />
        <input type="hidden" id="body_" runat="server" visible="true" />
        <input type="hidden" id="alert_mail_" runat="server" visible="true" />
    </form>
</body>
</html>
