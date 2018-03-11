library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity layer_wrapper is Generic (
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
end layer_wrapper;

architecture Behavioral of layer_wrapper is

component dummy_node_wrapper is
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
end component;

component layer_ctl_dec is Generic (
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
end component;

type data_bus is array(0 to 7) of SIGNED(15 downto 0);


SIGNAL node_layer_sig : STD_LOGIC_VECTOR(LY_ADDR_SZE - 1 downto 0);
SIGNAL layer_in_sel : STD_LOGIC_VECTOR(1 downto 0);
SIGNAL layer_win_sel : STD_LOGIC_VECTOR(2 downto 0);
SIGNAL layer_out_sel : STD_LOGIC_VECTOR(1 downto 0);
SIGNAL layer_wout_sel : STD_LOGIC_VECTOR(2 downto 0);

SIGNAL fp_in_bus : data_bus;

SIGNAL bp_in_bus : data_bus;

SIGNAL node0_ctl_sig : STD_LOGIC_VECTOR(CTL_SZE - 1 downto 0);
SIGNAL node1_ctl_sig : STD_LOGIC_VECTOR(CTL_SZE - 1 downto 0);
SIGNAL node2_ctl_sig : STD_LOGIC_VECTOR(CTL_SZE - 1 downto 0);
SIGNAL node3_ctl_sig : STD_LOGIC_VECTOR(CTL_SZE - 1 downto 0);
SIGNAL node4_ctl_sig : STD_LOGIC_VECTOR(CTL_SZE - 1 downto 0);
SIGNAL node5_ctl_sig : STD_LOGIC_VECTOR(CTL_SZE - 1 downto 0);
SIGNAL node6_ctl_sig : STD_LOGIC_VECTOR(CTL_SZE - 1 downto 0);
SIGNAL node7_ctl_sig : STD_LOGIC_VECTOR(CTL_SZE - 1 downto 0);

SIGNAL bp_win0_bus : data_bus;
SIGNAL bp_win1_bus : data_bus;
SIGNAL bp_win2_bus : data_bus;
SIGNAL bp_win3_bus : data_bus;
SIGNAL bp_win4_bus : data_bus;
SIGNAL bp_win5_bus : data_bus;
SIGNAL bp_win6_bus : data_bus;
SIGNAL bp_win7_bus : data_bus;

SIGNAL n0_in_bus : data_bus;
SIGNAL n1_in_bus : data_bus;
SIGNAL n2_in_bus : data_bus;
SIGNAL n3_in_bus : data_bus;
SIGNAL n4_in_bus : data_bus;
SIGNAL n5_in_bus : data_bus;
SIGNAL n6_in_bus : data_bus;
SIGNAL n7_in_bus : data_bus;

SIGNAL n0_win_bus : data_bus;
SIGNAL n1_win_bus : data_bus;
SIGNAL n2_win_bus : data_bus;
SIGNAL n3_win_bus : data_bus;
SIGNAL n4_win_bus : data_bus;
SIGNAL n5_win_bus : data_bus;
SIGNAL n6_win_bus : data_bus;
SIGNAL n7_win_bus : data_bus;

SIGNAL n0_out_bus : data_bus;
SIGNAL n1_out_bus : data_bus;
SIGNAL n2_out_bus : data_bus;
SIGNAL n3_out_bus : data_bus;
SIGNAL n4_out_bus : data_bus;
SIGNAL n5_out_bus : data_bus;
SIGNAL n6_out_bus : data_bus;
SIGNAL n7_out_bus : data_bus;

SIGNAL n0_wout_bus : data_bus;
SIGNAL n1_wout_bus : data_bus;
SIGNAL n2_wout_bus : data_bus;
SIGNAL n3_wout_bus : data_bus;
SIGNAL n4_wout_bus : data_bus;
SIGNAL n5_wout_bus : data_bus;
SIGNAL n6_wout_bus : data_bus;
SIGNAL n7_wout_bus : data_bus;

SIGNAL layer_wrapper_in_bus : data_bus;
SIGNAL layer_wrapper_win_bus : data_bus;
SIGNAL layer_wrapper_out_bus : data_bus;
SIGNAL layer_wrapper_wout_bus : data_bus;

begin

n0 : dummy_node_wrapper Generic Map (
            CTL_SZE => CTL_SZE,
            LY_ADDR_SZE => LY_ADDR_SZE,   
            LAYER_SZE => LAYER_SZE
)
Port Map (
            CLK => CLK,
            CTL => node0_ctl_sig,
            LAYER => node_layer_sig,
            IN_0 => n0_in_bus(0),
            IN_1 => n0_in_bus(1),
            IN_2 => n0_in_bus(2),
            IN_3 => n0_in_bus(3),
            IN_4 => n0_in_bus(4),
            IN_5 => n0_in_bus(5),
            IN_6 => n0_in_bus(6),
            IN_7 => n0_in_bus(7),
            WIN_0 => n0_win_bus(0),
            WIN_1 => n0_win_bus(1),
            WIN_2 => n0_win_bus(2),
            WIN_3 => n0_win_bus(3),
            WIN_4 => n0_win_bus(4),
            WIN_5 => n0_win_bus(5),
            WIN_6 => n0_win_bus(6),
            WIN_7 => n0_win_bus(7),
            OUT_0 => n0_out_bus(0),
            OUT_1 => n0_out_bus(1),
            OUT_2 => n0_out_bus(2),
            OUT_3 => n0_out_bus(3),
            OUT_4 => n0_out_bus(4),
            OUT_5 => n0_out_bus(5),
            OUT_6 => n0_out_bus(6),
            OUT_7 => n0_out_bus(7),
            WOUT_0 => n0_wout_bus(0),
            WOUT_1 => n0_wout_bus(1),
            WOUT_2 => n0_wout_bus(2),
            WOUT_3 => n0_wout_bus(3),
            WOUT_4 => n0_wout_bus(4),
            WOUT_5 => n0_wout_bus(5),
            WOUT_6 => n0_wout_bus(6),
            WOUT_7 => n0_wout_bus(7)
);

n1 : dummy_node_wrapper Generic Map (
            CTL_SZE => CTL_SZE,
            LY_ADDR_SZE => LY_ADDR_SZE,   
            LAYER_SZE => LAYER_SZE
)
Port Map (
            CLK => CLK,
            CTL => node1_ctl_sig,
            LAYER => node_layer_sig,
            IN_0 => n1_in_bus(0),
            IN_1 => n1_in_bus(1),
            IN_2 => n1_in_bus(2),
            IN_3 => n1_in_bus(3),
            IN_4 => n1_in_bus(4),
            IN_5 => n1_in_bus(5),
            IN_6 => n1_in_bus(6),
            IN_7 => n1_in_bus(7),
            WIN_0 => n1_win_bus(0),
            WIN_1 => n1_win_bus(1),
            WIN_2 => n1_win_bus(2),
            WIN_3 => n1_win_bus(3),
            WIN_4 => n1_win_bus(4),
            WIN_5 => n1_win_bus(5),
            WIN_6 => n1_win_bus(6),
            WIN_7 => n1_win_bus(7),
            OUT_0 => n1_out_bus(0),
            OUT_1 => n1_out_bus(1),
            OUT_2 => n1_out_bus(2),
            OUT_3 => n1_out_bus(3),
            OUT_4 => n1_out_bus(4),
            OUT_5 => n1_out_bus(5),
            OUT_6 => n1_out_bus(6),
            OUT_7 => n1_out_bus(7),
            WOUT_0 => n1_wout_bus(0),
            WOUT_1 => n1_wout_bus(1),
            WOUT_2 => n1_wout_bus(2),
            WOUT_3 => n1_wout_bus(3),
            WOUT_4 => n1_wout_bus(4),
            WOUT_5 => n1_wout_bus(5),
            WOUT_6 => n1_wout_bus(6),
            WOUT_7 => n1_wout_bus(7)
);

n2 : dummy_node_wrapper Generic Map (
            CTL_SZE => CTL_SZE,
            LY_ADDR_SZE => LY_ADDR_SZE,   
            LAYER_SZE => LAYER_SZE
)
Port Map (
            CLK => CLK,
            CTL => node2_ctl_sig,
            LAYER => node_layer_sig,
            IN_0 => n2_in_bus(0),
            IN_1 => n2_in_bus(1),
            IN_2 => n2_in_bus(2),
            IN_3 => n2_in_bus(3),
            IN_4 => n2_in_bus(4),
            IN_5 => n2_in_bus(5),
            IN_6 => n2_in_bus(6),
            IN_7 => n2_in_bus(7),
            WIN_0 => n2_win_bus(0),
            WIN_1 => n2_win_bus(1),
            WIN_2 => n2_win_bus(2),
            WIN_3 => n2_win_bus(3),
            WIN_4 => n2_win_bus(4),
            WIN_5 => n2_win_bus(5),
            WIN_6 => n2_win_bus(6),
            WIN_7 => n2_win_bus(7),
            OUT_0 => n2_out_bus(0),
            OUT_1 => n2_out_bus(1),
            OUT_2 => n2_out_bus(2),
            OUT_3 => n2_out_bus(3),
            OUT_4 => n2_out_bus(4),
            OUT_5 => n2_out_bus(5),
            OUT_6 => n2_out_bus(6),
            OUT_7 => n2_out_bus(7),
            WOUT_0 => n2_wout_bus(0),
            WOUT_1 => n2_wout_bus(1),
            WOUT_2 => n2_wout_bus(2),
            WOUT_3 => n2_wout_bus(3),
            WOUT_4 => n2_wout_bus(4),
            WOUT_5 => n2_wout_bus(5),
            WOUT_6 => n2_wout_bus(6),
            WOUT_7 => n2_wout_bus(7)
);

n3 : dummy_node_wrapper Generic Map (
            CTL_SZE => CTL_SZE,
            LY_ADDR_SZE => LY_ADDR_SZE,   
            LAYER_SZE => LAYER_SZE
)
Port Map (
            CLK => CLK,
            CTL => node3_ctl_sig,
            LAYER => node_layer_sig,
            IN_0 => n3_in_bus(0),
            IN_1 => n3_in_bus(1),
            IN_2 => n3_in_bus(2),
            IN_3 => n3_in_bus(3),
            IN_4 => n3_in_bus(4),
            IN_5 => n3_in_bus(5),
            IN_6 => n3_in_bus(6),
            IN_7 => n3_in_bus(7),
            WIN_0 => n3_win_bus(0),
            WIN_1 => n3_win_bus(1),
            WIN_2 => n3_win_bus(2),
            WIN_3 => n3_win_bus(3),
            WIN_4 => n3_win_bus(4),
            WIN_5 => n3_win_bus(5),
            WIN_6 => n3_win_bus(6),
            WIN_7 => n3_win_bus(7),
            OUT_0 => n3_out_bus(0),
            OUT_1 => n3_out_bus(1),
            OUT_2 => n3_out_bus(2),
            OUT_3 => n3_out_bus(3),
            OUT_4 => n3_out_bus(4),
            OUT_5 => n3_out_bus(5),
            OUT_6 => n3_out_bus(6),
            OUT_7 => n3_out_bus(7),
            WOUT_0 => n3_wout_bus(0),
            WOUT_1 => n3_wout_bus(1),
            WOUT_2 => n3_wout_bus(2),
            WOUT_3 => n3_wout_bus(3),
            WOUT_4 => n3_wout_bus(4),
            WOUT_5 => n3_wout_bus(5),
            WOUT_6 => n3_wout_bus(6),
            WOUT_7 => n3_wout_bus(7)
);

n4 : dummy_node_wrapper Generic Map (
            CTL_SZE => CTL_SZE,
            LY_ADDR_SZE => LY_ADDR_SZE,   
            LAYER_SZE => LAYER_SZE
)
Port Map (
            CLK => CLK,
            CTL => node4_ctl_sig,
            LAYER => node_layer_sig,
            IN_0 => n4_in_bus(0),
            IN_1 => n4_in_bus(1),
            IN_2 => n4_in_bus(2),
            IN_3 => n4_in_bus(3),
            IN_4 => n4_in_bus(4),
            IN_5 => n4_in_bus(5),
            IN_6 => n4_in_bus(6),
            IN_7 => n4_in_bus(7),
            WIN_0 => n4_win_bus(0),
            WIN_1 => n4_win_bus(1),
            WIN_2 => n4_win_bus(2),
            WIN_3 => n4_win_bus(3),
            WIN_4 => n4_win_bus(4),
            WIN_5 => n4_win_bus(5),
            WIN_6 => n4_win_bus(6),
            WIN_7 => n4_win_bus(7),
            OUT_0 => n4_out_bus(0),
            OUT_1 => n4_out_bus(1),
            OUT_2 => n4_out_bus(2),
            OUT_3 => n4_out_bus(3),
            OUT_4 => n4_out_bus(4),
            OUT_5 => n4_out_bus(5),
            OUT_6 => n4_out_bus(6),
            OUT_7 => n4_out_bus(7),
            WOUT_0 => n4_wout_bus(0),
            WOUT_1 => n4_wout_bus(1),
            WOUT_2 => n4_wout_bus(2),
            WOUT_3 => n4_wout_bus(3),
            WOUT_4 => n4_wout_bus(4),
            WOUT_5 => n4_wout_bus(5),
            WOUT_6 => n4_wout_bus(6),
            WOUT_7 => n4_wout_bus(7)
);

n5 : dummy_node_wrapper Generic Map (
            CTL_SZE => CTL_SZE,
            LY_ADDR_SZE => LY_ADDR_SZE,   
            LAYER_SZE => LAYER_SZE
)
Port Map (
            CLK => CLK,
            CTL => node5_ctl_sig,
            LAYER => node_layer_sig,
            IN_0 => n5_in_bus(0),
            IN_1 => n5_in_bus(1),
            IN_2 => n5_in_bus(2),
            IN_3 => n5_in_bus(3),
            IN_4 => n5_in_bus(4),
            IN_5 => n5_in_bus(5),
            IN_6 => n5_in_bus(6),
            IN_7 => n5_in_bus(7),
            WIN_0 => n5_win_bus(0),
            WIN_1 => n5_win_bus(1),
            WIN_2 => n5_win_bus(2),
            WIN_3 => n5_win_bus(3),
            WIN_4 => n5_win_bus(4),
            WIN_5 => n5_win_bus(5),
            WIN_6 => n5_win_bus(6),
            WIN_7 => n5_win_bus(7),
            OUT_0 => n5_out_bus(0),
            OUT_1 => n5_out_bus(1),
            OUT_2 => n5_out_bus(2),
            OUT_3 => n5_out_bus(3),
            OUT_4 => n5_out_bus(4),
            OUT_5 => n5_out_bus(5),
            OUT_6 => n5_out_bus(6),
            OUT_7 => n5_out_bus(7),
            WOUT_0 => n5_wout_bus(0),
            WOUT_1 => n5_wout_bus(1),
            WOUT_2 => n5_wout_bus(2),
            WOUT_3 => n5_wout_bus(3),
            WOUT_4 => n5_wout_bus(4),
            WOUT_5 => n5_wout_bus(5),
            WOUT_6 => n5_wout_bus(6),
            WOUT_7 => n5_wout_bus(7)
);

n6 : dummy_node_wrapper Generic Map (
            CTL_SZE => CTL_SZE,
            LY_ADDR_SZE => LY_ADDR_SZE,   
            LAYER_SZE => LAYER_SZE
)
Port Map (
            CLK => CLK,
            CTL => node6_ctl_sig,
            LAYER => node_layer_sig,
            IN_0 => n6_in_bus(0),
            IN_1 => n6_in_bus(1),
            IN_2 => n6_in_bus(2),
            IN_3 => n6_in_bus(3),
            IN_4 => n6_in_bus(4),
            IN_5 => n6_in_bus(5),
            IN_6 => n6_in_bus(6),
            IN_7 => n6_in_bus(7),
            WIN_0 => n6_win_bus(0),
            WIN_1 => n6_win_bus(1),
            WIN_2 => n6_win_bus(2),
            WIN_3 => n6_win_bus(3),
            WIN_4 => n6_win_bus(4),
            WIN_5 => n6_win_bus(5),
            WIN_6 => n6_win_bus(6),
            WIN_7 => n6_win_bus(7),
            OUT_0 => n6_out_bus(0),
            OUT_1 => n6_out_bus(1),
            OUT_2 => n6_out_bus(2),
            OUT_3 => n6_out_bus(3),
            OUT_4 => n6_out_bus(4),
            OUT_5 => n6_out_bus(5),
            OUT_6 => n6_out_bus(6),
            OUT_7 => n6_out_bus(7),
            WOUT_0 => n6_wout_bus(0),
            WOUT_1 => n6_wout_bus(1),
            WOUT_2 => n6_wout_bus(2),
            WOUT_3 => n6_wout_bus(3),
            WOUT_4 => n6_wout_bus(4),
            WOUT_5 => n6_wout_bus(5),
            WOUT_6 => n6_wout_bus(6),
            WOUT_7 => n6_wout_bus(7)
);

n7 : dummy_node_wrapper Generic Map (
            CTL_SZE => CTL_SZE,
            LY_ADDR_SZE => LY_ADDR_SZE,   
            LAYER_SZE => LAYER_SZE
)
Port Map (
            CLK => CLK,
            CTL => node7_ctl_sig,
            LAYER => node_layer_sig,
            IN_0 => n7_in_bus(0),
            IN_1 => n7_in_bus(1),
            IN_2 => n7_in_bus(2),
            IN_3 => n7_in_bus(3),
            IN_4 => n7_in_bus(4),
            IN_5 => n7_in_bus(5),
            IN_6 => n7_in_bus(6),
            IN_7 => n7_in_bus(7),
            WIN_0 => n7_win_bus(0),
            WIN_1 => n7_win_bus(1),
            WIN_2 => n7_win_bus(2),
            WIN_3 => n7_win_bus(3),
            WIN_4 => n7_win_bus(4),
            WIN_5 => n7_win_bus(5),
            WIN_6 => n7_win_bus(6),
            WIN_7 => n7_win_bus(7),
            OUT_0 => n7_out_bus(0),
            OUT_1 => n7_out_bus(1),
            OUT_2 => n7_out_bus(2),
            OUT_3 => n7_out_bus(3),
            OUT_4 => n7_out_bus(4),
            OUT_5 => n7_out_bus(5),
            OUT_6 => n7_out_bus(6),
            OUT_7 => n7_out_bus(7),
            WOUT_0 => n7_wout_bus(0),
            WOUT_1 => n7_wout_bus(1),
            WOUT_2 => n7_wout_bus(2),
            WOUT_3 => n7_wout_bus(3),
            WOUT_4 => n7_wout_bus(4),
            WOUT_5 => n7_wout_bus(5),
            WOUT_6 => n7_wout_bus(6),
            WOUT_7 => n7_wout_bus(7)
);

ctl : layer_ctl_dec Generic Map (
            CTL_SZE : integer := 4;
            LY_ADDR_SZE :   integer :=  3;   
            LAYER_SZE   :   integer :=  8;
            ND_ADDR_SZE : integer := 3;
            NODE_SZE : integer := 8
)
Port Map(
            CLK => CLK,
            LAYER_CTL => LAYER_CTL,
            LAYER => LAYER,
            NODE => NODE,
            NODE0_CTL => node0_ctl_sig,
            NODE1_CTL => node1_ctl_sig,
            NODE2_CTL => node2_ctl_sig,
            NODE3_CTL => node3_ctl_sig,
            NODE4_CTL => node4_ctl_sig,
            NODE5_CTL => node5_ctl_sig,
            NODE6_CTL => node6_ctl_sig,
            NODE7_CTL => node7_ctl_sig,
            LAYER_IN_SEL => layer_in_sel,
            LAYER_WIN_SEL => layer_win_sel,
            LAYER_OUT_SEL => layer_out_sel,
            LAYER_WOUT_SEL => layer_wout_sel
);

win_sel : process (layer_win_sel, layer_wrapper_win_bus) begin
    if layer_win_sel = "000" then
    n0_win_bus <= layer_wrapper_win_bus;
    elsif layer_win_sel = "001" then
    n1_win_bus <= layer_wrapper_win_bus;
    elsif layer_win_sel = "010" then
    n2_win_bus <= layer_wrapper_win_bus;
    elsif layer_win_sel = "011" then
    n3_win_bus <= layer_wrapper_win_bus;
    elsif layer_win_sel = "100" then
    n4_win_bus <= layer_wrapper_win_bus;
    elsif layer_win_sel = "101" then
    n5_win_bus <= layer_wrapper_win_bus;
    elsif layer_win_sel = "110" then
    n6_win_bus <= layer_wrapper_win_bus;
    elsif layer_win_sel = "111" then
    n7_win_bus <= layer_wrapper_win_bus;
end if;
end process win_sel;

wout_sel : process (layer_wout_sel) begin
    if layer_wout_sel = "000" then
        layer_wrapper_wout_bus <= n0_wout_bus;
    elsif layer_wout_sel = "001" then
        layer_wrapper_wout_bus <= n1_wout_bus;
    elsif layer_wout_sel = "010" then
        layer_wrapper_wout_bus <= n2_wout_bus;
    elsif layer_wout_sel = "011" then
        layer_wrapper_wout_bus <= n3_wout_bus;
    elsif layer_wout_sel = "100" then
        layer_wrapper_wout_bus <= n4_wout_bus;
    elsif layer_wout_sel = "101" then
        layer_wrapper_wout_bus <= n5_wout_bus;
    elsif layer_wout_sel = "110" then
        layer_wrapper_wout_bus <= n6_wout_bus;
    elsif layer_wout_sel = "111" then
        layer_wrapper_wout_bus <= n7_wout_bus;
    end if;
end process wout_sel;

node_layer_sig <= LAYER;

fp_in_bus <= (0 => n0_out_bus(0), 1 => n1_out_bus(0), 2 => n2_out_bus(0), 3 => n3_out_bus(0), 4 => n4_out_bus(0), 5 => n5_out_bus(0), 6 => n6_out_bus(0), 7 => n7_out_bus(0));

bp_in_bus <= (0 => n0_out_bus(0), 1 => n1_out_bus(0), 2 => n2_out_bus(0), 3 => n3_out_bus(0), 4 => n4_out_bus(0), 5 => n5_out_bus(0), 6 => n6_out_bus(0), 7 => n7_out_bus(0));

bp_win0_bus <= (0 => n0_wout_bus(0), 1 => n1_wout_bus(0), 2 => n2_wout_bus(0), 3 => n3_wout_bus(0), 4 => n4_wout_bus(0), 5 => n5_wout_bus(0), 6 => n6_wout_bus(0), 7 => n7_wout_bus(0));
bp_win1_bus <= (0 => n0_wout_bus(1), 1 => n1_wout_bus(1), 2 => n2_wout_bus(1), 3 => n3_wout_bus(1), 4 => n4_wout_bus(1), 5 => n5_wout_bus(1), 6 => n6_wout_bus(1), 7 => n7_wout_bus(1));
bp_win2_bus <= (0 => n0_wout_bus(2), 1 => n1_wout_bus(2), 2 => n2_wout_bus(2), 3 => n3_wout_bus(2), 4 => n4_wout_bus(2), 5 => n5_wout_bus(2), 6 => n6_wout_bus(2), 7 => n7_wout_bus(2));
bp_win3_bus <= (0 => n0_wout_bus(3), 1 => n1_wout_bus(3), 2 => n2_wout_bus(3), 3 => n3_wout_bus(3), 4 => n4_wout_bus(3), 5 => n5_wout_bus(3), 6 => n6_wout_bus(3), 7 => n7_wout_bus(3));
bp_win4_bus <= (0 => n0_wout_bus(4), 1 => n1_wout_bus(4), 2 => n2_wout_bus(4), 3 => n3_wout_bus(4), 4 => n4_wout_bus(4), 5 => n5_wout_bus(4), 6 => n6_wout_bus(4), 7 => n7_wout_bus(4));
bp_win5_bus <= (0 => n0_wout_bus(5), 1 => n1_wout_bus(5), 2 => n2_wout_bus(5), 3 => n3_wout_bus(5), 4 => n4_wout_bus(5), 5 => n5_wout_bus(5), 6 => n6_wout_bus(5), 7 => n7_wout_bus(5));
bp_win6_bus <= (0 => n0_wout_bus(6), 1 => n1_wout_bus(6), 2 => n2_wout_bus(6), 3 => n3_wout_bus(6), 4 => n4_wout_bus(6), 5 => n5_wout_bus(6), 6 => n6_wout_bus(6), 7 => n7_wout_bus(6));
bp_win7_bus <= (0 => n0_wout_bus(7), 1 => n1_wout_bus(7), 2 => n2_wout_bus(7), 3 => n3_wout_bus(7), 4 => n4_wout_bus(7), 5 => n5_wout_bus(7), 6 => n6_wout_bus(7), 7 => n7_wout_bus(7));

layer_wrapper_in_bus(0) <= IN_0;
layer_wrapper_in_bus(1) <= IN_1;
layer_wrapper_in_bus(2) <= IN_2;
layer_wrapper_in_bus(3) <= IN_3;
layer_wrapper_in_bus(4) <= IN_4;
layer_wrapper_in_bus(5) <= IN_5;
layer_wrapper_in_bus(6) <= IN_6;
layer_wrapper_in_bus(7) <= IN_7;

layer_wrapper_win_bus(0) <= WIN_0;
layer_wrapper_win_bus(1) <= WIN_1;
layer_wrapper_win_bus(2) <= WIN_2;
layer_wrapper_win_bus(3) <= WIN_3;
layer_wrapper_win_bus(4) <= WIN_4;
layer_wrapper_win_bus(5) <= WIN_5;
layer_wrapper_win_bus(6) <= WIN_6;
layer_wrapper_win_bus(7) <= WIN_7;

OUT_0 <= layer_wrapper_out_bus(0);
OUT_1 <= layer_wrapper_out_bus(1);
OUT_2 <= layer_wrapper_out_bus(2);
OUT_3 <= layer_wrapper_out_bus(3);
OUT_4 <= layer_wrapper_out_bus(4);
OUT_5 <= layer_wrapper_out_bus(5);
OUT_6 <= layer_wrapper_out_bus(6);
OUT_7 <= layer_wrapper_out_bus(7);

WOUT_0 <= layer_wrapper_wout_bus(0);
WOUT_1 <= layer_wrapper_wout_bus(1);
WOUT_2 <= layer_wrapper_wout_bus(2);
WOUT_3 <= layer_wrapper_wout_bus(3);
WOUT_4 <= layer_wrapper_wout_bus(4);
WOUT_5 <= layer_wrapper_wout_bus(5);
WOUT_6 <= layer_wrapper_wout_bus(6);
WOUT_7 <= layer_wrapper_wout_bus(7);

end Behavioral;
