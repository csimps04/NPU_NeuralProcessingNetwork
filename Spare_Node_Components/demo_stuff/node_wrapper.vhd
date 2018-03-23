library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--this module is a wrapper containing all pieces of hardware required to control and perform node operation

entity node_wrapper is
Generic (
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
end node_wrapper;

architecture Behavioral of node_wrapper is

component control_decoder is
Generic (
            CTL_SZE : integer := 4;
            LY_ADDR_SZE :   integer :=  3;   
            LAYER_SZE   :   integer :=  8);
Port (
            CTL : IN STD_LOGIC_VECTOR(CTL_SZE - 1 downto 0);
            LAYER : IN STD_LOGIC_VECTOR(LY_ADDR_SZE - 1 downto 0);
            ILSEL : OUT STD_LOGIC_VECTOR(LY_ADDR_SZE - 1 downto 0);
            OLSEL : OUT STD_LOGIC_VECTOR(LY_ADDR_SZE - 1 downto 0);
            WGHT_CACHE_WE : OUT STD_LOGIC;
            WGHT_CACHE_RS : OUT STD_LOGIC;
            WGHT_CACHE_ISEL : OUT STD_LOGIC;
            ERR_CACHE_WE : OUT STD_LOGIC;
            ERR_CACHE_RS : OUT STD_LOGIC;
            OUT_CACHE_WE : OUT STD_LOGIC;
            OUT_CACHE_RS : OUT STD_LOGIC;
            GRAD_CACHE_WE : OUT STD_LOGIC;
            GRAD_CACHE_RS : OUT STD_LOGIC;
            NODE_MODE : OUT STD_LOGIC_VECTOR(1 downto 0);
            NODE_IN_SEL : OUT STD_LOGIC_VECTOR(1 downto 0);
            NODE_WGHT_SEL : OUT STD_LOGIC_VECTOR(1 downto 0);
            OUT_SEL : OUT STD_LOGIC_VECTOR(1 downto 0)
);
end component;

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

component output_cache is
    Generic (
            LY_ADDR_SZE :   integer :=  3;   
            LAYER_SZE   :   integer :=  8
    );
    Port ( 
                CLK         :   in  std_logic;
                WE          :   in  std_logic;
                CLR         :   in  std_logic;
                layer_sel_in   :   in  std_logic_vector(LY_ADDR_SZE - 1 downto 0);
                layer_sel_out   :   in  std_logic_vector(LY_ADDR_SZE - 1 downto 0);
                d_in        :   in  signed(15 downto 0);
                d_out       :   out signed(15 downto 0)
    );
end component;

component node_compute_block is Port (
            MODE : IN STD_LOGIC_VECTOR(1 downto 0);
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
            BPIN_0 : IN SIGNED(15 downto 0);
            BPIN_1 : IN SIGNED(15 downto 0);
            OUT_0 : OUT SIGNED(15 downto 0);
            OUT_1 : OUT SIGNED(15 downto 0);
            OUT_2 : OUT SIGNED(15 downto 0);
            OUT_3 : OUT SIGNED(15 downto 0);
            OUT_4 : OUT SIGNED(15 downto 0);
            OUT_5 : OUT SIGNED(15 downto 0);
            OUT_6 : OUT SIGNED(15 downto 0);
            OUT_7 : OUT SIGNED(15 downto 0));
end component;

type data_bus is array(0 to 7) of SIGNED(15 downto 0);

SIGNAL node_comp_mode_sig : STD_LOGIC_VECTOR(1 downto 0);
SIGNAL node_comp_in_sel : STD_LOGIC_VECTOR(1 downto 0);
SIGNAL node_comp_wght_sel : STD_LOGIC_VECTOR(1 downto 0);
SIGNAL node_comp_bp_sel : STD_LOGIC_VECTOR(1 downto 0);
SIGNAL node_comp_in_bus : data_bus;
SIGNAL node_comp_wght_bus : data_bus;
SIGNAL node_comp_out_bus : data_bus;

SIGNAL out_cache_WE_sig : STD_LOGIC;
SIGNAL out_cache_RS_sig : STD_LOGIC;
SIGNAL out_cache_DOUT_sig : SIGNED(15 downto 0);
SIGNAL out_cache_DIN_sig : SIGNED(15 downto 0);

SIGNAL err_cache_WE_sig : STD_LOGIC;
SIGNAL err_cache_RS_sig : STD_LOGIC;
SIGNAL err_cache_DOUT_sig : SIGNED(15 downto 0);
SIGNAL err_cache_DIN_sig : SIGNED(15 downto 0);

SIGNAL wght_cache_WE_sig : STD_LOGIC;
SIGNAL wght_cache_RS_sig : STD_LOGIC;
SIGNAL wght_cache_in_sel : STD_LOGIC;
SIGNAL wght_cache_din_bus : data_bus;
SIGNAL wght_cache_dout_bus : data_bus;

SIGNAL grad_cache_WE_sig : STD_LOGIC;
SIGNAL grad_cache_RS_sig : STD_LOGIC;
SIGNAL grad_cache_din_bus : data_bus;
SIGNAL grad_cache_dout_bus : data_bus;

SIGNAL node_wrapper_in_bus : data_bus;
SIGNAL node_wrapper_win_bus : data_bus;
SIGNAL node_wrapper_out_bus : data_bus;
SIGNAL node_wrapper_wout_bus : data_bus;

SIGNAL node_wrapper_ILSEL_sig : STD_LOGIC_VECTOR(LY_ADDR_SZE - 1 downto 0);
SIGNAL node_wrapper_OLSEL_sig : STD_LOGIC_VECTOR(LY_ADDR_SZE - 1 downto 0);
SIGNAL node_wrapper_out_sel : STD_LOGIC_VECTOR(1 downto 0) := "00";
SIGNAL node_wrapper_wout_sel : STD_LOGIC_VECTOR(1 downto 0) := "00";

begin

--control signal decoder for the node
ctl_dec : control_decoder Generic Map (
            CTL_SZE => CTL_SZE,
            LY_ADDR_SZE =>  LY_ADDR_SZE,   
            LAYER_SZE =>  LAYER_SZE
)
Port Map(
            CTL => CTL,
            LAYER => LAYER,
            ILSEL => node_wrapper_ILSEL_sig,
            OLSEL => node_wrapper_OLSEL_sig, 
            WGHT_CACHE_WE => wght_cache_WE_sig,
            WGHT_CACHE_RS => wght_cache_RS_sig,
            WGHT_CACHE_ISEL => wght_cache_in_sel,
            ERR_CACHE_WE => err_cache_WE_sig,
            ERR_CACHE_RS => err_cache_RS_sig,
            OUT_CACHE_WE => out_cache_WE_sig,
            OUT_CACHE_RS => out_cache_RS_sig,
            GRAD_CACHE_WE => grad_cache_WE_sig,
            GRAD_CACHE_RS => grad_cache_RS_sig,
            NODE_MODE => node_comp_mode_sig,
            NODE_IN_SEL => node_comp_in_sel,
            NODE_WGHT_SEL => node_comp_wght_sel,
            OUT_SEL => node_wrapper_out_sel
            
);

--node computation block, similar to an ALU
node_comp : node_compute_block Port Map(
            MODE => node_comp_mode_sig,
            IN_0 => node_comp_in_bus(0),
            IN_1 => node_comp_in_bus(1),
            IN_2 => node_comp_in_bus(2),
            IN_3 => node_comp_in_bus(3),
            IN_4 => node_comp_in_bus(4),
            IN_5 => node_comp_in_bus(5),
            IN_6 => node_comp_in_bus(6),
            IN_7 => node_comp_in_bus(7),
            WIN_0 => node_comp_wght_bus(0),
            WIN_1 => node_comp_wght_bus(1),
            WIN_2 => node_comp_wght_bus(2),
            WIN_3 => node_comp_wght_bus(3),
            WIN_4 => node_comp_wght_bus(4),
            WIN_5 => node_comp_wght_bus(5),
            WIN_6 => node_comp_wght_bus(6),
            WIN_7 => node_comp_wght_bus(7),
            BPIN_0 => out_cache_dout_sig,
            BPIN_1 => node_wrapper_in_bus(0),
            OUT_0 => node_comp_out_bus(0),
            OUT_1 => node_comp_out_bus(1),
            OUT_2 => node_comp_out_bus(2),
            OUT_3 => node_comp_out_bus(3),
            OUT_4 => node_comp_out_bus(4),
            OUT_5 => node_comp_out_bus(5),
            OUT_6 => node_comp_out_bus(6),
            OUT_7 => node_comp_out_bus(7)
);

--output cache which contains the output values of previous layers
out_cache : output_cache Generic Map (
            LY_ADDR_SZE => LY_ADDR_SZE,
            LAYER_SZE => LAYER_SZE
)
Port Map (
            CLK => CLK,
            WE => out_cache_WE_sig,
            CLR => out_cache_RS_sig,
            layer_sel_in => node_wrapper_ILSEL_sig,
            layer_sel_out => node_wrapper_OLSEL_sig,
            d_in => out_cache_DIN_sig,
            d_out =>out_cache_DOUT_sig
);

--error cache stores the error for the node
err_cache : output_cache Generic Map (
            LY_ADDR_SZE => LY_ADDR_SZE,
            LAYER_SZE => LAYER_SZE
)
Port Map (
            CLK => CLK,
            WE => err_cache_WE_sig,
            CLR => err_cache_RS_sig,
            layer_sel_in => node_wrapper_ILSEL_sig,
            layer_sel_out => node_wrapper_OLSEL_sig,
            d_in => err_cache_DIN_sig,
            d_out =>err_cache_DOUT_sig
);

--weight cache stores all of the weights for the node
wght_cache : weight_cache Generic Map (
            LY_ADDR_SZE => LY_ADDR_SZE,
            LAYER_SZE => LAYER_SZE
)
Port Map (
        clk => CLK,
        WE_lay => wght_cache_WE_sig,
        reset => wght_cache_RS_sig,
        layer_sel_in => node_wrapper_ILSEL_sig,
        layer_sel_out => node_wrapper_OLSEL_sig,
        wt_in_0 => wght_cache_din_bus(0),
        wt_in_1 => wght_cache_din_bus(1),
        wt_in_2 => wght_cache_din_bus(2),
        wt_in_3 => wght_cache_din_bus(3),
        wt_in_4 => wght_cache_din_bus(4),
        wt_in_5 => wght_cache_din_bus(5),
        wt_in_6 => wght_cache_din_bus(6),
        wt_in_7 => wght_cache_din_bus(7),
        wt_out_0 => wght_cache_dout_bus(0),
        wt_out_1 => wght_cache_dout_bus(1),
        wt_out_2 => wght_cache_dout_bus(2),
        wt_out_3 => wght_cache_dout_bus(3),
        wt_out_4 => wght_cache_dout_bus(4),
        wt_out_5 => wght_cache_dout_bus(5),
        wt_out_6 => wght_cache_dout_bus(6),
        wt_out_7 => wght_cache_dout_bus(7)
 );
 
 --gradient cache stores error function gradients for each weight
 grad_cache : weight_cache Generic Map (
             LY_ADDR_SZE => LY_ADDR_SZE,
             LAYER_SZE => LAYER_SZE
 )
 Port Map (
         clk => CLK,
         WE_lay => grad_cache_WE_sig,
         reset => grad_cache_RS_sig,
         layer_sel_in => node_wrapper_ILSEL_sig,
         layer_sel_out => node_wrapper_OLSEL_sig,
         wt_in_0 => grad_cache_din_bus(0),
         wt_in_1 => grad_cache_din_bus(1),
         wt_in_2 => grad_cache_din_bus(2),
         wt_in_3 => grad_cache_din_bus(3),
         wt_in_4 => grad_cache_din_bus(4),
         wt_in_5 => grad_cache_din_bus(5),
         wt_in_6 => grad_cache_din_bus(6),
         wt_in_7 => grad_cache_din_bus(7),
         wt_out_0 => grad_cache_dout_bus(0),
         wt_out_1 => grad_cache_dout_bus(1),
         wt_out_2 => grad_cache_dout_bus(2),
         wt_out_3 => grad_cache_dout_bus(3),
         wt_out_4 => grad_cache_dout_bus(4),
         wt_out_5 => grad_cache_dout_bus(5),
         wt_out_6 => grad_cache_dout_bus(6),
         wt_out_7 => grad_cache_dout_bus(7)
  );
  
--this process determines what data to put on the OUT bus of the node
out_sel : process(node_wrapper_out_sel, wght_cache_dout_bus, out_cache_dout_sig, node_comp_out_bus) begin
    case node_wrapper_out_sel is
    when "00" => node_wrapper_out_bus <= wght_cache_dout_bus;
    when "01" => node_wrapper_out_bus <= (0 => out_cache_dout_sig, others => (others=>'0'));
    when others => node_wrapper_out_bus <= node_comp_out_bus;
    end case;
end process out_sel;

--this process selects what data is put on the weight cache in bus
wght_cache_in : process(wght_cache_in_sel, node_wrapper_win_bus, node_comp_out_bus) begin
    case wght_cache_in_sel is
        when '0' => wght_cache_din_bus <= node_wrapper_win_bus;
        when others => wght_cache_din_bus <= node_comp_out_bus;
    end case;
end process wght_cache_in;

--this process selects what data is put on the node compute in bus
node_comp_in : process(node_comp_in_sel, node_wrapper_in_bus, err_cache_dout_sig, grad_cache_dout_bus) begin
        case node_comp_in_sel is
            when "00" => node_comp_in_bus <= node_wrapper_in_bus;
            when "01" => node_comp_in_bus <= (others => err_cache_dout_sig);
            when others => node_comp_in_bus <= grad_cache_dout_bus;
        end case;
end process node_comp_in;

--this process selects what data is put on the node compute win bus
node_comp_wght : process(node_comp_wght_sel, wght_cache_dout_bus, node_wrapper_win_bus) begin
    case node_comp_wght_sel is
        when "00" => node_comp_wght_bus <= wght_cache_dout_bus;
        when others => node_comp_wght_bus <= node_wrapper_win_bus;
    end case;
end process node_comp_wght;

node_wrapper_in_bus(0) <= IN_0;
node_wrapper_in_bus(1) <= IN_1;
node_wrapper_in_bus(2) <= IN_2;
node_wrapper_in_bus(3) <= IN_3;
node_wrapper_in_bus(4) <= IN_4;
node_wrapper_in_bus(5) <= IN_5;
node_wrapper_in_bus(6) <= IN_6;
node_wrapper_in_bus(7) <= IN_7;

node_wrapper_win_bus(0) <= WIN_0;
node_wrapper_win_bus(1) <= WIN_1;
node_wrapper_win_bus(2) <= WIN_2;
node_wrapper_win_bus(3) <= WIN_3;
node_wrapper_win_bus(4) <= WIN_4;
node_wrapper_win_bus(5) <= WIN_5;
node_wrapper_win_bus(6) <= WIN_6;
node_wrapper_win_bus(7) <= WIN_7;

OUT_0 <= node_wrapper_out_bus(0);
OUT_1 <= node_wrapper_out_bus(1);
OUT_2 <= node_wrapper_out_bus(2);
OUT_3 <= node_wrapper_out_bus(3);
OUT_4 <= node_wrapper_out_bus(4);
OUT_5 <= node_wrapper_out_bus(5);
OUT_6 <= node_wrapper_out_bus(6);
OUT_7 <= node_wrapper_out_bus(7);

WOUT_0 <= node_wrapper_wout_bus(0);
WOUT_1 <= node_wrapper_wout_bus(1);
WOUT_2 <= node_wrapper_wout_bus(2);
WOUT_3 <= node_wrapper_wout_bus(3);
WOUT_4 <= node_wrapper_wout_bus(4);
WOUT_5 <= node_wrapper_wout_bus(5);
WOUT_6 <= node_wrapper_wout_bus(6);
WOUT_7 <= node_wrapper_wout_bus(7);

out_cache_din_sig <= node_comp_out_bus(0);

err_cache_din_sig <= node_comp_out_bus(1);

node_wrapper_wout_bus <= wght_cache_dout_bus;
grad_cache_din_bus <= node_comp_out_bus;
 
end Behavioral;
