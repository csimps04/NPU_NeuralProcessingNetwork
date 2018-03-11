
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity weight_cache_tb is
end;

architecture bench of weight_cache_tb is

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

  signal clk: std_logic;
  signal WE_lay: std_logic := '0';
  signal reset: std_logic;
  signal layer_sel: std_logic_vector(2 downto 0) := (others => '0');
  signal layer_sel_in: std_logic_vector(2 downto 0) := (others => '0');
  signal layer_sel_out: std_logic_vector(2 downto 0) := (others => '0');
  signal wt_in_0: signed(15 downto 0)  := (others => '0');
  signal wt_in_1: signed(15 downto 0) := (others => '0');
  signal wt_in_2: signed(15 downto 0) := (others => '0');
  signal wt_in_3: signed(15 downto 0) := (others => '0');
  signal wt_in_4: signed(15 downto 0) := (others => '0');
  signal wt_in_5: signed(15 downto 0) := (others => '0');
  signal wt_in_6: signed(15 downto 0) := (others => '0');
  signal wt_in_7: signed(15 downto 0) := (others => '0');
  signal wt_out_0: signed(15 downto 0);
  signal wt_out_1: signed(15 downto 0);
  signal wt_out_2: signed(15 downto 0);
  signal wt_out_3: signed(15 downto 0);
  signal wt_out_4: signed(15 downto 0);
  signal wt_out_5: signed(15 downto 0);
  signal wt_out_6: signed(15 downto 0);
  signal wt_out_7: signed(15 downto 0) ;

begin

clockProc : process
begin
    clk <= '0';
    wait for 5 ns;
    clk <= '1';
    wait for 5 ns;
end process clockProc;

  -- Insert values for generic parameters !!
  uut: weight_cache 
       port map ( clk         => clk,
                                  WE_lay      => WE_lay,
                                  reset       => reset,
                                  layer_sel_in   => layer_sel_in,
                                  layer_sel_out   => layer_sel_out,
                                  wt_in_0     => wt_in_0,
                                  wt_in_1     => wt_in_1,
                                  wt_in_2     => wt_in_2,
                                  wt_in_3     => wt_in_3,
                                  wt_in_4     => wt_in_4,
                                  wt_in_5     => wt_in_5,
                                  wt_in_6     => wt_in_6,
                                  wt_in_7     => wt_in_7,
                                  wt_out_0    => wt_out_0,
                                  wt_out_1    => wt_out_1,
                                  wt_out_2    => wt_out_2,
                                  wt_out_3    => wt_out_3,
                                  wt_out_4    => wt_out_4,
                                  wt_out_5    => wt_out_5,
                                  wt_out_6    => wt_out_6,
                                  wt_out_7    => wt_out_7 );

  stimulus: process
  begin
  
    -- Put initialisation code here


    -- Put test bench stimulus code here

    wait;
  end process;
  
  simProcess  : process
  type int_array is array (0 to 9) of integer;
  variable data_array : int_array := (2314, 43563, 8, 111, 2352, 345, 9006, 100023, 8734, 19923);
  
  begin
  
      reset <= '0';
      wait for 10 ns;
      
      
      wait for 10 ns;
      
      reset <= '1';
      
      wait for 100 ns;
      
      reset <= '0';
      
      wait for 5 ns;
      
      layer_sel_in <= "000";
      layer_sel_out <= "001";
      
      wt_in_0 <= to_signed(data_array(0), 16);
      wt_in_1 <= to_signed(data_array(1), 16);
      wt_in_2 <= to_signed(data_array(2), 16);
      wt_in_3 <= to_signed(data_array(3), 16);
      wt_in_4 <= to_signed(data_array(4), 16);
      wt_in_5 <= to_signed(data_array(5), 16);
      wt_in_6 <= to_signed(data_array(6), 16);
      wt_in_7 <= to_signed(data_array(7), 16);
      
      WE_lay <= '1';
      
      wait for 10 ns;
      
      WE_lay <= '0';
      
      wait for 10 ns;
      
      
      layer_sel_in <= "001";
      layer_sel_out <= "000";
      
      wt_in_1 <= to_signed(data_array(0), 16);
      wt_in_2 <= to_signed(data_array(1), 16);
      wt_in_3 <= to_signed(data_array(2), 16);
      wt_in_4 <= to_signed(data_array(3), 16);
      wt_in_5 <= to_signed(data_array(4), 16);
      wt_in_6 <= to_signed(data_array(5), 16);
      wt_in_7 <= to_signed(data_array(6), 16);
      wt_in_0 <= to_signed(data_array(7), 16);
      
      WE_lay <= '1';
      
      wait for 10 ns;
      
      WE_lay <= '0';
      
      wait for 10 ns;
      
      layer_sel_in <= "100";
      layer_sel_out <= "001";
      
      wt_in_2 <= to_signed(data_array(0), 16);
      wt_in_3 <= to_signed(data_array(1), 16);
      wt_in_4 <= to_signed(data_array(2), 16);
      wt_in_5 <= to_signed(data_array(3), 16);
      wt_in_6 <= to_signed(data_array(4), 16);
      wt_in_7 <= to_signed(data_array(5), 16);
      wt_in_0 <= to_signed(data_array(6), 16);
      wt_in_1 <= to_signed(data_array(7), 16);
      
      WE_lay <= '1';
      
      wait for 10 ns;
      
      WE_lay <= '0';
      
      wait for 10 ns;
      
      layer_sel_out <= "000";
      
      wait for 10 ns;

      layer_sel_out <= "001";
      
      wait for 10 ns;
      
      layer_sel_out <= "010";
      
      wait for 10 ns;
      
      layer_sel_out <= "100";
      
      wait for 10 ns; 
      
      reset <= '1';
      
      wait for 10 ns;   
      
      reset <= '0'; 
      
      wait for 10 ns;
      
      layer_sel_out <= "000";
       
       wait for 10 ns;
 
       layer_sel_out <= "001";
       
       wait for 10 ns;
       
       layer_sel_out <= "010";
       
       wait for 10 ns;
       
       layer_sel_out <= "100";
       
       wait for 10 ns; 

                  
