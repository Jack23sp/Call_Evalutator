<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Navigator.aspx.cs" Inherits="Call_Evalutator.Navigator" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">
    <link rel="stylesheet" href="CSS/style.css" />
    <title>Call Evaluator&copy</title>
    <link rel="icon" type="image/png" href="images/favicon.png" id="favicon" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" />
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans&display=swap" rel="stylesheet" />
    <%--    <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.5/themes/base/jquery-ui.css" type="text/css" media="all" />--%>
    <%--<link rel="stylesheet" href="http://static.jquery.com/ui/css/demo-docs-theme/ui.theme.css" type="text/css" media="all" />--%>
    <script type="text/javascript" src="Scripts/jquery-3.6.0.js"></script>
    <script type="text/javascript" src="Scripts/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/hover.css/2.3.1/css/hover.css" />
    <link rel="stylesheet" href="CSS/Navigator/navigator.css" />

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js" integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.min.js" integrity="sha384-7VPbUDkoPSGFnVtYi0QogXtr74QeVeeIs99Qfg5YCF+TidwNdjvaKZX19NZ/e6oz" crossorigin="anonymous"></script>

    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
    <script type="text/javascript" src="html2pdf.js-master/html2pdf.js-master/dist/html2pdf.bundle.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/es6-promise/4.2.8/es6-promise.auto.min.js"></script>
    <script src="jsPDF-master/jsPDF-master/src/jspdf.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
    <script type="text/javascript" src="html2pdf.min.js"></script>


    <link rel="stylesheet" type="text/css" href="CSS/Selector/Selector.css">
</head>

