window.addEventListener('load', function(){

  const PriceInput = document.getElementById('item-price');
  const SalesFee = document.getElementById('add-tax-price');
  const SalesProfit = document.getElementById('profit');

  PriceInput.addEventListener('input', function(){
    const InputValue = PriceInput.value;
    const SellingPrice = PriceInput.value;
    SalesFee.innerHTML = Math.floor(SellingPrice * 0.10);
    SalesProfit.innerHTML = Math.floor(SellingPrice * 0.90);
  })
})