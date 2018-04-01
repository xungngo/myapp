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
        limit: 10,
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
			startImageRenderer: true,
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
		dragDrop: {
			container: '.fileuploader-thumbnails-input'
		},
		onRemove: function(item) {
			$.post('delete_image', {
				image_id: item.data.id
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
                        image_id: item.data.id,
                        index: item.index
                    });
                });
                
                $.post('sort_image', {
                    _list: JSON.stringify(_list)
                });
			}
		},
	});
});