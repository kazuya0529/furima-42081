const price = () => {
  const priceInput = document.getElementById("item-price");
  const addtaxInput = document.getElementById("add-tax-price");
  const profitInput = document.getElementById("profit");

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const tax = Math.floor(inputValue * 0.1);
    const profit = inputValue - tax;

    addtaxInput.innerHTML = tax;
    profitInput.innerHTML = profit;
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);