library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity layer_ctl is Generic (
            CTL_SZE : integer := 4;
            LY_ADDR_SZE :   integer :=  3;   
            LAYER_SZE   :   integer :=  8;
            ND_ADDR_SZE : integer := 3;
            NODE_SZE : integer := 8
);
Port (
            LAYER_CTL : IN STD_LOGIC_VECTOR(CTL_SZE - 1 downto 0);
            LAYER : IN STD_LOGIC_VECTOR(LY_ADDR_SZE - 1 downto 0);
            NODE : IN STD_LOGIC_VECTOR(ND_ADDR_SZE - 1 downto 0);
);
end layer_ctl;

architecture Behavioral of layer_ctl is

begin


end Behavioral;
