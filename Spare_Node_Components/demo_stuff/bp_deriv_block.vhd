library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- computes the derivative of the sigmoid function to be used in error caclulation

entity bp_deriv_block is Port (
            D_IN : IN SIGNED(15 downto 0);
            D_OUT : OUT SIGNED(15 downto 0));
end bp_deriv_block;

architecture Behavioral of bp_deriv_block is

SIGNAL diff : SIGNED(15 downto 0);
SIGNAL product : SIGNED(31 downto 0);
SIGNAL product_trunc : SIGNED(15 downto 0);

begin
--inversion using symmetric property of sigmoid function
diff <= x"1000" - D_IN;
--multiplication
product <= D_IN * diff;
--truncation
product_trunc <= product(31) & product(26 downto 12);
D_OUT <= product_trunc;

end Behavioral;
