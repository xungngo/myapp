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
var cloned_ct = 1
var eventdate = [];
var starttime = [];
var endtime = [];
$('#event_start').on('change', function() {
    var date_array = $(this).periodpicker('valueStringStrong').split('-');
    var date_string = date_array[0];
    var date_id = date_string.replace(/\//g, '_');
    var starttime_id = 'starttime_'+date_id;
    var endtime_id = 'endtime_'+date_id;
    var eventdate_id = 'eventdate_'+date_id;
    if ($('#'+starttime_id).length == 0 && cloned_ct <= 14) {
        createEventDate(date_string, eventdate_id, starttime_id, endtime_id, '9:00 am', '5:00 pm');
    };
    sortTableColumn('event_date_table',1);
    countRows();
});

function createEventDate(date_string, eventdate_id, starttime_id, endtime_id, starttime_val, endtime_val) {
    cloned_obj = $('#tr_clone:first').clone(true);
    cloned_obj.css('visibility', 'visible'); // show
    cloned_obj.attr('id',''); // remove dup id
    cloned_obj.find('.dateshow').html(date_string);
    cloned_obj.find('.starttime').attr('id',starttime_id);
    cloned_obj.find('.endtime').attr('id',endtime_id);
    cloned_obj.find('.eventdate').attr('id',eventdate_id);
    cloned_obj.find('.eventdate').attr('value',date_string);
    $('#tr_clone').before(cloned_obj);
    var starttime_picker = $('#'+starttime_id).timepickeralone({hours: true, minutes: true, ampm: true, inputFormat: 'h:mm a', defaultTime: starttime_val, steps:[1,5,2,1], onHide: function($input){setMinTime($input.val(), $input.attr('id'))}});
    var endtime_picker = $('#'+endtime_id).timepickeralone({hours: true, minutes: true, ampm: true, inputFormat: 'h:mm a', defaultTime: endtime_val, steps:[1,5,2,1], onHide: function($input){setMaxTime($input.val(), $input.attr('id'))}});
    cloned_ct = $('.tr_clone').length;
};

$('.btnDel').click(function() {
    //if (confirm('continue delete?')) {
        $(this).closest('.tr_clone').remove(); //id is gone, use class
        countRows();
        cloned_ct = 1;
    //}
});

function setMinTime(v, id) {
    endtime_id = id.replace('starttime', 'endtime');
    $('#'+endtime_id).timepickeralone('setMin', v);
};

function setMaxTime(v, id) {
    starttime_id = id.replace('endtime', 'starttime');
    $('#'+starttime_id).timepickeralone('setMax', v);
};

function countRows() {
    var tbody = document.getElementById('event_date_tbody'),
        rows = tbody.rows,
        text = 'textContent' in document ? 'textContent' : 'innerText';
        //console.log(text);
    for (var i = 0, len = rows.length; i < len; i++){
    rows[i].children[0][text] = i+1 + ':';
    };
};

function sortTableColumn(tb,col) {
    var table, rows, switching, i, x, y, shouldSwitch;
    table = document.getElementById(tb);
    switching = true;
    // Make a loop that will continue until no switching has been done:
    while (switching) {
      //start by saying: no switching is done:
      switching = false;
      rows = table.getElementsByTagName("TR");
      // Loop through all table rows (except the first, which contains table headers):
      for (i = 1; i < (rows.length - 1); i++) {
        //start by saying there should be no switching:
        shouldSwitch = false;
        // Get the two elements you want to compare, one from current row and one from the next:
        x = rows[i].getElementsByTagName("TD")[col];
        y = rows[i + 1].getElementsByTagName("TD")[col];
        //check if the two rows should switch place:
        if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
          //if so, mark as a switch and break the loop:
          shouldSwitch = true;
          break;
        }
      }
      if (shouldSwitch) {
        // If a switch has been marked, make the switch and mark that a switch has been done:
        rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
        switching = true;
      }
    }
  };

  //update
  var evt_json = JSON.parse($('#current_eventdates').val());
  for (i in evt_json) {
    var date_string = evt_json[i].eventdate.split('-');
    var date_string = date_string[1]+'/'+date_string[2]+'/'+date_string[0]
    var date_id = date_string.replace(/\//g, '_');
    var starttime_id = 'starttime_'+date_id;
    var endtime_id = 'endtime_'+date_id;
    var eventdate_id = 'eventdate_'+date_id;
    var eventdate_id_id = 'eventdate_id_'+date_id; //update use only
    var starttime_string = evt_json[i].starttime;
    var endtime_string = evt_json[i].endtime;
    if ($('#'+starttime_id).length == 0 && cloned_ct <= 14) {
        createEventDate(date_string, eventdate_id, starttime_id, endtime_id, starttime_string, endtime_string);
        //need to add id for update
        cloned_obj.find('.eventdate_id').attr('id',eventdate_id_id);
        cloned_obj.find('.eventdate_id').attr('value',evt_json[i].id);
        setMinTime(starttime_string, starttime_id);
        setMaxTime(endtime_string, endtime_id);
    };
    sortTableColumn('event_date_table',1);
    countRows();
  };

  //File Uploader
  $(document).ready(function() {
	// enable fileuploader plugin
	$('input[name="images[]"]').fileuploader({
        inputNameBrackets: true,
        extensions: ['jpg', 'jpeg', 'png', 'gif', 'bmp'],
		changeInput: ' ',
		theme: 'thumbnails',
        enableApi: true,
		addMore: true,
		thumbnails: {
			box: '<div class="fileuploader-items">' +
                      '<ul class="fileuploader-items-list">' +
					      '<li class="fileuploader-thumbnails-input"><div class="fileuploader-thumbnails-input-inner">+</div></li>' +
                      '</ul>' +
                  '</div>',
			item: '<li class="fileuploader-item">' +
				       '<div class="fileuploader-item-inner">' +
                           '<div class="thumbnail-holder">${image}</div>' +
                           '<div class="actions-holder">' +
						   	   '<a class="fileuploader-action fileuploader-action-remove" title="${captions.remove}"><i class="remove"></i></a>' +
							   '<span class="fileuploader-action-popup"></span>' +
                           '</div>' +
                       	   '<div class="progress-holder">${progressBar}</div>' +
                       '</div>' +
                   '</li>',
			item2: '<li class="fileuploader-item">' +
				       '<div class="fileuploader-item-inner">' +
                           '<div class="thumbnail-holder">${image}</div>' +
                           '<div class="actions-holder">' +
                               '<a class="fileuploader-action fileuploader-action-sort" title="${captions.sort}"><i></i></a>' +
                               '<a class="fileuploader-action fileuploader-action-remove" title="${captions.remove}"><i class="remove"></i></a>' +
							   '<span class="fileuploader-action-popup"></span>' +
                           '</div>' +
                       '</div>' +
                   '</li>',
			startImageRenderer: false,
			canvasImage: false,
			_selectors: {
				list: '.fileuploader-items-list',
				item: '.fileuploader-item',
				start: '.fileuploader-action-start',
				retry: '.fileuploader-action-retry',
				remove: '.fileuploader-action-remove',
                sorter: '.fileuploader-action-sort'
			},
			onItemShow: function(item, listEl) {
				var plusInput = listEl.find('.fileuploader-thumbnails-input');
				
				plusInput.insertAfter(item.html);
				
				if(item.format == 'image') {
					item.html.find('.fileuploader-item-icon').hide();
				}
			}
		},
		afterRender: function(listEl, parentEl, newInputEl, inputEl) {
			var plusInput = listEl.find('.fileuploader-thumbnails-input'),
				api = $.fileuploader.getInstance(inputEl.get(0));
		
			plusInput.on('click', function() {
				api.open();
			});
		},
		upload: {
			url: 'create_attachments',
            data: null,
            type: 'POST',
            enctype: 'multipart/form-data',
            start: true,
            synchron: true,
            beforeSend: null,
            onSuccess: function(data, item) {
				setTimeout(function() {
                    item.html.find('.fileuploader-action-remove').before('<a class="fileuploader-action fileuploader-action-sort" title="Sort"><i></i></a>');
					item.html.find('.progress-holder').hide();
					item.renderThumbnail();
				}, 400);
            },
            onError: function(item) {
				item.html.find('.progress-holder').hide();
				item.html.find('.fileuploader-item-icon i').text('Failed!');
            },
            onProgress: function(data, item) {
                var progressBar = item.html.find('.progress-holder');
				
                if(progressBar.length > 0) {
                    progressBar.show();
                    progressBar.find('.fileuploader-progressbar .bar').width(data.percentage + "%");
                }
            }
        },
		dragDrop: {
			container: '.fileuploader-thumbnails-input'
		},
		onRemove: function(item) {
			$.post('php/ajax_remove_file.php', {
				file: item.name
			});
		},
        sorter: {
			selectorExclude: null,
			placeholder: '<li class="fileuploader-item fileuploader-sorter-placeholder"><div class="fileuploader-item-inner"></div></li>',
			scrollContainer: window,
			onSort: function(list, listEl, parentEl, newInputEl, inputEl) {
                var api = $.fileuploader.getInstance(inputEl.get(0)),
                    fileList = api.getFileList(),
                    _list = [];
                
                $.each(fileList, function(i, item) {
                    _list.push({
                        name: item.name,
                        index: item.index
                    });
                });
                
                $.post('php/ajax_sort_files.php', {
                    _list: JSON.stringify(_list)
                });
			}
		},
	});
});