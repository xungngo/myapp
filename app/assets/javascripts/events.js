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
    var date_array = $(this).periodpicker('valueString').split(' ');
    var date_string = date_array[1] + ' ' + date_array[0] + ', ' + date_array[2];
    var date_id = date_string.replace(/ /g, '_').replace(',', '')
    var starttime_id = 'starttime_'+date_id;
    var endtime_id = 'endtime_'+date_id;
    if ($('#'+starttime_id).length == 0) {
        var c = $('#tr_clone:first').clone(true);
            c.css('visibility', 'visible'); // show
            c.attr('id',''); // remove dup id
            c.find('label').html(date_string);
            c.find('.starttime').attr('name',starttime_id);
            c.find('.starttime').attr('id',starttime_id);
            c.find('.endtime').attr('name',endtime_id);
            c.find('.endtime').attr('id',endtime_id);
        $('#tr_clone').before(c);
        $('#'+starttime_id).timepickeralone({hours: true, minutes: true, ampm: true, inputFormat: 'h:mm a', defaultTime:''});
        $('#'+endtime_id).timepickeralone({hours: true, minutes: true, ampm: true, inputFormat: 'h:mm a', defaultTime:''});
    };
});

$('.btnDel').click(function() {
    if (confirm('continue delete?')) {
        $(this).closest('.tr_clone').remove(); //id is gone, use class
    }
});
