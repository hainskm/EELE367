library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity control_unit is
	port (Clock      : in std_logic;
	      Reset      : in std_logic;
	      IR         : in std_logic_vector(7 downto 0);
	      CCR_Result : in std_logic_vector(3 downto 0);
	      write_bit: out std_logic;
	      IR_Load  : out std_logic;
	      MAR_Load : out std_logic;
	      PC_Load  : out std_logic;
	      PC_Inc   : out std_logic;
   	      A_Load   : out std_logic;
	      B_Load   : out std_logic;
	      ALU_Sel  : out std_logic_vector(2 downto 0);
	      CCR_Load : out std_logic;
	      Bus2_Sel : out std_logic_vector(1 downto 0);
	      Bus1_Sel : out std_logic_vector(1 downto 0));
end entity;

architecture control_unit_arch of control_unit is

	type state_type is
			(S_FETCH_0, S_FETCH_1, S_FETCH_2,
			 S_DECODE_3,
			 S_LDA_IMM_4, S_LDA_IMM_5, S_LDA_IMM_6,
			 S_LDA_DIR_4, S_LDA_DIR_5, S_LDA_DIR_6, S_LDA_DIR_7, S_LDA_DIR_8,
			 S_STA_DIR_4, S_STA_DIR_5, S_STA_DIR_6, S_STA_DIR_7,
			 S_BRA_4, S_BRA_5, S_BRA_6);

	signal current_state, next_state : state_type;

	constant LDA_IMM : std_logic_vector(7 downto 0) := x"86";
	constant LDA_DIR : std_logic_vector(7 downto 0) := x"87";
	constant STA_DIR : std_logic_vector(7 downto 0) := x"96";
	constant BRA : std_logic_vector(7 downto 0) := x"20";

	begin

		STATE_MEMORY : process (Clock, Reset)
		   begin
			if (Reset = '0') then
			   current_state <= S_FETCH_0;
			elsif (Clock'event and Clock = '1') then
			   current_state <= next_state;
			end if;
		end process;

		NEXT_STATE_LOGIC : process (current_state, IR, CCR_Result)
		   begin
			if (current_state = S_FETCH_0) then
			   next_state <= S_FETCH_1;
			elsif (current_state = S_FETCH_1) then
			   next_state <= S_FETCH_2;
			elsif (current_state = S_FETCH_2) then
			   next_state <= S_DECODE_3;
			elsif (current_state = S_DECODE_3) then
			   if (IR = LDA_IMM) then
				next_state <= S_LDA_IMM_4;
			   elsif (IR = LDA_DIR) then
				next_state <= S_LDA_DIR_4;
			   elsif (IR = STA_DIR) then
				next_state <= S_STA_DIR_4;
			   elsif (IR = BRA) then
				next_state <= S_BRA_4;
			   else
				next_state <= S_FETCH_0;
			   end if;
			elsif (current_state = S_LDA_IMM_4) then
			   next_state <= S_LDA_IMM_5;
			elsif (current_state = S_LDA_IMM_5) then
			   next_state <= S_LDA_IMM_6;
			elsif (current_state = S_LDA_IMM_6) then
			   next_state <= S_FETCH_0;

			elsif (current_state = S_LDA_DIR_4) then
			   next_state <= S_LDA_DIR_5;
			elsif (current_state = S_LDA_DIR_5) then
			   next_state <= S_LDA_DIR_6;
			elsif (current_state = S_LDA_DIR_6) then
			   next_state <= S_LDA_DIR_7;
			elsif (current_state = S_LDA_DIR_7) then
			   next_state <= S_LDA_DIR_8;
			elsif (current_state = S_LDA_DIR_8) then
			   next_state <= S_FETCH_0;

			elsif (current_state = S_STA_DIR_4) then
			   next_state <= S_STA_DIR_5;
			elsif (current_state = S_STA_DIR_5) then
			   next_state <= S_STA_DIR_6;
			elsif (current_state = S_STA_DIR_6) then
			   next_state <= S_STA_DIR_7;
			elsif (current_state = S_STA_DIR_7) then
			   next_state <= S_FETCH_0;

			elsif (current_state = S_BRA_4) then
			   next_state <= S_BRA_5;
			elsif (current_state = S_BRA_5) then
			   next_state <= S_BRA_6;
			elsif (current_state = S_BRA_6) then
			   next_state <= S_FETCH_0;
			end if;
		end process;

		OUTPUT_LOGIC : process (current_state)
		   begin
			case (current_state) is
			   when S_FETCH_0 => --Put PC onto MAR to read Opcode
				IR_Load <= '0';
				MAR_Load <= '1';
				PC_Load <= '0';
				PC_Inc <= '0';
				A_Load <= '0';
				B_Load <= '0';
				ALU_Sel <= "000";
				CCR_Load <= '0';
				Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
				Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
				write_bit <= '0';
			   when S_FETCH_1 => -- Increment PC
				IR_Load <= '0';
				MAR_Load <= '0';
				PC_Load <= '0';
				PC_Inc <= '1';
				A_Load <= '0';
				B_Load <= '0';
				ALU_Sel <= "000";
				CCR_Load <= '0';
				Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
				Bus2_Sel <= "00"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
				write_bit <= '0';
			   when S_FETCH_2 => -- Opcode available on Bus2
				IR_Load <= '1';
				MAR_Load <= '0';
				PC_Load <= '0';
				PC_Inc <= '0';
				A_Load <= '0';
				B_Load <= '0';
				ALU_Sel <= "000";
				CCR_Load <= '0';
				Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
				Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
				write_bit <= '0';
			   when S_DECODE_3 => -- No changes. Instruction being determined
				IR_Load <= '0';
				MAR_Load <= '0';
				PC_Load <= '0';
				PC_Inc <= '0';
				A_Load <= '0';
				B_Load <= '0';
				ALU_Sel <= "000";
				CCR_Load <= '0';
				Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
				Bus2_Sel <= "00"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
				write_bit <= '0';
			   when S_LDA_IMM_4 => -- Load A Immediate
				IR_Load <= '0';
				MAR_Load <= '1';
				PC_Load <= '0';
				PC_Inc <= '0';
				A_Load <= '0';
				B_Load <= '0';
				ALU_Sel <= "000";
				CCR_Load <= '0';
				Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
				Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
				write_bit <= '0';
			   when S_LDA_IMM_5 => -- Load A Immediate
				IR_Load <= '0';
				MAR_Load <= '0';
				PC_Load <= '0';
				PC_Inc <= '1';
				A_Load <= '0';
				B_Load <= '0';
				ALU_Sel <= "000";
				CCR_Load <= '0';
				Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
				Bus2_Sel <= "00"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
				write_bit <= '0';
			   when S_LDA_IMM_6 => -- Load A Immediate
				IR_Load <= '0';
				MAR_Load <= '0';
				PC_Load <= '0';
				PC_Inc <= '0';
				A_Load <= '1';
				B_Load <= '0';
				ALU_Sel <= "000";
				CCR_Load <= '0';
				Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
				Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
				write_bit <= '0';
			   when S_LDA_DIR_4 => -- Load A Direct
				IR_Load <= '0';
				MAR_Load <= '1';
				PC_Load <= '0';
				PC_Inc <= '0';
				A_Load <= '0';
				B_Load <= '0';
				ALU_Sel <= "000";
				CCR_Load <= '0';
				Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
				Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
				write_bit <= '0';
			   when S_LDA_DIR_5 => -- Load A Direct
				IR_Load <= '0';
				MAR_Load <= '0';
				PC_Load <= '0';
				PC_Inc <= '1';
				A_Load <= '0';
				B_Load <= '0';
				ALU_Sel <= "000";
				CCR_Load <= '0';
				Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
				Bus2_Sel <= "00"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
				write_bit <= '0';
			   when S_LDA_DIR_6 => -- Load A Direct
				IR_Load <= '0';
				MAR_Load <= '1';
				PC_Load <= '0';
				PC_Inc <= '0';
				A_Load <= '0';
				B_Load <= '0';
				ALU_Sel <= "000";
				CCR_Load <= '0';
				Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
				Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
				write_bit <= '0';
			   when S_LDA_DIR_7 => -- Load A Direct
				IR_Load <= '0';
				MAR_Load <= '0';
				PC_Load <= '0';
				PC_Inc <= '0';
				A_Load <= '0';
				B_Load <= '0';
				ALU_Sel <= "000";
				CCR_Load <= '0';
				Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
				Bus2_Sel <= "00"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
				write_bit <= '0';
			   when S_LDA_DIR_8 => -- Load A Direct
				IR_Load <= '0';
				MAR_Load <= '0';
				PC_Load <= '0';
				PC_Inc <= '0';
				A_Load <= '1';
				B_Load <= '0';
				ALU_Sel <= "000";
				CCR_Load <= '0';
				Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
				Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
				write_bit <= '0';
			   when S_STA_DIR_4 => -- Store A Direct
				IR_Load <= '0';
				MAR_Load <= '1';
				PC_Load <= '0';
				PC_Inc <= '0';
				A_Load <= '0';
				B_Load <= '0';
				ALU_Sel <= "000";
				CCR_Load <= '0';
				Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
				Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
				write_bit <= '0';
			   when S_STA_DIR_5 => -- Store A Direct
				IR_Load <= '0';
				MAR_Load <= '0';
				PC_Load <= '0';
				PC_Inc <= '1';
				A_Load <= '0';
				B_Load <= '0';
				ALU_Sel <= "000";
				CCR_Load <= '0';
				Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
				Bus2_Sel <= "00"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
				write_bit <= '0';
			   when S_STA_DIR_6 => -- Store A Direct
				IR_Load <= '0';
				MAR_Load <= '1';
				PC_Load <= '0';
				PC_Inc <= '0';
				A_Load <= '0';
				B_Load <= '0';
				ALU_Sel <= "000";
				CCR_Load <= '0';
				Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
				Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
				write_bit <= '0';
			   when S_STA_DIR_7 => -- Store A Direct
				IR_Load <= '0';
				MAR_Load <= '0';
				PC_Load <= '0';
				PC_Inc <= '0';
				A_Load <= '0';
				B_Load <= '0';
				ALU_Sel <= "000";
				CCR_Load <= '0';
				Bus1_Sel <= "01"; -- "00" = PC, "01" = A, "10" = B
				Bus2_Sel <= "00"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
				write_bit <= '1';
			   when S_BRA_4 => -- Branch Always
				IR_Load <= '0';
				MAR_Load <= '1';
				PC_Load <= '0';
				PC_Inc <= '0';
				A_Load <= '0';
				B_Load <= '0';
				ALU_Sel <= "000";
				CCR_Load <= '0';
				Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
				Bus2_Sel <= "01"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
				write_bit <= '0';
			   when S_BRA_5 => -- Branch Always
				IR_Load <= '0';
				MAR_Load <= '0';
				PC_Load <= '0';
				PC_Inc <= '0';
				A_Load <= '0';
				B_Load <= '0';
				ALU_Sel <= "000";
				CCR_Load <= '0';
				Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
				Bus2_Sel <= "00"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
				write_bit <= '0';
			   when S_BRA_6 => -- Branch Always
				IR_Load <= '0';
				MAR_Load <= '0';
				PC_Load <= '1';
				PC_Inc <= '0';
				A_Load <= '0';
				B_Load <= '0';
				ALU_Sel <= "000";
				CCR_Load <= '0';
				Bus1_Sel <= "00"; -- "00" = PC, "01" = A, "10" = B
				Bus2_Sel <= "10"; -- "00" = ALU_Result, "01" = Bus1, "10" = from_memory
				write_bit <= '0';
			end case;
		end process;

end architecture;

