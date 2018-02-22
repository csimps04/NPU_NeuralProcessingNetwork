library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity node_wrapper_tb is
--Port ();
end node_wrapper_tb;

architecture Behavioral of node_wrapper_tb is

component node_wrapper is Port (
            IN_0 : IN SIGNED(15 downto 0);
            IN_1 : IN SIGNED(15 downto 0);
            IN_2 : IN SIGNED(15 downto 0);
            IN_3 : IN SIGNED(15 downto 0);
            IN_4 : IN SIGNED(15 downto 0);
            IN_5 : IN SIGNED(15 downto 0);
            IN_6 : IN SIGNED(15 downto 0);
            IN_7 : IN SIGNED(15 downto 0);
            W_0 : IN SIGNED(15 downto 0);
            W_1 : IN SIGNED(15 downto 0);
            W_2 : IN SIGNED(15 downto 0);
            W_3 : IN SIGNED(15 downto 0);
            W_4 : IN SIGNED(15 downto 0);
            W_5 : IN SIGNED(15 downto 0);
            W_6 : IN SIGNED(15 downto 0);
            W_7 : IN SIGNED(15 downto 0);
            OUT_0 : OUT SIGNED(15 downto 0));
end component;

SIGNAL in_0_sig : SIGNED(15 downto 0) := x"1000";
SIGNAL in_1_sig : SIGNED(15 downto 0) := x"0000";
SIGNAL in_2_sig : SIGNED(15 downto 0) := x"0000";
SIGNAL in_3_sig : SIGNED(15 downto 0) := x"0000";
SIGNAL in_4_sig : SIGNED(15 downto 0) := x"0000";
SIGNAL in_5_sig : SIGNED(15 downto 0) := x"0000";
SIGNAL in_6_sig : SIGNED(15 downto 0) := x"0000";
SIGNAL in_7_sig : SIGNED(15 downto 0) := x"0000";

SIGNAL w_0_sig : SIGNED(15 downto 0) := x"1000";
SIGNAL w_1_sig : SIGNED(15 downto 0) := x"0000";
SIGNAL w_2_sig : SIGNED(15 downto 0) := x"0000";
SIGNAL w_3_sig : SIGNED(15 downto 0) := x"0000";
SIGNAL w_4_sig : SIGNED(15 downto 0) := x"0000";
SIGNAL w_5_sig : SIGNED(15 downto 0) := x"0000";
SIGNAL w_6_sig : SIGNED(15 downto 0) := x"0000";
SIGNAL w_7_sig : SIGNED(15 downto 0) := x"0000";

SIGNAL out_0_sig : SIGNED(15 downto 0);

begin

uut : node_wrapper Port Map(
            IN_0 => in_0_sig,
            IN_1 => in_1_sig,
            IN_2 => in_2_sig,
            IN_3 => in_3_sig,
            IN_4 => in_4_sig,
            IN_5 => in_5_sig,
            IN_6 => in_6_sig,
            IN_7 => in_7_sig,
            W_0 => w_0_sig,
            W_1 => w_1_sig,
            W_2 => w_2_sig,
            W_3 => w_3_sig,
            W_4 => w_4_sig,
            W_5 => w_5_sig,
            W_6 => w_6_sig,
            W_7 => w_7_sig,
            OUT_0 => out_0_sig
);

test: process begin
wait for 10 ns;
in_0_sig <= x"0000";
in_1_sig <= x"0000";
in_2_sig <= x"0000";
in_3_sig <= x"0000";
in_4_sig <= x"0000";
in_5_sig <= x"0000";
in_6_sig <= x"0000";
in_7_sig <= x"0000";

w_0_sig <= x"0000";
w_1_sig <= x"0000";
w_2_sig <= x"0000";
w_3_sig <= x"0000";
w_4_sig <= x"0000";
w_5_sig <= x"0000";
w_6_sig <= x"0000";
w_7_sig <= x"0000";

end process test;

end Behavioral;
