----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2018 02:10:03 PM
-- Design Name: 
-- Module Name: NPU_Controller - Behavioral
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
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.Std_Logic_Arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity NPU_Controller is
    generic(
            NODE_WIDTH          :   integer := 8;
            NODE_ADDR_WIDTH     :   integer := 3;
            LAYER_WIDTH         :   integer := 8;
            LAYER_ADDR_WIDTH    :   integer := 3;
            AXI_CNTL_WIDTH      :   integer := 3;
            INPUT_CNTL_WIDTH    :   integer := 32;
            OP_CODE_WIDTH       :   integer := 4;                
            CNTL_ADDR_WIDTH     :   integer := 3
    );
    Port (
            CLK         :   in  std_logic;
            RESET       :   in  std_logic;  -- Resets all counters and registers
            CTL_IN      :   in  std_logic_vector(INPUT_CNTL_WIDTH - 1 downto 0); -- Input for the control instruction
            AXI_R_COMP  :   in  std_logic;  -- Indicates to the control unit that a read has completed, and new values should be placed in register
            CTRL_WREADY :   in  std_logic;  -- Indicates that a new instruction is ready to be processed
            REG_WREADY  :   in  std_logic;  -- Indicates that a new value is ready to load into the next weight register
            D_WREADY    :   in  std_logic;  -- Indicates new value is ready for data
            BP_WREADY   :   in  std_logic;  -- Indicates new back prop value is ready
            REG_RREADY  :   out std_logic;  -- Indicates that weight registers are ready to be read from for output
            OUT_RREADY  :   out std_logic;  -- Indicates that output registers are ready to be read from for output
            D_BREADY    :   out std_logic;  -- Indicates to AXI when ready for new data
            REG_BREADY  :   out std_logic;  -- Indicates when AXI should accept new weight register value 
            BP_BREADY   :   out std_logic;  -- Indicates when AXI should accept new back prop register values
            CTRL_BREADY :   out std_logic;  -- Indicates when AXI should accept new instruction for control unit
            NODE_CNT    :   out std_logic_vector(NODE_ADDR_WIDTH - 1 downto 0);  -- output to each node
            LAY_CNT     :   out std_logic_vector(LAYER_ADDR_WIDTH - 1 downto 0); -- output to each node
            NPU_CTL_OUT :   out std_logic_vector(CNTL_ADDR_WIDTH - 1 downto 0); -- Controls the NPU based on control instructions
            AXI_CTL_OUT :   out std_logic_vector(AXI_CNTL_WIDTH - 1 downto 0)    -- May or may not be necessary
    );
end NPU_Controller;

architecture Behavioral of NPU_Controller is

-- Constant values for the maximum node and layer values.
constant max_node_count   :   std_logic_vector(NODE_ADDR_WIDTH - 1 downto 0) := (others => '1');
constant max_layer_count  :   std_logic_vector(LAYER_ADDR_WIDTH - 1 downto 0) := (others => '1');


-- Configure constants for op code values, which will be used to determine microcoded instruction
constant OP_IDLE        :   std_logic_vector(OP_CODE_WIDTH - 1 downto 0) := (others => '0');
constant OP_LD_WT       :   std_logic_vector(OP_CODE_WIDTH - 1 downto 0) := (0 => '1', others => '0');                  -- "001"
constant OP_RTRV_WT     :   std_logic_vector(OP_CODE_WIDTH - 1 downto 0) := (1 => '1', others => '0');                   -- "010"
constant OP_FW_BATCH    :   std_logic_vector(OP_CODE_WIDTH - 1 downto 0) := (0 => '1', 1 => '1', others => '0');        -- "011"
constant OP_FW_SINGLE   :   std_logic_vector(OP_CODE_WIDTH - 1 downto 0) := (2 => '1', others => '0');                  -- "100

-- Constant control outputs to NPU for different operations
constant NPU_IDLE    :   std_logic_vector(CNTL_ADDR_WIDTH - 1 downto 0) := (others => '0');
constant NPU_LOAD_WEIGHTS :   std_logic_vector(CNTL_ADDR_WIDTH - 1 downto 0) := (0 => '1', others => '0');
constant NPU_READ_WEIGHTS :   std_logic_vector(CNTL_ADDR_WIDTH - 1 downto 0) := (1 => '1', others => '0');
constant NPU_FWPROP       :   std_logic_vector(CNTL_ADDR_WIDTH - 1 downto 0) := (0 => '1', 1 => '1', others => '0');
--constant NPU_FWPROP_SINGL :   std_logic_vector(CNTL_ADDR_WIDTH - 1 downto 0) := (0 => '1', 1 => '1', others => '0');

-- Node and layer sizes as indicated during setup
signal set_node_max   :   std_logic_vector(NODE_ADDR_WIDTH - 1 downto 0) := (others => '1');
signal set_layer_max  :   std_logic_vector(LAYER_ADDR_WIDTH - 1 downto 0) := (others => '1');

