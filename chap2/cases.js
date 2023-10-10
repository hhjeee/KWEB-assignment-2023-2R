const factorial = (number) => {
  return number ? number * factorial(number - 1) : 1;
};
const permutation = (n, r) => factorial(n) / factorial(n - r);
const combination = (n, r) => factorial(n) / (factorial(n - r) * factorial(r));
const multiPermutation = (n, r) => n ** r;
const multiCombination = (n, r) => combination(n + r - 1, r);

module.exports = {
  factorial,
  permutation,
  combination,
  multiPermutation,
  multiCombination,
};
