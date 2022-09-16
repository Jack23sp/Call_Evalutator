<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChartStats.aspx.cs" Inherits="Call_Evalutator.ChartStats" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="CSS/style.css" />
    <title></title>
</head>
<body>
    <form id="chartForm" runat="server">
        <div id="divchart" runat="server">
        </div>
        <div id="firstResult"></div>
        <div id="overlayFirst">
            <asp:Label ID="lblFirstReult" runat="server" Text="Prova_1"></asp:Label>
        </div>
        <div id="secondResult"></div>
        <div id="overlaySecond">
            <asp:Label ID="lblSecondReult" runat="server" Text="Prova_1"></asp:Label>
        </div>
        <div id="thirdResult"></div>
        <div id="overlayThird">
            <asp:Label ID="lblThirdReult" runat="server" Text="Prova_1"></asp:Label>
        </div>
        <div id="fourthResult"></div>
        <div id="overlayFourth">
            <asp:Label ID="lblFourthReult" runat="server" Text="Prova_1"></asp:Label>
        </div>
        <asp:Chart ID="callStats" runat="server"
            BackColor="Transparent"
            PageColor="Transparent"
            BackImageTransparentColor="Silver"
            BorderlineColor="Transparent"
            OnLoad="callStats_Load">
            <BorderSkin BackColor="Transparent" PageColor="Transparent" />
            <Series>
                <asp:Series Name="Series1" ChartType="Spline">
                    <Points>
                        <asp:DataPoint AxisLabel="Mark" YValues="800" />
                        <asp:DataPoint AxisLabel="Steve" YValues="900" />
                        <asp:DataPoint AxisLabel="John" YValues="700" />
                        <asp:DataPoint AxisLabel="Mary" YValues="900" />
                        <asp:DataPoint AxisLabel="Ben" YValues="600" />
                    </Points>
                </asp:Series>
            </Series>
            <ChartAreas>
                <asp:ChartArea Name="ChartArea1" BackColor="Transparent">
<%--                    <AxisX Title="Student Name"></AxisX>
                    <AxisY Title="Total Marks"></AxisY>--%>
                </asp:ChartArea>
            </ChartAreas>
        </asp:Chart>
    </form>
</body>
</html>
