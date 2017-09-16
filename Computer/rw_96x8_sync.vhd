library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity rw_96x8_sync is
	port (Clock      : in std_logic;
	      address    : in std_logic_vector(7 downto 0);
	      data_in    : in std_logic_vector(7 downto 0);
	      write_bit	 : in std_logic;
	      data_out   : out std_logic_vector(7 downto 0));
end entity;

architecture rw_96x8_sync_arch of rw_96x8_sync is

	type rw_type is array (128 to 223) of std_logic_vector(7 downto 0);
	signal RW : rw_type;
	signal EN : std_logic;
	begin
		enable : process (address)
		   begin
			if((to_integer(unsigned(address)) >= 128) and (to_integer(unsigned(address)) <= 223)) then
			   EN <= '1';
			else
			   EN <= '0';
			end if;
		end process;

		memory : process (Clock)
		   begin
			if(Clock'event and Clock='1') then
			   if(EN = '1' and write_bit = '1') then
				RW(to_integer(unsigned(address))) <= data_in;
			   elsif(EN = '1' and write_bit = '0') then
				data_out <= RW(to_integer(unsigned(address)));
			   end if;
			end if;
		end process;

end architecture;
