$(document).ready(function(){
  $('.datepicker').datepicker();
});

function stripe_table(table)
{
  $(table).find("tr").each(function(index, element) {
    $(element).removeClass("odd even")
    
    if(index % 2 == 0)
      $(element).addClass("odd");
    else
      $(element).addClass("even");
  });
}
