function getUserLanguage()
{
    var locale = (navigator.userLanguage == undefined) ? navigator.language : navigator.userLanguage;
    var locale_str = locale.toLowerCase().split('-');

    return locale_str[0];
}

$(document).ready(function() {
    $("#writing_writing_date").datepicker($.datepicker.regional[getUserLanguage()]);
});