--      layer_sel <= "000";
--      wt_in_0 <= to_signed(data_array(0), 16);
--      wait for 5 ns;
--      T_WE    <=  '1';
--      wait for 10 ns;
--      T_WE    <= '0';
--      wait for 20 ns;
--      T_nd_sel <= "0011";
--              wt_in_1 <= to_signed(data_array(1), 16);
--      wait for 10 ns;
--      T_WE    <=  '1';
--      wait for 10 ns;
--      T_WE    <= '0';
--      wait for 20 ns;
--      T_nd_sel <= "1000";
--              wt_in_2 <= to_signed(data_array(2), 16);
--      wait for 10 ns;
--      T_WE    <=  '1';
--      wait for 10 ns;
--      T_WE    <= '0';
--      wait for 20 ns;
--      T_nd_sel <= "0010";
--              T_data_in <= to_signed(data_array(3), 16);
--      wait for 10 ns;
--      T_WE    <=  '1';
--      wait for 10 ns;
--      T_WE    <= '0';
--      wait for 20 ns;
--      T_nd_sel <= "0111";
--              T_data_in <= to_signed(data_array(4), 16);
--      wait for 10 ns;
--      T_WE    <=  '1';
--      wait for 10 ns;
--      T_WE    <= '0';
--      wait for 20 ns;
--      T_nd_sel <= "1001";
--              T_data_in <= to_signed(data_array(5), 16);
--      wait for 10 ns;
--      T_WE    <=  '1';
--      wait for 10 ns;
--      T_WE    <= '0';
--      T_layer_sel <= "000";
      
      
      
--      wait for 10 ns;
--      T_layer_sel <= "010";
--      T_nd_sel <= "0000";
  
--      T_data_in <=  x"F08A";
--      wait for 5 ns;
--      T_WE    <=  '1';
--      wait for 10 ns;
--      T_WE    <= '0';
--      wait for 20 ns;
--      T_nd_sel <= "0011";
--      T_data_in <=  x"A00A";
--      wait for 10 ns;
--      T_WE    <=  '1';
--      wait for 10 ns;
--      T_WE    <= '0';
--      wait for 20 ns;
--      T_nd_sel <= "1000";
--      T_data_in <=  x"438A";
--      wait for 10 ns;
--      T_WE    <=  '1';
--      wait for 10 ns;
--      T_WE    <= '0';
--      wait for 20 ns;
--      T_nd_sel <= "0010";
--      T_data_in <=  x"BBBB";
--      wait for 10 ns;
--      T_WE    <=  '1';
--      wait for 10 ns;
--      T_WE    <= '0';
--      wait for 20 ns;
--      T_nd_sel <= "0111";
--      T_data_in <=  x"A067";
--      wait for 10 ns;
--      T_WE    <=  '1';
--      wait for 10 ns;
--      T_WE    <= '0';
--      wait for 20 ns;
--      T_nd_sel <= "1001";
--      T_data_in <=  x"AAAA";
--      wait for 10 ns;
--      T_WE    <=  '1';
--      wait for 10 ns;
--      T_WE    <= '0';
      
--      wait for 100 ns;
--      T_reset <= '1';
--      wait for 20 ns;
  
  
  
  end process simProcess; 


end;
