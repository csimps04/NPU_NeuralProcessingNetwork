library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity NPU_AXI_v1_1_NPU_AXI is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line

		-- Width of S_AXI data bus
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		-- Width of S_AXI address bus
		C_S_AXI_ADDR_WIDTH	: integer	:= 7;
		
		-- Specific for control unit intermediary signals
        AXI_CNTL_WIDTH      :   integer := 3;
        INPUT_CNTL_WIDTH    :   integer := 32;
        NODE_WIDTH          :   integer := 8;
        NODE_ADDR_WIDTH     :   integer := 3;
        LAYER_WIDTH         :   integer := 8;
        LAYER_ADDR_WIDTH    :   integer := 3;
        
        -- Generics for data input addresses
        WEIGHT_1_0_ADDRESS     :   std_logic_vector(4 downto 0) := "00000";
        WEIGHT_3_2_ADDRESS     :   std_logic_vector(4 downto 0) := "00001";
        WEIGHT_5_4_ADDRESS     :   std_logic_vector(4 downto 0) := "00010";
        WEIGHT_7_6_ADDRESS     :   std_logic_vector(4 downto 0) := "00011";
        INPUT_1_0_ADDRESS     :   std_logic_vector(4 downto 0) := "00100";
        INPUT_3_2_ADDRESS     :   std_logic_vector(4 downto 0) := "00101";
        INPUT_5_4_ADDRESS     :   std_logic_vector(4 downto 0) := "00110";
        INPUT_7_6_ADDRESS     :   std_logic_vector(4 downto 0) := "01000";
        BPINPUT_1_0_ADDRESS     :   std_logic_vector(4 downto 0) := "01001";
        BPINPUT_3_2_ADDRESS     :   std_logic_vector(4 downto 0) := "01010";
        BPINPUT_5_4_ADDRESS     :   std_logic_vector(4 downto 0) := "01011";
        BPINPUT_7_6_ADDRESS     :   std_logic_vector(4 downto 0) := "01100";
        INSTR_7_6_ADDRESS     :   std_logic_vector(4 downto 0) := "10001"
	);
	port (
		-- Users to add ports here

		-- User ports ends
		-- Do not modify the ports beyond this line

		-- Global Clock Signal
		S_AXI_ACLK	: in std_logic;
		-- Global Reset Signal. This Signal is Active LOW
		S_AXI_ARESETN	: in std_logic;
		-- Write address (issued by master, acceped by Slave)
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		-- Write channel Protection type. This signal indicates the
    		-- privilege and security level of the transaction, and whether
    		-- the transaction is a data access or an instruction access.
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		-- Write address valid. This signal indicates that the master signaling
    		-- valid write address and control information.
		S_AXI_AWVALID	: in std_logic;
		-- Write address ready. This signal indicates that the slave is ready
    		-- to accept an address and associated control signals.
		S_AXI_AWREADY	: out std_logic;
		-- Write data (issued by master, acceped by Slave) 
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		-- Write strobes. This signal indicates which byte lanes hold
    		-- valid data. There is one write strobe bit for each eight
    		-- bits of the write data bus.    
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		-- Write valid. This signal indicates that valid write
    		-- data and strobes are available.
		S_AXI_WVALID	: in std_logic;
		-- Write ready. This signal indicates that the slave
    		-- can accept the write data.
		S_AXI_WREADY	: out std_logic;
		-- Write response. This signal indicates the status
    		-- of the write transaction.
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		-- Write response valid. This signal indicates that the channel
    		-- is signaling a valid write response.
		S_AXI_BVALID	: out std_logic;
		-- Response ready. This signal indicates that the master
    		-- can accept a write response.
		S_AXI_BREADY	: in std_logic;
		-- Read address (issued by master, acceped by Slave)
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		-- Protection type. This signal indicates the privilege
    		-- and security level of the transaction, and whether the
    		-- transaction is a data access or an instruction access.
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		-- Read address valid. This signal indicates that the channel
    		-- is signaling valid read address and control information.
		S_AXI_ARVALID	: in std_logic;
		-- Read address ready. This signal indicates that the slave is
    		-- ready to accept an address and associated control signals.
		S_AXI_ARREADY	: out std_logic;
		-- Read data (issued by slave)
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		-- Read response. This signal indicates the status of the
    		-- read transfer.
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		-- Read valid. This signal indicates that the channel is
    		-- signaling the required read data.
		S_AXI_RVALID	: out std_logic;
		-- Read ready. This signal indicates that the master can
    		-- accept the read data and response information.
		S_AXI_RREADY	: in std_logic
	);
end NPU_AXI_v1_1_NPU_AXI;

