$( document ).ready(function() {
  function sortStudentScores(column, order) {
    var $rows = $('tr').slice(1)
    var $sorted = $rows.sort(function(a, b) {
      var a = $(a).find('td:nth-child(' + column + ')').text(), b = $(b).find('td:nth-child(' + column + ')').text();
      if(order === "asc") {
        return a.localeCompare(b, false, {numeric: true})
      } else {
        return b.localeCompare(a, false, {numeric: true})
      }
    })

    $.each($sorted, function(index, row) {
      $('.student-scores').append(row);
    });
  }

  $('.student-scores th:nth-child(1)').click(function() {sortStudentScores(1, 'asc')})
  $('.student-scores th:nth-child(2)').click(function() {sortStudentScores(2, 'desc')})
  $('.student-scores th:nth-child(3)').click(function() {sortStudentScores(3, 'desc')})

  $('.hider').click(function() {
    console.log("HIT")
    $('.cohort-form').toggle('slow');
  })
});
