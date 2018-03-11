library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity weight_node_reg_tb is
end;

architecture bench of weight_node_reg_tb is

  component weight_node_reg
      Generic (
                  ADDR_SZE    :   integer :=  3;   
                  LAYER_SZE   :   integer :=  8
      );
      Port (
                  CLK         :   in  std_logic;
                  WE          :   in  std_logic;
                  CLR         :   in  std_logic;
                  d_in        :   in  signed(15 downto 0);
                  l_sel_in    :   in  std_logic_vector(ADDR_SZE - 1 downto 0);
                  l_sel_out   :   in  std_logic_vector(ADDR_SZE - 1 downto 0);
                  d_out       :   out signed(15 downto 0)
       );
  end component;
  
  constant S_ADDR_SZE : integer := 3;
  constant S_LAYER_SZE   :   integer :=  8;

  signal CLK: std_logic;
  signal WE: std_logic := '0';
  signal CLR: std_logic := '0';
  signal d_in: signed(15 downto 0) := (others => '0');
  signal l_sel_in: std_logic_vector(S_ADDR_SZE - 1 downto 0) := (others => '0');
  signal l_sel_out: std_logic_vector(S_ADDR_SZE - 1 downto 0) := (others => '0');
  signal d_out: signed(15 downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  -- Insert values for generic parameters !!
  uut: weight_node_reg 
      port map ( CLK       => CLK,
                 WE        => WE,
                 CLR       => CLR,
                 d_in      => d_in,
                 l_sel_in  => l_sel_in,
                 l_sel_out => l_sel_out,
                 d_out     => d_out );

  stimulus: process
  begin
  
    -- Put initialisation code here
    wait for 10 ns;
    l_sel_in <= "001";
    l_sel_out <= "001";
    d_in <= x"0F51";
    WE <= '1';
    wait for 10 ns;
    WE <= '0';
    wait for 10 ns;
     l_sel_in <= "101";
    l_sel_out <= "001";
    d_in <= x"AAAA";
    WE <= '1';
    wait for 10 ns;
    WE <= '0';
    wait for 10 ns;   
    l_sel_in <= "001";
    l_sel_out <= "101";
    d_in <= x"BBBB";
    WE <= '1';
    wait for 10 ns;
    WE <= '0';
    wait for 10 ns;
    l_sel_in <= "111";
    l_sel_out <= "001";
    d_in <= x"CCCC";
    WE <= '1';
    wait for 10 ns;
    WE <= '0';
    wait for 10 ns;
    l_sel_in <= "000";
    l_sel_out <= "000";
    wait for 10 ns;
    l_sel_in <= "001";
    l_sel_out <= "001";
    wait for 10 ns;
     l_sel_in <= "010";
    l_sel_out <= "010";
    wait for 10 ns;   
        
    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      CLK <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;