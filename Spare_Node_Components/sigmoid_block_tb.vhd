library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity sigmoid_block_tb is
--  Port ( );
end sigmoid_block_tb;

architecture Behavioral of sigmoid_block_tb is

component sigmoid_block is Port (
                                input : IN SIGNED(35 downto 0);
                                sigmoid: OUT SIGNED(15 downto 0));
end component;

SIGNAL input_sig : SIGNED(35 downto 0) := x"000000000";
SIGNAL sigmoid_sig : SIGNED(15 downto 0);

begin

uut : sigmoid_block PORT MAP(input => input_sig, sigmoid => sigmoid_sig);

test : process begin
wait for 10 ns;
input_sig <= input_sig + x"000004000";

end process test;

end Behavioral;
