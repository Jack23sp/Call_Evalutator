var printdata;
var case_number;
var date_evalutation;
let input;
let dropdown;

window.onload = function FindVariable() {
    printdata = document.getElementById('printarea');
    case_number = document.getElementById('case_number');
    date_evalutation = document.getElementById('date_evaluation');
    input = document.getElementsByClassName('input');
    dropdown = document.getElementsByClassName('dropdown');
}

function Print() {
    newwin = window.open("");
    newwin.document.write(printdata.outerHTML);
    newwin.print();
    newwin.close();
}

function AlertSuccess() {
    alert("Dati salvati correttamente!");
}

function AlertFailed() {
    alert("Si è riscontrato un errore, dati non salvati!");
} 

function SendMail() {
    var link; 

    if (case_number.value != "") {
        link = "mailto:me@example.com"
            + "?cc=myCCaddress@example.com"
            + "&subject=" + encodeURIComponent("Call Evalutation on case " + case_number.value + " on date " + convertDate(date_evalutation.value));
        + "&body=" + encodeURIComponent("Ciao,%0D%0DIn allegato puoi trovare la call evaluation con tutti i dettagli.%0D%0DIn caso di dubbi sono a disposizione.")
            ;
    }
    else {
        link = "mailto:me@example.com"
            + "?cc=myCCaddress@example.com"
            + "&subject=" + encodeURIComponent("Call Evalutation on date " + convertDate(date_evalutation.value));
        + "&body=" + encodeURIComponent("Ciao,%0D%0DIn allegato puoi trovare la call evaluation con tutti i dettagli.%0D%0DIn caso di dubbi sono a disposizione.")
            ;
    }
    window.location.href = link;
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