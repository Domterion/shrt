$("#add").on("submit", function (e) {
    e.preventDefault();
    const data = new FormData(this);

    var object = {
        "slug": data.get("slug").length > 0 ? data.get("slug") : null,
        "url": data.get("url").length > 0 ? data.get("url") : null,
    };

    var json = JSON.stringify(object);

    $.ajax({
        type: "POST",
        url: "/url",
        contentType: "application/json",
        data: json,
        complete: function (xhr, text) {
            const code = xhr.status
            if (code == 409) {
                                $("#status").append(`<div class="alert alert-danger alert-dismissible fade show" role="alert">
  <strong>That slug is already registered... please try again.</strong>
  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
</div>`)
                return
            }
                

            if (code == 400) {
                $("#status").append(`<div class="alert alert-danger alert-dismissible fade show" role="alert">
  <strong>Invalid data, please make sure you meet all requirements listed under each field.</strong>
  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
</div>`)
                return
            }
            let parsed = JSON.parse(xhr.responseText)
            $("#status").append(`<div class="alert alert-success alert-dismissible fade show" role="alert">
  <strong>${window.location.hostname}/${parsed["slug"]} now redirects to ${parsed["url"]}</strong>
  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
</div>`)

        }
    });
});