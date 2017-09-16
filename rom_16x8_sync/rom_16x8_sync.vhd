library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity rom_16x8_sync is
	port	(Clock	  : in std_logic;
		 Address  : in std_logic_vector(3 downto 0);
		 Data_Out : out std_logic_vector(7 downto 0));
end entity;

architecture rom_16x8_sync_arch of rom_16x8_sync is

	type ROM_type is array (0 to 15) of std_logic_vector(7 downto 0);

	constant ROM : ROM_type := (0 => "11111111",
				    1 => "11101110",
				    2 => "11011101",
				    3 => "11001100",
				    4 => "10111011",
				    5 => "10101010",
				    6 => "10011001",
				    7 => "10001000",
				    8 => "01110111",
				    9 => "01100110",
				    10=> "01010101",
				    11=> "01000100",
				    12=> "00110011",
				    13=> "00100010",
				    14=> "00010001",
				    15=> "00000000");

	begin

		MEMORY : process(Clock)
			begin
				if(rising_edge(clock)) then
					Data_Out <= ROM( to_integer(unsigned(address)));
				end if;
		end process;

end architecture;