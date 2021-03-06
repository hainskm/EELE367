library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity rom_128x8_sync is
	port (Clock      : in std_logic;
	      address    : in std_logic_vector(7 downto 0);
	      data_out   : out std_logic_vector(7 downto 0));
end entity;

architecture rom_128x8_sync_arch of rom_128x8_sync is

	constant LDA_IMM : std_logic_vector(7 downto 0) := x"86";
	constant LDA_DIR : std_logic_vector(7 downto 0) := x"87";
	constant STA_DIR : std_logic_vector(7 downto 0) := x"96";
	constant BRA : std_logic_vector(7 downto 0) := x"20";

	type rom_type is array (0 to 127) of std_logic_vector(7 downto 0);

	constant ROM : rom_type := (0 => LDA_IMM,
				    1 => x"AA",
				    2 => STA_DIR,
				    3 => x"E0",
				    4 => BRA,
				    5 => x"00",
				    6 => LDA_DIR,
				    7 => x"BB",
				    8 => STA_DIR,
				    9 => x"E0",
				    10 => STA_DIR,
				    11 => x"E1",
				    12 => BRA,
				    13 => x"00",
				    others => x"00");

	signal EN : std_logic;
	begin

		enable : process (address)
		   begin
			if((to_integer(unsigned(address)) >= 0) and (to_integer(unsigned(address)) <= 127)) then
			   EN <= '1';
			else
			   EN <= '0';
			end if;
		end process;

		memory : process (Clock)
		   begin
			if(Clock'event and Clock='1') then
			   if(EN = '1') then
				data_out <= ROM(to_integer(unsigned(address)));
			   end if;
			end if;
		end process;

end architecture;

