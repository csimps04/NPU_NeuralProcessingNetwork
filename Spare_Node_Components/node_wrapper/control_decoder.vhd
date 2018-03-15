library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control_decoder is
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
end control_decoder;

architecture Behavioral of control_decoder is

SIGNAL layer_curr_sig : UNSIGNED(LY_ADDR_SZE - 1 downto 0);
SIGNAL layer_prev_sig : UNSIGNED(LY_ADDR_SZE - 1 downto 0);
SIGNAL layer_next_sig : UNSIGNED(LY_ADDR_SZE - 1 downto 0);

begin

layer_curr_sig <= unsigned(LAYER);
layer_prev_sig <= layer_curr_sig - "1";
layer_next_sig <= layer_curr_sig + "1";
process (CTL, LAYER) begin
    if CTL = x"0" then --read weights from weight cache
        ILSEL <= std_logic_vector(layer_curr_sig);
        OLSEL <= std_logic_vector(layer_curr_sig);
        WGHT_CACHE_WE <= '0';
        WGHT_CACHE_RS <= '0';
        ERR_CACHE_WE <= '0';
        ERR_CACHE_RS <= '0';
        WGHT_CACHE_ISEL <= '0';
        OUT_CACHE_WE <= '0';
        OUT_CACHE_RS <= '0';
        GRAD_CACHE_WE <= '0';
        GRAD_CACHE_RS <= '0';
        NODE_MODE <= "00";
        NODE_IN_SEL <= "00";
        NODE_WGHT_SEL <= "00";
        OUT_SEL <= "00";
    elsif CTL = x"1" then --load weights into weight cache
        ILSEL <= std_logic_vector(layer_curr_sig);
        OLSEL <= std_logic_vector(layer_curr_sig);
        WGHT_CACHE_WE <= '1';
        WGHT_CACHE_RS <= '0';
        WGHT_CACHE_ISEL <= '0';
        ERR_CACHE_WE <= '0';
        ERR_CACHE_RS <= '0';
        OUT_CACHE_WE <= '0';
        OUT_CACHE_RS <= '0';
        GRAD_CACHE_WE <= '0';
        GRAD_CACHE_RS <= '0';
        NODE_MODE <= "00";
        NODE_IN_SEL <= "00";
        NODE_WGHT_SEL <= "00";
        OUT_SEL <= "00";
    elsif CTL = x"2" then --forward propagation
        ILSEL <= std_logic_vector(layer_curr_sig);
        OLSEL <= std_logic_vector(layer_prev_sig);
        WGHT_CACHE_WE <= '0';
        WGHT_CACHE_RS <= '0';
        WGHT_CACHE_ISEL <= '0';
        ERR_CACHE_WE <= '0';
        ERR_CACHE_RS <= '0';
        OUT_CACHE_WE <= '1';
        OUT_CACHE_RS <= '0';
        GRAD_CACHE_WE <= '0';
        GRAD_CACHE_RS <= '0';
        NODE_MODE <= "00";
        NODE_IN_SEL <= "00";
        NODE_WGHT_SEL <= "00";
        OUT_SEL <= "01";
    elsif CTL = x"3" then --back propagation output layer error calc
        ILSEL <= std_logic_vector(layer_curr_sig);
        OLSEL <= std_logic_vector(layer_curr_sig);
        WGHT_CACHE_WE <= '0';
        WGHT_CACHE_RS <= '0';
        WGHT_CACHE_ISEL <= '0';
        ERR_CACHE_WE <= '1';
        ERR_CACHE_RS <= '0';
        OUT_CACHE_WE <= '0';
        OUT_CACHE_RS <= '0';
        GRAD_CACHE_WE <= '0';
        GRAD_CACHE_RS <= '0';
        NODE_MODE <= "00";
        NODE_IN_SEL <= "00";
        NODE_WGHT_SEL <= "00";
        OUT_SEL <= "00";
    elsif CTL = x"4" then --back propagation hidden layer error calc
        ILSEL <= std_logic_vector(layer_curr_sig);
        OLSEL <= std_logic_vector(layer_next_sig);
        WGHT_CACHE_WE <= '0';
        WGHT_CACHE_RS <= '0';
        WGHT_CACHE_ISEL <= '0';
        ERR_CACHE_WE <= '1';
        ERR_CACHE_RS <= '0';
        OUT_CACHE_WE <= '0';
        OUT_CACHE_RS <= '0';
        GRAD_CACHE_WE <= '0';
        GRAD_CACHE_RS <= '0';
        NODE_MODE <= "01";
        NODE_IN_SEL <= "00";
        NODE_WGHT_SEL <= "00";
        OUT_SEL <= "00";
    elsif CTL = x"5" then --back propagation gradient calculation
        ILSEL <= std_logic_vector(layer_curr_sig);
        OLSEL <= std_logic_vector(layer_next_sig);
        WGHT_CACHE_WE <= '0';
        WGHT_CACHE_RS <= '0';
        WGHT_CACHE_ISEL <= '0';
        ERR_CACHE_WE <= '0';
        ERR_CACHE_RS <= '0';
        OUT_CACHE_WE <= '0';
        OUT_CACHE_RS <= '0';
        GRAD_CACHE_WE <= '1';
        GRAD_CACHE_RS <= '0';
        NODE_MODE <= "10";
        NODE_IN_SEL <= "01";
        NODE_WGHT_SEL <= "01";
        OUT_SEL <= "01";
    elsif CTL = x"4" then --back propagation weight update
        ILSEL <= std_logic_vector(layer_curr_sig);
        OLSEL <= std_logic_vector(layer_curr_sig);
        WGHT_CACHE_WE <= '1';
        WGHT_CACHE_RS <= '0';
        WGHT_CACHE_ISEL <= '0';
        ERR_CACHE_WE <= '0';
        ERR_CACHE_RS <= '0';
        OUT_CACHE_WE <= '0';
        OUT_CACHE_RS <= '0';
        GRAD_CACHE_WE <= '0';
        GRAD_CACHE_RS <= '0';
        NODE_MODE <= "11";
        NODE_IN_SEL <= "10";
        NODE_WGHT_SEL <= "00";
        OUT_SEL <= "00";
    elsif CTL = x"F" then --clear caches
        ILSEL <= std_logic_vector(layer_curr_sig);
        OLSEL <= std_logic_vector(layer_curr_sig);
        WGHT_CACHE_WE <= '0';
        WGHT_CACHE_RS <= '1';
        WGHT_CACHE_ISEL <= '0';
        ERR_CACHE_WE <= '0';
        ERR_CACHE_RS <= '1';
        OUT_CACHE_WE <= '0';
        OUT_CACHE_RS <= '1';
        GRAD_CACHE_WE <= '0';
        GRAD_CACHE_RS <= '1';
        NODE_MODE <= "00";
        NODE_IN_SEL <= "00";
        NODE_WGHT_SEL <= "00";
        OUT_SEL <= "00";
    else
        ILSEL <= std_logic_vector(layer_curr_sig);
        OLSEL <= std_logic_vector(layer_curr_sig);
        WGHT_CACHE_WE <= '0';
        WGHT_CACHE_RS <= '0';
        WGHT_CACHE_ISEL <= '0';
        ERR_CACHE_WE <= '0';
        ERR_CACHE_RS <= '0';
        OUT_CACHE_WE <= '0';
        OUT_CACHE_RS <= '0';
        GRAD_CACHE_WE <= '0';
        GRAD_CACHE_RS <= '0';
        NODE_MODE <= "00";
        NODE_IN_SEL <= "00";
        NODE_WGHT_SEL <= "00";
        OUT_SEL <= "00";
    end if;
end process;

end Behavioral;
