library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity layer_ctl_dec is Generic (
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
            LAYER_WIN_SEL : OUT STD_LOGIC_VECTOR(2 downto 0);
            LAYER_OUT_SEL : OUT STD_LOGIC_VECTOR(1 downto 0);
            LAYER_WOUT_SEL : OUT STD_LOGIC_VECTOR(2 downto 0)
);
end layer_ctl_dec;

architecture Behavioral of layer_ctl_dec is

begin

process (CLK, LAYER_CTL, LAYER, NODE) begin

  if(rising_edge(CLK)) then
    if(LAYER_CTL = x"0") then --read weight
        LAYER_IN_SEL <= "00";
        LAYER_WIN_SEL <= "00";
        LAYER_OUT_SEL <= "00";
        LAYER_WOUT_SEL <= "000";
        NODE0_CTL <= x"0";
        NODE1_CTL <= x"0";
        NODE2_CTL <= x"0";
        NODE3_CTL <= x"0";
        NODE4_CTL <= x"0";
        NODE5_CTL <= x"0";
        NODE6_CTL <= x"0";
        NODE7_CTL <= x"0";
        LAYER_WIN_SEL <= NODE;
    elsif(LAYER_CTL = x"1") then -- load wieght
        LAYER_IN_SEL <= "00";
        LAYER_WIN_SEL <= "00";
        LAYER_OUT_SEL <= "00";
        LAYER_WOUT_SEL <= "000";
        NODE0_CTL <= x"0";
        NODE1_CTL <= x"0";
        NODE2_CTL <= x"0";
        NODE3_CTL <= x"0";
        NODE4_CTL <= x"0";
        NODE5_CTL <= x"0";
        NODE6_CTL <= x"0";
        NODE7_CTL <= x"0";
        if NODE = "000" then
        NODE0_CTL <= x"1";
        elsif NODE = "001" then
        NODE1_CTL <= x"1";
        elsif NODE = "010" then
        NODE2_CTL <= x"1";
        elsif NODE = "011" then
        NODE3_CTL <= x"1";
        elsif NODE = "100" then
        NODE4_CTL <= x"1";
        elsif NODE = "101" then
        NODE5_CTL <= x"1";
        elsif NODE = "110" then
        NODE6_CTL <= x"1";
        elsif NODE = "111" then
        NODE7_CTL <= x"1";
        end if;
    else
        LAYER_IN_SEL <= "00";
        LAYER_WIN_SEL <= "00";
        LAYER_OUT_SEL <= "00";
        LAYER_WOUT_SEL <= "000";
        NODE0_CTL <= x"0";
        NODE1_CTL <= x"0";
        NODE2_CTL <= x"0";
        NODE3_CTL <= x"0";
        NODE4_CTL <= x"0";
        NODE5_CTL <= x"0";
        NODE6_CTL <= x"0";
        NODE7_CTL <= x"0";
        LAYER_WIN_SEL <= NODE;
    end if;
  end if;

end process;


end Behavioral;
