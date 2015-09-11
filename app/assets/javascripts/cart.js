function update_shipping(cost) {
  $('#shipping-cost').html(cost);
  calculate_total_cost();
}

function calculate_total_cost(){
  var shipping = parseFloat(document.getElementById("shipping-cost").innerHTML) || 0;
  var subTotal = parseFloat(document.getElementById("subtotal-cost").innerHTML) || 0;
  var total = subTotal + shipping;
  $('#total-cost').html(total);
}