<body>
    <form runat="server">
        <article class="kontext">
            <div class="layer one show" id="canPrint" style="overflow-y: auto">
                <div class="container-fluid navigator-container" id="navigator-container">
                    <div class="row">
                        <div class="col-lg-12 col-md-12 col-sm-12">
                            <div class="container-fluid">
                                <div id="navigator" class="navigator col-12">
                                    <div class="container-fluid d-flex flex-column ">
                                        <div class="row flex">
                                            <div class="menu_placeholder col-xl-2 col-lg-2 col-md-12 col-sm-12 col-12">
                                                <img src="images/favicon.png" alt="Logo" width="40px" id="logo" class="logo" />
                                                <h1 id="title" class="title">Call Evaluator</h1>
                                            </div>
                                            <div class="menu_col col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12" style="padding-top: 5px;">
                                                <img src="images/agent.png" alt="Agent" id="icon_agent" class="icon" />
                                                <asp:DropDownList required="required" name="agent_name" ID="agent_name" placeholder="Select the agent name" runat="server" class="insert_dropdown agent_name" AutoPostBack="false" />
                                                <br />
                                                <label for="agent_name" class="label">Agent Name</label>
                                            </div>
                                            <div class="menu_col col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12" style="padding-top: 5px;">
                                                <img src="images/case.png" alt="case" id="icon_case" class="icon" />
                                                <input type="text" style="text-transform: uppercase" id="case_number" name="case_number" size="10" runat="server" class="insert_input case_number" required="required" />
                                                <br />
                                                <label for="case_number" id="lblDateEval" class="label" runat="server">Case number</label>
                                            </div>
                                            <div class="menu_col col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12" style="padding-top: 5px;">
                                                <img src="images/date.png" alt="date" id="icon_date" class="icon" />
                                                <input type="text" id="date_evaluation" class="date_evaluation" name="date_evaluation" size="10" runat="server" readonly="true" />
                                                <br />
                                                <label for="date_evaluation" id="lblDate" class="label" runat="server">Date of evaluation</label>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="menu_placeholder -xl-2 col-lg-2 col-md-12 col-sm-12 col-12"></div>
                                            <div class="menu_col col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12" style="padding-top: 5px;">
                                                <img src="images/teamleader.png" alt="team_leader" id="icon_owner" class="icon" />
                                                <asp:DropDownList required="required" name="owner" ID="owner" placeholder="Select the owner" runat="server" class="insert_dropdown owner" AutoPostBack="false" />
                                                <br />
                                                <label for="owner" class="label">Evaluation Owner</label>
                                            </div>
                                            <div class="menu_col col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12" style="padding-top: 5px;">
                                                <img src="images/date.png" alt="date" id="icon_date2" class="icon" />
                                                <input type="date" value="" id="call_date" name="call_date" size="10" runat="server" class="insert_input call_date" required="required" />
                                                <br />
                                                <label for="call_date" class="label">Date of call</label>
                                            </div>
                                            <div class="menu_col col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12" style="padding-top: 5px;">
                                                <img src="images/personincall.png" alt="personincall" id="icon_personincall" class="icon" />
                                                <asp:DropDownList required="required" name="call_person" ID="call_person" placeholder="Select a person" runat="server" class="insert_dropdown call_person" AutoPostBack="false" />
                                                <br />
                                                <label for="call_person" class="label">Person in call</label>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-12" style="padding-top: 50px;">
                                                <div class="centered" id="centered">
                                                    <div class="plus1" id="plus1" runat="server">
                                                        <div class="plus1__line plus1__line--v">
                                                            <div>
                                                                <button type="button" id="clear_button_1" class="clearButton" style="background-color: transparent;">
                                                                    <img src="images/Gnome-edit-clear.svg.png" style="margin-top: -5px;" alt="clean" class="image" onclick="ClearInsertFilter();" /></button>
                                                                <asp:ImageButton ID="confirm_button" CssClass="imgConfirmSelector clearButton confirm_button" runat="server" ImageUrl="~/images/8f21d4f67a146c95e0799c68f3cde00c.png" OnClientClick="CheckifOpen(plus1.id);" OnClick="confirm_button_Click" ValidationGroup="Send" />
                                                                <button type="button" id="print_button_1" class="clearButton" onclick="Print();" style="background-color: transparent;">
                                                                    <img src="images/Icons8_flat_print.svg.png" style="margin-top: -5px;" alt="print" class="image" /></button>
                                                                <button type="button" id="email_button_1" class="clearButton" onclick="SendMail(cc_.value,body_.value,alert_mail_.value);" style="background-color: transparent;">
                                                                    <img src="images/Circle-icons-mail.svg.png" alt="email" class="image" /></button>
                                                            </div>
                                                        </div>
                                                        <div class="plus1__line plus1__line--h"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="printable col-xl-6 col-lg-12 col-md-12 col-sm-12 col-12">
                            <div class="accordion" id="accordionPanelsStayOpenExample">
                                <div class="accordion-item" style="margin-top: 15px;">
                                    <h2 class="accordion-header" id="panelsStayOpen-headingOne">
                                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">
                                            Elementi comuni a tutte le conversazioni
                                        </button>
                                    </h2>
                                    <div id="panelsStayOpen-collapseOne" class="accordion-collapse show" aria-labelledby="panelsStayOpen-headingOne">
                                        <div class="accordion-body">
                                            <div class="container-fluid">
                                                <div class="row color-lightblue">
                                                    <div class="col-9" style="min-height: 100px;">
                                                        <p id="p1" class="par">Apertura e contratto: presentazione azienda, identificazione cliente, scopo della chiamata, spiegazione del caso.</p>

                                                    </div>
                                                    <div class="col-3">
                                                        <input type="number" name="score" value="" min="1" max="3" id="input_score1" class="insert_input input_score" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="row color-lightgrey">
                                                    <div class="col-9" style="min-height: 59px;">
                                                        <p id="p2" class="par">Informazione al cliente su registrazione chiamata (Solo chiamate OUC).</p>
                                                    </div>
                                                    <div class="col-3">
                                                        <input type="number" name="score" value="" min="1" max="3" id="input_score2" class="insert_input input_score" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="row color-lightblue">
                                                    <div class="col-9" style="min-height: 73px;">
                                                        <p id="p3" class="par">Ricerca della motivazione a pagare: l'advisor fa emergere la volontá del cliente a pagare.</p>
                                                    </div>
                                                    <div class="col-3">
                                                        <input type="number" name="score" value="" min="1" max="3" id="input_score3" class="insert_input input_score" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="row color-lightgrey">
                                                    <div class="col-9" style="min-height: 74px;">
                                                        <p id="p4" class="par">Gestione delle obiezioni del cliente: uso di argomentazione tecniche e legali.</p>
                                                    </div>
                                                    <div class="col-3">
                                                        <input type="number" name="score" value="" min="1" max="3" id="input_score4" class="insert_input input_score" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="row color-lightblue">
                                                    <div class="col-9" style="min-height: 42px;">
                                                        <p id="p5" class="par">Budget e Qtab (compilato correttamente).</p>
                                                    </div>
                                                    <div class="col-3">
                                                        <input type="number" name="score" value="" min="1" max="3" id="input_score5" class="insert_input input_score" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="row color-lightgrey">
                                                    <div class="col-9" style="min-height: 74px;">
                                                        <p id="p6" class="par">Negoziazione: l'advisor segue lo standard e propone la soluzione piu appropriata (ARR, BUCKET).</p>
                                                    </div>
                                                    <div class="col-3">
                                                        <input type="number" name="score" value="" min="1" max="3" id="input_score6" class="insert_input input_score" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="row color-lightblue">
                                                    <div class="col-9" style="min-height: 75px;">
                                                        <p id="p7" class="par">L'advisor ha usato le note delle conversazioni precedenti per essere più efficace col cliente.</p>
                                                    </div>
                                                    <div class="col-3">
                                                        <input type="number" name="score" value="" min="1" max="3" id="input_score7" class="insert_input input_score" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="row color-lightgrey">
                                                    <div class="col-9" style="min-height: 42px;">
                                                        <p id="p8" class="par">Chiusura: l'advisor ha preso la garanzia.</p>
                                                    </div>
                                                    <div class="col-3">
                                                        <input type="number" name="score" value="" min="1" max="3" id="input_score8" class="insert_input input_score" runat="server" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="printable col-xl-6 col-lg-12 col-md-12 col-sm-12 col-12">
                            <div class="accordion" id="accordionPanelsStayOpenExample1">
                                <div class="accordion-item" style="margin-top: 15px;">
                                    <h2 class="accordion-header" id="panelsStayOpen-headingOne1">
                                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne1" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne1">
                                            Linguaggio ed Approccio
                                        </button>
                                    </h2>
                                    <div id="panelsStayOpen-collapseOne1" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne1">
                                        <div class="accordion-body">
                                            <div class="container-fluid">
                                                <div class="row color-lightblue">
                                                    <div class="col-9" style="min-height: 100px;">
                                                        <p id="p9" class="par">L'advisor ha condotto la chiamata con un approccio proattivo (assertivitá e determinazione).</p>
                                                    </div>
                                                    <div class="col-3">
                                                        <input type="number" name="score" value="" min="1" max="3" id="input_score9" class="insert_input input_score" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="row color-lightgrey">
                                                    <div class="col-9" style="min-height: 59px;">
                                                        <p id="p10" class="par">Uso corretto del linguaggio, adatto al cliente.</p>
                                                    </div>
                                                    <div class="col-3">
                                                        <input type="number" name="score" value="" min="1" max="3" id="input_score10" class="insert_input input_score" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="row color-lightblue">
                                                    <div class="col-9" style="min-height: 73px;">
                                                        <p id="p11" class="par">Uso corretto della voce, adeguato al tipo di cliente.</p>
                                                    </div>
                                                    <div class="col-3">
                                                        <input type="number" name="score" value="" min="1" max="3" id="input_score11" class="insert_input input_score" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="row color-lightgrey">
                                                    <div class="col-9" style="min-height: 74px;">
                                                        <p id="p12" class="par">Gestione corretta delle emozioni.</p>
                                                    </div>
                                                    <div class="col-3">
                                                        <input type="number" name="score" value="" min="1" max="3" id="input_score12" class="insert_input input_score" runat="server" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="printable col-xl-6 col-lg-12 col-md-12 col-sm-12 col-12">
                            <div class="accordion" id="accordionPanelsStayOpenExample2">
                                <div class="accordion-item" style="margin-top: 15px;">
                                    <h2 class="accordion-header" id="panelsStayOpen-headingOne2">
                                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne2" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne2">
                                            Procedure obligatorie
                                        </button>
                                    </h2>
                                    <div id="panelsStayOpen-collapseOne2" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne2">
                                        <div class="accordion-body">
                                            <div class="container-fluid">
                                                <div class="row color-lightblue">
                                                    <div class="col-9" style="min-height: 100px;">
                                                        <p id="p13" class="par">Conoscenza delle procedure.</p>
                                                    </div>
                                                    <div class="col-3">
                                                        <input type="number" name="score" value="" min="1" max="3" id="input_score13" class="insert_input input_score" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="row color-lightgrey">
                                                    <div class="col-9" style="min-height: 59px;">
                                                        <p id="p14" class="par">Acquisizione o conferma dei dati del cliente.</p>
                                                    </div>
                                                    <div class="col-3">
                                                        <input type="number" name="score" value="" min="1" max="3" id="input_score14" class="insert_input input_score" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="row color-lightblue">
                                                    <div class="col-9" style="min-height: 73px;">
                                                        <p id="p15" class="par">L'advisor ha seguito lo standard della firma? (eSignature - EMU - Invio per mail).</p>
                                                    </div>
                                                    <div class="col-3">
                                                        <input type="number" name="score" value="" min="1" max="3" id="input_score15" class="insert_input input_score" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="row color-lightgrey">
                                                    <div class="col-9" style="min-height: 74px;">
                                                        <p id="p16" class="par">L'advisor ha correttamente presentato eKRUK e deadline del link di attivazione?</p>
                                                    </div>
                                                    <div class="col-3">
                                                        <input type="number" name="score" value="" min="1" max="3" id="input_score16" class="insert_input input_score" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="row color-lightblue">
                                                    <div class="col-9" style="min-height: 73px;">
                                                        <p id="p17" class="par">Corretto uso dello standard delle note, dei codici e della documentazione.</p>
                                                    </div>
                                                    <div class="col-3">
                                                        <input type="number" name="score" value="" min="1" max="3" id="input_score17" class="insert_input input_score" runat="server" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="printable col-xl-6 col-lg-12 col-md-12 col-sm-12 col-12">
                            <div class="accordion" id="accordionPanelsStayOpenExample3">
                                <div class="accordion-item" style="margin-top: 15px;">
                                    <h2 class="accordion-header" id="panelsStayOpen-headingOne3">
                                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne3" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne3">
                                            Obiettivo
                                        </button>
                                    </h2>
                                    <div id="panelsStayOpen-collapseOne3" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne2">
                                        <div class="accordion-body">
                                            <div class="container-fluid">
                                                <div class="row color-lightblue">
                                                    <div class="col-9" style="min-height: 42px;">
                                                        <p id="p18" class="par">Ha fatto tutto il possibile per ottenere la soluzione migliore?</p>
                                                    </div>
                                                    <div class="col-3">
                                                        <input type="number" name="score" value="" min="1" max="3" id="input_score18" class="insert_input input_score" runat="server" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="printable col-xl-6 col-lg-12 col-md-12 col-sm-12 col-12">
                            <div class="accordion" id="accordionPanelsStayOpenExample4">
                                <div class="accordion-item" style="margin-top: 15px;">
                                    <h2 class="accordion-header" id="panelsStayOpen-headingOne4">
                                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne4" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne4">
                                            Punti di forza
                                        </button>
                                    </h2>
                                    <div id="panelsStayOpen-collapseOne4" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne2">
                                        <div class="accordion-body">
                                            <div class="container-fluid">
                                                <div class="row">
                                                    <div class="col-12">
                                                        <asp:TextBox TextMode="MultiLine" name="strenght_weakness" value="" ID="strenght" class="insert_input strenght" runat="server" />
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="printable col-xl-6 col-lg-12 col-md-12 col-sm-12 col-12">
                            <div class="accordion" id="accordionPanelsStayOpenExample5">
                                <div class="accordion-item" style="margin-top: 15px;">
                                    <h2 class="accordion-header" id="panelsStayOpen-headingOne5">
                                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne5" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne5">
                                            Punti di debolezza
                                        </button>
                                    </h2>
                                    <div id="panelsStayOpen-collapseOne5" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingOne5">
                                        <div class="accordion-body">
                                            <div class="container-fluid">
                                                <div class="row">
                                                    <div class="col-12">
                                                        <asp:TextBox TextMode="MultiLine" name="strenght_weakness" value="" ID="weakness" class="insert_input weakness" runat="server" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="separator col-12">
                        </div>
                    </div>

                </div>
            </div>
            <div class="layer two">
                <div class="container-fluid navigator-container" id="navigator-container1">
                    <asp:UpdatePanel ID="OrdersPanel"
                        UpdateMode="Conditional"
                        runat="server">
                        <ContentTemplate>
                            <asp:ScriptManager ID="ScriptManager1"
                                runat="server" />
                            <div class="row">
                                <div class="col-lg-12 col-md-12 col-sm-12">
                                    <div class="container-fluid">
                                        <div id="navigator1" class="navigator col-12">
                                            <div class="container-fluid d-flex flex-column ">
                                                <div class="row flex">
                                                    <div class="menu_placeholder col-xl-2 col-lg-2 col-md-12 col-sm-12 col-12">
                                                        <img src="images/favicon.png" alt="Logo" width="40px" id="logo" class="logo" />
                                                        <h1 id="title1" class="title">Call Evaluator</h1>
                                                    </div>
                                                    <div class="menu_col col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12" style="padding-top: 5px;">
                                                        <img src="images/agent.png" alt="Agent" id="icon_agent1" class="icon" />
                                                        <asp:DropDownList name="agent_name" ID="agent_name2" placeholder="Select the agent name" runat="server" class="insert_dropdown agent_name" AutoPostBack="false" />
                                                        <br />
                                                        <label for="agent_name2" class="label">Agent Name</label>
                                                    </div>
                                                    <div class="menu_col col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12" style="padding-top: 5px;">
                                                        <img src="images/case.png" alt="case" id="icon_case1" class="icon" />
                                                        <input type="text" style="text-transform: uppercase" id="case_number2" name="case_number2" size="10" runat="server" class="insert_input case_number" />
                                                        <br />
                                                        <label for="case_number2" id="Label1" class="label" runat="server">Case number</label>
                                                    </div>
                                                    <div class="menu_col col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12" style="padding-top: 5px;">
                                                        <img src="images/date.png" alt="date" id="icon_date3" class="icon" />
                                                        <input type="date" value="" id="date_evaluation2" name="date_evaluation2" size="10" runat="server" class="insert_input date_evaluation" />
                                                        <br />
                                                        <label for="date_evaluation2" id="Label2" class="label" runat="server">Date of evaluation</label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="menu_placeholder -xl-2 col-lg-2 col-md-12 col-sm-12 col-12"></div>
                                                    <div class="menu_col col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12" style="padding-top: 5px;">
                                                        <img src="images/teamleader.png" alt="team_leader" id="icon_owner1" class="icon" />
                                                        <asp:DropDownList name="owner" ID="owner2" placeholder="Select the owner" runat="server" class="insert_dropdown owner" AutoPostBack="false" />
                                                        <br />
                                                        <label for="owner2" class="label">Evaluation Owner</label>
                                                    </div>
                                                    <div class="menu_col col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12" style="padding-top: 5px;">
                                                        <img src="images/date.png" alt="date" id="icon_date4" class="icon" />
                                                        <input type="date" value="" id="call_date2" name="call_date" size="10" runat="server" class="insert_input call_date" />
                                                        <br />
                                                        <label for="call_date2" class="label">Date of call</label>
                                                    </div>
                                                    <div class="menu_col col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12" style="padding-top: 5px;">
                                                        <img src="images/personincall.png" alt="personincall" id="icon_personincall2" class="icon" />
                                                        <asp:DropDownList name="call_person" ID="call_person2" placeholder="Select a person" runat="server" class="insert_dropdown call_person" AutoPostBack="false" />
                                                        <br />
                                                        <label for="call_person2" class="label">Person in call</label>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-12" style="padding-top: 50px;">
                                                        <div class="centered2" id="centered2">
                                                            <div class="plus2" id="plus2">
                                                                <div class="plus2__line plus2__line--v">
                                                                    <button type="button" id="clear_button_2" class="clearButton" style="background-color: transparent;">
                                                                        <img src="images/Gnome-edit-clear.svg.png" style="margin-top: -5px;" alt="clean" class="image" onclick="ClearInsertFilter();" /></button>
                                                                    <asp:ImageButton ID="ImageButton1" CssClass="imgConfirmSelector clearButton confirm_button" runat="server" ImageUrl="~/images/8f21d4f67a146c95e0799c68f3cde00c.png" OnClick="confirm_button_2_Click1" formNoValidate="false" />
                                                                </div>
                                                                <div class="plus2__line plus2__line--h"></div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <div id="divExport" runat="server">
                                        <asp:ImageButton ID="imgExl" runat="server" OnClick="imgExl_Click" ImageUrl="~/images/excel.png" formNoValidate="false" CausesValidation="false" />
                                    </div>
                                    <div id="noRecord" runat="server" visible="false">
                                        <label id="lblNoRecord" runat="server">Non sono stati trovati risultati per la ricerca effettuata!</label>
                                    </div>
                                    <div id="divGrid" runat="server" style="width: 100%; height: 87%; overflow-x: auto; overflow-y: hidden;padding-top:15px;">
                                        <asp:GridView ID="grvDati" runat="server"
                                            PagerSettings-Visible="true"
                                            PagerSettings-Mode="NextPreviousFirstLast"
                                            PageSize="5" AllowPaging="true"
                                            AllowSorting="true"
                                            AutoGenerateColumns="false"
                                            DataKeyNames="Id"
                                            OnPageIndexChanging="grvDati_PageIndexChanging"
                                            OnRowCancelingEdit="grvDati_RowCancelingEdit"
                                            OnRowDeleting="grvDati_RowDeleting"
                                            OnRowEditing="grvDati_RowEditing"
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
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="imgExl" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>
            </div>
            <input type="hidden" id="cc_" runat="server" visible="true" />
            <input type="hidden" id="body_" runat="server" visible="true" />
            <input type="hidden" id="alert_mail_" runat="server" visible="true" />


            <%--VISUALIZATION--%>
        </article>
        <ul class="bullets"></ul>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8" crossorigin="anonymous"></script>
        <script src="JS/Navigator/Navigator.js"></script>
        <script src="JS/scripts.js"></script>
    </form>
</body>
</html>
