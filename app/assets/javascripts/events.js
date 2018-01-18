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
	alert($(this).periodpicker('valueStringStrong'));
});
