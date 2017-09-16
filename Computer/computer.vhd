library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity computer is
	port (Clock : in std_logic;
	      Reset : in std_logic;
	      port_in_00, port_in_01, port_in_02, port_in_03, port_in_04, port_in_05, port_in_06, port_in_07 : in std_logic_vector(7 downto 0);
	      port_in_08, port_in_09, port_in_10, port_in_11, port_in_12, port_in_13, port_in_14, port_in_15 : in std_logic_vector(7 downto 0);
	      port_out_00, port_out_01, port_out_02, port_out_03, port_out_04, port_out_05, port_out_06, port_out_07 : out std_logic_vector(7 downto 0);
	      port_out_08, port_out_09, port_out_10, port_out_11, port_out_12, port_out_13, port_out_14, port_out_15 : out std_logic_vector(7 downto 0));
end entity;

architecture computer_arch of computer is

	component cpu
		port (Clock : in std_logic;
	     	      Reset : in std_logic;
	              from_memory : in std_logic_vector(7 downto 0);
	              address : out std_logic_vector(7 downto 0);
	      	      write_bit : out std_logic;
	      	      to_memory : out std_logic_vector(7 downto 0));
	end component;

	component memory
		port (Clock      : in std_logic;
	    	      Reset      : in std_logic;
	      	      address    : in std_logic_vector(7 downto 0);
	              data_in    : in std_logic_vector(7 downto 0);
	              write_bit      : in std_logic;
	              port_in_00, port_in_01, port_in_02, port_in_03, port_in_04, port_in_05, port_in_06, port_in_07 : in std_logic_vector(7 downto 0);
	              port_in_08, port_in_09, port_in_10, port_in_11, port_in_12, port_in_13, port_in_14, port_in_15 : in std_logic_vector(7 downto 0);
	              data_out   : out std_logic_vector(7 downto 0);
	              port_out_00, port_out_01, port_out_02, port_out_03, port_out_04, port_out_05, port_out_06, port_out_07 : out std_logic_vector(7 downto 0);
	              port_out_08, port_out_09, port_out_10, port_out_11, port_out_12, port_out_13, port_out_14, port_out_15 : out std_logic_vector(7 downto 0));
	end component;
	
	signal data_out_from_memory : std_logic_vector(7 downto 0);
	signal address_from_cpu : std_logic_vector(7 downto 0);
	signal write_bit_cpu : std_logic;
	signal data_in_from_cpu : std_logic_vector(7 downto 0);
	signal port0, port1, port2, port3, port4, port5, port6, port7, port8, port9, port10, port11, port12, port13, port14, port15 : std_logic_vector(7 downto 0);

	begin

		CPU1 : cpu port map (Clock, Reset, data_out_from_memory, address => address_from_cpu, write_bit => write_bit_cpu, to_memory => data_in_from_cpu);

		MEMORY1: memory port map (Clock, Reset, address_from_cpu, data_in_from_cpu, write_bit_cpu, port_in_00, port_in_01, port_in_02, port_in_03, port_in_04, port_in_05, port_in_06, port_in_07,
					  port_in_08, port_in_09, port_in_10, port_in_11, port_in_12, port_in_13, port_in_14, port_in_15, data_out => data_out_from_memory,
					  port_out_00 => port0, port_out_01 => port1, port_out_02 => port2, port_out_03 => port3, port_out_04 => port4, port_out_05 => port5, port_out_06 => port6, 
					  port_out_07 => port7, port_out_08 => port8, port_out_09 => port9, port_out_10 => port10, port_out_11 => port11, port_out_12 => port12, 
					  port_out_13 => port13, port_out_14 => port14, port_out_15 => port15);
	
	
	port_out_00 <= port0;
	port_out_01 <= port1;
	port_out_02 <= port2;
	port_out_03 <= port3;
	port_out_04 <= port4;
	port_out_05 <= port5;
	port_out_06 <= port6;
	port_out_07 <= port7;
	port_out_08 <= port8;
	port_out_09 <= port9;
	port_out_10 <= port10;
	port_out_11 <= port11;
	port_out_12 <= port12;
	port_out_13 <= port13;
	port_out_14 <= port14;
	port_out_15 <= port15;
end architecture;

