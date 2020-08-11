$.notify.addStyle("metro", {
    html: "<div>" +
    "<div class='image' data-notify-html='image'/>" +
    "<div class='text-wrapper'>" +
    "<div class='title' data-notify-html='title'/>" +
    "<div class='text' data-notify-html='text'/>" +
    "</div>" +
    "</div>",
    classes: {
        default: {
            "color": "#444 !important",
            "background-color": "#f4f4f4",
            "border": "0px solid #ddd"
        },
        error: {
            "color": "#fafafa !important",
            "background-color": "#dd4b39",
            "border": "0px solid #d73925"
        },
        success: {
            "color": "#fafafa !important",
            "background-color": "#00a65a",
            "border": "0px solid #008d4c"
        },
        info: {
            "color": "#fafafa !important",
            "background-color": "#00c0ef",
            "border": "0px solid #00acd6"
        },
        warning: {
            "color": "#fafafa !important",
            "background-color": "#f39c12",
            "border": "0px solid #e08e0b"
        },
        black: {
            "color": "#fafafa !important",
            "background-color": "#444",
            "border": "0px solid #323232"
        },
        white: {
            "background-color": "#e6eaed",
            "border": "0px solid #ddd"
        }
    }
});

$.notify.autoHideNotify = function (style, position, title, text) {
    var icon = "fa fa-adjust";
    if (style == "error") {
        icon = "fa fa-exclamation";
    } else if (style == "warning") {
        icon = "fa fa-warning";
    } else if (style == "success") {
        icon = "fa fa-check";
    } else if (style == "info") {
        icon = "fa fa-question";
    } else {
        icon = "fa fa-adjust";
    }
    $.notify({
        title: title,
        text: text,
        image: "<i class='" + icon + "'></i>"
    }, {
        style: 'metro',
        className: style,
        globalPosition: position,
        showAnimation: "slideDown",
        showDuration: 200,
        hideAnimation: "slideUp",
        hideDuration: 200,
        autoHideDelay: 5000,
        autoHide: true,
        clickToHide: true
    });
}
