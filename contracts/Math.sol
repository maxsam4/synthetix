pragma solidity 0.4.25;

import "./SafeDecimalMath.sol";

contract Math {
    using SafeMath for uint;
    using SafeDecimalMath for uint;

    /**
    * @dev Uses "exponentiation by squaring" algorithm where cost is 0(logN)
    * vs 0(N) for naive repeated multiplication. 
    * Calculates x^n with x as fixed-point and n as regular unsigned int.
    * Calculates to 18 digits of precision with SafeDecimalMath.unit()
    */
    function powDecimal(uint x, uint n)
        internal
        pure
        returns (uint)
    {
        // https://mpark.github.io/programming/2014/08/18/exponentiation-by-squaring/
        // double exp(double x, int n) {
        //  if (n < 0) return 1 / exp(x, -n);
        //  double result = 1;
        //  while (n > 0) {
        //      if (n % 2 == 1) result *= x;
        //      x *= x;
        //      n /= 2;
        //    }  // while
        //  return result;
        // }

        uint result = SafeDecimalMath.unit();
        while (n > 0) {
            if (n % 2 != 0) {
                result = result.multiplyDecimal(x);
            }
            x = x.multiplyDecimal(x);
            n /= 2;
        }
        return result;
    }
}
    