-- Additional output signals for NPU control
signal node_count       :   std_logic_vector(NODE_ADDR_WIDTH - 1 downto 0);
signal layer_count      :   std_logic_vector(LAYER_ADDR_WIDTH - 1 downto 0);
signal npu_control_out  :   std_logic_vector(CNTL_ADDR_WIDTH - 1 downto 0);

type state_type is (ST_init, ST_decode, ST_WeightWrite_Load, ST_WeightWrite_writeNPU, ST_WeightRead, ST_ForwardProp_Load, ST_ForwardProp_Exec, ST_ForwardProp_Read, ST_BackProp_Base, ST_BackProp_Error, ST_BackProp_Grad, ST_BackProp_WtChng);
signal PS,NS : state_type;

signal OP_CODE :    std_logic_vector(OP_CODE_WIDTH - 1 downto 0) := (others => '0');

begin

NPU_CTL_OUT     <=  npu_control_out;
NODE_CNT      <=  node_count;
LAY_CNT       <=  layer_count;
OP_CODE         <= CTL_IN(INPUT_CNTL_WIDTH - 1 downto INPUT_CNTL_WIDTH - OP_CODE_WIDTH);


-- Go to next state on clock edge
sync_p: process (CLK, NS, RESET)
begin
   if (RESET = '1') then
      PS <= ST_init;
   elsif (rising_edge(CLK)) then 
      PS <= NS;
   end if;
end process sync_p;

-- Finite state machine for control signals. Commands AXI as a slave, and the NPU configuration for different operations
comb_p: process (PS)
variable    load_node_count     :   integer := 0;
variable    load_layer_count    :   integer := 0;
variable    batch_count         :   integer := 0;
variable    batch_size          :   integer := 0;
begin

     -- schedule output signals to default values -----------------------
     npu_control_out    <=  NPU_IDLE;
     REG_RREADY         <=  '0';
     OUT_RREADY         <=  '0';  
     D_BREADY           <=  '0';  
     REG_BREADY         <=  '0';   
     BP_BREADY          <=  '0';
     CTRL_BREADY        <=  '0';      
     
