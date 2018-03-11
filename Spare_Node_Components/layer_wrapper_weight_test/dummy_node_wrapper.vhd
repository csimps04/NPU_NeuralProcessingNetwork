

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dummy_node_wrapper is Generic (
            CTL_SZE : integer := 4;
            LY_ADDR_SZE :   integer :=  3;   
            LAYER_SZE   :   integer :=  8
);
Port (
            CLK : IN STD_LOGIC;
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
            WIN_0 : IN SIGNED(15 downto 0);
            WIN_1 : IN SIGNED(15 downto 0);
            WIN_2 : IN SIGNED(15 downto 0);
            WIN_3 : IN SIGNED(15 downto 0);
            WIN_4 : IN SIGNED(15 downto 0);
            WIN_5 : IN SIGNED(15 downto 0);
            WIN_6 : IN SIGNED(15 downto 0);
            WIN_7 : IN SIGNED(15 downto 0);
            OUT_0 : OUT SIGNED(15 downto 0);
            OUT_1 : OUT SIGNED(15 downto 0);
            OUT_2 : OUT SIGNED(15 downto 0);
            OUT_3 : OUT SIGNED(15 downto 0);
            OUT_4 : OUT SIGNED(15 downto 0);
            OUT_5 : OUT SIGNED(15 downto 0);
            OUT_6 : OUT SIGNED(15 downto 0);
            OUT_7 : OUT SIGNED(15 downto 0);
            WOUT_0 : OUT SIGNED(15 downto 0);
            WOUT_1 : OUT SIGNED(15 downto 0);
            WOUT_2 : OUT SIGNED(15 downto 0);
            WOUT_3 : OUT SIGNED(15 downto 0);
            WOUT_4 : OUT SIGNED(15 downto 0);
            WOUT_5 : OUT SIGNED(15 downto 0);
            WOUT_6 : OUT SIGNED(15 downto 0);
            WOUT_7 : OUT SIGNED(15 downto 0)
);
end dummy_node_wrapper;

architecture Behavioral of dummy_node_wrapper is

component weight_cache is
    Generic (
            LY_ADDR_SZE :   integer :=  3;   
            LAYER_SZE   :   integer :=  10
    );

    Port (
            clk         :   in  std_logic;
            WE_lay      :   in  std_logic;
            reset       :   in  std_logic;
            layer_sel_in   :   in  std_logic_vector(LY_ADDR_SZE - 1 downto 0);
            layer_sel_out   :   in  std_logic_vector(LY_ADDR_SZE - 1 downto 0);
            wt_in_0     :   in  signed(15 downto 0);
            wt_in_1     :   in  signed(15 downto 0);
            wt_in_2     :   in  signed(15 downto 0);
            wt_in_3     :   in  signed(15 downto 0);
            wt_in_4     :   in  signed(15 downto 0);
            wt_in_5     :   in  signed(15 downto 0);
            wt_in_6     :   in  signed(15 downto 0);
            wt_in_7     :   in  signed(15 downto 0);
            wt_out_0    :   out signed(15 downto 0);
            wt_out_1    :   out signed(15 downto 0);
            wt_out_2    :   out signed(15 downto 0);
            wt_out_3    :   out signed(15 downto 0);
            wt_out_4    :   out signed(15 downto 0);
            wt_out_5    :   out signed(15 downto 0);
            wt_out_6    :   out signed(15 downto 0);
            wt_out_7    :   out signed(15 downto 0)
     );
end component;

begin

wght_cache : weight_cache Generic Map (
            LY_ADDR_SZE => LY_ADDR_SZE,
            LAYER_SZE => LAYER_SZE
)
Port Map (
        clk => CLK,
        WE_lay => CTL(0),
        reset => '0',
        layer_sel_in => LAYER,
        layer_sel_out => LAYER,
        wt_in_0 => WIN_0,
        wt_in_1 => WIN_1,
        wt_in_2 => WIN_2,
        wt_in_3 => WIN_3,
        wt_in_4 => WIN_4,
        wt_in_5 => WIN_5,
        wt_in_6 => WIN_6,
        wt_in_7 => WIN_7,
        wt_out_0 => WOUT_0,
        wt_out_1 => WOUT_1,
        wt_out_2 => WOUT_2,
        wt_out_3 => WOUT_3,
        wt_out_4 => WOUT_4,
        wt_out_5 => WOUT_5,
        wt_out_6 => WOUT_6,
        wt_out_7 => WOUT_7
 );


end Behavioral;
