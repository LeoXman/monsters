$ ->
  $("a.add-favorite").on "ajax:success", (e, data, status, xhr) ->
    count = $("#favorites_count").text()
    count = +count + 1
    $(@).find('i').removeClass('fa-heart-o')
    $(@).find('i').addClass('fa-heart')
    $("#favorites_count").text(count)
    $("#alert-success strong").text("Добавлен в избранное")
    $("#alert-success").show()
$ ->
  $("a.add-like").on "ajax:success", (e, data, status, xhr) ->
    $(@).find('i').removeClass('fa-heart-o')
    $(@).find('i').addClass('fa-heart')
    $("#alert-success strong").text("Успешно проголосовали")
    $("#alert-success").show()
  $("a.add-like").on "ajax:error", (e, xhr, status, error) ->
    $(@).find('i').removeClass('fa-heart')
    $(@).find('i').addClass('fa-heart-o')
