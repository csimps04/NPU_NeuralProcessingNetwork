----------------------------------------------------------------------------------
-- Company: NPU
-- Engineer: Cameron Simpson
-- 
-- Create Date: 02/08/2018 03:18:01 PM
-- Design Name: 
-- Module Name: weight_cache - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--  Upon WE signal, the weights will update on same cycle.
--  This may cause issues for backprop process
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;


entity weight_cache is
    Generic (
            ND_ADDR_SZE :   integer :=  4;
            LY_ADDR_SZE :   integer :=  3;   
            LAYER_SZE   :   integer :=  10
    );

    Port (
            clk         :   in  std_logic;
            WE_lay      :   in  std_logic;
            reset       :   in  std_logic;
            layer_sel   :   in  std_logic_vector(LY_ADDR_SZE - 1 downto 0);
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
end weight_cache;

architecture Behavioral of weight_cache is

component weight_node_reg is
    Port (
            CLK         :   in  std_logic;
            WE          :   in  std_logic;
            CLR         :   in  std_logic;
            d_in        :   in  signed(15 downto 0);
            l_sel       :   in  std_logic_vector(LY_ADDR_SZE - 1 downto 0);
            d_out       :   out signed(15 downto 0)
     );
end component;           

begin

node0 : weight_node_reg
    Port Map(   CLK         =>   clk,
                WE          =>   WE_lay,
                CLR         =>   reset,
                d_in        =>   wt_in_0,
                l_sel       =>   layer_sel,
                d_out       =>   wt_out_0);

node1 : weight_node_reg
    Port Map(   CLK         =>   clk,
                WE          =>   WE_lay,
                CLR         =>   reset,
                d_in        =>   wt_in_1,
                l_sel       =>   layer_sel,
                d_out       =>   wt_out_1);

node2 : weight_node_reg
    Port Map(   CLK         =>   clk,
                WE          =>   WE_lay,
                CLR         =>   reset,
                d_in        =>   wt_in_2,
                l_sel       =>   layer_sel,
                d_out       =>   wt_out_2);                                
                
node3 : weight_node_reg
    Port Map(   CLK         =>   clk,
                WE          =>   WE_lay,
                CLR         =>   reset,
                d_in        =>   wt_in_3,
                l_sel       =>   layer_sel,
                d_out       =>   wt_out_3);

node4 : weight_node_reg
    Port Map(   CLK         =>   clk,
                WE          =>   WE_lay,
                CLR         =>   reset,
                d_in        =>   wt_in_4,
                l_sel       =>   layer_sel,
                d_out       =>   wt_out_4);
                
node5 : weight_node_reg
    Port Map(   CLK         =>   clk,
                WE          =>   WE_lay,
                CLR         =>   reset,
                d_in        =>   wt_in_5,
                l_sel       =>   layer_sel,
                d_out       =>   wt_out_5);                

node6 : weight_node_reg
    Port Map(   CLK         =>   clk,
                WE          =>   WE_lay,
                CLR         =>   reset,
                d_in        =>   wt_in_6,
                l_sel       =>   layer_sel,
                d_out       =>   wt_out_6);                

node7 : weight_node_reg
    Port Map(   CLK         =>   clk,
                WE          =>   WE_lay,
                CLR         =>   reset,
                d_in        =>   wt_in_7,
                l_sel       =>   layer_sel,
                d_out       =>   wt_out_7);

end Behavioral;
