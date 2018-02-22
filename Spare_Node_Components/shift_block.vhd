library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity shift_block is Port (
                D_IN : IN SIGNED(35 downto 0);
                SHIFT : IN UNSIGNED(2 downto 0);
                D_OUT : OUT SIGNED(35 downto 0));
end shift_block;

architecture Behavioral of shift_block is

begin

    D_OUT <= shift_right(D_IN, to_integer(SHIFT));

end Behavioral;