// myckeditor.js
function chkUpload(){
	CKEDITOR.replace('content',{
		width:'80%',
		height:'350px',
		filebrowserImageUploadUrl : 'study.kosta?cmd=board&subcmd=ckBoard'
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