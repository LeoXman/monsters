var app = angular.module('single-page-mod', []);

app.controller("CommentsCtrl", function($scope) {
  $scope.word_count = function(){
    var input = $('#comment_text').val().length;
    $scope.comment_words_count = input
    if (input > 20) {
      word_count_warning()
    }
    if (input < 20) {
      word_count_valid(input)
    }
  };
  word_count_warning = function(){
    $('.count-words').css("color", "#f44336");
    $('.count-words').text("Слишком много символов!")
  };
  word_count_valid = function(input){
    $('.count-words').css("color", "#665959");
    $('.count-words').text("Колличество символов: " + input)
  };
});
