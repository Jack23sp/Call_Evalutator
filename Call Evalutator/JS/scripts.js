var printdata;
var case_number;
var agent_name;
var call_date;
var date_evalutation;
var call_person;
var owner;
var print_button;
var email_button;
var plus;
var plus1;
var bulletSend;
var navigator;

let insert_input;
let input;
let dropdown;
let insert_dropdown;
let filter;
let column;
let menu;
let menu_placeholder;
var centered;

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
    insert_input = document.getElementsByClassName('insert_input');
    dropdown = document.getElementsByClassName('dropdown');
    insert_dropdown = document.getElementsByClassName('insert_dropdown');
    filter = document.getElementsByClassName('filter');

    MaxDate();
    ToDoOnLoad();
    Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function () {
        ToDoOnLoad();
    });

    //HandleResize();
}

//function HandleResize() {
//    var nav = document.getElementById("navigator");
//    var data = document.getElementById("data-container");
//    data.setAttribute("style", "margin-left:" + (nav.offsetWidth + 1) + "px !important");
//}

function debounce(func) {
    var timer;
    return function (event) {
        if (timer) clearTimeout(timer);
        timer = setTimeout(func, 100, event);
    };
}

function StartFunction(func) {
    var timer;
    if (timer) clearTimeout(timer);
    timer = setTimeout(func, 500);
}

function Reformat() {
    for (var i = 0; i < column.length; i++) {
        column[i].className = "printable col-xl-6 col-lg-12 col-md-12 col-sm-12 col-12";
    }
    //    HandleResize();
}

function ReformatHeader() {
    for (var i = 0; i < menu.length; i++) {
        menu[i].className = "menu_col col-xl-3 col-lg-3 col-md-12 col-sm-12 col-12";
    }

    for (var i = 0; i < menu_placeholder.length; i++) {
        menu_placeholder[i].className = "menu_placeholder col-xl-2 col-lg-2 col-md-12 col-sm-12 col-12";
    }

    for (var i = 0; i < centered.length; i++) {
        centered[i].style.display = 'flex';
    }
}

//window.addEventListener("resize", debounce(function (e) {
//    HandleResize();
//}));

function plusToggle() {
    plus1.classList.toggle('plus1--active');
    plus.classList.toggle('plus2--active');
}

function ToDoOnLoad() {
    plus = document.getElementById('plus2');
    plus.addEventListener('click', plusToggle);
    plus1 = document.getElementById('plus1');
    plus1.addEventListener('click', plusToggle);
}


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
    if (document.getElementById('plus1').classList.contains('plus1--active')) {
        if (CheckFilled() == true) {
            event.preventDefault();
            debugger;
            column = document.querySelectorAll(".printable");
            menu = document.querySelectorAll('.menu_col');
            menu_placeholder = document.querySelectorAll('.menu_placeholder');
            centered = document.querySelectorAll('.plus1');

            for (var i = 0; i < column.length; i++) {
                column[i].classList = '';
            }

            for (var i = 0; i < menu.length; i++) {
                menu[i].classList = '';
            }

            for (var i = 0; i < menu_placeholder.length; i++) {
                menu_placeholder[i].classList = '';
            }

            for (var i = 0; i < centered.length; i++) {
                centered[i].style.display = 'none';
            }


            var element = document.getElementById('canPrint');

            var opt = {
                margin: [5, 5],
                filename: 'pdfFileName.pdf',
                image: { type: 'jpeg', quality: 0.98 },
                html2canvas: { scale: 2, letterRendering: true },
                jsPDF: { unit: 'pt', format: 'letter', orientation: 'portrait' },
                pagebreak: { mode: ['avoid-all', 'css', 'legacy'] }
            };

            html2pdf().set(opt).from(element).save();

            StartFunction(Reformat);
            StartFunction(ReformatHeader);
        }
        else {
            AlertFilled();
        }
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

function NotAuthorizedToVisualize() {
    alert("Non si e' autorizzati ad effettuare la visualizzazione! Contattare l'amministratore di sistema.");
}

function NotAuthorizedToModify() {
    alert("Non si e' autorizzati a modificare i dati! Contattare l'amministratore di sistema.");
}
function NotAuthorizedToDownload() {
    alert("Non si e' autorizzati ad effettuare il download dei dati! Contattare l'amministratore di sistema.");
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

function NoRecordFound() {
    alert("Non sono stati trovati risultati per la ricerca effettuata!");
}

function CheckifOpen(id) {
    debugger;
    var id_concat = id + '--active';
    if (document.getElementById(id).classList.contains(id_concat)) {
        Confirm("Yes",id);
    }
    else {
        Confirm("No");
    }
}

function Confirm(actual,id) {
    if (document.getElementById(id + '_confirm') == null) {
        var confirm_value = document.createElement("INPUT");
        confirm_value.type = "hidden";
        confirm_value.name = "confirm_value";
        confirm_value.id = id + '_confirm';
        confirm_value.value = actual;
        document.forms[0].appendChild(confirm_value);
    }
    else {
        document.getElementById(id + '_confirm').value = actual;
    }
}

function SendMail(cc, body, alert) {
    if (document.getElementById('plus1').classList.contains('plus1--active')) {
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
}

function Clear() {
    if (confirm("Vuoi davvero procedere con il reset dei valori?") == true) {
        for (var i = 0; i < input.length; i++) {
            input[i].value = "";
        }
        for (var i = 0; i < dropdown.length; i++) {
            dropdown[i].getElementsByTagName('option')[0].selected = 'selected';
        }
    }
}

function ClearInsertFilter() {
    if (document.getElementById('plus1').classList.contains('plus1--active')) {
        if (confirm("Vuoi davvero procedere con il reset dei valori?") == true) {
            for (var i = 0; i < insert_input.length; i++) {
                insert_input[i].value = "";
            }
            for (var i = 0; i < insert_dropdown.length; i++) {
                insert_dropdown[i].getElementsByTagName('option')[0].selected = 'selected';
            }
        }
    }
}

function convertDate(inputFormat) {
    function pad(s) { return (s < 10) ? '0' + s : s; }
    var d = new Date(inputFormat)
    return [pad(d.getDate()), pad(d.getMonth() + 1), d.getFullYear()].join('/')
}