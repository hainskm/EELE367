library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rca_8bit_TB is
end entity;

architecture rca_8bit_TB_arch of rca_8bit_TB is
  
  signal A_TB, B_TB, SUM_TB : std_logic_vector(7 downto 0);
  signal COUT_TB : std_logic;
  
  component rca_8bit is
	port (A, B : in std_logic_vector(7 downto 0);
	      S    : out std_logic_vector(7 downto 0);
	      Cout : out std_logic);
  end component;
  
  begin
    
    DUT : rca_8bit port map (A_TB, B_TB, SUM_TB, COUT_TB);
      
    STIMULUS : process
     begin
	for i in 0 to 251 loop
		for j in 0 to 251 loop
       			A_TB <= std_logic_vector(to_unsigned(i,8)); 
			B_TB <= std_logic_vector(to_unsigned(j,8)); 
			wait for 30 ns;
		end loop;
	end loop;
                       
    end process;         
         
end architecture;

