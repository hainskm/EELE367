library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Counter_16bit_UpDown is
	port (Clock, Reset : in std_logic;
	      Up	   : in std_logic;
	      Count_Out	   : out std_logic_vector(15 downto 0));
end entity;

architecture Counter_16bit_UpDown_arch of Counter_16bit_UpDown is

	signal internalCounter : integer;

	begin
	
		COUNTER : process (Clock, Reset, Up)
			begin
				if (Reset = '0') then
					internalCounter <= 0;
				elsif (Clock'event and Clock = '1') then
					if (Up = '1') then
						if (internalCounter = 65535) then
							internalCounter <= 0;
						else
							internalCounter <= internalCounter + 1;
						end if;
					else
						if (internalCounter = 0) then
							internalCounter <= 65535;
						else
							internalCounter <= internalCounter - 1;
						end if;
					end if;
				end if;
		end process;

	Count_Out <= std_logic_vector(to_unsigned(internalCounter, 16));				

end architecture;
