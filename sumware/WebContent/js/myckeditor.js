// myckeditor.js
function chkUpload(){
	CKEDITOR.replace('bcont',{
		width:'80%',
		height:'350px',
		filebrowserImageUploadUrl : 'sumware?model=board&submod=ckBoard'
	});
	CKEDITOR.on('dialogDefinition', function(ev){
		var dialogName = ev.data.name;
		var dialogDefinition = ev.data.definition;
		switch(dialogName){
		case 'image' : // Image Properties dialog
			// dialogDefinition.removeContents('info');
			dialogDefinition.removeContents('Link');
			dialogDefinition.removeContents('advanced');
			break;
		}
	});
}