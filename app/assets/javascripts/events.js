var ppToday = new Date();
var ppDD = ppToday.getDate();
var ppMM = ppToday.getMonth()+1; //January is 0!

var ppYYYY = ppToday.getFullYear();
if(ppDD<10){
    ppDD='0'+ppDD;
} 
if(ppMM<10){
    ppMM='0'+ppMM;
} 
var pickerMinDate = ppMM+'/'+ppDD+'/'+ppYYYY;
var ppYYYY = ppYYYY+1;
var pickerMaxDate = ppMM+'/'+ppDD+'/'+ppYYYY;
var ppYear = ppToday.getFullYear();
var ppYearsPeriod = [ppYear-1, ppYear+1]

$('#event_start').periodpicker({
    inline: true,
    norange: true,
    cells: [1, 1],
    okButton: true,
    resizeButton: false,
    formatDate: 'MM/DD/YYYY',
    dayOfWeekStart: 7,
    weekEnds: [6,7],
    minDate: pickerMinDate,
    maxDate: pickerMaxDate,
    yearsPeriod: ppYearsPeriod
});


$('#event_start').on('change', function () {
    var calVal = $(this).periodpicker('valueString');
    var nameId = calVal.replace(/ /g, '');
    var c = $('.clonedInput:first').clone(true);
        c.children(':text').attr('name',nameId);
        c.children(':text').attr('id',nameId);
        c.children('label').html(calVal);
    $('#timediv').before(c);
    $('#'+nameId).timepickeralone({
        hours: true,
        minutes: true,
        ampm: true
    });
});

$('.btnDel').click(function() {
    if (confirm('continue delete?')) {
        $(this).closest('.clonedInput').remove();
    }
});

/*
function createTimeDiv(v){
    //alert(v);
    var tmpDiv = '<div id="'+v+'"/>';
    var tmpDivId = '#'+v;
    $('#timediv').append($(tmpDiv));
    $('<a href="#" id="close">remove</a>').appendTo(tmpDivId);   
    $('<div id="box-results"><p>you need to add the click handler on #close after you insert the element into the document.</p></div>').appendTo(tmpDivId);
    $('#close').bind('click', function ()
    {
    $(tmpDivId).remove();
    return false;
    });
};
*/
