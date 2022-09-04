var printdata;
var case_number;
var agent_name;
var call_date;
var date_evalutation;
var call_person;
var owner;
var print_button;
var email_button;

let input;
let dropdown;
let filter;

window.onload = function FindVariable() {
    printdata = document.getElementById('printarea');
    agent_name = document.getElementById('agent_name');
    case_number = document.getElementById('case_number');
    call_date = document.getElementById('call_date');
    date_evalutation = document.getElementById('date_evaluation');
    call_person = document.getElementById('call_person');
    owner = document.getElementById('owner');
    print_button = document.getElementById('print_button');
    email_button = document.getElementById('email_button');
    input = document.getElementsByClassName('input');
    dropdown = document.getElementsByClassName('dropdown');
    filter = document.getElementsByClassName('filter');

    MaxDate();

}

$(document).ready(function () {
    $(".Calender").dynDateTime({
        showsTime: true,
        ifFormat: "%Y/%m/%d %H:%M",
        daFormat: "%l;%M %p, %e %m, %Y",
        align: "BR",
        electric: false,
        singleClick: false,
        displayArea: ".siblings('.dtcDisplayArea')",
        button: ".next()"
    });
});


function MaxDate() {
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth() + 1; //January is 0 so need to add 1 to make it 1!
    var yyyy = today.getFullYear();
    if (dd < 10) {
        dd = '0' + dd
    }
    if (mm < 10) {
        mm = '0' + mm
    }

    today = yyyy + '-' + mm + '-' + dd;
    call_date.setAttribute("max", today);
}

function CheckFilled() {

    return agent_name.value != "" && case_number.value != "" && call_date != "" && date_evalutation != "" && call_person.value != "" && owner.value != "";
}

function Print() {

    if (CheckFilled() == true) {
        newwin = window.open("");
        newwin.document.write(printdata.outerHTML);
        newwin.print();
        newwin.close();
    }
    else {
        AlertFilled();
    }
}

function AlertFilled() {
    alert("Per utilizzare questa funzione vanno compilati tutti i filtri di ricerca!")
}

function AlertSuccess() {
    alert("Dati salvati correttamente!");
}

function AlertFailed() {
    alert("Si e' riscontrato un errore, dati non salvati!");
}

function AlertSuccessUpdate() {
    alert("Dati modificati correttamente!");
}

function AlertFailedUpdate() {
    alert("Si e' riscontrato un errore nella modifica dei dati!");
}

function AlertSuccessDelete() {
    alert("Dati eliminati correttamente!");
}

function AlertFailedDelete() {
    alert("Non e' stato possibile eliminare i dati a causa di un errore!");
}
function NotAuthorizedToInsert() {
    alert("Non si e' autorizzati ad effettuare l'inserimento! Contattare l'amministratore di sistema.");
}

function TransferToVisualize() {
    window.location.href = "Visualizzazione.aspx";
}

function CallDateError() {
    alert("Il campo call date deve essere minore della data odierna e della data di valutazione!");
}

function CheckData() {
    alert("I campi numerici devo essere compilati con valori da 0 a 3!");
}

function SendMail(cc, body, alert) {
    if (CheckFilled() == true) {
        if (confirm(alert) == true) {
            var link;
            var value = agent_name.value;

            link = "mailto:" + value
                + "?cc=" + cc
                + "&subject=" + encodeURIComponent("Call Evalutation on case " + case_number.value)
                + "&body=" + encodeURIComponent(body)
                ;
            window.location.href = link;
        }
    }
    else {
        AlertFilled();
    }
}

function Clear() {
    for (var i = 0; i < input.length; i++) {
        input[i].value = "";
    }
    for (var i = 0; i < dropdown.length; i++) {
        dropdown[i].getElementsByTagName('option')[0].selected = 'selected';
    }
}

function convertDate(inputFormat) {
    function pad(s) { return (s < 10) ? '0' + s : s; }
    var d = new Date(inputFormat)
    return [pad(d.getDate()), pad(d.getMonth() + 1), d.getFullYear()].join('/')
}