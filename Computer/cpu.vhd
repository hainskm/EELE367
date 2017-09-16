library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity cpu is
	port (Clock : in std_logic;
	      Reset : in std_logic;
	      from_memory : in std_logic_vector(7 downto 0);
	      address : out std_logic_vector(7 downto 0);
	      write_bit : out std_logic;
	      to_memory : out std_logic_vector(7 downto 0));
end entity;

architecture cpu_arch of cpu is

	component control_unit
		port (Clock      : in std_logic;
	              Reset      : in std_logic;
	              IR         : in std_logic_vector(7 downto 0);
	              CCR_Result : in std_logic_vector(3 downto 0);
	              write_bit  : out std_logic;
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
	end component;

	component data_path
		port (Clock      : in std_logic;
	              Reset      : in std_logic;
	              from_memory: in std_logic_vector(7 downto 0);
	              IR_Load    : in std_logic;
	              MAR_Load   : in std_logic;
	              PC_Load    : in std_logic;
	              PC_Inc     : in std_logic;
   	              A_Load     : in std_logic;
	              B_Load     : in std_logic;
	              ALU_Sel    : in std_logic_vector(2 downto 0);
	              CCR_Load   : in std_logic;
	              Bus2_Sel   : in std_logic_vector(1 downto 0);
	              Bus1_Sel   : in std_logic_vector(1 downto 0);
	              IR         : out std_logic_vector(7 downto 0);
	              CCR_Result : out std_logic_vector(3 downto 0);
	              address    : out std_logic_vector(7 downto 0);
	              to_memory  : out std_logic_vector(7 downto 0));
	end component;
	
	signal IR_L, MAR_L, PC_L, PC_I, A_L, B_L, CCR_L, write_bit_out : std_logic;
	signal ALU_S : std_logic_vector(2 downto 0);
	signal BUS1, BUS2 : std_logic_vector(1 downto 0);
	signal CCR_R : std_logic_vector(3 downto 0);
	signal IR_Out, address_out, mem_out : std_logic_vector(7 downto 0);
	

	begin
		CONTROL : control_unit port map (Clock, Reset, IR_Out, CCR_R, write_bit => write_bit_out, IR_Load => IR_L, MAR_Load => MAR_L, PC_Load => PC_L, PC_Inc => PC_I,
						 A_Load => A_L, B_Load => B_L, ALU_Sel => ALU_S, CCR_Load => CCR_L, BUS2_Sel => BUS2, BUS1_Sel => BUS1);

		DATA : data_path port map (Clock, Reset, from_memory, IR_L, MAR_L, PC_L, PC_I, A_L, B_L, ALU_S, CCR_L, BUS2, BUS1, IR => IR_Out,
					   CCR_Result => CCR_R, address => address_out, to_memory => mem_out);

	address <= address_out;
	write_bit <= write_bit_out;
	to_memory <= mem_out;

end architecture;

