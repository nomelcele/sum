/**
 * notification
 */
var notification = window.Notification || window.mozNotification || window.webkitNotification;
if ('undefined' === typeof notification)
    alert('Web notification not supported');
else
    notification.requestPermission(function(permission){});

// A function handler
function Notify(titleText, bodyText)
{
	console.log("Notify실행");
    if ('undefined' === typeof notification){
    	console.log("Notify지원안됨");
    	return false;
	}//Not supported....
    var noty = new notification( 
        titleText, {
            body: bodyText,
            dir: 'auto', // or ltr, rtl
            lang: 'EN', //lang used within the notification.
            tag: 'notificationPopup', //An element ID to get/set the content
            icon: '' //The URL of an image to be used as an icon
        }
    );
    noty.onclick = function () {
        console.log('notification.Click');
    };
    noty.onerror = function () {
        console.log('notification.Error');
    };
    noty.onshow = function () {
        console.log('notification.Show');
    };
    noty.onclose = function () {
        console.log('notification.Close');
    };
    return true;
}