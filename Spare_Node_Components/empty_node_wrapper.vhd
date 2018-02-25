library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity empty_node_wrapper is
Generic (
            CTL_SZE : integer := 4;
            LY_ADDR_SZE :   integer :=  3;   
            LAYER_SZE   :   integer :=  8
);
Port (
            CTL : IN STD_LOGIC_VECTOR(CTL_SZE - 1 downto 0);
            LAYER : IN STD_LOGIC_VECTOR(LY_ADDR_SZE - 1 downto 0);
            IN_0 : IN SIGNED(15 downto 0);
            IN_1 : IN SIGNED(15 downto 0);
            IN_2 : IN SIGNED(15 downto 0);
            IN_3 : IN SIGNED(15 downto 0);
            IN_4 : IN SIGNED(15 downto 0);
            IN_5 : IN SIGNED(15 downto 0);
            IN_6 : IN SIGNED(15 downto 0);
            IN_7 : IN SIGNED(15 downto 0);
            OUT_0 : OUT SIGNED(15 downto 0);
            OUT_1 : OUT SIGNED(15 downto 0);
            OUT_2 : OUT SIGNED(15 downto 0);
            OUT_3 : OUT SIGNED(15 downto 0);
            OUT_4 : OUT SIGNED(15 downto 0);
            OUT_5 : OUT SIGNED(15 downto 0);
            OUT_6 : OUT SIGNED(15 downto 0);
            OUT_7 : OUT SIGNED(15 downto 0));
end empty_node_wrapper;

architecture Behavioral of empty_node_wrapper is

begin

end Behavioral;