architecture arch_imp of NPU_AXI_v1_1_NPU_AXI is

	-- AXI4LITE signals
	signal axi_awaddr	: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
	signal axi_awready	: std_logic;
	signal axi_wready	: std_logic;
	signal axi_bresp	: std_logic_vector(1 downto 0);
	signal axi_bvalid	: std_logic;
	signal axi_araddr	: std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
	signal axi_arready	: std_logic;
	signal axi_rdata	: std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_rresp	: std_logic_vector(1 downto 0);
	signal axi_rvalid	: std_logic;

	-- Example-specific design signals
	-- local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
	-- ADDR_LSB is used for addressing 32/64 bit registers/memories
	-- ADDR_LSB = 2 for 32 bits (n downto 2)
	-- ADDR_LSB = 3 for 64 bits (n downto 3)
	constant ADDR_LSB  : integer := (C_S_AXI_DATA_WIDTH/32)+ 1;
	constant OPT_MEM_ADDR_BITS : integer := 4;
	------------------------------------------------
	---- Signals for user logic register space example
	--------------------------------------------------
	---- Number of Slave Registers 20
	signal axi_wt_reg_1_0	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_wt_reg_3_2	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_wt_reg_5_4	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_wt_reg_7_6	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_in_reg_1_0	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_in_reg_3_2	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_in_reg_5_4	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_in_reg_7_6	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_bp_reg_1_0	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_bp_reg_3_2	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_bp_reg_5_4	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_bp_reg_7_6	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_out_reg_1_0	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_out_reg_3_2	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_out_reg_5_4	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_out_reg_7_6	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_learn_rate_reg	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_ctlr_instr_reg	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_unused_reg0	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_unused_reg1	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg_rden	: std_logic;
	signal slv_reg_wren	: std_logic;
	signal reg_data_out	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal byte_index	: integer;
	signal aw_en	: std_logic;

	-- Intermediary control signals for control unit for AXI
	signal ctrl_cmdReg	:std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);	
	signal ctl_ctl_in   :   std_logic := '0';
	signal ctl_ctl_wr   :   std_logic := '0';
    signal ctl_reg_wr   :   std_logic := '0';
	signal ctl_d_wr     :   std_logic := '0';
    signal ctl_bp_wr    :   std_logic := '0';
    signal ctl_bp_br    :   std_logic := '0';       
    signal ctl_d_br     :   std_logic := '0';
    signal ctl_dout_br  :   std_logic := '0';
    signal ctl_reg_br   :   std_logic := '0';
    signal ctl_instr_br :   std_logic := '0';
    signal ctl_axi_out  :   std_logic_vector(AXI_CNTL_WIDTH - 1 downto 0) := (others => '0');
    
    signal ctl_wready   :   std_logic := '0';
    
    -- Intermediary control signals for control unit to NPU
    signal ctl_npu_ctl  :   std_logic_vector(INPUT_CNTL_WIDTH - 1 downto 0) := (others => '0');
    signal ctl_npu_ndct :   std_logic_vector(NODE_ADDR_WIDTH - 1 downto 0) := (others => '0');
    signal ctl_npu_lyct :   std_logic_vector(LAYER_ADDR_WIDTH - 1 downto 0) := (others => '0');  
    
    -- Weight register signals, feed into each node wrapper
    signal wt_reg0      :   std_logic_vector(15 downto 0) := (others => '0');
    signal wt_reg1      :   std_logic_vector(15 downto 0) := (others => '0');
    signal wt_reg2      :   std_logic_vector(15 downto 0) := (others => '0');                               
    signal wt_reg3      :   std_logic_vector(15 downto 0) := (others => '0');	
    signal wt_reg4      :   std_logic_vector(15 downto 0) := (others => '0');	
    signal wt_reg5      :   std_logic_vector(15 downto 0) := (others => '0');	
    signal wt_reg6      :   std_logic_vector(15 downto 0) := (others => '0');	
    signal wt_reg7      :   std_logic_vector(15 downto 0) := (others => '0');	
    
    -- output register signals
    signal out_reg0      :   std_logic_vector(15 downto 0) := (others => '0');
    signal out_reg1      :   std_logic_vector(15 downto 0) := (others => '0');
    signal out_reg2      :   std_logic_vector(15 downto 0) := (others => '0');                               
    signal out_reg3      :   std_logic_vector(15 downto 0) := (others => '0');    
    signal out_reg4      :   std_logic_vector(15 downto 0) := (others => '0');    
    signal out_reg5      :   std_logic_vector(15 downto 0) := (others => '0');    
    signal out_reg6      :   std_logic_vector(15 downto 0) := (others => '0');    
    signal out_reg7      :   std_logic_vector(15 downto 0) := (others => '0'); 
    
    -- expected value registers for back propagation
    signal bp_reg0      :   std_logic_vector(15 downto 0) := (others => '0');
    signal bp_reg1      :   std_logic_vector(15 downto 0) := (others => '0');
    signal bp_reg2      :   std_logic_vector(15 downto 0) := (others => '0');                               
    signal bp_reg3      :   std_logic_vector(15 downto 0) := (others => '0');    
    signal bp_reg4      :   std_logic_vector(15 downto 0) := (others => '0');    
    signal bp_reg5      :   std_logic_vector(15 downto 0) := (others => '0');    
    signal bp_reg6      :   std_logic_vector(15 downto 0) := (others => '0');    
    signal bp_reg7      :   std_logic_vector(15 downto 0) := (others => '0'); 
     
    
    -- input register signals
    signal in_reg0      :   std_logic_vector(15 downto 0) := (others => '0');
    signal in_reg1      :   std_logic_vector(15 downto 0) := (others => '0');
    signal in_reg2      :   std_logic_vector(15 downto 0) := (others => '0');                               
    signal in_reg3      :   std_logic_vector(15 downto 0) := (others => '0');    
    signal in_reg4      :   std_logic_vector(15 downto 0) := (others => '0');    
    signal in_reg5      :   std_logic_vector(15 downto 0) := (others => '0');    
    signal in_reg6      :   std_logic_vector(15 downto 0) := (others => '0');    
    signal in_reg7      :   std_logic_vector(15 downto 0) := (others => '0');     
    
    -- Learning rate signal
    signal learn_rate   :   std_logic_vector(15 downto 0) := (others => '0'); 
	
	
	component NPU_Controller is
        generic(
                NODE_WIDTH          :   integer := 8;
                NODE_ADDR_WIDTH     :   integer := 3;
                LAYER_WIDTH         :   integer := 8;
                LAYER_ADDR_WIDTH    :   integer := 3;
                AXI_CNTL_WIDTH      :   integer := 3;
                INPUT_CNTL_WIDTH    :   integer := 32;                
                CNTL_ADDR_WIDTH     :   integer := 3
        );
        Port (
                CLK         :   in  std_logic;
                RESET       :   in  std_logic;  -- Resets all counters and registers
                CTL_IN      :   in  std_logic_vector(INPUT_CNTL_WIDTH - 1 downto 0); -- Input for the control instruction
                CTRL_WREADY :   in  std_logic;  -- Indicates that a new instruction is ready to be processed
                REG_WREADY  :   in  std_logic;  -- Indicates that a new value is ready to load into the next weight register
                D_WREADY    :   in  std_logic;  -- Indicates new value is ready for data
                BP_WREADY   :   in  std_logic;  -- Indicates new back prop value is ready
                D_BREADY    :   out std_logic;  -- Indicates to AXI when ready for new data
                REG_BREADY  :   out std_logic;  -- Indicates when AXI should accept new weight register value 
                BP_BREADY   :   out std_logic;  -- Indicates when AXI should accept new back prop register values
                CTRL_BREADY :   out std_logic;  -- Indicates when AXI should accept new instruction for control unit
                NODE_CNT    :   out std_logic_vector(NODE_ADDR_WIDTH - 1 downto 0);  -- output to each node
                LAY_CNT     :   out std_logic_vector(LAYER_ADDR_WIDTH - 1 downto 0); -- output to each node
                NPU_CTL_OUT :   out std_logic_vector(CNTL_ADDR_WIDTH - 1 downto 0); -- Controls the NPU based on control instructions
                AXI_CTL_OUT :   out std_logic_vector(AXI_CNTL_WIDTH - 1 downto 0)    -- May or may not be necessary
        );
    end component;

