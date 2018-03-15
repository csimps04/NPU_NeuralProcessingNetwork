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
            CLK : IN STD_LOGIC;
            LAYER_CTL : IN STD_LOGIC_VECTOR(CTL_SZE - 1 downto 0);
            LAYER : IN STD_LOGIC_VECTOR(LY_ADDR_SZE - 1 downto 0);
            NODE : IN STD_LOGIC_VECTOR(ND_ADDR_SZE - 1 downto 0);
            NODE0_CTL : OUT STD_LOGIC_VECTOR(CTL_SZE - 1 downto 0);
            NODE1_CTL : OUT STD_LOGIC_VECTOR(CTL_SZE - 1 downto 0);
            NODE2_CTL : OUT STD_LOGIC_VECTOR(CTL_SZE - 1 downto 0);
            NODE3_CTL : OUT STD_LOGIC_VECTOR(CTL_SZE - 1 downto 0);
            NODE4_CTL : OUT STD_LOGIC_VECTOR(CTL_SZE - 1 downto 0);
            NODE5_CTL : OUT STD_LOGIC_VECTOR(CTL_SZE - 1 downto 0);
            NODE6_CTL : OUT STD_LOGIC_VECTOR(CTL_SZE - 1 downto 0);
            NODE7_CTL : OUT STD_LOGIC_VECTOR(CTL_SZE - 1 downto 0);
            LAYER_IN_SEL : OUT STD_LOGIC_VECTOR(1 downto 0);
            LAYER_WIN_SEL : OUT STD_LOGIC_VECTOR(1 downto 0);
            LAYER_OUT_SEL : OUT STD_LOGIC_VECTOR(1 downto 0);
            LAYER_WOUT_SEL : OUT STD_LOGIC_VECTOR(1 downto 0);
);
end layer_ctl;

architecture Behavioral of layer_ctl is

begin

process (CLK, LAYER_CTL, LAYER, NODE) begin

  if(rising_edge(CLK)) then
    if(LAYER_CTL = x"0") then --read weight
      LAYER_IN_SEL <= "00";
      LAYER_WIN_SEL <= "00";
    elsif(LAYER_CTL = x"1") then -- load wieght
      LAYER_IN_SEL <= "00";
      LAYER_WIN_SEL <= "00";
    elsif(LAYER_CTL = x"2") then
      LAYER_IN_SEL <= "00";
      LAYER_WIN_SEL <= "00";
    else
      LAYER_IN_SEL <= "00";
      LAYER_WIN_SEL <= "00";
    end if;
  end if;

end process;


end Behavioral;
