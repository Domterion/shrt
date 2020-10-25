"use strict";

$("#add").on("submit", function (e) {
  e.preventDefault();
  var data = new FormData(this);
  var object = {
    "slug": data.get("slug").length > 0 ? data.get("slug") : null,
    "url": data.get("url").length > 0 ? data.get("url") : null
  };
  var json = JSON.stringify(object);
  $.ajax({
    type: "POST",
    url: "/url",
    contentType: "application/json",
    data: json,
    complete: function complete(xhr, text) {
      var code = xhr.status;

      if (code == 409) {
        $("#status").append("<div class=\"alert alert-danger alert-dismissible fade show\" role=\"alert\">\n  <strong>That slug is already registered... please try again.</strong>\n  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">\n    <span aria-hidden=\"true\">&times;</span>\n  </button>\n</div>");
        return;
      }

      if (code == 400) {
        $("#status").append("<div class=\"alert alert-danger alert-dismissible fade show\" role=\"alert\">\n  <strong>Invalid data, please make sure you meet all requirements listed under each field.</strong>\n  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">\n    <span aria-hidden=\"true\">&times;</span>\n  </button>\n</div>");
        return;
      }

      var parsed = JSON.parse(xhr.responseText);
      $("#status").append("<div class=\"alert alert-success alert-dismissible fade show\" role=\"alert\">\n  <strong>".concat(window.location.hostname, "/").concat(parsed["slug"], " now redirects to ").concat(parsed["url"], "</strong>\n  <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\">\n    <span aria-hidden=\"true\">&times;</span>\n  </button>\n</div>"));
    }
  });
});