begin
	-- I/O Connections assignments

	S_AXI_AWREADY	<= axi_awready;
	S_AXI_WREADY	<= axi_wready;
	S_AXI_BRESP	<= axi_bresp;
	S_AXI_BVALID	<= axi_bvalid;
	S_AXI_ARREADY	<= axi_arready;
	S_AXI_RDATA	<= axi_rdata;
	S_AXI_RRESP	<= axi_rresp;
	S_AXI_RVALID	<= axi_rvalid;
	-- Implement axi_awready generation
	-- axi_awready is asserted for one S_AXI_ACLK clock cycle when both
	-- S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
	-- de-asserted when reset is low.

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_awready <= '0';
	      aw_en <= '1';
	    else
	      if (axi_awready = '0' and S_AXI_AWVALID = '1' and S_AXI_WVALID = '1' and aw_en = '1') then
	        -- slave is ready to accept write address when
	        -- there is a valid write address and write data
	        -- on the write address and data bus. This design 
	        -- expects no outstanding transactions. 
	        axi_awready <= '1';
	        elsif (S_AXI_BREADY = '1' and axi_bvalid = '1') then
	            aw_en <= '1';
	        	axi_awready <= '0';
	      else
	        axi_awready <= '0';
	      end if;
	    end if;
	  end if;
	end process;

	-- Implement axi_awaddr latching
	-- This process is used to latch the address when both 
	-- S_AXI_AWVALID and S_AXI_WVALID are valid. 

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_awaddr <= (others => '0');
	    else
	      if (axi_awready = '0' and S_AXI_AWVALID = '1' and S_AXI_WVALID = '1' and aw_en = '1') then
	        -- Write Address latching
	        axi_awaddr <= S_AXI_AWADDR;
	      end if;
	    end if;
	  end if;                   
	end process; 
	
	
	-- ctl_wready is set by the control unit, indicating that a write is expected from either the weight, data, backprop, or instruction input
	-- also make sure no writing is done when the AXI signals that the control unit has valid data to write to NPU
	ctl_wready <= (ctl_reg_br OR ctl_d_br OR ctl_bp_br OR ctl_instr_br) AND NOT (ctl_ctl_wr OR ctl_reg_wr OR ctl_d_wr OR ctl_bp_wr);
	
	
	

	-- Implement axi_wready generation
	-- axi_wready is asserted for one S_AXI_ACLK clock cycle when both
	-- S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is 
	-- de-asserted when reset is low. 

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_wready <= '0';
	    else
	      if (axi_wready = '0' and S_AXI_WVALID = '1' and S_AXI_AWVALID = '1' and aw_en = '1' and ctl_wready = '1') then
	          -- slave is ready to accept write data when 
	          -- there is a valid write address and write data
	          -- on the write address and data bus. This design 
	          -- expects no outstanding transactions.           
	          axi_wready <= '1';
	      else
	        axi_wready <= '0';
	      end if;
	    end if;
	  end if;
	end process; 

	-- Implement memory mapped register select and write logic generation
	-- The write data is accepted and written to memory mapped registers when
	-- axi_awready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted. Write strobes are used to
	-- select byte enables of slave registers while writing.
	-- These registers are cleared when reset (active low) is applied.
	-- Slave register write enable is asserted when valid address and data are available
	-- and the slave is ready to accept the write address and write data.
	slv_reg_wren <= axi_wready and S_AXI_WVALID and axi_awready and S_AXI_AWVALID ;

	process (S_AXI_ACLK)
	variable loc_addr :std_logic_vector(OPT_MEM_ADDR_BITS downto 0); 
	begin	
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_wt_reg_1_0 <= (others => '0');
	      axi_wt_reg_3_2 <= (others => '0');
	      axi_wt_reg_5_4 <= (others => '0');
	      axi_wt_reg_7_6 <= (others => '0');
	      axi_in_reg_1_0 <= (others => '0');
	      axi_in_reg_3_2 <= (others => '0');
	      axi_in_reg_5_4 <= (others => '0');
	      axi_in_reg_7_6 <= (others => '0');
	      axi_bp_reg_1_0 <= (others => '0');
	      axi_bp_reg_3_2 <= (others => '0');
	      axi_bp_reg_5_4 <= (others => '0');
	      axi_bp_reg_7_6 <= (others => '0');
	      axi_out_reg_1_0 <= (others => '0');
	      axi_out_reg_3_2 <= (others => '0');
	      axi_out_reg_5_4 <= (others => '0');
	      axi_out_reg_7_6 <= (others => '0');
	      axi_learn_rate_reg <= (others => '0');
	      axi_ctlr_instr_reg <= (others => '0');
	      axi_unused_reg0 <= (others => '0');
	      axi_unused_reg1 <= (others => '0');
	    else
	      loc_addr := axi_awaddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto ADDR_LSB);
	      -- First case is that the weight registers are ready to be loaded, as indicated by
	      -- the ctl_reg_br signal output from the control unit, indicating the control is expecting
	      -- to write to the NPU once all the weight registers are filled
	      if (slv_reg_wren = '1' and ctl_reg_br = '1') then
	        case loc_addr is
	          when b"00000" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 0
	                axi_wt_reg_1_0(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"00001" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 1
	                axi_wt_reg_3_2(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"00010" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 2
	                axi_wt_reg_5_4(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"00011" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 3
	                axi_wt_reg_7_6(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
              when others =>
                  axi_wt_reg_1_0 <= axi_wt_reg_1_0;
                  axi_wt_reg_3_2 <= axi_wt_reg_3_2;
                  axi_wt_reg_5_4 <= axi_wt_reg_5_4;
                  axi_wt_reg_7_6 <= axi_wt_reg_7_6;
                  axi_in_reg_1_0 <= axi_in_reg_1_0;
                  axi_in_reg_3_2 <= axi_in_reg_3_2;
                  axi_in_reg_5_4 <= axi_in_reg_5_4;
                  axi_in_reg_7_6 <= axi_in_reg_7_6;
                  axi_bp_reg_1_0 <= axi_bp_reg_1_0;
                  axi_bp_reg_3_2 <= axi_bp_reg_3_2;
                  axi_bp_reg_5_4 <= axi_bp_reg_5_4;
                  axi_bp_reg_7_6 <= axi_bp_reg_7_6;
                  axi_out_reg_1_0 <= axi_out_reg_1_0;
                  axi_out_reg_3_2 <= axi_out_reg_3_2;
                  axi_out_reg_5_4 <= axi_out_reg_5_4;
                  axi_out_reg_7_6 <= axi_out_reg_7_6;
                  axi_learn_rate_reg <= axi_learn_rate_reg;
                  axi_ctlr_instr_reg <= axi_ctlr_instr_reg;
                  axi_unused_reg0 <= axi_unused_reg0;
                  axi_unused_reg1 <= axi_unused_reg1;
            end case;
          elsif (slv_reg_wren = '1' and ctl_d_br = '1') then
            case loc_addr is
	          when b"00100" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 4
	                axi_in_reg_1_0(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"00101" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 5
	                axi_in_reg_3_2(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"00110" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 6
	                axi_in_reg_5_4(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"00111" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 7
	                axi_in_reg_7_6(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
              when others =>
                  axi_wt_reg_1_0 <= axi_wt_reg_1_0;
                  axi_wt_reg_3_2 <= axi_wt_reg_3_2;
                  axi_wt_reg_5_4 <= axi_wt_reg_5_4;
                  axi_wt_reg_7_6 <= axi_wt_reg_7_6;
                  axi_in_reg_1_0 <= axi_in_reg_1_0;
                  axi_in_reg_3_2 <= axi_in_reg_3_2;
                  axi_in_reg_5_4 <= axi_in_reg_5_4;
                  axi_in_reg_7_6 <= axi_in_reg_7_6;
                  axi_bp_reg_1_0 <= axi_bp_reg_1_0;
                  axi_bp_reg_3_2 <= axi_bp_reg_3_2;
                  axi_bp_reg_5_4 <= axi_bp_reg_5_4;
                  axi_bp_reg_7_6 <= axi_bp_reg_7_6;
                  axi_out_reg_1_0 <= axi_out_reg_1_0;
                  axi_out_reg_3_2 <= axi_out_reg_3_2;
                  axi_out_reg_5_4 <= axi_out_reg_5_4;
                  axi_out_reg_7_6 <= axi_out_reg_7_6;
                  axi_learn_rate_reg <= axi_learn_rate_reg;
                  axi_ctlr_instr_reg <= axi_ctlr_instr_reg;
                  axi_unused_reg0 <= axi_unused_reg0;
                  axi_unused_reg1 <= axi_unused_reg1;  
            end case;
          elsif (slv_reg_wren = '1' and ctl_bp_br = '1') then
            case loc_addr is
	          when b"01000" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 8
	                axi_bp_reg_1_0(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"01001" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 9
	                axi_bp_reg_3_2(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"01010" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 10
	                axi_bp_reg_5_4(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"01011" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 11
	                axi_bp_reg_7_6(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
              when others =>
                  axi_wt_reg_1_0 <= axi_wt_reg_1_0;
                  axi_wt_reg_3_2 <= axi_wt_reg_3_2;
                  axi_wt_reg_5_4 <= axi_wt_reg_5_4;
                  axi_wt_reg_7_6 <= axi_wt_reg_7_6;
                  axi_in_reg_1_0 <= axi_in_reg_1_0;
                  axi_in_reg_3_2 <= axi_in_reg_3_2;
                  axi_in_reg_5_4 <= axi_in_reg_5_4;
                  axi_in_reg_7_6 <= axi_in_reg_7_6;
                  axi_bp_reg_1_0 <= axi_bp_reg_1_0;
                  axi_bp_reg_3_2 <= axi_bp_reg_3_2;
                  axi_bp_reg_5_4 <= axi_bp_reg_5_4;
                  axi_bp_reg_7_6 <= axi_bp_reg_7_6;
                  axi_out_reg_1_0 <= axi_out_reg_1_0;
                  axi_out_reg_3_2 <= axi_out_reg_3_2;
                  axi_out_reg_5_4 <= axi_out_reg_5_4;
                  axi_out_reg_7_6 <= axi_out_reg_7_6;
                  axi_learn_rate_reg <= axi_learn_rate_reg;
                  axi_ctlr_instr_reg <= axi_ctlr_instr_reg;
                  axi_unused_reg0 <= axi_unused_reg0;
                  axi_unused_reg1 <= axi_unused_reg1;
            end case;
          -- Case should be removed as the AXI should not have any outputs
          elsif (slv_reg_wren = '1' and ctl_dout_br = '1') then
            case loc_addr is
	          when b"01100" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 12
	                axi_out_reg_1_0(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"01101" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 13
	                axi_out_reg_3_2(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"01110" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 14
	                axi_out_reg_5_4(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"01111" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 15
	                axi_out_reg_7_6(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
              when others =>
                  axi_wt_reg_1_0 <= axi_wt_reg_1_0;
                  axi_wt_reg_3_2 <= axi_wt_reg_3_2;
                  axi_wt_reg_5_4 <= axi_wt_reg_5_4;
                  axi_wt_reg_7_6 <= axi_wt_reg_7_6;
                  axi_in_reg_1_0 <= axi_in_reg_1_0;
                  axi_in_reg_3_2 <= axi_in_reg_3_2;
                  axi_in_reg_5_4 <= axi_in_reg_5_4;
                  axi_in_reg_7_6 <= axi_in_reg_7_6;
                  axi_bp_reg_1_0 <= axi_bp_reg_1_0;
                  axi_bp_reg_3_2 <= axi_bp_reg_3_2;
                  axi_bp_reg_5_4 <= axi_bp_reg_5_4;
                  axi_bp_reg_7_6 <= axi_bp_reg_7_6;
                  axi_out_reg_1_0 <= axi_out_reg_1_0;
                  axi_out_reg_3_2 <= axi_out_reg_3_2;
                  axi_out_reg_5_4 <= axi_out_reg_5_4;
                  axi_out_reg_7_6 <= axi_out_reg_7_6;
                  axi_learn_rate_reg <= axi_learn_rate_reg;
                  axi_ctlr_instr_reg <= axi_ctlr_instr_reg;
                  axi_unused_reg0 <= axi_unused_reg0;
                  axi_unused_reg1 <= axi_unused_reg1;
	          end case;
	      elsif (slv_reg_wren = '1'  and ctl_instr_br = '1') then  -- Case for control register
	        if (loc_addr = b"10001") then
	          for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	            if ( S_AXI_WSTRB(byte_index) = '1' ) then
	              -- Respective byte enables are asserted as per write strobes                   
	              -- slave registor 17
	              axi_ctlr_instr_reg(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	            end if;
	          end loop;
	        else 
                axi_wt_reg_1_0 <= axi_wt_reg_1_0;
                axi_wt_reg_3_2 <= axi_wt_reg_3_2;
                axi_wt_reg_5_4 <= axi_wt_reg_5_4;
                axi_wt_reg_7_6 <= axi_wt_reg_7_6;
                axi_in_reg_1_0 <= axi_in_reg_1_0;
                axi_in_reg_3_2 <= axi_in_reg_3_2;
                axi_in_reg_5_4 <= axi_in_reg_5_4;
                axi_in_reg_7_6 <= axi_in_reg_7_6;
                axi_bp_reg_1_0 <= axi_bp_reg_1_0;
                axi_bp_reg_3_2 <= axi_bp_reg_3_2;
                axi_bp_reg_5_4 <= axi_bp_reg_5_4;
                axi_bp_reg_7_6 <= axi_bp_reg_7_6;
                axi_out_reg_1_0 <= axi_out_reg_1_0;
                axi_out_reg_3_2 <= axi_out_reg_3_2;
                axi_out_reg_5_4 <= axi_out_reg_5_4;
                axi_out_reg_7_6 <= axi_out_reg_7_6;
                axi_learn_rate_reg <= axi_learn_rate_reg;
                axi_ctlr_instr_reg <= axi_ctlr_instr_reg;
                axi_unused_reg0 <= axi_unused_reg0;
                axi_unused_reg1 <= axi_unused_reg1;
	        end if;
	      elsif(slv_reg_wren = '1') then
	        case loc_addr is
	          when b"10000" =>
                            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                              if ( S_AXI_WSTRB(byte_index) = '1' ) then
                                -- Respective byte enables are asserted as per write strobes                   
                                -- slave registor 16
                                axi_learn_rate_reg(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                              end if;
                            end loop;
	          when b"10010" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 18
	                axi_unused_reg0(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when b"10011" =>
	            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
	              if ( S_AXI_WSTRB(byte_index) = '1' ) then
	                -- Respective byte enables are asserted as per write strobes                   
	                -- slave registor 19
	                axi_unused_reg1(byte_index*8+7 downto byte_index*8) <= S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
	              end if;
	            end loop;
	          when others =>
	            axi_wt_reg_1_0 <= axi_wt_reg_1_0;
	            axi_wt_reg_3_2 <= axi_wt_reg_3_2;
	            axi_wt_reg_5_4 <= axi_wt_reg_5_4;
	            axi_wt_reg_7_6 <= axi_wt_reg_7_6;
	            axi_in_reg_1_0 <= axi_in_reg_1_0;
	            axi_in_reg_3_2 <= axi_in_reg_3_2;
	            axi_in_reg_5_4 <= axi_in_reg_5_4;
	            axi_in_reg_7_6 <= axi_in_reg_7_6;
	            axi_bp_reg_1_0 <= axi_bp_reg_1_0;
	            axi_bp_reg_3_2 <= axi_bp_reg_3_2;
	            axi_bp_reg_5_4 <= axi_bp_reg_5_4;
	            axi_bp_reg_7_6 <= axi_bp_reg_7_6;
	            axi_out_reg_1_0 <= axi_out_reg_1_0;
	            axi_out_reg_3_2 <= axi_out_reg_3_2;
	            axi_out_reg_5_4 <= axi_out_reg_5_4;
	            axi_out_reg_7_6 <= axi_out_reg_7_6;
	            axi_learn_rate_reg <= axi_learn_rate_reg;
	            axi_ctlr_instr_reg <= axi_ctlr_instr_reg;
	            axi_unused_reg0 <= axi_unused_reg0;
	            axi_unused_reg1 <= axi_unused_reg1;
	        end case;
	      end if;
	    end if;
	  end if;                   
	end process; 

	-- Implement write response logic generation
	-- The write response and response valid signals are asserted by the slave 
	-- when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.  
	-- This marks the acceptance of address and indicates the status of 
	-- write transaction.

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_bvalid  <= '0';
	      axi_bresp   <= "00"; --need to work more on the responses
	    else
	      if (axi_awready = '1' and S_AXI_AWVALID = '1' and axi_wready = '1' and S_AXI_WVALID = '1' and axi_bvalid = '0'  ) then
	        axi_bvalid <= '1';
	        axi_bresp  <= "00"; 
	      elsif (S_AXI_BREADY = '1' and axi_bvalid = '1') then   --check if bready is asserted while bvalid is high)
	        axi_bvalid <= '0';                                 -- (there is a possibility that bready is always asserted high)
	      end if;
	    end if;
	  end if;                   
	end process; 

	-- Implement axi_arready generation
	-- axi_arready is asserted for one S_AXI_ACLK clock cycle when
	-- S_AXI_ARVALID is asserted. axi_awready is 
	-- de-asserted when reset (active low) is asserted. 
	-- The read address is also latched when S_AXI_ARVALID is 
	-- asserted. axi_araddr is reset to zero on reset assertion.

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_arready <= '0';
	      axi_araddr  <= (others => '1');
	    else
	      if (axi_arready = '0' and S_AXI_ARVALID = '1') then
	        -- indicates that the slave has acceped the valid read address
	        axi_arready <= '1';
	        -- Read Address latching 
	        axi_araddr  <= S_AXI_ARADDR;           
	      else
	        axi_arready <= '0';
	      end if;
	    end if;
	  end if;                   
	end process; 

	-- Implement axi_arvalid generation
	-- axi_rvalid is asserted for one S_AXI_ACLK clock cycle when both 
	-- S_AXI_ARVALID and axi_arready are asserted. The slave registers 
	-- data are available on the axi_rdata bus at this instance. The 
	-- assertion of axi_rvalid marks the validity of read data on the 
	-- bus and axi_rresp indicates the status of read transaction.axi_rvalid 
	-- is deasserted on reset (active low). axi_rresp and axi_rdata are 
	-- cleared to zero on reset (active low).  
	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then
	    if S_AXI_ARESETN = '0' then
	      axi_rvalid <= '0';
	      axi_rresp  <= "00";
	    else
	      if (axi_arready = '1' and S_AXI_ARVALID = '1' and axi_rvalid = '0') then
	        -- Valid read data is available at the read data bus
	        axi_rvalid <= '1';
	        axi_rresp  <= "00"; -- 'OKAY' response
	      elsif (axi_rvalid = '1' and S_AXI_RREADY = '1') then
	        -- Read data is accepted by the master
	        axi_rvalid <= '0';
	      end if;            
	    end if;
	  end if;
	end process;

	-- Implement memory mapped register select and read logic generation
	-- Slave register read enable is asserted when valid address is available
	-- and the slave is ready to accept the read address.
	slv_reg_rden <= axi_arready and S_AXI_ARVALID and (not axi_rvalid) ;

	process (axi_wt_reg_1_0, axi_wt_reg_3_2, axi_wt_reg_5_4, axi_wt_reg_7_6, axi_in_reg_1_0, axi_in_reg_3_2, axi_in_reg_5_4, axi_in_reg_7_6, axi_bp_reg_1_0, axi_bp_reg_3_2, axi_bp_reg_5_4, axi_bp_reg_7_6, axi_out_reg_1_0, axi_out_reg_3_2, axi_out_reg_5_4, axi_out_reg_7_6, axi_learn_rate_reg, axi_ctlr_instr_reg, axi_unused_reg0, axi_unused_reg1, axi_araddr, S_AXI_ARESETN, slv_reg_rden)
	variable loc_addr :std_logic_vector(OPT_MEM_ADDR_BITS downto 0);
	begin
	    -- Address decoding for reading registers
	    loc_addr := axi_araddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto ADDR_LSB);
	    case loc_addr is
	      when b"00000" =>
	        reg_data_out <= axi_wt_reg_1_0;
	      when b"00001" =>
	        reg_data_out <= axi_wt_reg_3_2;
	      when b"00010" =>
	        reg_data_out <= axi_wt_reg_5_4;
	      when b"00011" =>
	        reg_data_out <= axi_wt_reg_7_6;
	      when b"00100" =>
	        reg_data_out <= axi_in_reg_1_0;
	      when b"00101" =>
	        reg_data_out <= axi_in_reg_3_2;
	      when b"00110" =>
	        reg_data_out <= axi_in_reg_5_4;
	      when b"00111" =>
	        reg_data_out <= axi_in_reg_7_6;
	      when b"01000" =>
	        reg_data_out <= axi_bp_reg_1_0;
	      when b"01001" =>
	        reg_data_out <= axi_bp_reg_3_2;
	      when b"01010" =>
	        reg_data_out <= axi_bp_reg_5_4;
	      when b"01011" =>
	        reg_data_out <= axi_bp_reg_7_6;
	      when b"01100" =>
	        reg_data_out <= axi_out_reg_1_0;
	      when b"01101" =>
	        reg_data_out <= axi_out_reg_3_2;
	      when b"01110" =>
	        reg_data_out <= axi_out_reg_5_4;
	      when b"01111" =>
	        reg_data_out <= axi_out_reg_7_6;
	      when b"10000" =>
	        reg_data_out <= axi_learn_rate_reg;
	      when b"10001" =>
	        reg_data_out <= axi_ctlr_instr_reg;
	      when b"10010" =>
	        reg_data_out <= axi_unused_reg0;
	      when b"10011" =>
	        reg_data_out <= axi_unused_reg1;
	      when others =>
	        reg_data_out  <= (others => '0');
	    end case;
	end process; 

	-- Output register or memory read data
	process( S_AXI_ACLK ) is
	begin
	  if (rising_edge (S_AXI_ACLK)) then
	    if ( S_AXI_ARESETN = '0' ) then
	      axi_rdata  <= (others => '0');
	    else
	      if (slv_reg_rden = '1') then
	        -- When there is a valid read address (S_AXI_ARVALID) with 
	        -- acceptance of read address by the slave (axi_arready), 
	        -- output the read dada 
	        -- Read address mux
	          axi_rdata <= reg_data_out;     -- register read data
	      end if;   
	    end if;
	  end if;
	end process;


	-- Add user logic here
	
	
	-- Read Ready process will indicate to the control system whether the registers have been filled 
	-- for a particular input. These include the 
	WriteReady  :   process(S_AXI_ACLK, ctl_d_br, ctl_reg_br, ctl_bp_br)
	variable loc_addr :std_logic_vector(OPT_MEM_ADDR_BITS downto 0); 
	begin
	loc_addr := axi_awaddr(ADDR_LSB + OPT_MEM_ADDR_BITS downto ADDR_LSB);
	if rising_edge(S_AXI_ACLK) then
      -- Initially set all the write recieved registers (for control unit) to 0, as the control unit should not be attempting to 
      -- write any data to the NPU, unless it is explicitely told so when the particular register address is
      -- written to.
      ctl_reg_wr <= '0';
      ctl_d_wr <= '0';
      ctl_ctl_wr <= '0';
      ctl_bp_wr <= '0';
	   
	   -- If the registers are going to be written to, check if the final address is
	   -- being filled (since they are done so sequentially). If so, indicate to the 
	   -- control unit that the data is ready to be loaded into the NPU
	   if(slv_reg_wren = '1') then
           if(loc_addr = WEIGHT_7_6_ADDRESS and ctl_reg_br = '1') then
               ctl_reg_wr <= '1';
           elsif(loc_addr =  INPUT_7_6_ADDRESS and ctl_d_br = '1') then
               ctl_d_wr   <= '1';
           elsif(loc_addr =  BPINPUT_7_6_ADDRESS and ctl_bp_br = '1') then
               ctl_bp_wr  <= '1'; 
           elsif(loc_addr = INSTR_7_6_ADDRESS and ctl_instr_br = '1') then
               ctl_ctl_wr <= '1';  
           end if;
	   end if;
	end if;
	
	end process WriteReady; 
	
	
	-- WriteReadyResponse indicates that the control unit has recieved the input and processed, and is ready to take in new
	-- data for certain operations. This resets the write responses set when AXI finishes a data write for all 4 of a set
	WriteReadyResponse :   process(S_AXI_ACLK, ctl_reg_br, ctl_d_br, ctl_bp_br, ctl_instr_br)
	begin
	   if(ctl_reg_br = '1') then
	       ctl_reg_wr <= '0';
	   elsif(ctl_d_br = '1') then
	       
	   elsif(ctl_bp_br = '1') then 
	   elsif(ctl_instr_br = '1') then
	   end if;
	
	end process WriteReadyResponse;
		--ctl_wready <= (ctl_reg_br OR ctl_d_br OR ctl_bp_br OR ctl_instr_br) AND NOT (ctl_ctl_wr OR ctl_reg_wr OR ctl_d_wr OR ctl_bp_wr);
	

controller : NPU_Controller
    Port Map(
            CLK         =>  S_AXI_ACLK,
            RESET       =>  S_AXI_ARESETN,
            CTL_IN      =>  ctrl_cmdReg,--:   in  std_logic_vector(CNTL_ADDR_WIDTH - 1 downto 0);     -- From AXI, for data control
            CTRL_WREADY =>  ctl_ctl_wr,
            REG_WREADY  =>  ctl_reg_wr,--:   in  std_logic;  -- Indicates that a new value is ready to load into the next weight register
            D_WREADY    =>  ctl_d_wr,--:   in  std_logic;  -- Indicates new value is ready for data
            BP_WREADY   =>  ctl_bp_wr,--:   in  std_logic;  -- Indicates new back prop value is ready
            D_BREADY    =>  ctl_d_br,--:   out std_logic;  -- Indicates to AXI when ready for new data
            REG_BREADY  =>  ctl_reg_br,--:   out std_logic;  -- Indicates when AXI should accept new weight register value 
            BP_BREADY   =>  ctl_bp_br,
            CTRL_BREADY =>  ctl_instr_br,
            NODE_CNT    =>  ctl_npu_ndct,--:   out std_logic_vector(NODE_ADDR_WIDTH - 1 downto 0);  -- output to each node
            LAY_CNT     =>  ctl_npu_lyct,--:   out std_logic_vector(LAYER_ADDR_WIDTH - 1 downto 0); -- output to each node
            NPU_CTL_OUT =>  ctl_npu_ctl,--:   out std_logic_vector(INPUT_CNTL_WIDTH - 1 downto 0);           
            AXI_CTL_OUT =>  ctl_axi_out--:   out std_logic_vector(AXI_CNTL_WIDTH - 1 downto 0)    -- May or may not be necessary
    );
    
    -- weight register mapping
    wt_reg0      <=     axi_wt_reg_1_0(15 downto 0);
    wt_reg1      <=     axi_wt_reg_1_0(31 downto 16);
    wt_reg2      <=     axi_wt_reg_3_2(15 downto 0);                               
    wt_reg3      <=     axi_wt_reg_3_2(31 downto 16);    
    wt_reg4      <=     axi_wt_reg_5_4(15 downto 0);
    wt_reg5      <=     axi_wt_reg_5_4(31 downto 16);
    wt_reg6      <=     axi_wt_reg_7_6(15 downto 0);
    wt_reg7      <=     axi_wt_reg_7_6(31 downto 16);
    
    -- output register signals
    out_reg0    <=     axi_wt_reg_1_0(15 downto 0);      
    out_reg1    <=     axi_wt_reg_1_0(31 downto 16);  
    out_reg2    <=     axi_wt_reg_3_2(15 downto 0);                                     
    out_reg3    <=     axi_wt_reg_3_2(31 downto 16);      
    out_reg4    <=     axi_wt_reg_5_4(15 downto 0);      
    out_reg5    <=     axi_wt_reg_5_4(31 downto 16);      
    out_reg6    <=     axi_wt_reg_7_6(15 downto 0);      
    out_reg7    <=     axi_wt_reg_7_6(31 downto 16);   
    
    -- expected value registers for back propagation
    bp_reg0     <=     axi_wt_reg_1_0(15 downto 0); 
    bp_reg1     <=     axi_wt_reg_1_0(31 downto 16); 
    bp_reg2     <=     axi_wt_reg_3_2(15 downto 0);                                     
    bp_reg3     <=     axi_wt_reg_3_2(31 downto 16);     
    bp_reg4     <=     axi_wt_reg_5_4(15 downto 0);          
    bp_reg5     <=     axi_wt_reg_5_4(31 downto 16);     
    bp_reg6     <=     axi_wt_reg_7_6(15 downto 0);     
    bp_reg7     <=     axi_wt_reg_7_6(31 downto 16);  
     
    
    -- input register signals
    in_reg0     <=     axi_wt_reg_1_0(15 downto 0); 
    in_reg1     <=     axi_wt_reg_1_0(31 downto 16); 
    in_reg2     <=     axi_wt_reg_3_2(15 downto 0);                                
    in_reg3     <=     axi_wt_reg_3_2(31 downto 16);     
    in_reg4     <=     axi_wt_reg_5_4(15 downto 0);     
    in_reg5     <=     axi_wt_reg_5_4(31 downto 16);     
    in_reg6     <=     axi_wt_reg_7_6(15 downto 0);     
    in_reg7     <=     axi_wt_reg_7_6(31 downto 16); 
  
    -- Learning rate signal
    learn_rate      <=    axi_learn_rate_reg(15 downto 0);
    ctl_npu_ctl     <=    axi_ctlr_instr_reg;
 
  

	-- User logic ends

end arch_imp;