case PS is
   
    -- STATE: the init cycle ------------------------------------
    -- Initialize all control outputs to non-active states and 
   when ST_init => 
    
                            
   -- STATE: the execute cycle ---------------------------------
   when ST_decode => 
      if(CTRL_WREADY = '1') then
        case OP_CODE is
            when OP_LD_WT   =>     REG_BREADY       <=  '1';                    --  Indicate to AXI that we are ready to load in an iteration of weight values
                                   NS               <=  ST_WeightWrite_Load;    --  Next state is to continue loading in the weight registers
                                   NODE_CNT         <= (others => '0');         --  Indicate NPU to output initial node count 0
                                   LAY_CNT          <= (others => '0');         --  Indicate NPU to output initial layer count 0
            when OP_RTRV_WT =>     REG_RREADY       <= '1';                     --  Schedule rready signal so AXI will output first weight iteration
                                   NS               <=  ST_WeightRead;     --  Next state is to send out the weights
                                   npu_control_out  <= NPU_READ_WEIGHTS;        --  Indicate to NPU that we are reading the weights
                                   NODE_CNT         <= (others => '0');         --  Indicate NPU to output initial node count 0
                                   LAY_CNT          <= (others => '0');         --  Indicate NPU to output initial layer count 0 
                                   
            when OP_FW_BATCH =>
            
            when OP_FW_SINGLE =>
            
            
            when others  =>
                                   npu_control_out  <= NPU_IDLE; 
        
        end case;
      
      else
        NS <= ST_decode;
      
      end if;

    -- Load in the new weights into the AXI registers. If reg_wready is asserted, all 8 weights for an iteration have been loaded, so we must go to ST_WeightWrite_writeNPU
    -- so we can write those weights to the weight registers in each node of the NPU.
    when ST_WeightWrite_Load    =>
        if(REG_WREADY = '1') then                           -- If AXI registers have finished loading for weights, load new weights into NPU
            REG_BREADY  <=  '0';                            -- Indicate to AXI to stop loading values
            npu_control_out <= NPU_LOAD_WEIGHTS;            -- Indicate to NPU to load in new weights available
            NS       <= ST_WeightWrite_writeNPU;            -- Next state is writing the newly loaded weights to the NPU nodes.
            
        else    
            REG_BREADY  <=  '1';                            -- Keep loading the weights
            npu_control_out <= NPU_IDLE;                    -- NPU should be in idle state, as we are in the middle of loading a weight iteration to AXI registers
  
        end if;  
    
    -- This state will update the node and layer count for the weight write process, or determine if the process has completed. During this clock cycle
    -- the weights will be loaded into the NPU, so we are scheduling the signals for the following cycle.
    when ST_WeightWrite_writeNPU =>   
        REG_BREADY  <=  '1';                                -- Schedule load next weight set into AXI registers via reg_bready
        npu_control_out <= NPU_IDLE;                   -- Schedule npu control to idle
        NS      <=  ST_WeightWrite_Load;                    -- Schedule next state to load in next values. Set to decode if layer max and node max met
    
        if(node_count = max_node_count) then                -- If the node count has reached its max, we either need to increase the layer count or finish loading weights

            node_count    <=  (others => '0');              -- node count reached its maximum, so lets reset the node count, then check if layer count is maxxed or should be incremented
            
            
            if(layer_count = max_layer_count) then                          -- If the layer count is currently at max, we have finished the process and need to reset to the idle/decode state for the next instruction
                NS          <=  ST_DECODE;                                  -- If maxxed out, set decode to next state instead of WeightWrite
                REG_BREADY  <=  '0';                                        -- Deassert reg_bready so no new values are put in AXI registers
            else
                layer_count <= layer_count + (0 => '1', others => '0');     -- Setup for next layer
                NS      <=  ST_WeightWrite_Load;                            -- Next state will be to continue writing the new AXI registers with weights
            end if;
        else
            node_count <= node_count + (0 => '1', others => '0');           -- If node count hasn't reached it's max, just increment and keep layer count the same
        end if;
        
        
    
    -- Assumes single cycle delay between weight switches
    when ST_WeightRead  =>
        REG_RREADY       <= '1';    
        NS               <=  ST_WeightRead;     --  Next state is to send out the weights
        npu_control_out  <= NPU_READ_WEIGHTS;        --  Indicate to NPU that we are reading the weights
        NODE_CNT         <= (others => '0');         --  Indicate NPU to output initial node count 0
        LAY_CNT          <= (others => '0');         --  Indicate NPU to output initial layer count 0 
    
        if(AXI_R_COMP = '1') then                                               -- Indicates the current iteration values have been read, so increment iteration or end weight read
        
            if(node_count = max_node_count) then                                -- If the node count has reached its max, we either need to increase the layer count or finish loading weights
                node_count          <=  (others => '0');                        -- node count reached its maximum, reset the node count then check if layer count is maxxed or should be incremented
                               
                if(layer_count = max_layer_count) then                          -- finished the process and need to reset to the idle/decode state for the next instruction
                    NS              <=  ST_DECODE;                              -- If maxxed out, set decode to next state instead of WeightRead
                    REG_RREADY      <= '0';                                     -- Deassert reg_rready AXI doesn't try to keep reading anything
                else
                    layer_count <= layer_count + (0 => '1', others => '0');     -- Step for next layer
                end if;
            else
                node_count <= node_count + (0 => '1', others => '0');           -- If node count hasn't reached it's max, just increment and keep layer count the same
            end if;
        
            REG_RREADY       <= '0';                                            -- Delay read for one clock cycle so weight switch can take effect
        else
        
        end if;

    when   ST_ForwardProp_Load =>
        if(D_WREADY = '1') then                           -- If AXI registers have finished loading for input, load input into NPU by executing first layer
            D_BREADY  <=  '0';                            -- Indicate to AXI to stop loading values
            --node_count <= (others => '0');
            npu_control_out <= NPU_FWPROP;            -- Indicate to NPU to execute first layer, dependent on input
            NS       <= ST_ForwardProp_Exec;                -- Next state is executing the forward prop sequence
            
        else    
            D_BREADY  <=  '1';                            -- Keep loading the weights
            npu_control_out <= NPU_IDLE;                    -- NPU should be in idle state, as we are in the middle of loading a weight iteration to AXI registers
   
        end if;  
        
        
    when   ST_ForwardProp_Exec =>  
        if(layer_count = set_layer_max) then                            -- If we have iterated through all the layers, ready to output the values
            NS              <=  ST_ForwardProp_Read;                    -- If maxxed out, set decode to next state instead of forward prop read
            OUT_RREADY      <= '1';                                     
        else
            layer_count <= layer_count + (0 => '1', others => '0');     -- Step for next layer
        end if;
            
        
    when   ST_ForwardProp_Read =>    
        OUT_RREADY      <= '0';                                         --  We are finished reading so deassert the read signal 
         
        if(batch_count = batch_size - 1) then                           --  Means we are done with our forward prop process and should revert back to decode state
            NS  <=  ST_Decode;
        else
            batch_count :=  batch_count + 1;
            NS  <=  ST_ForwardProp_Load;
            D_BREADY  <=  '1';
        end if;
        
        
    when    ST_BackProp_Base    =>
    
    
    when    ST_BackProp_Error   =>
    
    
    when    ST_BackProp_Grad    =>
    
    
    when    ST_BackProp_WtChng  =>    
              
    when others =>    -- for outer case
        NS      <=      ST_decode;      
    end case;  -- outer init/fetch/execute case
    
end process comb_p;



end Behavioral;
