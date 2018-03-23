library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- performs multiplication of an error value and a sigmoid output value to compute new error value

entity bp_multiply_block is Port (
            D_IN0 : IN SIGNED(15 downto 0);
            D_IN1 : IN SIGNED(15 downto 0);
            D_OUT : OUT SIGNED(15 downto 0));
end bp_multiply_block;

architecture Behavioral of bp_multiply_block is

SIGNAL product : SIGNED(31 downto 0);
SIGNAL product_trunc : SIGNED(15 downto 0);

begin

--multiplication
product <= D_IN0 * D_IN1;

--size reduction by truncation
product_trunc <= product(31) & product(26 downto 12);
D_OUT <= product_trunc;

end Behavioral;
