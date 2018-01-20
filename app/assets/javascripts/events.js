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
    var val_string = $(this).periodpicker('valueString');
    var starttime_name_id = 'starttime_'+val_string.replace(/ /g, '');
    var endtime_name_id = 'endtime_'+val_string.replace(/ /g, '');
    if ($('#'+starttime_name_id).length == 0) {
        var c = $('#tr_clone:first').clone(true);
            c.css('visibility', 'visible'); // show
            c.attr('id',''); // remove dup id
            c.find('label').html(val_string);
            c.find('.starttime').attr('name',starttime_name_id);
            c.find('.starttime').attr('id',starttime_name_id);
            c.find('.endtime').attr('name',endtime_name_id);
            c.find('.endtime').attr('id',endtime_name_id);
        $('#tr_clone').before(c);
        $('#'+starttime_name_id).timepickeralone({hours: true, minutes: true, ampm: true, inputFormat: 'h:mm a'});
        $('#'+endtime_name_id).timepickeralone({hours: true, minutes: true, ampm: true, inputFormat: 'h:mm a'});
    };
});

$('.btnDel').click(function() {
    if (confirm('continue delete?')) {
        $(this).closest('.tr_clone').remove(); //id is gone, use class
    }
});
