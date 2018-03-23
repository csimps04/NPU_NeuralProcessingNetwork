library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--control decoder for node wrapper

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

--process changes internal node control signals based on operation mode
process (CTL, layer_curr_sig, layer_prev_sig, layer_next_sig) begin
    case CTL is
    when x"0" => --read weights from weight cache
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
    when x"1" => --load weights into weight cache
        ILSEL <= std_logic_vector(layer_curr_sig);
        OLSEL <= std_logic_vector(layer_curr_sig);
        WGHT_CACHE_WE <= '1';
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
    when x"2" => --forward propagation initial
        ILSEL <= std_logic_vector(layer_curr_sig);
        OLSEL <= std_logic_vector(layer_curr_sig);
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
    when x"3" => --forward propagation feedforward
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
    when x"E" => --read output cache
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
        OUT_SEL <= "01";
    when x"F" => --clear caches
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
    when others =>
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
    end case;
end process;

end Behavioral;
