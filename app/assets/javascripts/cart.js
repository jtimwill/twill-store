function update_shipping(shipping) {
  var dollarShipping = "$".concat(shipping);
  $('#shipping-cost').html(dollarShipping);
  calculate_total_cost(shipping);
}

function calculate_total_cost(shipping){
  var subTotal = document.getElementById("subtotal-cost").innerHTML
  var splitTotal = subTotal.split("$")
  var floatTotal = parseFloat(splitTotal[1]) || 0;
  var total = floatTotal + shipping ;
  var dollarString = total.toString();
  var finalString = "$".concat(dollarString);
  $('#total-cost').html(finalString);
}
