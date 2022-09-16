<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="Call_Evalutator.WebForm1" %>

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
                        <asp:DropDownList required="required" name="agent_name" ID="agent_name" placeholder="Select the agent name" runat="server" class="dropdown filter" AutoPostBack="true" />
                    </li>
                    <br />
                    <li>
                        <label for="case_number" class="label">Case Number</label>
                        <input type="text" style="text-transform: uppercase" id="case_number" name="case_number" size="10" runat="server" class="input filter" required="required" />
                    </li>
                    <br />
                    <li>
                        <label for="date_evaluation" id="lblDate" class="label" runat="server">Date of evaluation</label>
                        <input type="text" id="date_evaluation" name="date_evaluation" size="10" runat="server" readonly="true" />
                    </li>
                    <br />
                    <li>
                        <label for="owner" class="label">Evaluation Owner</label>
                        <asp:DropDownList required="required" name="owner" ID="owner" placeholder="Select the owner" runat="server" class="dropdown filter" AutoPostBack="true" />
                    </li>
                    <br />
                    <li>
                        <label for="call_date" class="label">Date of call</label>
                        <input type="date" value="" id="call_date" name="call_date" size="10" runat="server" class="input filter" required="required" />
                    </li>
                    <br />
                    <li>
                        <label for="call_person" class="label">Person in call</label>
                        <asp:DropDownList required="required" name="call_person" ID="call_person" placeholder="Select a person" runat="server" class="dropdown filter" AutoPostBack="true" />
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
        <section id="printarea">
            <!-- Body of webapp -->
            <div>
                <h2 id="h2_1">Elementi comuni a tutte le conversazioni</h2>
            </div>
            <div>
                <p id="p1">Apertura e contratto: presentazione azienda, identificazione cliente, scopo della chiamata, spiegazione del caso.</p>
                <p id="p2">Informazione al cliente su registrazione chiamata (Solo chiamate OUC).</p>
                <p id="p3">Ricerca della motivazione a pagare: l'advisor fa emergere la volontá del cliente a pagare.</p>
                <p id="p4">Gestione delle obiezioni del cliente: uso di argomentazione tecniche e legali.</p>
                <p id="p5">Budget e Qtab (compilato correttamente).</p>
                <p id="p6">Negoziazione: l'advisor segue lo standard e propone la soluzione piu appropriata (ARR, BUCKET).</p>
                <p id="p7">L'advisor ha usato le note delle conversazioni precedenti per essere più efficace col cliente.</p>
                <p id="p8">Chiusura: l'advisor ha preso la garanzia.</p>
            </div>
            <div>
                <h2 id="h2_2">Linguaggio ed Approccio</h2>
            </div>
            <div>
                <p id="p9">L'advisor ha condotto la chiamata con un approccio proattivo (assertivitá e determinazione).</p>
                <p id="p10">Uso corretto del linguaggio, adatto al cliente.</p>
                <p id="p11">Uso corretto della voce, adeguato al tipo di cliente.</p>
                <p id="p12">Gestione corretta delle emozioni.</p>
            </div>
            <div>
                <h2 id="h2_3">Procedure obligatorie</h2>
            </div>
            <div>
                <p id="p13">Conoscenza delle procedure.</p>
                <p id="p14">Acquisizione o conferma dei dati del cliente.</p>
                <p id="p15">L'advisor ha seguito lo standard della firma? (eSignature - EMU - Invio per mail).</p>
                <p id="p16">L'advisor ha correttamente presentato eKRUK e deadline del link di attivazione?</p>
                <p id="p17">Corretto uso dello standard delle note, dei codici e della documentazione.</p>
            </div>
            <div>
                <h2 id="h2_4">Obiettivo</h2>
            </div>
            <div>
                <p id="p18">Ha fatto tutto il possibile per ottenere la soluzione migliore?</p>
            </div>
            <div>
                <!-- input score -->
                <p id="score1">Score</p>
                <input type="number" name="score" value="" min="1" max="3" id="input_score1" class="input" runat="server" />
                <input type="number" name="score" value="" min="1" max="3" id="input_score2" class="input" runat="server" />
                <input type="number" name="score" value="" min="1" max="3" id="input_score3" class="input" runat="server" />
                <input type="number" name="score" value="" min="1" max="3" id="input_score4" class="input" runat="server" />
                <input type="number" name="score" value="" min="1" max="3" id="input_score5" class="input" runat="server" />
                <input type="number" name="score" value="" min="1" max="3" id="input_score6" class="input" runat="server" />
                <input type="number" name="score" value="" min="1" max="3" id="input_score7" class="input" runat="server" />
                <input type="number" name="score" value="" min="1" max="3" id="input_score8" class="input" runat="server" />
                <p id="score2">Score</p>
                <input type="number" name="score" value="" min="1" max="3" id="input_score9" class="input" runat="server" />
                <input type="number" name="score" value="" min="1" max="3" id="input_score10" class="input" runat="server" />
                <input type="number" name="score" value="" min="1" max="3" id="input_score11" class="input" runat="server" />
                <input type="number" name="score" value="" min="1" max="3" id="input_score12" class="input" runat="server" />
                <p id="score3">Score</p>
                <input type="number" name="score" value="" min="1" max="3" id="input_score13" class="input" runat="server" />
                <input type="number" name="score" value="" min="1" max="3" id="input_score14" class="input" runat="server" />
                <input type="number" name="score" value="" min="1" max="3" id="input_score15" class="input" runat="server" />
                <input type="number" name="score" value="" min="1" max="3" id="input_score16" class="input" runat="server" />
                <input type="number" name="score" value="" min="1" max="3" id="input_score17" class="input" runat="server" />
                <p id="score4">Score</p>
                <input type="number" name="score" value="" min="1" max="3" id="input_score18" class="input" runat="server" />
                <div id="dvImage" runat="server">
                    <asp:ImageButton ID="rdrBtn" runat="server" OnClientClick="TransferToVisualize();" OnClick="rdrBtn_Click" ImageUrl="~/images/visualize.png" CausesValidation="false" Visible="false" />
                </div>
            </div>
            <div id="title_print">
                <h1>Call Evaluator</h1>
            </div>
            <h2 id="h2_5">Punti di forza</h2>
            <asp:TextBox TextMode="MultiLine" name="strenght_weakness" value="" ID="strenght" class="input" runat="server" />
            <h2 id="h2_6">Punti di debolezza</h2>
            <asp:TextBox TextMode="MultiLine" name="strenght_weakness" value="" ID="weakness" class="input" runat="server" />
        </section>
        <input type="hidden" id="cc_" runat="server" visible="true" />
        <input type="hidden" id="body_" runat="server" visible="true" />
        <input type="hidden" id="alert_mail_" runat="server" visible="true" />
    </form>
</body>
</html>
